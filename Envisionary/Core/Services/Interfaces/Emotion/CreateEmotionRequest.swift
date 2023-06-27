//
//  CreateEmotionRequest.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/24/23.
//

import SwiftUI

struct CreateEmotionRequest {
    var date: Date = Date()
    var emotionList: [EmotionType] = [EmotionType]()
    var activityList: [String] = [String]()
    var amount: Int = 4
    
    init(properties: Properties){
        date = properties.date ?? Date()
        emotionList = properties.emotionList ?? [EmotionType]()
        activityList = properties.activityList ?? [String]()
        amount = properties.amount ?? 4
    }
}
