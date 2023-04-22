//
//  CreateAspectRequest.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/27/23.
//

import Foundation

struct CreateAspectRequest{
    
    var aspect: AspectType
    var description: String
    

    init(aspect: AspectType, description: String)
    {
        self.aspect = aspect
        self.description = description
    }
    
    init(properties: Properties){
        self.aspect = properties.aspect ?? .academic
        self.description = properties.description ?? ""
    }
}
