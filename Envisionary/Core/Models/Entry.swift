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
    var chapter: UUID
    var images: [UUID]
    var parent: UUID?
    var parentObject: ObjectType?
        
    init(id: UUID = UUID(), title: String, description: String, startDate: Date, chapter: UUID, images: [UUID], parent: UUID?, parentObject: ObjectType?) {
        self.id = id
        self.title = title
        self.description = description
        self.startDate = startDate
        self.chapter = chapter
        self.images = images
        self.parent = parent
        self.parentObject = parentObject
    }
    
    init(request: CreateEntryRequest){
        self.id = UUID()
        self.title = request.title
        self.description = request.description
        self.startDate = request.startDate
        self.chapter = request.chapter
        self.images = request.images
        self.parent = request.parent
        self.parentObject = request.parentObject
    }
    
    init(from entity: EntryEntity){
        self.id = entity.id ?? UUID()
        self.title = entity.title ?? ""
        self.description = entity.desc ?? ""
        self.startDate = entity.startDate ?? Date()
        self.chapter = entity.chapter ?? UUID()
//        let a = entity.images?.allObjects
//        self.images = entity.images.allObjects
        self.images = entity.images?.toIdArray() ?? [UUID]()
        self.parent = entity.parent
        self.parentObject = ObjectType.allCases.first(where: {$0.toString() == entity.parentObject ?? ""})
    }
    
    mutating func update(from request: UpdateEntryRequest) {
        self.title = request.title
        self.description = request.description
        self.images = request.images
        self.parent = request.parent
        self.parentObject = request.parentObject
    }
}

extension Entry {
    static let sampleJournals: [Entry] =
    [
//        Entry(id: UUID(), title: "", description: <#T##String#>, startDate: <#T##Date#>, chapter: <#T##UUID#>, images: <#T##[UUID]#>, parent: <#T##UUID?#>, parentObject: <#T##ObjectType?#>)
    ]
}
