//
//  CreateGoalRequest.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/27/23.
//

import Foundation

struct CreateGoalRequest{
    
    var title: String = ""
    var description: String = ""
    var priority: PriorityType = .moderate
    var startDate: Date = Date()
    var endDate: Date = Date()
    var progress: Int = 0
    var image: UUID? = nil
    var aspect: String = AspectType.academic.toString()
    var parentId: UUID? = nil
    var previousGoalId: UUID? = nil
    var superId: UUID? = nil
    
//    var isRecurring: Bool
//    var amount: Int?
//    var unitOfMeasure: UnitType?
//    var timeframe: TimeframeType?
//    var schedule: ScheduleType?

    init(title: String, description: String, priority: PriorityType, startDate: Date, endDate: Date, percentComplete: Int, image: UUID?, aspect: String, parent: UUID?,  previousGoalId: UUID? = nil, superId: UUID?)//, isRecurring: Bool, amount: Int?, unitOfMeasure: UnitType?, timeframe: TimeframeType?, schedule: ScheduleType?)
    {
        self.title = title
        self.description = description
        self.priority = priority
        self.startDate = startDate
        self.endDate = endDate
        self.progress = percentComplete
        self.image = image
        self.aspect = aspect
        self.parentId = parent
        self.previousGoalId = previousGoalId
        self.superId = superId
        
//        self.isRecurring = isRecurring
//        self.amount = amount
//        self.unitOfMeasure = unitOfMeasure
//        self.timeframe = timeframe
//        self.schedule = schedule
    }
    
    init(properties: Properties){
        self.title = properties.title ?? ""
        self.description = properties.description ?? ""
        self.priority = properties.priority ?? .critical
        self.startDate = properties.startDate ?? Date()
        self.endDate = properties.endDate ?? Date()
        self.progress = properties.progress ?? 0
        self.image = properties.image
        self.aspect = properties.aspect ?? AspectType.academic.toString()
        self.parentId = properties.parentGoalId
        self.superId = properties.superId == nil ? self.parentId : self.superId
        
//        self.isRecurring = properties.isRecurring ?? false
//        self.amount = properties.amount
//        self.unitOfMeasure = properties.unitOfMeasure
//        self.timeframe = properties.timeframe
//        self.schedule = properties.schedule
    }
}
