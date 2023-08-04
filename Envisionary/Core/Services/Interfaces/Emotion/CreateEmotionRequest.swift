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
    
    init(date: Date, emotionList: [EmotionType], activityList: [String], amount: Int){
        self.date = date
        self.emotionList = emotionList
        self.activityList = activityList
        self.amount = amount
    }
    
    init(properties: Properties){
        date = properties.date ?? Date()
        emotionList = properties.emotionList ?? [EmotionType]()
        activityList = properties.activityList ?? [String]()
        amount = properties.emotionalState ?? 4
    }
}
