//
//  CoreValue.swift
//  Visionary
//
//  Created by Campbell McGavin on 12/31/21.
//

import Foundation
import SwiftUI

struct CoreValue: Codable, Equatable, Hashable, Identifiable, Comparable {
    var id: UUID
    var title: String
    var description: String
    var image: UUID?
    
    init(id: UUID = UUID(), coreValue: String, description: String, image: UUID?) {
        self.id = id
        self.title = coreValue
        self.description = description
        self.image = image
    }
    
    init(title: String){
        self.id = UUID()
        self.title = title
        self.description = ""
    }
    
    init(){
        self.id = UUID()
        self.title = ValueType.Kindness.toString()
        self.description = "I am kind in all of my deeds."
        self.image = nil
    }
    
    init(request: CreateCoreValueRequest){
        self.id = UUID()
        self.title = request.title
        self.description = request.description
        self.image = request.image
    }
    
    init(from coreValueEntity: CoreValueEntity){
        self.id = coreValueEntity.id ?? UUID()
        self.title = coreValueEntity.title ?? ""
        self.description = coreValueEntity.desc ?? ""
        self.image = coreValueEntity.image
    }
    
    static func <(lhs: CoreValue, rhs: CoreValue) -> Bool {
        lhs.title.lowercased() < rhs.title.lowercased()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
