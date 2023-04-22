//
//  UpdateValueRequest.swift
//  Envisionary
//
//  Updated by Campbell McGavin on 4/5/23.
//

import Foundation

struct UpdateCoreValueRequest{
    
    var description: String = ""
    

    init(description: String)
    {
        self.description = description
    }
    
    init(properties: Properties){
        self.description = properties.description ?? ""
    }
}
