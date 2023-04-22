//
//  Chapter.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/20/23.
//

import SwiftUI

struct Chapter: Identifiable, Codable, Equatable, Hashable  {
    let id: UUID
    var title: String
    var description: String
    var aspect: AspectType
    var image: UUID?
    
    init(id: UUID = UUID(), title: String, description: String, aspect: AspectType, image: UUID? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.image = nil
        self.aspect = aspect
    }
    
    init(){
        self.id = UUID()
        self.title = "New Chapter"
        self.description = "New Description"
        self.aspect = AspectType.academic
        self.image = nil
    }
    
    init(request: CreateDreamRequest){
        self.id = UUID()
        self.title = request.title
        self.description = request.description
        self.aspect = request.aspect
        self.image = nil
    }
    
    init(from chapterEntity: ChapterEntity){
        self.id = chapterEntity.id ?? UUID()
        self.title = chapterEntity.title ?? ""
        self.description = chapterEntity.desc ?? ""
        self.aspect = AspectType.allCases.first(where: {$0.toString() == chapterEntity.aspect ?? ""}) ?? .academic
        self.image = chapterEntity.image
    }
    
    mutating func update(from request: UpdateDreamRequest) {
        title = request.title
        description = request.description
        aspect = request.aspect
        image = request.image
    }
}
