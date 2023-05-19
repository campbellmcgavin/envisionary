//
//  Aspect.swift
//  Visionary
//
//  Created by Campbell McGavin on 12/31/21.
//

import Foundation
import SwiftUI

struct Aspect: Codable, Equatable, Hashable, Identifiable {
    var id: UUID
    var aspect: AspectType
    var description: String
    
    init(id: UUID = UUID(), aspect: AspectType, description: String) {
        self.id = id
        self.aspect = aspect
        self.description = description
    }
    
    init(){
        self.id = UUID()
        self.aspect = .academic
        self.description = "I am kind in all of my deeds."
    }
    
    init(request: CreateAspectRequest){
        self.id = UUID()
        self.aspect = request.aspect
        self.description = request.description
    }
    
    init(from entity: AspectEntity){
        self.id = entity.id ?? UUID()
        self.aspect = AspectType.fromString(input: entity.aspect ?? "")
        self.description = entity.desc ?? ""
    }
    
    mutating func update(from request: UpdateAspectRequest) {
        description = request.description
    }
    
    static let samples: [Aspect] =
    [
        Aspect(aspect: .academic, description: "Inner-nerd meets outer student."),
        Aspect(aspect: .philanthropy, description: "Exercising goodness with no other intention than to exercise goodness."),
        Aspect(aspect: .environment, description: "My surroundings. Physically, emotionally... all of it."),
        Aspect(aspect: .career, description: "The stuff I do from 7-5."),
        Aspect(aspect: .children, description: "Improving my dad jokes, one-liner at a time."),
        Aspect(aspect: .adventure, description: "Getting out from under the rock and living a little."),
        Aspect(aspect: .emotional, description: "The touchy feels."),
        Aspect(aspect: .family, description: "Fam-damily forever."),
        Aspect(aspect: .financial, description: "Money meets budget meets comfortable living."),
        Aspect(aspect: .health, description: "Living my best life in a balanced fashion.")
    ]
}
