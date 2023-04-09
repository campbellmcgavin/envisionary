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
    
    init(id: UUID = UUID(), title: String, description: String, aspect: AspectType, image: UUID?) {
        self.id = id
        self.title = title
        self.description = description
        self.image = image
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
        self.image = request.image
    }
    
    mutating func update(from request: UpdateDreamRequest) {
        title = request.title
        description = request.description
        image = request.image
        aspect = request.aspect
    }
}
