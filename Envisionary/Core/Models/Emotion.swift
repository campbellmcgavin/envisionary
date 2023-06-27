//
//  Emotion.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/19/23.
//

import SwiftUI

struct Emotion: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    var date: Date
    var emotionalState: Int
    var emotionList: [EmotionType]
    var activityList: [String]

    init(){
        self.id = UUID()
        self.date = Date()
        self.emotionList = [EmotionType]()
        self.activityList = [String]()
        self.emotionalState = 4
    }

    init(from emotionEntity: EmotionEntity){
        self.id = emotionEntity.id ?? UUID()
        self.date = emotionEntity.startDate ?? Date()
        self.emotionList = emotionEntity.emotionList?.toStringArray().map({EmotionType.fromString(from: $0)}) ?? [EmotionType]()
        self.activityList = emotionEntity.activityList?.toStringArray() ?? [String]()
        self.emotionalState = Int(emotionEntity.amount)
    }
}
