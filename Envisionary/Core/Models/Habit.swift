//
//  Habit.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/19/23.
//

import SwiftUI

struct Habit: Identifiable, Codable, Equatable, Hashable{
    let id: UUID
    var title: String
    var description: String
    var aspect: AspectType
    var timeframe: TimeframeType
    var schedule: ScheduleType
    var priority: PriorityType
    var startDate: Date
    var endDate: Date
    var goalId: UUID?
    var image: UUID?
    var amount: Int?
    var unitOfMeasure: UnitType
    
    init(from entity: HabitEntity){
        self.id = entity.id ?? UUID()
        self.title = entity.title ?? ""
        self.description = entity.desc ?? ""
        self.priority = PriorityType.allCases.first(where: {$0.toString() == entity.priority ?? ""}) ?? .low
        self.startDate = entity.startDate ?? Date()
        self.endDate = entity.endDate ?? Date()
        self.aspect = AspectType.fromString(input: entity.aspect ?? "")
        self.timeframe = TimeframeType.fromString(input: entity.timeframe ?? "")
        self.image = entity.image
        self.amount = Int(entity.amount)
        self.unitOfMeasure = UnitType.fromString(input: entity.unitOfMeasure ?? "")
        self.schedule = ScheduleType.fromString(input: entity.schedule ?? "")
    }
    
    init(){
        id = UUID()
        title = "New Habit"
        description = ""
        aspect = .academic
        timeframe = .day
        schedule = .morning
        priority = .low
        startDate = Date()
        endDate = Date()
        goalId = UUID()
        image = UUID()
        unitOfMeasure = .minutes
    }
}
