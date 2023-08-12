//
//  UpdateChapterRequest.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/20/23.
//

import SwiftUI

struct UpdateChapterRequest {
    var title: String = ""
    var description: String = ""
    var aspect: String = AspectType.academic.toString()
    var image: UUID? = nil
    var archived: Bool = false
    
    init(title: String, description: String, aspect: String, image: UUID? = nil, archived: Bool)
    {
        self.title = title
        self.description = description
        self.aspect = aspect
        self.image = image
        self.archived = archived
    }
    
    init(chapter: Chapter){
        self.title = chapter.title
        self.description = chapter.description
        self.aspect = chapter.aspect
        self.image = chapter.image
        self.archived = chapter.archived
    }
    
    init(properties: Properties){
        self.title = properties.title ?? ""
        self.description = properties.description ?? ""
        self.aspect = properties.aspect ?? AspectType.academic.toString()
        self.image = properties.image
        self.archived = properties.archived ?? false
    }
}
