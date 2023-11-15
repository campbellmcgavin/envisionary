//
//  Prompt.swift
//  Visionary
//
//  Created by Campbell McGavin on 12/31/21.
//

import Foundation
import SwiftUI

struct Prompt: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    var type: PromptType
    var title: String
    var date: Date
    var objectType: ObjectType
    var objectId: UUID?
    var timeframe: TimeframeType?
    
    init(id: UUID = UUID(), type: PromptType, date: Date, objectType: ObjectType, objectId: UUID? = nil, timeframe: TimeframeType? = nil){
        self.id = id
        self.type = type
        self.title = objectType.GetPromptTitle()
        self.date = date
        self.objectType = objectType
        self.objectId = objectId
        self.timeframe = timeframe
    }
    
    init(){
        self.id = UUID()
        self.type = .favorite
        self.title = ObjectType.session.GetPromptTitle()
        self.date = Date()
        self.objectType = .session
        self.objectId = nil
        self.timeframe = nil
    }
    
    
    
    init(from entity: PromptEntity){
        self.id = entity.id ?? UUID()
        self.type = PromptType.fromString(from: entity.type ?? "")
        self.title = entity.title ?? ""
        self.date = entity.date ?? Date()
        self.objectType = ObjectType.fromString(from: entity.objectType ?? "")
        self.objectId = entity.objectId
        self.timeframe = TimeframeType.fromString(input: entity.timeframe ?? "")
    }
//
//    mutating func update(from request: UpdatePromptRequest) {
//        title = request.title
//        description = request.description
//        priority = request.priority
//        startDate = request.startDate
//        endDate = request.endDate
//        progress = request.progress
//        image = request.image
//        aspect = request.aspect
//        parentId = request.parent
//    }
}




