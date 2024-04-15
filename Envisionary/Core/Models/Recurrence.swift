//
//  Recurrence.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/21/23.
//

import SwiftUI

struct Recurrence: Identifiable, Codable, Equatable, Hashable{
    let id: UUID
    let parentId: UUID
    var isComplete: Bool
    let scheduleType: ScheduleType
    var amount: Int
    let timeOfDay: TimeOfDayType
    let startDate: Date
    let endDate: Date
    let archived: Bool
    
    init(from entity: RecurrenceEntity){
        self.id = entity.id ?? UUID()
        self.parentId = entity.parentId ?? UUID()
        self.isComplete = entity.isComplete
        self.scheduleType = ScheduleType.fromString(input: entity.scheduleType ?? "") ?? .aCertainAmountOverTime
        self.amount = Int(entity.amount)
        self.timeOfDay = TimeOfDayType.fromString(input: entity.timeOfDay ?? "")
        self.startDate = entity.startDate ?? Date()
        self.endDate = entity.endDate ?? Date()
        self.archived = entity.archived
    }
    
    init(){
        id = UUID()
        parentId = UUID()
        isComplete = false
        scheduleType = .aCertainAmountOverTime
        amount = 0
        timeOfDay = .notApplicable
        startDate = Date()
        endDate = Date()
        archived = false
    }
}
