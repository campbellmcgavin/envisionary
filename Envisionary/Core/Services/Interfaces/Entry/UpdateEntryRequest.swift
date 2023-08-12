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
    var chapterId: UUID?
    var archived: Bool
    
    init(properties: Properties){
        self.title = properties.title ?? ""
        self.description = properties.description ?? ""
        self.images = properties.images ?? [UUID]()
        self.chapterId = properties.chapterId
        self.archived = properties.archived ?? false
    }
    
    init(entry: Entry){
        self.title = entry.title
        self.description = entry.description
        self.images = entry.images
        self.chapterId = entry.chapterId
        self.archived = entry.archived
    }
}
