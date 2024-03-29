//
//  CreateSessionRequest.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/5/23.
//

import SwiftUI

struct CreateSessionRequest {
    let date: Date
    let title: String
    let dateCompleted: Date
    let timeframe: TimeframeType
    let goalProperties: [Properties]
    let evaluationDictionary: [UUID: EvaluationType]
    let alignmentDictionary: [UUID: [String:Bool]]
    let childrenAddedDictionary: [UUID: [UUID]]
    
    init(properties: Properties){
        self.date = properties.date ?? Date()
        self.title = (properties.timeframe ?? .day).toString() + " Session for " + (properties.date ?? Date()).toString(timeframeType: properties.timeframe ?? .day)
        self.dateCompleted = properties.completedDate ?? Date()
        self.timeframe = properties.timeframe ?? .year
        self.goalProperties = properties.goalProperties ?? [Properties]()
        self.evaluationDictionary = properties.evaluationDictionary ?? [UUID: EvaluationType]()
        self.alignmentDictionary = properties.alignmentDictionary ?? [UUID: [String:Bool]]()
        self.childrenAddedDictionary = properties.childrenAddedDictionary ?? [UUID: [UUID]]()
    }
}
