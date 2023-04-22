//
//  Dream.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/8/23.
//

import SwiftUI

struct Dream: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    var title: String
    var description: String
    var aspect: AspectType
    var image: UUID?
    
    init(id: UUID = UUID(), title: String, description: String, aspect: AspectType) {
        self.id = id
        self.title = title
        self.description = description
        self.image = nil
        self.aspect = aspect
    }
    
    init(){
        self.id = UUID()
        self.title = "New Dream"
        self.description = "New Description"
        self.aspect = AspectType.academic
        self.image = nil
    }
    
    init(request: CreateDreamRequest){
        self.id = UUID()
        self.title = request.title
        self.description = request.description
        self.aspect = request.aspect
    }
    
    init(from dreamEntity: DreamEntity){
        self.id = dreamEntity.id ?? UUID()
        self.title = dreamEntity.title ?? ""
        self.description = dreamEntity.desc ?? ""
        self.aspect = AspectType.allCases.first(where: {$0.toString() == dreamEntity.aspect ?? ""}) ?? .academic
    }
    
    mutating func update(from request: UpdateDreamRequest) {
        title = request.title
        description = request.description
        aspect = request.aspect
    }
    
    static let samples: [Dream] = [
    
        Dream(title: "World Peace", description: "I want to contribute at an international level to decreasing violence and increasing love.", aspect: .philanthropy),
        Dream(title: "Curing cancer", description: "I want to come up with a cure that will allow millions of people who are slowly dying of cancer, to beat the unbeatable.", aspect: .philanthropy),
        Dream(title: "Colonial Estate", description: "I want to own a 5 Acre colonial estate with a home in the Georgian-Colonial architecture.", aspect: .home)
    ]
}
