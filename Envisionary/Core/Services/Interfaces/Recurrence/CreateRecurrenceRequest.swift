//
//  CreateRecurrenceRequest.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/21/23.
//

import SwiftUI

struct CreateRecurrenceRequest {
    var goalId: UUID
    var scheduleType: ScheduleType
    var startDate: Date
    var endDate: Date
    var timeOfDay: TimeOfDayType
    
    init(goalId: UUID, scheduleType: ScheduleType, timeOfDay: TimeOfDayType, startDate: Date, endDate: Date){
        self.goalId = goalId
        self.scheduleType = scheduleType
        self.startDate = startDate
        self.endDate = endDate
        self.timeOfDay = timeOfDay
    }
}
