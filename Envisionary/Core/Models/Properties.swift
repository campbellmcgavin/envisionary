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
    var superId: UUID?
    
    var start: String?
    var end: String?
    
    var schedule: ScheduleType?
    var amount: Int?
    var unitOfMeasure: UnitType?
    var habitId: UUID?
    var isRecurring: Bool?
    
    //sessions
    var date: Date?
    var completedDate: Date?
    var goalProperties: [Properties]?
    var evaluationDictionary: [UUID: EvaluationType]?
    var alignmentDictionary: [UUID: [String:Bool]]?
    var childrenAddedDictionary: [UUID: [UUID]]?
    
    //prompt
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
        self.superId = goal?.superId
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
            if isRecurring != true{
                return nil
            }
            return .fieldCannotBeEmpty
        case .unit:
            if isRecurring != true{
                return nil
            }
            return .fieldCannotBeEmpty
        case .amount:
            if isRecurring != true{
                return nil
            }
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
            if isRecurring != true{
                return true
            }
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
            if isRecurring != true{
                return true
            }
            return schedule != nil
        case .unit:
            if isRecurring != true{
                return true
            }
            if let schedule{
                if schedule.shouldShowAmount(){
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
            if isRecurring != true{
                return true
            }
            if let schedule{
                if schedule.shouldShowAmount(){
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
