//
//  Journal.swift
//  Visionary
//
//  Created by Campbell McGavin on 4/25/22.
//

import Foundation
import SwiftUI

struct Entry: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    var title: String
    var description: String
    var startDate: Date
    var images: [UUID]
    var chapterId: UUID?
        
    init(id: UUID = UUID(), title: String, description: String, startDate: Date, images: [UUID], chapterId: UUID) {
        self.id = id
        self.title = title
        self.description = description
        self.startDate = startDate
        self.images = images
        self.chapterId = chapterId
    }
    
    init(request: CreateEntryRequest){
        self.id = UUID()
        self.title = request.title
        self.description = request.description
        self.startDate = request.startDate
        self.chapterId = request.chapterId
        self.images = request.images
        self.chapterId = request.chapterId
    }
    
    init(){
        self.id = UUID()
        self.title = ""
        self.description = ""
        self.startDate = Date()
        self.chapterId = UUID()
        self.images = [UUID]()
        self.chapterId = nil
    }
    
    init(from entity: EntryEntity){
        self.id = entity.id ?? UUID()
        self.title = entity.title ?? ""
        self.description = entity.desc ?? ""
        self.startDate = entity.startDate ?? Date()
        self.chapterId = entity.chapterId
        self.images = entity.images?.toIdArray() ?? [UUID]()
    }
}
