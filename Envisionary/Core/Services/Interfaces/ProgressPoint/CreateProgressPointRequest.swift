//
//  ProgressPoint.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/27/24.
//

import Foundation
struct CreateProgressPointRequest {
    var parentId: UUID
    var date: Date
    var amount: Int
    var progress: Int
    init(parentId: UUID, date: Date, amount: Int, progress: Int)
    {
        self.parentId = parentId
        self.date = date
        self.amount = amount
        self.progress = progress
    }
    
    init(properties: Properties)
    {
        self.parentId = properties.parentGoalId ?? UUID()
        self.date = properties.date ?? Date()
        self.amount = properties.amount ?? 2
        self.progress = properties.progress ?? 0
    }
}
