//
//  CreatePromptRequest.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/15/23.
//

import SwiftUI

struct CreatePromptRequest {
    var type: PromptType
    var title: String
    var date: Date
    var objectType: ObjectType
    var objectId: UUID?
    var timeframe: TimeframeType?
}
