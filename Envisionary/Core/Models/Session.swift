//
//  PlanningSession.swift
//  Visionary
//
//  Created by Campbell McGavin on 8/18/22.
//

import SwiftUI

struct Session: Identifiable, Equatable, Hashable, Codable  {
    
    let id: UUID
    let date: Date
    let dateCompleted: Date
    let timeframe: TimeframeType
    var goalProperties: [Properties]
    var evaluationDictionary: [UUID: EvaluationType]
    var alignmentDictionary: [UUID: [ValueType:Bool]]
    var childrenAddedDictionary: [UUID: [UUID]]
    
    
    init(id: UUID = UUID(), date: Date, timeframe: TimeframeType, goalProperties: [Properties], evaluationDictionary: [UUID: EvaluationType], alignmentDictionary: [UUID: [ValueType:Bool]], pushOffDictionary: [UUID: Int], deletionList: [UUID],  childrenAddedDictionary: [UUID: [UUID]]){
        self.id = id
        self.date = date
        self.dateCompleted = Date()
        self.timeframe = timeframe
        self.goalProperties = goalProperties
        self.evaluationDictionary = evaluationDictionary
        self.alignmentDictionary  = alignmentDictionary
        self.childrenAddedDictionary = childrenAddedDictionary
    }
    
    init(from entity: SessionEntity){
        self.id = entity.id ?? UUID()
        self.date = entity.date ?? Date()
        self.dateCompleted = entity.dateCompleted ?? Date()
        self.timeframe = TimeframeType.fromString(input: entity.timeframe ?? "")
        self.goalProperties = [Properties]()
        self.evaluationDictionary = [UUID: EvaluationType]()
        self.alignmentDictionary = [UUID: [ValueType:Bool]]()
        self.childrenAddedDictionary = [UUID: [UUID]]()
        
        do {
            let decoder = JSONDecoder()
            
            self.goalProperties = try decoder.decode([Properties].self, from: entity.goalProperties ?? Data())
            
            if let evaluationDictionary = entity.evaluationDictionary{
                self.evaluationDictionary = try decoder.decode([UUID:EvaluationType].self, from: evaluationDictionary)
//                self.evaluationDictionary = ConvertFromStringToUUIDDictionary(stringDictionary: stringEvaluationDictionary)
            }
            if let alignmentDictionary = entity.alignmentDictionary{
                self.alignmentDictionary = try decoder.decode([UUID:[ValueType:Bool]].self, from: alignmentDictionary)
//                self.alignmentDictionary = ConvertFromStringToUUIDDictionary(stringDictionary: stringAlignmentDictionary)
            }
            
//            self.childrenAddedDictionary = try decoder.decode([UUID:[UUID]].self, from: entity.evaluationDictionary ?? Data())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    init(){
        self.id = UUID()
        self.date = Date()
        self.dateCompleted = Date()
        self.timeframe = .week
        self.goalProperties = [Properties]()
        self.evaluationDictionary = [UUID: EvaluationType]()
        self.alignmentDictionary  = [UUID: [ValueType:Bool]]()
        self.childrenAddedDictionary = [UUID: [UUID]]()
    }
    
    private func ConvertFromStringToUUIDDictionary<T>(stringDictionary: [String: T]) -> [UUID:T]{
        var uuidDictionary = [UUID: T]()
        
        for id in stringDictionary.keys{
            
            if let uuid = UUID(uuidString: id){
                uuidDictionary[uuid] = stringDictionary[id]
            }
        }
        return uuidDictionary
    }
}
