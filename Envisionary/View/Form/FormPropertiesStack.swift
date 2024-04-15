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
    @Binding var didAttemptToSave: Bool

    let objectType: ObjectType
    let modalType: ModalType
    var isSimple: Bool = false
    var parentGoalId: UUID?
    var convertDreamId: UUID?
    
    @State var title = ""
    @State var description = ""
    @State var aspectString = ""
    @State var priorityString = ""

    @State var startDate = Date()
    @State var endDate = Date()
    @State var filteredValues = [ValueType]()
    @State var chapterString = ""
    @State var hasChapterId: Bool = false
    
    @State var scheduleTimeframe = TimeframeType.day
    @State var scheduleTimeframeString = ""
    @State var scheduleString = ""
    @State var schedule: ScheduleType = ScheduleType.oncePerDay
    @State var scheduleOptions = [String]()
    @State var amount = 0
    @State var unit = UnitType.minutes
    @State var unitString = ""
    @State var isRecurring = false
    
    @State private var titleDirtyTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var setupTimer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    @StateObject var validator: FormPropertiesValidator = FormPropertiesValidator()
    @EnvironmentObject var vm: ViewModel
    
    @State var isSettingUp = true
    
    var body: some View {
        
        VStack(spacing:10){
            ForEach(PropertyType.allCases){ property in
                
                if objectType.hasProperty(property: property) && (!isSimple || property.isSimple()){
                    GetFormControl(property:property)
                }
            }
        }
        .onAppear{
            isSettingUp = true
            title = properties.title ?? ""
            description = properties.description ?? ""
            aspectString = properties.aspect ?? ""
            
            scheduleTimeframeString = scheduleTimeframe.toString()
            
            priorityString = properties.priority?.toString() ?? ""
            
            if properties.startDate != nil{
                startDate = properties.startDate!
            }
            else{
                properties.startDate = Date().StartOfDay()
            }
            
            if properties.endDate != nil{
                endDate = properties.endDate!
            }
            else{
                endDate = startDate.AdvanceYear(forward: true)
                properties.endDate = endDate
            }
            
            scheduleString = properties.schedule?.toString() ?? schedule.toString()
            scheduleOptions = GetSchedules()
            unitString = unit.toString()
            
            validator.reset()
            validator.validateForm(properties: properties, objectType: objectType)
            isValidForm = validator.isValidForm()
            didAttemptToSave = false
            titleDirtyTimer.upstream.connect().cancel()
            
            let chapters = vm.ListChapters()
            chapterString = chapters.first(where: {$0.id == properties.chapterId})?.title ?? ""
            hasChapterId = properties.chapterId != nil
            amount = properties.amount ?? 0
            
            let timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false, block: {
                _ in
                isSettingUp = false
            })
            
        }
        .onDisappear(){
            validator.reset()
        }
        .onChange(of: properties){
            _ in
            validator.validateForm(properties: properties, objectType: objectType)
            isValidForm = validator.isValidForm()
        }
        .onChange(of: didAttemptToSave){
            _ in
            
            if !isSettingUp {
                validator.isDirty = true
            }
        }
        .onChange(of: scheduleTimeframeString){
            _ in
            scheduleTimeframe = TimeframeType.fromString(input: scheduleTimeframeString)
            scheduleOptions = GetSchedules()
            properties.timeframe = scheduleTimeframe
        }
        .onChange(of: startDate){
            _ in
            if !isSettingUp{
                properties.startDate = startDate
                validator.startDate.isDirty = true
            }
        }
        .onChange(of: endDate){ _ in
            if !isSettingUp{
                properties.endDate = endDate
                validator.endDate.isDirty = true
            }
        }
        .onChange(of: priorityString){
            _ in
            properties.priority = PriorityType.fromString(input: priorityString)
            validator.priority.isDirty = true
        }
        .onChange(of: aspectString){ _ in
            if objectType == .aspect {
                title = aspectString
                properties.title = aspectString
            }
            properties.aspect = aspectString
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
            properties.schedule = schedule
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
        .onReceive(setupTimer){ _ in
            titleDirtyTimer.upstream.connect().cancel()
            isSettingUp = false
        }
        .onChange(of: isRecurring){
            _ in
            unitString = UnitType.minutes.toString()
            scheduleTimeframeString = TimeframeType.day.toString()
            amount = 0
            scheduleOptions = GetSchedules()
            properties.isRecurring = isRecurring
        }
    }
    
    @ViewBuilder
    func GetFormControl(property: PropertyType) -> some View{
        
        switch property {
        case .title:
            if objectType == .aspect{
                let savedAspects = vm.ListAspects().map({$0.title})
                let allAspects = AspectType.allCases.map({$0.toString()})
                
                FormStackPicker(fieldValue: $title, fieldName: PropertyType.title.toString(), options: .constant(allAspects.filter({savedAspects.firstIndex(of: $0) == nil})), iconType: .aspect, isSearchable: true)
                    .modifier(ModifierFormValidator(fieldPropertyValidator: $validator.title, isDirtyForm: $validator.isDirty, propertyType: .title))
            }
            else if objectType == .value {
                if modalType == .add {
                    FormStackPicker(fieldValue: $title, fieldName: PropertyType.title.toString(), options: .constant(ValueType.allCases.filter({vm.GetCoreValue(coreValue: $0) == nil && $0 != .Introduction && $0 != .Conclusion}).map{$0.toString()}), iconType: .value, isSearchable: true)
                        .modifier(ModifierFormValidator(fieldPropertyValidator: $validator.title, isDirtyForm: $validator.isDirty, propertyType: .title))
                }
                else{
                    FormLabel(fieldValue: title, fieldName: PropertyType.title.toString(), iconType: .value, shouldShowLock: true)
                }
            }
            else if objectType == .dream{
                FormStackPicker(fieldValue: $title, fieldName: PropertyType.title.toString(), options: .constant(DreamType.allCases.map({$0.toString()})), iconType: .dream, isSearchable: true)
                    .modifier(ModifierFormValidator(fieldPropertyValidator: $validator.title, isDirtyForm: $validator.isDirty, propertyType: .title))
            }
            else{
                FormText(fieldValue: $title, fieldName: PropertyType.title.toString(), axis: .horizontal, iconType: .title)
                    .modifier(ModifierFormValidator(fieldPropertyValidator: $validator.title, isDirtyForm: $validator.isDirty, propertyType: .title))
                    .frame(height:60)
            }
        case .description:
            FormText(fieldValue: $description, fieldName: GetDescriptionFieldName(), axis: .vertical, iconType: .description)
        case .startDate:
            if (objectType == .habit && modalType == .edit ){
                FormLabel(fieldValue: startDate.toString(timeframeType: scheduleTimeframe), fieldName: GetStartDateFieldName(), iconType: .dates, shouldShowLock: true)
            }
            else{
                FormCalendarPicker(fieldValue: $startDate, fieldName: GetStartDateFieldName(), timeframeType: .day, iconType: .dates, isStartDate: true)
                    .modifier(ModifierFormValidator(fieldPropertyValidator: $validator.startDate, isDirtyForm: $validator.isDirty, propertyType: .startDate))
            }
        case .endDate:
            if (objectType == .habit && modalType == .edit ){
                FormLabel(fieldValue: startDate.toString(timeframeType: scheduleTimeframe), fieldName: GetStartDateFieldName(), iconType: .dates, shouldShowLock: true)
            }
            else{
                FormCalendarPicker(fieldValue: $endDate, fieldName: PropertyType.endDate.toString(), timeframeType: .day, iconType: .dates, isStartDate: true)
                    .modifier(ModifierFormValidator(fieldPropertyValidator: $validator.endDate, isDirtyForm: $validator.isDirty, propertyType: .endDate))
            }
        case .aspect:
            if objectType != .aspect{
                if parentGoalId != nil {
                    FormLabel(fieldValue: aspectString, fieldName: PropertyType.aspect.toString(), iconType: .aspect, shouldShowLock: true)
                }
                else{
                    FormStackPicker(fieldValue: $aspectString, fieldName: PropertyType.aspect.toString(), options: .constant(vm.ListAspects().map({$0.title}).sorted()),iconType: .aspect)
                        .modifier(ModifierFormValidator(fieldPropertyValidator: $validator.aspect, isDirtyForm: $validator.isDirty, propertyType: .aspect))
                }
            }
        case .priority:
            FormStackPicker(fieldValue: $priorityString, fieldName: PropertyType.priority.toString(), options: .constant(PriorityType.allCases.map({$0.toString()})),iconType: .priority)
                .modifier(ModifierFormValidator(fieldPropertyValidator: $validator.priority, isDirtyForm: $validator.isDirty, propertyType: .priority))

        case .chapter:
            if hasChapterId {
                let chapter = vm.GetChapter(id: properties.chapterId!)
                FormLabel(fieldValue: chapter?.title ?? "", fieldName: PropertyType.chapter.toString(), iconType: .chapter, shouldShowLock: true)
            }
            else{
                let chapters = vm.ListChapters()
                FormStackPicker(fieldValue: $chapterString, fieldName: PropertyType.chapter.toString(), options: .constant(chapters.map({$0.title})), iconType: .chapter)
                    .modifier(ModifierFormValidator(fieldPropertyValidator: $validator.chapter, isDirtyForm: $validator.isDirty, propertyType: .chapter))
            }
        case .images:
            FormImages(fieldValue: $images, shouldPopImagesModal: $isPresentingPhotoSource, fieldName: PropertyType.images.toString(), iconType: .photo)
        case .scheduleType:
            if isRecurring {
                if modalType == .add{
                    FormStackPicker(fieldValue: $scheduleTimeframeString, fieldName: "Schedule " + PropertyType.timeframe.toString(), options: .constant([TimeframeType.day.toString(), TimeframeType.week.toString()]),iconType: .timeframe)
                        .modifier(ModifierFormValidator(fieldPropertyValidator: $validator.timeframe, isDirtyForm: $validator.isDirty, propertyType: .timeframe))
                    
                    FormStackPicker(fieldValue: $scheduleString, fieldName: PropertyType.scheduleType.toString(), options: $scheduleOptions, iconType: .dates, isSearchable: false)
                        .modifier(ModifierFormValidator(fieldPropertyValidator: $validator.scheduleType, isDirtyForm: $validator.isDirty, propertyType: .scheduleType))
                }
                else{
                    FormLabel(fieldValue: scheduleTimeframeString, fieldName: "Schedule " + PropertyType.timeframe.toString(), iconType: .timeframe, shouldShowLock: true)
                    FormLabel(fieldValue: scheduleString, fieldName: PropertyType.scheduleType.toString(), iconType: .dates, shouldShowLock: true)
                }
            }
        case .amount:
            if schedule.shouldShowAmount() == true && isRecurring{
                
                if modalType == .add{
                    FormCounter(fieldValue: $amount, fieldName: GetAmountFieldName(), iconType: .dates, maxValue: ComputeMaxValue())
                        .modifier(ModifierFormValidator(fieldPropertyValidator: $validator.amount, isDirtyForm: $validator.isDirty, propertyType: .amount))
                }
                else{
                    FormLabel(fieldValue: String(amount), fieldName: GetAmountFieldName(), iconType: .dates, shouldShowLock: true)
                }
            }
        case .unit:
            if schedule.shouldShowAmount() == true && isRecurring {
                
                if modalType == .add{
                    FormStackPicker(fieldValue: $unitString, fieldName: PropertyType.unit.toString(), options: .constant(UnitType.allCases.map({$0.toString()})), iconType: .ruler)
                        .modifier(ModifierFormValidator(fieldPropertyValidator: $validator.unit, isDirtyForm: $validator.isDirty, propertyType: .unit))
                }
                else{
                    FormLabel(fieldValue: unitString, fieldName: PropertyType.unit.toString(), iconType: .ruler, shouldShowLock: true)
                }
            }
        case .isRecurring:
            FormRadioButton(fieldValue: $isRecurring, caption: "Track repetitive tasks", fieldName: PropertyType.isRecurring.toString(), iconType: .habit, selectedColor: .lightPurple)
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
    
    func ComputeMaxValue() -> Int{
        switch scheduleTimeframe {
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
}

struct FormPropertiesStack_Previews: PreviewProvider {
    static var previews: some View {
        FormPropertiesStack(properties: .constant(Properties()), images: .constant([UIImage]()), isPresentingPhotoSource: .constant(false), isValidForm: .constant(true), didAttemptToSave: .constant(false), objectType: .goal, modalType: .search)
    }
}
