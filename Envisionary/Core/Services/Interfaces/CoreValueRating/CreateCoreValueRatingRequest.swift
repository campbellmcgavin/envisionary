//
//  CreateCoreValueRatingRequest.swift
//  Envisionary
//
//  Created by Campbell McGavin on 8/11/23.
//

import SwiftUI

struct CreateCoreValueRatingRequest {
    var parentGoalId: UUID
    var valueId: UUID
    var amount: Int

    init(parentGoalId: UUID, valueId: UUID, amount: Int)
    {
        self.parentGoalId = parentGoalId
        self.valueId = valueId
        self.amount = amount
    }
    
    init(properties: Properties)
    {
        self.parentGoalId = properties.parentGoalId ?? UUID()
        self.valueId = properties.valueId ?? UUID()
        self.amount = properties.amount ?? 2
    }
}
