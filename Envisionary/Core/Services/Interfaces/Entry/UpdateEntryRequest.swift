//
//  UpdateEntryRequest.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/20/23.
//

import SwiftUI

struct UpdateEntryRequest {

    var title: String
    var description: String
    var images: [UUID]
    var parent: UUID?
    var parentObject: ObjectType?
    
    init(properties: Properties){
        self.title = properties.title ?? ""
        self.description = properties.description ?? ""
        self.images = properties.images ?? [UUID]()
        self.parent = properties.parent
        self.parentObject = properties.parentObject
    }
}
