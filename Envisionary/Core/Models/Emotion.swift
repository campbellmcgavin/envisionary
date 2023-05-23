////
////  Emotion.swift
////  Envisionary
////
////  Created by Campbell McGavin on 5/19/23.
////
//
//import SwiftUI
//
//struct Emotion: Identifiable, Codable, Equatable, Hashable {
//    let id: UUID
//    var date: Date
//    var emotionList: [EmotionType]
//    var activityList: [DailyActivityType]
//
//    init(id: UUID = UUID(), title: String, description: String, aspect: AspectType) {
//        self.id = id
//        self.title = title
//        self.description = description
//        self.image = nil
//        self.aspect = aspect
//    }
//
//    init(){
//        self.id = UUID()
//        self.title = "New Emotion"
//        self.description = "New Description"
//        self.aspect = AspectType.academic
//        self.image = nil
//    }
//
//    init(request: CreateEmotionRequest){
//        self.id = UUID()
//        self.title = request.title
//        self.description = request.description
//        self.aspect = request.aspect
//    }
//
//    init(from emotionEntity: EmotionEntity){
//        self.id = emotionEntity.id ?? UUID()
//        self.title = emotionEntity.title ?? ""
//        self.description = emotionEntity.desc ?? ""
//        self.aspect = AspectType.fromString(input: emotionEntity.aspect ?? "")
//    }
//
//    static let samples: [Emotion] = [
//
//        Emotion(title: "World Peace", description: "I want to contribute at an international level to decreasing violence and increasing love.", aspect: .philanthropy),
//        Emotion(title: "Curing cancer", description: "I want to come up with a cure that will allow millions of people who are slowly dying of cancer, to beat the unbeatable.", aspect: .philanthropy),
//        Emotion(title: "Colonial Estate", description: "I want to own a 5 Acre colonial estate with a home in the Georgian-Colonial architecture.", aspect: .home)
//    ]
//}
