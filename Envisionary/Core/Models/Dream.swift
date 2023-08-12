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
    var aspect: String
    var image: UUID?
    var archived: Bool
    
    init(id: UUID = UUID(), title: String, description: String, aspect: String) {
        self.id = id
        self.title = title
        self.description = description
        self.image = nil
        self.aspect = aspect
        self.archived = false
    }
    
    init(){
        self.id = UUID()
        self.title = "New Dream"
        self.description = "New Description"
        self.aspect = AspectType.academic.toString()
        self.image = nil
        self.archived = false
    }
    
    init(request: CreateDreamRequest){
        self.id = UUID()
        self.title = request.title
        self.description = request.description
        self.aspect = request.aspect
        self.archived = false
    }
    
    init(from dreamEntity: DreamEntity){
        self.id = dreamEntity.id ?? UUID()
        self.title = dreamEntity.title ?? ""
        self.description = dreamEntity.desc ?? ""
        self.aspect = dreamEntity.aspect ?? ""
        self.archived = dreamEntity.archived
        self.image = dreamEntity.image
    }
    
    mutating func update(from request: UpdateDreamRequest) {
        title = request.title
        description = request.description
        aspect = request.aspect
        archived = request.archived
    }
}
