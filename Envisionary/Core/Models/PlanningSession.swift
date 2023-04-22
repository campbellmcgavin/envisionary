////
////  PlanningSession.swift
////  Visionary
////
////  Created by Campbell McGavin on 8/18/22.
////
//
//import SwiftUI
//
//struct PlanningSession: Identifiable, Equatable, Hashable, Codable  {
//    
//    let id: UUID
//    let date: Date
//    let dateCompleted: Date
//    let timeframe: TimeframeType
//    let goals: [Goal]
//    let evaluationDictionary: [UUID: EvaluationType]
//    let alignmentDictionary: [UUID: [Generic:AlignmentType]]
//    let pushOffDictionary: [UUID: Int]
//    let childrenAddedDictionary: [UUID: [UUID]]
//    let deletionList: [UUID]
//    
//    
//    init(id: UUID = UUID(), date: Date, timeframe: TimeframeType, goals: [Goal], evaluationDictionary: [UUID: EvaluationType], alignmentDictionary: [UUID: [Generic:AlignmentType]], pushOffDictionary: [UUID: Int], deletionList: [UUID],  childrenAddedDictionary: [UUID: [UUID]]){
//        self.id = id
//        self.date = date
//        self.dateCompleted = Date()
//        self.timeframe = timeframe
//        self.goals = goals
//        self.evaluationDictionary = evaluationDictionary
//        self.alignmentDictionary  = alignmentDictionary
//        self.pushOffDictionary = pushOffDictionary
//        self.childrenAddedDictionary = childrenAddedDictionary
//        self.deletionList = deletionList
//    }
//    
//    init(){
//        self.id = UUID()
//        self.date = Date()
//        self.dateCompleted = Date()
//        self.timeframe = .week
//        self.goals = [Goal]()
//        self.evaluationDictionary = [UUID: EvaluationType]()
//        self.alignmentDictionary  = [UUID: [Generic:AlignmentType]]()
//        self.pushOffDictionary = [UUID: Int]()
//        self.childrenAddedDictionary = [UUID: [UUID]]()
//        self.deletionList = [UUID]()
//    }
//}
//
//extension DataModel{
//    func GetPropertyImage(planningSession: PlanningSession, propertyType: PropertyType){
//        
//    }
//}
