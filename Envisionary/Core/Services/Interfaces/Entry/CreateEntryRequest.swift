//
//  CreateEntryRequest.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/20/23.
//

import SwiftUI

struct CreateEntryRequest {
    var title: String
    var description: String
    var startDate: Date
    var chapterId: UUID?
    var images: [UUID]
    
    init(properties: Properties){
        self.title = properties.title ?? ""
        self.description = properties.description ?? ""
        self.startDate = properties.startDate ?? Date()
        self.chapterId = properties.chapterId ?? UUID()
        self.images = properties.images ?? [UUID]()
        self.chapterId = properties.chapterId
    }
}
