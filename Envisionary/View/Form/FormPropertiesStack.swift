//
//  FormPropertiesStack.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/11/23.
//

import SwiftUI

struct FormPropertiesStack: View {
    @Binding var properties: Properties
    @Binding var images: [UIImage]
    @Binding var isPresentingPhotoSource: Bool
    let objectType: ObjectType
    let modalType: ModalType
    var isSimple: Bool = false
    var parentId: UUID?
    
    @State var title = ""
    @State var description = ""
    @State var aspect = ""
    @State var priority = ""
    @State var coreValue = ""
    @State var timeframeString = ""
    @State var timeframe = TimeframeType.day
    @State var startDate = Date()
    @State var numberOf = 0
    @State var endDate = Date()
    @State var filteredValues = [ValueType]()
    @State var chapterString = ""
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
        VStack(spacing:10){
            ForEach(PropertyType.allCases){ property in
                
                if objectType.hasProperty(property: property) && (!isSimple || property.isSimple()){
                    GetFormControl(property:property)
                }
            }
        }
        .onAppear{
            title = properties.title ?? ""
            description = properties.description ?? ""
            aspect = properties.aspect?.toString() ?? ""
            timeframeString = properties.timeframe?.toString() ?? ""
            priority = properties.priority?.toString() ?? ""
            startDate = properties.startDate ?? Date()
            numberOf = 0
            endDate = properties.endDate ?? Date()
            coreValue = properties.coreValue?.toString() ?? ""
        }
        .onChange(of:timeframeString){ _ in
            timeframe = TimeframeType.fromString(input: timeframeString)
            properties.timeframe = timeframe
        }
        .onChange(of: timeframe){
            _ in
            numberOf = 0
            endDate = startDate.AdvanceDate(timeframe: timeframe, forward: true)
            properties.endDate = endDate
        }
        .onChange(of: numberOf){
            _ in
            endDate = startDate.ComputeEndDate(timeframeType: timeframe, numberOfDates: numberOf)
            properties.endDate = endDate
        }
        .onChange(of: startDate){
            _ in
            endDate = startDate.ComputeEndDate(timeframeType: timeframe, numberOfDates: numberOf)
            properties.startDate = startDate
        }
        .onChange(of: priority){
            _ in
            properties.priority = PriorityType.fromString(input: priority)
        }
        .onChange(of: coreValue){ _ in
            if objectType == .value {
                title = coreValue
                properties.title = coreValue
            }
            properties.coreValue = ValueType.fromString(input: coreValue)
        }
        .onChange(of: aspect){ _ in
            if objectType == .aspect {
                title = aspect
                properties.title = aspect
            }
            properties.aspect = AspectType.fromString(input: aspect)
        }
        .onChange(of: title){
            _ in
            properties.title = title
        }
        .onChange(of: description){
            _ in
            properties.description = description
        }
    }
    
    func ComputeMaxValue() -> Int{
        switch timeframe {
        case .decade:
            return 4
        case .year:
            return 10
        case .month:
            return 12
        case .week:
            return 4
        case .day:
            return 7
        }
    }
    
    @ViewBuilder
    func GetFormControl(property: PropertyType) -> some View{
        
        switch property {
        case .title:
            FormText(fieldValue: $title, fieldName: PropertyType.title.toString(), axis: .horizontal, iconType: .title)
        case .description:
            FormText(fieldValue: $description, fieldName: GetDescriptionFieldName(), axis: .vertical, iconType: .description)
        case .timeframe:
            if parentId != nil && modalType != .add {
                FormLabel(fieldValue: timeframeString, fieldName: PropertyType.timeframe.toString(), iconType: .timeframe, shouldShowLock: true)
            }
            else{
                FormStackPicker(fieldValue: $timeframeString, fieldName: PropertyType.timeframe.toString(), options: TimeframeType.allCases.map({$0.toString()}),iconType: .timeframe)
            }
        case .startDate:
            FormCalendarPicker(fieldValue: $startDate, fieldName: GetStartDateFieldName(), timeframeType: $timeframe, iconType: .dates, isStartDate: true)
        case .endDate:
            FormCounter(fieldValue: $numberOf, fieldName: GetNumberOfFieldName(), iconType: .dates, maxValue: ComputeMaxValue())
            FormLabel(fieldValue: endDate.toString(timeframeType: timeframe, isStartDate: false), fieldName: PropertyType.endDate.toString(), iconType: .dates, shouldShowLock: true)
        case .aspect:
            
            if objectType == .aspect{
                let savedAspects = vm.ListAspects().map({$0.aspect.toString()})
                let allAspects = AspectType.allCases.map({$0.toString()})
                
                FormStackPicker(fieldValue: $aspect, fieldName: PropertyType.aspect.toString(), options: allAspects.filter({savedAspects.firstIndex(of: $0) == nil}), iconType: .aspect, isSearchable: true)
            }
            
            else{
                if parentId != nil {
                    FormLabel(fieldValue: aspect, fieldName: PropertyType.aspect.toString(), iconType: .aspect, shouldShowLock: true)
                }
                else{
                    FormStackPicker(fieldValue: $aspect, fieldName: PropertyType.aspect.toString(), options: AspectType.allCases.map({$0.toString()}),iconType: .aspect)
                }
            }
        case .priority:
            FormStackPicker(fieldValue: $priority, fieldName: PropertyType.priority.toString(), options: PriorityType.allCases.map({$0.toString()}),iconType: .priority)
//        case .progress:
//            <#code#>
//        case .parentId:
//            <#code#>
        case .coreValue:
            if modalType == .add {
                FormStackPicker(fieldValue: $coreValue, fieldName: PropertyType.coreValue.toString(), options: ValueType.allCases.filter({vm.GetCoreValue(coreValue: $0) == nil && $0 != .Introduction && $0 != .Conclusion}).map{$0.toString()}, iconType: .value, isSearchable: true)
            }
            else{
                FormLabel(fieldValue: coreValue, fieldName: PropertyType.coreValue.toString(), iconType: .value, shouldShowLock: true)
            }
        case .chapter:
            let chapters = vm.ListChapters()
            FormStackPicker(fieldValue: $chapterString, fieldName: PropertyType.chapter.toString(), options: chapters.map({$0.title}), iconType: .chapter)
        case .images:
            FormImages(fieldValue: $images, shouldPopImagesModal: $isPresentingPhotoSource, fieldName: PropertyType.images.toString(), iconType: .photo)
        default:
            let _ = "why"
        }
    }
    
    func GetDescriptionFieldName() -> String{
        if objectType == .entry {
            return "Entry"
        }
        else {return "Description"}
    }
    
    func GetStartDateFieldName() -> String{
        if objectType.hasProperty(property: .endDate){
            return PropertyType.startDate.toString()
        }
        else {
            return "Date"
        }
    }
    
    func GetNumberOfFieldName() -> String {
        return "Number of " + timeframe.toString() + "s"
    }
}

struct FormPropertiesStack_Previews: PreviewProvider {
    static var previews: some View {
        FormPropertiesStack(properties: .constant(Properties()), images: .constant([UIImage]()), isPresentingPhotoSource: .constant(false), objectType: .goal, modalType: .search)
    }
}
