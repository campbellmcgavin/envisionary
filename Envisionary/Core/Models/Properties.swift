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
    var valueId: UUID?
    
    var title: String?
    var coreValue: String?
    var aspect: String?
    var description: String?
    var timeframe: TimeframeType?
    var startDate: Date?
    var endDate: Date?
    var priority: PriorityType?
    var progress: Int?
    var image: UUID?
    var images: [UUID]?
    var position: String?
    
    var start: String?
    var end: String?
    
    var scheduleType: ScheduleType?
    var amount: Int?
    var unitOfMeasure: UnitType?
    var habitId: UUID?
    
    
    //sessions
    var date: Date?
    var completedDate: Date?
    var goalProperties: [Properties]?
    var evaluationDictionary: [UUID: EvaluationType]?
    var alignmentDictionary: [UUID: [String:Bool]]?
    var childrenAddedDictionary: [UUID: [UUID]]?
    
    //prompt
    var promptType: PromptType?
    var objectType: ObjectType?
    var objectId: UUID?
    
    //archiving
    var archived: Bool?
    
    init(objectType: ObjectType){
        timeframe = .day
        startDate = Date()
        endDate = Date()
        aspect = AspectType.allCases.randomElement()!.toString()
        priority = PriorityType.allCases.randomElement()!
        title = "Learn Spanish"
        description = "I want to learn Spanish using duo lingo over a period of 12 months. I will spend 4 hours per day, 5 days per week. I will track my metrics using the app interface and then use people I can hold myself accountable to."
        parentGoalId = nil
        image = nil
        id = UUID()
    }
    
    init(){
        id = UUID()
    }
    
    init(recurrence: Recurrence?){
        self.id = recurrence?.id ?? UUID()
        self.parentGoalId = recurrence?.habitId ?? UUID()
        self.scheduleType = recurrence?.scheduleType ?? .oncePerDay
        self.amount = recurrence?.amount ?? 0
        self.habitId = recurrence?.habitId
        self.archived = recurrence?.archived
    }
    
    init(goal: Goal?){
        self.id = goal?.id ?? UUID()
        self.title = goal?.title ?? "Empty Goal"
        self.description = goal?.description ?? "Empty Description"
        self.startDate = goal?.startDate
        self.endDate = goal?.endDate
        self.aspect = goal?.aspect
        self.priority = goal?.priority
        self.progress = goal?.progress
        self.parentGoalId = goal?.parentId
        self.image = goal?.image
        self.archived = goal?.archived
        self.position = goal?.position
    }
    
    init(dream: Dream?){
        self.id = dream?.id ?? UUID()
        self.title = dream?.title ?? "Empty Dream"
        self.description = dream?.description ?? "Empty Description"
        self.aspect = dream?.aspect
        self.image = dream?.image
        self.archived = dream?.archived
    }
    
    init(value: CoreValue?){
        self.id = value?.id ?? UUID()
        self.title = value?.title ?? "Empty Value"
        self.coreValue = value?.title
        self.description = value?.description ?? "Empty Description"
        self.image = value?.image
    }
    
    init(aspect: Aspect?){
        self.id = aspect?.id ?? UUID()
        self.title = aspect?.title ?? "Empty Value"
        self.description = aspect?.description ?? "Empty Description"
        self.image = aspect?.image
    }
    
    init(creed: Bool, valueCount: Int){
        self.id = UUID()
        self.title = "Life's Creed"
        self.description = "Your personalized life's mission statement, with a total of " + String(valueCount - 2) + " values."
        self.start = "Birth"
        self.end = "Death"
    }
    
    init(valueRating: CoreValueRating){
        self.id = valueRating.id
        self.parentGoalId = valueRating.parentGoalId
        self.valueId = valueRating.coreValueId
        self.amount = valueRating.amount
    }
    
    init(chapter: Chapter?){
        self.id = chapter?.id ?? UUID()
        self.title = chapter?.title ?? "Empty Chapter"
        self.description = chapter?.description ?? "Empty Description"
        self.aspect = chapter?.aspect
        self.image = chapter?.image
        self.archived = chapter?.archived
    }
    init(entry: Entry?){
        self.id = entry?.id ?? UUID()
        self.title = entry?.title
        self.description = entry?.description
        self.images = entry?.images
        self.chapterId = entry?.chapterId
        self.startDate = entry?.startDate
        self.archived = entry?.archived
    }
    
    init(prompt: Prompt?){
        self.id = prompt?.id ?? UUID()
        self.title = prompt?.title ?? ""
        self.promptType = prompt?.type ?? .favorite
        self.date = prompt?.date ?? Date()
        self.objectType = prompt?.objectType ?? .goal
        self.objectId = prompt?.objectId ?? UUID()
        self.timeframe = prompt?.timeframe ?? .day
    }
    
    init(session: Session?){
        self.id = session?.id ?? UUID()
        self.title = session?.title ?? ""
        self.date = session?.date ?? Date()
        self.completedDate = session?.dateCompleted ?? Date()
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
        self.archived = habit?.archived
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
        case .endDate:
            if endDate == nil{
                return .fieldCannotBeEmpty
            }
            if startDate == nil{
                return .fieldCannotBeEmpty
            }
            if (startDate!.isAfter(date: endDate!)){
                return .fieldCannotBeBefore
            }
            return nil
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
                if title.count > 2 && title.count < 51{
                    return true
                }
                else if title.count >= 51 {
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
            return endDate != nil && startDate != nil && !startDate!.isAfter(date: endDate!)
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
