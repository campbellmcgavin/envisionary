//
//  UpdateChapterRequest.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/20/23.
//

import SwiftUI

struct UpdateChapterRequest {
    var title: String = ""
    var description: String = ""
    var aspect: AspectType = .academic
    var image: UUID? = nil
    
    init(title: String, description: String, aspect: AspectType, image: UUID? = nil)
    {
        self.title = title
        self.description = description
        self.aspect = aspect
        self.image = image
    }
    
    init(properties: Properties){
        self.title = properties.title ?? ""
        self.description = properties.description ?? ""
        self.aspect = properties.aspect ?? .academic
        self.image = properties.image
    }
}
