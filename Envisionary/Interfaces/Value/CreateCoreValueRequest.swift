//
//  CreateCoreValueRequest.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/27/23.
//

import Foundation

struct CreateCoreValueRequest{
    
    var coreValue: ValueType
    var description: String = ""
    

    init(coreValue: ValueType, description: String)
    {
        self.coreValue = coreValue
        self.description = description
    }
    
    init(properties: Properties){
        self.coreValue = properties.coreValue ?? .Kindness
        self.description = properties.description ?? ""
    }
}
