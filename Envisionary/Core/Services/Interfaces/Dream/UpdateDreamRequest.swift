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
        var aspect: AspectType = .academic
    

    init(title: String, description: String, image: UUID, aspect: AspectType)
    {
        self.title = title
        self.description = description
        self.image = image
        self.aspect = aspect
    }
    
    init(properties: Properties){
        self.title = properties.title ?? ""
        self.description = properties.description ?? ""
        self.image = properties.image
        self.aspect = properties.aspect ?? .academic
    }
}
