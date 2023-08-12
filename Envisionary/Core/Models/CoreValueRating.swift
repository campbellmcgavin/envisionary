//
//  CoreValueRating.swift
//  Envisionary
//
//  Created by Campbell McGavin on 8/11/23.
//

import SwiftUI

struct CoreValueRating: Equatable {
    var id: UUID
    var parentGoalId: UUID
    var coreValueId: UUID
    var amount: Int
    
    init(id: UUID, parentGoalId: UUID, coreValueId: UUID, amount: Int){
        self.id = id
        self.parentGoalId = parentGoalId
        self.coreValueId = coreValueId
        self.amount = amount
    }
    
    init(){
        self.id = UUID()
        self.parentGoalId = UUID()
        self.coreValueId = UUID()
        self.amount = -1
    }
    
    init(entity: CoreValueRatingEntity){
        self.id = entity.id ?? UUID()
        self.parentGoalId = entity.parentId ?? UUID()
        self.coreValueId = entity.coreValueId ?? UUID()
        self.amount = Int(entity.amount)
    }
}
