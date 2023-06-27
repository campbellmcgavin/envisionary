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
    

    init(title: String, description: String)
    {
        self.title = title
        self.description = description
    }
    
    init(properties: Properties){
        self.title = properties.title ?? ValueType.Kindness.toString()
        self.description = properties.description ?? ""
    }
}
