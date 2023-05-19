//
//  CreateSessionRequest.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/5/23.
//

import SwiftUI

struct CreateSessionRequest {
    let date: Date
    let dateCompleted: Date
    let timeframe: TimeframeType
    let goalProperties: [Properties]
    let evaluationDictionary: [UUID: EvaluationType]
    let alignmentDictionary: [UUID: [ValueType:Bool]]
    let childrenAddedDictionary: [UUID: [UUID]]
    
    init(properties: Properties){
        self.date = properties.date ?? Date()
        self.dateCompleted = properties.dateCompleted ?? Date()
        self.timeframe = properties.timeframe ?? .year
        self.goalProperties = properties.goalProperties ?? [Properties]()
        self.evaluationDictionary = properties.evaluationDictionary ?? [UUID: EvaluationType]()
        self.alignmentDictionary = properties.alignmentDictionary ?? [UUID: [ValueType:Bool]]()
        self.childrenAddedDictionary = properties.childrenAddedDictionary ?? [UUID: [UUID]]()
    }
}
