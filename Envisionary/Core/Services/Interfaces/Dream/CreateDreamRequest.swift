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
//        var image: UUID? = nil
        var aspect: AspectType = .academic
    

    init(title: String, description: String, aspect: AspectType)
    {
        self.title = title
        self.description = description
        self.aspect = aspect
    }
    
    init(properties: Properties){
        self.title = properties.title ?? ""
        self.description = properties.description ?? ""
        self.aspect = properties.aspect ?? .academic
    }
}
