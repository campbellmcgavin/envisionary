//
//  CreateCoreValueRequest.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/27/23.
//

import Foundation

struct CreateCoreValueRequest{
    
    var title: String
    var description: String = ""
    var image: UUID?

    init(title: String, description: String, image: UUID?)
    {
        self.title = title
        self.description = description
        self.image = image
    }
    
    init(properties: Properties){
        self.title = properties.title ?? ValueType.Kindness.toString()
        self.description = properties.description ?? ""
        self.image = properties.image
    }
}
