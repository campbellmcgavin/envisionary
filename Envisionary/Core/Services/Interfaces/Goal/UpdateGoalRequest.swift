//
//  UpdateGoalRequest.swift
//  Envisionary
//
//  Updated by Campbell McGavin on 3/27/23.
//

import Foundation

struct UpdateGoalRequest{
    
    var title: String = ""
    var description: String = ""
    var priority: PriorityType = .moderate
    var startDate: Date?
    var endDate: Date?
    var progress: Int = 0
    var image: UUID? = nil
    var aspect: String = AspectType.academic.toString()
    var parent: UUID? = nil
    var valuesDictionary: [String:Bool]? = nil
    var archived: Bool = false
    var completedDate: Date? = nil
    var reorderGoalId: UUID? = nil
    var reorderPlacement: PlacementType? = nil
    var position: String = ""
    var superId: UUID?
    
//    var isRecurring: Bool
//    var amount: Int?
//    var unitOfMeasure: UnitType?
//    var timeframe: TimeframeType?
//    var schedule: ScheduleType?

    init(title: String, description: String, priority: PriorityType, startDate: Date?, endDate: Date?, percentComplete: Int, image: UUID, aspect: String, parent: UUID, valuesDictionary: [String:Bool], archived: Bool, completedDate: Date?, superId: UUID?)//, isRecurring: Bool, amount: Int?, unitOfMeasure: UnitType?, timeframe: TimeframeType?, schedule: ScheduleType?)
    {
        self.title = title
        self.description = description
        self.priority = priority
        self.startDate = startDate
        self.endDate = endDate
        self.progress = percentComplete
        self.image = image
        self.aspect = aspect
        self.parent = parent
        self.valuesDictionary = valuesDictionary
        self.archived = archived
        self.completedDate = completedDate
        
//        self.isRecurring = isRecurring
//        self.amount = amount
//        self.unitOfMeasure = unitOfMeasure
//        self.timeframe = timeframe
//        self.schedule = schedule
    }
    
    init(goal: Goal){
        self.title = goal.title
        self.description = goal.description
        self.priority = goal.priority
        self.startDate = goal.startDate
        self.endDate = goal.endDate
        self.progress = goal.progress
        self.image = goal.image
        self.aspect = goal.aspect
        self.parent = goal.parentId
        self.archived = goal.archived
        self.position = goal.position
        self.completedDate = goal.completedDate
        self.superId = goal.superId
        
//        self.isRecurring = goal.isRecurring
//        self.amount = goal.amount
//        self.unitOfMeasure = goal.unitOfMeasure
//        self.timeframe = goal.timeframe
//        self.schedule = goal.schedule
    }
    
    func hasDates() -> Bool{
        return self.startDate != nil && self.endDate != nil
    }
    
    init(properties: Properties){
        self.title = properties.title ?? ""
        self.description = properties.description ?? ""
        self.priority = properties.priority ?? .critical
        self.startDate = properties.startDate
        self.endDate = properties.endDate
        self.progress = properties.progress ?? 0
        self.image = properties.image
        self.aspect = properties.aspect ?? AspectType.academic.toString()
        self.parent = properties.parentGoalId
        self.archived = properties.archived ?? false
        self.position = properties.position ?? ""
        self.completedDate = properties.completedDate
        self.superId = properties.superId
        
//        self.isRecurring = properties.isRecurring ?? false
//        self.amount = properties.amount
//        self.unitOfMeasure = properties.unitOfMeasure
//        self.timeframe = properties.timeframe
//        self.schedule = properties.schedule
    }
}
