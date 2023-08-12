//
//  CreateDreamRequest.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/27/23.
//

import Foundation

struct CreateDreamRequest{
    
    var title: String = ""
    var description: String = ""
    var image: UUID? = nil
    var aspect: String = AspectType.academic.toString()
    

    init(title: String, description: String, aspect: String, image: UUID?)
    {
        self.title = title
        self.description = description
        self.aspect = aspect
        self.image = image
    }
    
    init(properties: Properties){
        self.title = properties.title ?? ""
        self.description = properties.description ?? ""
        self.aspect = properties.aspect ?? AspectType.academic.toString()
        self.image = properties.image
    }
}
