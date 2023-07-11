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
    
    @State var title = ""
    @State var description = ""
    
    @State var aspectString = ""
    
    @State var priorityString = ""
    
    @State var timeframe = TimeframeType.day
    @State var timeframeString = ""
    
    @State var scheduleTimeframe = TimeframeType.day
    @State var scheduleTimeframeString = ""
    
    @State var startDate = Date()
    @State var numberOf = 0
    @State var endDate = Date()
    @State var filteredValues = [ValueType]()
    @State var chapterString = ""
    @State var hasChapterId: Bool = false
    
    @State var scheduleString = ""
    @State var schedule = ScheduleType.oncePerDay
    @State var scheduleOptions = [String]()
    
    @State var amount = 0
    
    @State var unit = UnitType.minutes
    @State var unitString = ""
    
    @State var emotionStringDictionary = [String:Bool]()
    @State var emotionStringOptions = [String:[String]]()
    
    @State var activityStringDictionary = [String:Bool]()
    @State var activityStringOptions = [String]()
    
    @State var emotionalState: Int = 3
    
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
            scheduleString = properties.scheduleType?.toString() ?? schedule.toString()
            scheduleOptions = GetSchedules()
            unitString = unit.toString()
            
            validator.reset()
            validator.validateForm(properties: properties, objectType: objectType)
            isValidForm = validator.isValidForm()
            didAttemptToSave = false
            titleDirtyTimer.upstream.connect().cancel()
            
            emotionStringDictionary = FillEmotionDictionary()
            emotionStringOptions = FillEmotionOptions()
            
            activityStringDictionary = FillActivitiesDictionary()
            activityStringOptions = vm.ListActivities().map({$0.keyword})
            
            let chapters = vm.ListChapters()
            chapterString = chapters.first(where: {$0.id == properties.chapterId})?.title ?? ""
            hasChapterId = properties.chapterId != nil
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
        .onChange(of: vm.updates.activity){
            _ in
            activityStringDictionary = FillActivitiesDictionary()
            activityStringOptions = vm.ListActivities().map({$0.keyword})
        }
        .onChange(of: emotionStringDictionary){ _ in
            
            let dictionaryToList = emotionStringDictionary.filter({$0.value}).keys
            properties.emotionList = dictionaryToList.map({EmotionType.fromString(from: $0)})
        }
        .onChange(of: activityStringDictionary){
            _ in
            let dictionaryToList = activityStringDictionary.filter({$0.value}).keys
            properties.activityList = Array(dictionaryToList)
        }
        .onChange(of: emotionalState){
            _ in
            properties.emotionalState = emotionalState
        }
        .onReceive(titleDirtyTimer){ _ in
            titleDirtyTimer.upstream.connect().cancel()
            validator.title.isDirty = true
        }
        .onReceive(setupTimer){ _ in
            titleDirtyTimer.upstream.connect().cancel()
            isSettingUp = false
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
        case .timeframe:
            if parentGoalId != nil {
                FormLabel(fieldValue: timeframeString, fieldName: PropertyType.timeframe.toString(), iconType: .timeframe, shouldShowLock: true)
            }
            else{
                FormStackPicker(fieldValue: $timeframeString, fieldName: PropertyType.timeframe.toString(), options: .constant(TimeframeType.allCases.map({$0.toString()})),iconType: .timeframe)
                    .modifier(ModifierFormValidator(fieldPropertyValidator: $validator.timeframe, isDirtyForm: $validator.isDirty, propertyType: .timeframe))
            }
        case .startDate:
            FormCalendarPicker(fieldValue: $startDate, fieldName: GetStartDateFieldName(), timeframeType: $timeframe, iconType: .dates, isStartDate: true)
                .modifier(ModifierFormValidator(fieldPropertyValidator: $validator.startDate, isDirtyForm: $validator.isDirty, propertyType: .startDate))
        case .endDate:
            FormCounter(fieldValue: $numberOf, fieldName: GetNumberOfFieldName(), iconType: .dates, maxValue: ComputeMaxValue())
            FormLabel(fieldValue: endDate.toString(timeframeType: timeframe, isStartDate: false), fieldName: PropertyType.endDate.toString(), iconType: .dates, shouldShowLock: true)
        case .aspect:
            if objectType != .aspect{
                if parentGoalId != nil {
                    FormLabel(fieldValue: aspectString, fieldName: PropertyType.aspect.toString(), iconType: .aspect, shouldShowLock: true)
                }
                else{
                    FormStackPicker(fieldValue: $aspectString, fieldName: PropertyType.aspect.toString(), options: .constant(vm.ListAspects().map({$0.title})),iconType: .aspect)
                        .modifier(ModifierFormValidator(fieldPropertyValidator: $validator.aspect, isDirtyForm: $validator.isDirty, propertyType: .aspect))
                }
            }
        case .priority:
            FormStackPicker(fieldValue: $priorityString, fieldName: PropertyType.priority.toString(), options: .constant(PriorityType.allCases.map({$0.toString()})),iconType: .priority)
                .modifier(ModifierFormValidator(fieldPropertyValidator: $validator.priority, isDirtyForm: $validator.isDirty, propertyType: .priority))
//        case .coreValue:

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
            FormStackPicker(fieldValue: $scheduleTimeframeString, fieldName: "Schedule " + PropertyType.timeframe.toString(), options: .constant([TimeframeType.day.toString(), TimeframeType.week.toString()]),iconType: .timeframe)
            FormStackPicker(fieldValue: $scheduleString, fieldName: PropertyType.scheduleType.toString(), options: $scheduleOptions, iconType: .dates, isSearchable: false)
                .modifier(ModifierFormValidator(fieldPropertyValidator: $validator.scheduleType, isDirtyForm: $validator.isDirty, propertyType: .scheduleType))
        case .amount:
            if schedule.shouldShowAmount(){
                FormCounter(fieldValue: $amount, fieldName: GetAmountFieldName(), iconType: .dates, maxValue: ComputeMaxValue())
                    .modifier(ModifierFormValidator(fieldPropertyValidator: $validator.amount, isDirtyForm: $validator.isDirty, propertyType: .amount))
            }
            else if objectType == .emotion{
                FormEmotionalStatePicker(fieldValue: $amount, fieldName: "Emotional State")
            }
        case .unit:
            if schedule.shouldShowAmount() {
                FormStackPicker(fieldValue: $unitString, fieldName: PropertyType.unit.toString(), options: .constant(UnitType.allCases.map({$0.toString()})), iconType: .chapter)
                    .modifier(ModifierFormValidator(fieldPropertyValidator: $validator.unit, isDirtyForm: $validator.isDirty, propertyType: .unit))
            }
        case .emotions:
            FormStackGroupedMultiPicker(fieldValues: $emotionStringDictionary, fieldName: "Emotions", groupedOptions: $emotionStringOptions, iconType: .timeframe)
        case .activities:
            FormStackMultiPicker(fieldValues: $activityStringDictionary, fieldName: "Activities", options: $activityStringOptions, iconType: .run, isSearchable: true, isActivityPicker: true)
        case .emotionalState:
            FormEmotionalStatePicker(fieldValue: $emotionalState, fieldName: "Emotional State")
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
    
    func FillEmotionDictionary() -> [String: Bool]{
        var emotionDictionary = [String:Bool]()
        
        for emotion in EmotionType.allCases{
            emotionDictionary[emotion.toString()] = false
        }
        
        return emotionDictionary
    }
    
    func FillEmotionOptions() -> [String:[String]]{
        var groupedDictionary = [String:[String]]()
        for parentEmotion in EmotionType.allCases.filter({$0.isParentEmotion()}){
            
            var childEmotionList = [String]()
            
            for childEmotion in EmotionType.allCases.filter({$0.toParentEmotion() == parentEmotion}){
                childEmotionList.append(childEmotion.toString())
            }
            groupedDictionary[parentEmotion.toString()] = childEmotionList
        }
        return groupedDictionary
    }
    
    func FillActivitiesDictionary() -> [String: Bool]{
        var activitiesDictionary = [String:Bool]()
        let activities = vm.ListActivities()
        
        for activity in activities{
            if let selectedActivity = self.activityStringDictionary[activity.keyword]{
                activitiesDictionary[activity.keyword] = selectedActivity
            }
            else{
                activitiesDictionary[activity.keyword] = false
            }
        }
        
        return activitiesDictionary
    }
}

struct FormPropertiesStack_Previews: PreviewProvider {
    static var previews: some View {
        FormPropertiesStack(properties: .constant(Properties()), images: .constant([UIImage]()), isPresentingPhotoSource: .constant(false), isValidForm: .constant(true), didAttemptToSave: .constant(false), objectType: .goal, modalType: .search)
    }
}
