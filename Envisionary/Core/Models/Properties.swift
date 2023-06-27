//
//  Properties.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/15/23.
//

import Foundation

struct Properties: Identifiable, Equatable, Hashable, Codable{
    let id: UUID
    var chapterId: UUID?
    var parentGoalId: UUID?
    
    var title: String?
    var coreValue: String??
    var aspect: AspectType?
    var description: String?
    var timeframe: TimeframeType?
    var startDate: Date?
    var endDate: Date?
    var priority: PriorityType?
    var progress: Int?
    var image: UUID?
    var images: [UUID]?
    
    var start: String?
    var end: String?
    
    var valuesDictionary: [String: Bool]?
    
    var scheduleType: ScheduleType?
    var amount: Int?
    var unitOfMeasure: UnitType?
    var habitId: UUID?
    
    
    //sessions
    var date: Date?
    var dateCompleted: Date?
    var goalProperties: [Properties]?
    var evaluationDictionary: [UUID: EvaluationType]?
    var alignmentDictionary: [UUID: [String:Bool]]?
    var childrenAddedDictionary: [UUID: [UUID]]?
    
    //emotions
    var emotionList: [EmotionType]?
    var activityList: [String]?
    var emotionalState: Int?
    
    init(objectType: ObjectType){
        timeframe = .day
        startDate = Date()
        endDate = Date()
        aspect = AspectType.allCases.randomElement()!
        priority = PriorityType.allCases.randomElement()!
        title = "Learn Spanish"
        description = "I want to learn Spanish using duo lingo over a period of 12 months. I will spend 4 hours per day, 5 days per week. I will track my metrics using the app interface and then use people I can hold myself accountable to."
        parentGoalId = nil
        image = nil
        id = UUID()
    }
    
    init(){
        timeframe = nil
        startDate = nil
        endDate = nil
        aspect = nil
        priority = nil
        title = nil
        description = nil
        parentGoalId = nil
        image = nil
        images = nil
        id = UUID()
    }
    
    init(recurrence: Recurrence?){
        self.id = recurrence?.id ?? UUID()
        self.parentGoalId = recurrence?.habitId ?? UUID()
        self.scheduleType = recurrence?.scheduleType ?? .oncePerDay
        self.amount = recurrence?.amount ?? 0
        self.habitId = recurrence?.habitId
    }
    
    init(goal: Goal?){
        self.id = goal?.id ?? UUID()
        self.title = goal?.title ?? "Empty Goal"
        self.description = goal?.description ?? "Empty Description"
        self.timeframe = goal?.timeframe
        self.startDate = goal?.startDate
        self.endDate = goal?.endDate
        self.aspect = goal?.aspect
        self.priority = goal?.priority
        self.progress = goal?.progress
        self.parentGoalId = goal?.parentId
        self.image = goal?.image
    }
    
    init(dream: Dream?){
        self.id = dream?.id ?? UUID()
        self.title = dream?.title ?? "Empty Dream"
        self.description = dream?.description ?? "Empty Description"
        self.aspect = dream?.aspect
        self.image = dream?.image
    }
    
    init(value: CoreValue?){
        self.id = value?.id ?? UUID()
        self.title = value?.title ?? "Empty Value"
        self.coreValue = value?.title
        self.description = value?.description ?? "Empty Description"
    }
    
    init(aspect: Aspect?){
        self.id = aspect?.id ?? UUID()
        self.title = aspect?.aspect.toString() ?? "Empty Value"
        self.aspect = aspect?.aspect ?? .personal
        self.description = aspect?.description ?? "Empty Description"
    }
    
//    init(task: Task?){
//        self.id = task?.id ?? UUID()
//        self.title = task?.title ?? "Empty Value"
//        self.description = task?.description ?? "Empty Description"
//        self.startDate = task?.startDate
//        self.endDate = task?.endDate
//        self.progress = task?.progress
//    }
    
    init(creed: Bool, valueCount: Int){
        self.id = UUID()
        self.title = "Life's Creed"
        self.description = "Your personalized life's mission statement, with a total of " + String(valueCount - 2) + " values."
        self.start = "Birth"
        self.end = "Death"
    }
    
    init(chapter: Chapter?){
        self.id = chapter?.id ?? UUID()
        self.title = chapter?.title ?? "Empty Chapter"
        self.description = chapter?.description ?? "Empty Description"
        self.aspect = chapter?.aspect
        self.image = chapter?.image
    }
    init(entry: Entry?){
        self.id = entry?.id ?? UUID()
        self.title = entry?.title
        self.description = entry?.description
        self.images = entry?.images
        self.chapterId = entry?.chapterId
        self.startDate = entry?.startDate
    }
    
    init(session: Session?){
        self.id = session?.id ?? UUID()
        self.title = session?.date.toString(timeframeType: session?.timeframe ?? .day)
        self.date = session?.date ?? Date()
        self.dateCompleted = session?.dateCompleted ?? Date()
        self.timeframe = session?.timeframe ?? .week
        self.goalProperties = session?.goalProperties
        self.evaluationDictionary = session?.evaluationDictionary
        self.alignmentDictionary = session?.alignmentDictionary
        self.childrenAddedDictionary = session?.childrenAddedDictionary
    }
    
    init(habit: Habit?){
        self.id = habit?.id ?? UUID()
        self.title = habit?.title ?? "Empty Goal"
        self.description = habit?.description ?? "Empty Description"
        self.timeframe = habit?.timeframe
        self.startDate = habit?.startDate
        self.endDate = habit?.endDate
        self.aspect = habit?.aspect
        self.priority = habit?.priority
        self.parentGoalId = habit?.goalId
        self.image = habit?.image
        self.amount = habit?.amount
        self.unitOfMeasure = habit?.unitOfMeasure
        self.scheduleType = habit?.schedule
    }
    
    init(emotion: Emotion?){
        self.id = emotion?.id ?? UUID()
        self.emotionList = emotion?.emotionList
        self.activityList = emotion?.activityList
        self.title = "Check-in"
        self.startDate = emotion?.date
        self.emotionalState = emotion?.emotionalState
    }
    
    func getFormError(propertyType: PropertyType) -> FormErrorType?{
        switch propertyType {
        case .title:
            if let title = self.title{
                if title.count > 2 && title.count < 24{
                    return nil
                }
                else if title.count >= 24 {
                    return .fieldIsTooLong
                }
                else {
                    return .fieldIsTooShort
                }
            }
            return .fieldCannotBeEmpty
        case .timeframe:
            return .fieldCannotBeEmpty
        case .date:
            return .fieldCannotBeEmpty
        case .startDate:
            return .fieldCannotBeEmpty
        case .aspect:
            return .fieldCannotBeEmpty
        case .priority:
            return .fieldCannotBeEmpty
        case .chapter:
            return .fieldCannotBeEmpty
        case .scheduleType:
            return .fieldCannotBeEmpty
        case .unit:
            return .fieldCannotBeEmpty
        case .amount:
            return .fieldCannotBeZero
        case .habitId:
            return .fieldCannotBeEmpty
        default:
            return nil
        }
    }
    
    func isValid(propertyType: PropertyType, objectType: ObjectType) -> Bool{
        switch propertyType {
        case .title:
            if let title = self.title{
                if title.count > 2 && title.count < 40{
                    return true
                }
                else if title.count >= 24 {
                    return false
                }
                else {
                    return false
                }
            }
            else{
                return false
            }
        case .timeframe:
            return timeframe != nil
        case .date:
            return date != nil
        case .startDate:
            return startDate != nil
        case .endDate:
            return timeframe != nil
        case .aspect:
            return aspect != nil
        case .priority:
            return priority != nil
        case .chapter:
            return chapterId != nil
        case .scheduleType:
            return scheduleType != nil
        case .unit:
            if let scheduleType{
                if scheduleType.shouldShowAmount(){
                    if let _ = unitOfMeasure {
                        return true
                    }
                }
                else{
                    return true
                }
            }
            return false
        case .amount:
            if let scheduleType{
                if scheduleType.shouldShowAmount(){
                    if let amount {
                        return amount > 0
                    }
                }
                else{
                    return true
                }
            }
            return false
        case .habitId:
            return self.habitId != nil
        default:
            return true
        }
    }
}
