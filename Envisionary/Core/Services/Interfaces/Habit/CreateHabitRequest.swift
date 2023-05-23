//
//  CreateHabitRequest.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/20/23.
//

import SwiftUI

struct CreateHabitRequest {
    var title: String = ""
    var description: String = ""
    var priority: PriorityType = .moderate
    var startDate: Date = Date()
    var endDate: Date = Date()
    var schedule: ScheduleType
    var amount: Int
    var unitOfMeasure: UnitType
    var image: UUID? = nil
    var aspect: AspectType = .academic
    var timeframe: TimeframeType = .day
    
    init(properties: Properties){
        self.title = properties.title ?? ""
        self.description = properties.description ?? ""
        self.priority = properties.priority ?? .critical
        self.startDate = properties.startDate ?? Date()
        self.endDate = properties.endDate ?? Date()
        self.image = properties.image
        self.aspect = properties.aspect ?? .academic
        self.timeframe = properties.timeframe ?? .day
        self.schedule = properties.scheduleType ?? .aCertainAmountOverTime
        self.unitOfMeasure = properties.unitOfMeasure ?? .minutes
        self.amount = properties.amount ?? 0
    }
}
