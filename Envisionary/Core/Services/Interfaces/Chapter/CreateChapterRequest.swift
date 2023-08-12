//
//  CreateChapterRequest.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/20/23.
//

import SwiftUI

struct CreateChapterRequest {
    var title: String = ""
    var description: String = ""
    var aspect: String = AspectType.academic.toString()
    var image: UUID? = nil
    
    init(title: String, description: String, aspect: String, image: UUID? = nil)
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
