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
    var aspect: String
    var image: UUID?
    var archived: Bool
    
    init(id: UUID = UUID(), title: String, description: String, aspect: String, image: UUID? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.image = nil
        self.aspect = aspect
        self.archived = false
    }
    
    init(){
        self.id = UUID()
        self.title = "New Chapter"
        self.description = "New Description"
        self.aspect = AspectType.academic.toString()
        self.image = nil
        self.archived = false
    }
    
    init(from chapterEntity: ChapterEntity){
        self.id = chapterEntity.id ?? UUID()
        self.title = chapterEntity.title ?? ""
        self.description = chapterEntity.desc ?? ""
        self.aspect = chapterEntity.aspect ?? ""
        self.image = chapterEntity.image
        self.archived = chapterEntity.archived
    }
}
