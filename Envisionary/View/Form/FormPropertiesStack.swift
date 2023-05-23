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
    
    @State var aspectString = ""
    
    @State var priorityString = ""
    
    @State var coreValue = ""
    
    @State var timeframe = TimeframeType.day
    @State var timeframeString = ""
    
    @State var scheduleTimeframe = TimeframeType.day
    @State var scheduleTimeframeString = ""
    
    @State var startDate = Date()
    @State var numberOf = 0
    @State var endDate = Date()
    @State var filteredValues = [ValueType]()
    @State var chapterString = ""
    
    @State var scheduleString = ""
    @State var schedule = ScheduleType.aCertainAmountOverTime
    @State var scheduleOptions = [String]()
    
    @State var amount = 0
    
    @State var unit = UnitType.minutes
    @State var unitString = ""
    
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
            
            aspectString = properties.aspect?.toString() ?? ""
            

            
            if objectType == .habit {
                timeframe = .month
                timeframeString = timeframe.toString()
            }
            else{
                timeframeString = properties.timeframe?.toString() ?? timeframe.toString()
                timeframe = TimeframeType.fromString(input: timeframeString)
            }
            
            scheduleTimeframeString = scheduleTimeframe.toString()
            
            priorityString = properties.priority?.toString() ?? ""
            
            startDate = properties.startDate ?? Date().StartOfTimeframe(timeframe: timeframe)
            endDate = properties.endDate ?? startDate.EndOfTimeframe(timeframe: timeframe)
            numberOf = 0
            endDate = properties.endDate ?? Date()
            coreValue = properties.coreValue?.toString() ?? ""
            scheduleString = properties.scheduleType?.toString() ?? ""
            scheduleOptions = GetSchedules()
            
            unitString = unit.toString()
        }
        .onChange(of: timeframeString){
            _ in
            timeframe = TimeframeType.fromString(input: timeframeString)
            numberOf = 0
            startDate = startDate.StartOfTimeframe(timeframe: timeframe)
            endDate = startDate.AdvanceDate(timeframe: timeframe, forward: true).EndOfTimeframe(timeframe: timeframe)
            properties.startDate = startDate
            properties.endDate = endDate
            properties.timeframe = timeframe
        }
        .onChange(of: scheduleTimeframeString){
            _ in
            scheduleTimeframe = TimeframeType.fromString(input: scheduleTimeframeString)
            scheduleOptions = GetSchedules()
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
        .onChange(of: priorityString){
            _ in
            print(properties.priority)
            properties.priority = PriorityType.fromString(input: priorityString)
            print(properties.priority)
        }
        .onChange(of: coreValue){ _ in
            if objectType == .value {
                title = coreValue
                properties.title = coreValue
            }
            properties.coreValue = ValueType.fromString(input: coreValue)
        }
        .onChange(of: aspectString){ _ in
            if objectType == .aspect {
                title = aspectString
                properties.title = aspectString
            }
            properties.aspect = AspectType.fromString(input: aspectString)
        }
        .onChange(of: title){
            _ in
            properties.title = title
        }
        .onChange(of: description){
            _ in
            properties.description = description
        }
        .onChange(of: scheduleString){
            _ in
            schedule = ScheduleType.fromString(input: scheduleString)
            properties.scheduleType = schedule
        }
        .onChange(of: amount){ _ in
            properties.amount = amount
        }
        .onChange(of: unitString){ _ in
            unit = UnitType.fromString(input: unitString)
            properties.unitOfMeasure = unit
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
                FormStackPicker(fieldValue: $timeframeString, fieldName: PropertyType.timeframe.toString(), options: .constant(TimeframeType.allCases.map({$0.toString()})),iconType: .timeframe)
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
                
                FormStackPicker(fieldValue: $aspectString, fieldName: PropertyType.aspect.toString(), options: .constant(allAspects.filter({savedAspects.firstIndex(of: $0) == nil})), iconType: .aspect, isSearchable: true)
            }
            
            else{
                if parentId != nil {
                    FormLabel(fieldValue: aspectString, fieldName: PropertyType.aspect.toString(), iconType: .aspect, shouldShowLock: true)
                }
                else{
                    FormStackPicker(fieldValue: $aspectString, fieldName: PropertyType.aspect.toString(), options: .constant(AspectType.allCases.map({$0.toString()})),iconType: .aspect)
                }
            }
        case .priority:
            FormStackPicker(fieldValue: $priorityString, fieldName: PropertyType.priority.toString(), options: .constant(PriorityType.allCases.map({$0.toString()})),iconType: .priority)
        case .coreValue:
            if modalType == .add {
                FormStackPicker(fieldValue: $coreValue, fieldName: PropertyType.coreValue.toString(), options: .constant(ValueType.allCases.filter({vm.GetCoreValue(coreValue: $0) == nil && $0 != .Introduction && $0 != .Conclusion}).map{$0.toString()}), iconType: .value, isSearchable: true)
            }
            else{
                FormLabel(fieldValue: coreValue, fieldName: PropertyType.coreValue.toString(), iconType: .value, shouldShowLock: true)
            }
        case .chapter:
            let chapters = vm.ListChapters()
            FormStackPicker(fieldValue: $chapterString, fieldName: PropertyType.chapter.toString(), options: .constant(chapters.map({$0.title})), iconType: .chapter)
        case .images:
            FormImages(fieldValue: $images, shouldPopImagesModal: $isPresentingPhotoSource, fieldName: PropertyType.images.toString(), iconType: .photo)
        case .scheduleType:
            FormStackPicker(fieldValue: $scheduleTimeframeString, fieldName: "Schedule " + PropertyType.timeframe.toString(), options: .constant([TimeframeType.day.toString(), TimeframeType.week.toString()]),iconType: .timeframe)
            FormStackPicker(fieldValue: $scheduleString, fieldName: PropertyType.scheduleType.toString(), options: $scheduleOptions, iconType: .dates, isSearchable: false)
        case .amount:
            if schedule.shouldShowAmount(){
                FormCounter(fieldValue: $amount, fieldName: GetAmountFieldName(), iconType: .dates, maxValue: ComputeMaxValue())
            }
        case .unit:
            if schedule.shouldShowAmount() {
                FormStackPicker(fieldValue: $unitString, fieldName: PropertyType.unit.toString(), options: .constant(UnitType.allCases.map({$0.toString()})), iconType: .chapter)
            }
        default:
            let _ = "why"
        }
    }
    
    func GetSchedules() -> [String]{
        return ScheduleType.allCases.filter({$0.shouldShow(timeframe: scheduleTimeframe)}).map({$0.toString()})
    }
    
    func GetAmountFieldName() -> String{
        return "Number of " + unit.toString()
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
