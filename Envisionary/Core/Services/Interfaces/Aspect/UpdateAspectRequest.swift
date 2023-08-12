//
//  UpdateValueRequest.swift
//  Envisionary
//
//  Updated by Campbell McGavin on 4/5/23.
//

import Foundation

struct UpdateAspectRequest{
    var title: String = ""
    var description: String = ""
    var image: UUID?

    init(title: String, description: String, image: UUID?)
    {
        self.title = title
        self.description = description
        self.image = image
    }
    
    init(properties: Properties){
        self.title = properties.title ?? ""
        self.description = properties.description ?? ""
        self.image = properties.image
    }
}
