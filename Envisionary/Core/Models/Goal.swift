//
//  Goal.swift
//  Visionary
//
//  Created by Campbell McGavin on 12/31/21.
//

import Foundation
import SwiftUI

struct Goal: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    var title: String
    var description: String
    var priority: PriorityType
    var startDate: Date?
    var endDate: Date?
    var completedDate: Date?
    var progress: Int
    var aspect: String
    var image: UUID?
    var parentId: UUID?
    var superId: UUID?
    var archived: Bool
    var position: String
    
//    var isRecurring: Bool
//    var amount: Int?
//    var unitOfMeasure: UnitType?
//    var timeframe: TimeframeType?
//    var schedule: ScheduleType?
    
    init(id: UUID = UUID(), title: String, description: String, priority: PriorityType, startDate: Date?, endDate: Date?, percentComplete: Int, aspect: String, image: UUID?, parent: UUID?, position: String, superId: UUID?){//}, isRecurring: Bool, amount: Int?, unitOfMeasure: UnitType?, timeframe: TimeframeType?, schedule: ScheduleType?){
        self.id = id
        self.title = title
        self.description = description
        self.priority = priority
        self.startDate = startDate
        self.endDate = endDate
        self.progress = percentComplete
        self.image = image
        self.aspect = aspect
        self.parentId = parent
        self.archived = false
        self.position = position
        self.superId = superId
        
//        self.isRecurring = isRecurring
//        self.amount = amount
//        self.unitOfMeasure = unitOfMeasure
//        self.timeframe = timeframe
//        self.schedule = schedule
    }
    
    init(emptyTitle: Bool = false){
        self.id = UUID()
        self.title = emptyTitle ? "" : "New Goal with a long name"
        self.description = ""
        self.priority = .moderate
        self.progress = 0
        self.aspect = AspectType.academic.toString()
        self.archived = false
        self.position = "A"
        self.superId = nil
    }
    
    init(from entity: GoalEntity){
        self.id = entity.id ?? UUID()
        self.title = entity.title ?? ""
        self.description = entity.desc ?? ""
        self.priority = PriorityType.allCases.first(where: {$0.toString() == entity.priority ?? ""}) ?? .low
        self.startDate = entity.startDate
        self.endDate = entity.endDate
        self.progress = Int(entity.progress)
        self.aspect = entity.aspect ?? ""
        self.image = entity.image
        self.parentId = entity.parentId
        self.archived = entity.archived
        self.position = entity.position ?? ""
        self.completedDate = entity.completedDate
        self.superId = entity.superId
        
//        self.isRecurring = entity.isRecurring
//        self.amount = Int(entity.amount)
//        self.unitOfMeasure = UnitType.fromString(input: entity.unitOfMeasure ?? "")
//        self.timeframe = TimeframeType.fromString(input: entity.timeframe ?? "")
//        self.schedule = ScheduleType.fromString(input: entity.schedule ?? "")
    }
    
    func hasDates() -> Bool{
        return self.startDate != nil && self.endDate != nil
    }
    
    mutating func update(from request: UpdateGoalRequest) {
        title = request.title
        description = request.description
        priority = request.priority
        startDate = request.startDate
        endDate = request.endDate
        progress = request.progress
        image = request.image
        aspect = request.aspect
        parentId = request.parent
        archived = request.archived
        position = request.position
        completedDate = request.completedDate
        superId = request.superId
        
//        isRecurring = request.isRecurring
//        amount = request.amount
//        unitOfMeasure = request.unitOfMeasure
//        timeframe = request.timeframe
//        schedule = request.schedule
    }
}
