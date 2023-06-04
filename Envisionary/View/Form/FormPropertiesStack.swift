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
    @Binding var isValidForm: Bool

    let objectType: ObjectType
    let modalType: ModalType
    var isSimple: Bool = false
    var parentGoalId: UUID?
    
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
    @State var schedule = ScheduleType.oncePerDay
    @State var scheduleOptions = [String]()
    
    @State var amount = 0
    
    @State var unit = UnitType.minutes
    @State var unitString = ""
    
    @State private var titleDirtyTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    @EnvironmentObject var validator: FormPropertiesValidator
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
                properties.timeframe = timeframe
            }
            else{
                timeframeString = properties.timeframe?.toString() ?? timeframe.toString()
                timeframe = TimeframeType.fromString(input: timeframeString)
            }
            properties.timeframe = timeframe
            scheduleTimeframeString = scheduleTimeframe.toString()
            
            priorityString = properties.priority?.toString() ?? ""
            
            startDate = properties.startDate ?? Date().StartOfTimeframe(timeframe: timeframe)
            endDate = properties.endDate ?? startDate.EndOfTimeframe(timeframe: timeframe)
            numberOf = 0
            endDate = properties.endDate ?? Date()
            coreValue = properties.coreValue?.toString() ?? ""
            scheduleString = properties.scheduleType?.toString() ?? schedule.toString()
            scheduleOptions = GetSchedules()
            unitString = unit.toString()
            validator.reset()
            validator.validateForm(properties: properties, objectType: objectType)
            titleDirtyTimer.upstream.connect().cancel()
        }
        .onChange(of: properties){
            _ in
            validator.validateForm(properties: properties, objectType: objectType)
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
            validator.endDate.isDirty = true
            validator.timeframe.isDirty = true
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
            validator.startDate.isDirty = true
        }
        .onChange(of: priorityString){
            _ in
            properties.priority = PriorityType.fromString(input: priorityString)
            validator.priority.isDirty = true
        }
        .onChange(of: coreValue){ _ in
            if objectType == .value {
                title = coreValue
                properties.title = coreValue
            }
            properties.coreValue = ValueType.fromString(input: coreValue)
            validator.coreValue.isDirty = true
        }
        .onChange(of: aspectString){ _ in
            if objectType == .aspect {
                title = aspectString
                properties.title = aspectString
            }
            properties.aspect = AspectType.fromString(input: aspectString)
            validator.aspect.isDirty = true
        }
        .onChange(of: title){
            _ in
            properties.title = title
            titleDirtyTimer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
        }
        .onChange(of: description){
            _ in
            properties.description = description
        }
        .onChange(of: scheduleString){
            _ in
            schedule = ScheduleType.fromString(input: scheduleString)
            properties.scheduleType = schedule
            validator.scheduleType.isDirty = true
        }
        .onChange(of: amount){ _ in
            properties.amount = amount
            validator.amount.isDirty = true
        }
        .onChange(of: unitString){ _ in
            unit = UnitType.fromString(input: unitString)
            properties.unitOfMeasure = unit
            validator.unit.isDirty = true
        }
        .onChange(of: chapterString){ _ in
            properties.chapterId = vm.ListChapters().first(where: {$0.title == chapterString})?.id
            validator.chapter.isDirty = true
        }
        .onReceive(titleDirtyTimer){ _ in
            titleDirtyTimer.upstream.connect().cancel()
            validator.title.isDirty = true
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
            if objectType == .aspect{
                let savedAspects = vm.ListAspects().map({$0.aspect.toString()})
                let allAspects = AspectType.allCases.map({$0.toString()})
                
                FormStackPicker(fieldValue: $aspectString, fieldName: PropertyType.aspect.toString(), options: .constant(allAspects.filter({savedAspects.firstIndex(of: $0) == nil})), iconType: .aspect, isSearchable: true)
            }
            else{
                FormText(fieldValue: $title, fieldName: PropertyType.title.toString(), axis: .horizontal, iconType: .title)
                    .modifier(ModifierFormValidator(fieldPropertyValidator: $validator.title, isValidForm: $isValidForm, propertyType: .title))
            }
        case .description:
            FormText(fieldValue: $description, fieldName: GetDescriptionFieldName(), axis: .vertical, iconType: .description)
        case .timeframe:
            if parentGoalId != nil {
                FormLabel(fieldValue: timeframeString, fieldName: PropertyType.timeframe.toString(), iconType: .timeframe, shouldShowLock: true)
            }
            else{
                FormStackPicker(fieldValue: $timeframeString, fieldName: PropertyType.timeframe.toString(), options: .constant(TimeframeType.allCases.map({$0.toString()})),iconType: .timeframe)
                    .modifier(ModifierFormValidator(fieldPropertyValidator: $validator.timeframe, isValidForm: $isValidForm, propertyType: .timeframe))
            }
        case .startDate:
            FormCalendarPicker(fieldValue: $startDate, fieldName: GetStartDateFieldName(), timeframeType: $timeframe, iconType: .dates, isStartDate: true)
                .modifier(ModifierFormValidator(fieldPropertyValidator: $validator.startDate, isValidForm: $isValidForm, propertyType: .startDate))
        case .endDate:
            FormCounter(fieldValue: $numberOf, fieldName: GetNumberOfFieldName(), iconType: .dates, maxValue: ComputeMaxValue())
            FormLabel(fieldValue: endDate.toString(timeframeType: timeframe, isStartDate: false), fieldName: PropertyType.endDate.toString(), iconType: .dates, shouldShowLock: true)
        case .aspect:
            if objectType != .aspect{
                if parentGoalId != nil {
                    FormLabel(fieldValue: aspectString, fieldName: PropertyType.aspect.toString(), iconType: .aspect, shouldShowLock: true)
                }
                else{
                    FormStackPicker(fieldValue: $aspectString, fieldName: PropertyType.aspect.toString(), options: .constant(vm.ListAspects().map({$0.aspect.toString()})),iconType: .aspect)
                        .modifier(ModifierFormValidator(fieldPropertyValidator: $validator.aspect, isValidForm: $isValidForm, propertyType: .aspect))
                }
            }
        case .priority:
            FormStackPicker(fieldValue: $priorityString, fieldName: PropertyType.priority.toString(), options: .constant(PriorityType.allCases.map({$0.toString()})),iconType: .priority)
                .modifier(ModifierFormValidator(fieldPropertyValidator: $validator.priority, isValidForm: $isValidForm, propertyType: .priority))
        case .coreValue:
            if modalType == .add {
                FormStackPicker(fieldValue: $coreValue, fieldName: PropertyType.coreValue.toString(), options: .constant(ValueType.allCases.filter({vm.GetCoreValue(coreValue: $0) == nil && $0 != .Introduction && $0 != .Conclusion}).map{$0.toString()}), iconType: .value, isSearchable: true)
                    .modifier(ModifierFormValidator(fieldPropertyValidator: $validator.coreValue, isValidForm: $isValidForm, propertyType: .coreValue))
            }
            else{
                FormLabel(fieldValue: coreValue, fieldName: PropertyType.coreValue.toString(), iconType: .value, shouldShowLock: true)
            }
        case .chapter:
            let chapters = vm.ListChapters()
            FormStackPicker(fieldValue: $chapterString, fieldName: PropertyType.chapter.toString(), options: .constant(chapters.map({$0.title})), iconType: .chapter)
                .modifier(ModifierFormValidator(fieldPropertyValidator: $validator.chapter, isValidForm: $isValidForm, propertyType: .chapter))
        case .images:
            FormImages(fieldValue: $images, shouldPopImagesModal: $isPresentingPhotoSource, fieldName: PropertyType.images.toString(), iconType: .photo)
        case .scheduleType:
            FormStackPicker(fieldValue: $scheduleTimeframeString, fieldName: "Schedule " + PropertyType.timeframe.toString(), options: .constant([TimeframeType.day.toString(), TimeframeType.week.toString()]),iconType: .timeframe)
            FormStackPicker(fieldValue: $scheduleString, fieldName: PropertyType.scheduleType.toString(), options: $scheduleOptions, iconType: .dates, isSearchable: false)
                .modifier(ModifierFormValidator(fieldPropertyValidator: $validator.scheduleType, isValidForm: $isValidForm, propertyType: .scheduleType))
        case .amount:
            if schedule.shouldShowAmount(){
                FormCounter(fieldValue: $amount, fieldName: GetAmountFieldName(), iconType: .dates, maxValue: ComputeMaxValue())
                    .modifier(ModifierFormValidator(fieldPropertyValidator: $validator.amount, isValidForm: $isValidForm, propertyType: .amount))
            }
        case .unit:
            if schedule.shouldShowAmount() {
                FormStackPicker(fieldValue: $unitString, fieldName: PropertyType.unit.toString(), options: .constant(UnitType.allCases.map({$0.toString()})), iconType: .chapter)
                    .modifier(ModifierFormValidator(fieldPropertyValidator: $validator.unit, isValidForm: $isValidForm, propertyType: .unit))
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
        FormPropertiesStack(properties: .constant(Properties()), images: .constant([UIImage]()), isPresentingPhotoSource: .constant(false), isValidForm: .constant(true), objectType: .goal, modalType: .search)
    }
}
