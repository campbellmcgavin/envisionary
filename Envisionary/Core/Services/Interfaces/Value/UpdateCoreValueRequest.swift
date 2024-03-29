//
//  UpdateValueRequest.swift
//  Envisionary
//
//  Updated by Campbell McGavin on 4/5/23.
//

import Foundation

struct UpdateCoreValueRequest{
    
    var description: String = ""
    var image: UUID?

    init(description: String, image: UUID?)
    {
        self.description = description
        self.image = image
    }
    
    init(properties: Properties){
        self.description = properties.description ?? ""
        self.image = properties.image
    }
}
