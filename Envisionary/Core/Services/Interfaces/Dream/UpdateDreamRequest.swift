//
//  UpdateDreamRequest.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/8/23.
//

import Foundation

struct UpdateDreamRequest{
    
    var title: String = ""
    var description: String = ""
    var image: UUID? = nil
    var aspect: String = AspectType.academic.toString()
    var archived: Bool = false

    init(title: String, description: String, image: UUID, aspect: String, archived: Bool)
    {
        self.title = title
        self.description = description
        self.image = image
        self.aspect = aspect
        self.archived = archived
    }
    
    init(properties: Properties){
        self.title = properties.title ?? ""
        self.description = properties.description ?? ""
        self.image = properties.image
        self.aspect = properties.aspect ?? AspectType.academic.toString()
        self.archived = properties.archived ?? false
    }
    
    init(dream: Dream){
        self.title = dream.title
        self.description = dream.description
        self.image = dream.image
        self.aspect = dream.aspect
        self.archived = dream.archived
    }
}
