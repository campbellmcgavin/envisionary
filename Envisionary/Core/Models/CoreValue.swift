//
//  CoreValue.swift
//  Visionary
//
//  Created by Campbell McGavin on 12/31/21.
//

import Foundation
import SwiftUI

struct CoreValue: Codable, Equatable, Hashable, Identifiable {
    var id: UUID
    var coreValue: ValueType
    var description: String
    
    init(id: UUID = UUID(), coreValue: ValueType, description: String) {
        self.id = id
        self.coreValue = coreValue
        self.description = description
    }
    
    init(){
        self.id = UUID()
        self.coreValue = .Kindness
        self.description = "I am kind in all of my deeds."
    }
    
    init(request: CreateCoreValueRequest){
        self.id = UUID()
        self.coreValue = request.coreValue
        self.description = request.description
    }
    
    init(from coreValueEntity: CoreValueEntity){
        self.id = coreValueEntity.id ?? UUID()
        self.coreValue = ValueType.allCases.first(where:{$0.toString() == coreValueEntity.coreValue ?? ""}) ?? .Kindness
        self.description = coreValueEntity.desc ?? ""
    }
    
    mutating func update(from request: UpdateCoreValueRequest) {
        description = request.description
    }
}

extension CoreValue{
    static let samples: [CoreValue] = [
        CoreValue(coreValue: .Introduction, description: "I am a flawed person trying my best everyday.."),
        CoreValue(coreValue: .Conclusion, description: "In living by these statutes, I will become the best version of myself."),
        CoreValue(coreValue: .Honesty, description: "I am honest in all of my actions, even when no one is watching."),
        CoreValue(coreValue: .Integrity, description: "I practice integrity regardless of who is watching."),
        CoreValue(coreValue: .Compassion, description: "I am compassionate even when I don't understand why someone is struggling."),
        CoreValue(coreValue: .Kindness, description: "I am kind even when a situation does not benefit me."),
        CoreValue(coreValue: .Achievement, description: "I achieve my best work. Every. Single. Day."),
        CoreValue(coreValue: .Responsibility, description: "I always rise to fill all responsibilities asked of me."),
        CoreValue(coreValue: .Wealth, description: "I have enough money to meet my needs and the needs of those who depend on me. I give generously to those who have less."),
        CoreValue(coreValue: .Balance, description: "I am a multi-dimensional being who requires nourishment and development in all areas, simultaneously.")
    ]
}
