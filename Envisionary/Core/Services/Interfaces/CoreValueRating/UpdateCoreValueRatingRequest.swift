//
//  UpdateCoreValueRatingRequest.swift
//  Envisionary
//
//  Created by Campbell McGavin on 8/11/23.
//

import SwiftUI

struct UpdateCoreValueRatingRequest {
    var amount: Int

    init(amount: Int)
    {
        self.amount = amount
    }
    
    init(properties: Properties)
    {
        self.amount = properties.amount ?? 2
    }
}
