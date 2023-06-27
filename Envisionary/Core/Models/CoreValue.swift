//
//  CoreValue.swift
//  Visionary
//
//  Created by Campbell McGavin on 12/31/21.
//

import Foundation
import SwiftUI

struct CoreValue: Codable, Equatable, Hashable, Identifiable {
    var id: UUID
    var title: String
    var description: String
    
    init(id: UUID = UUID(), coreValue: String, description: String) {
        self.id = id
        self.title = coreValue
        self.description = description
    }
    
    init(){
        self.id = UUID()
        self.title = ValueType.Kindness.toString()
        self.description = "I am kind in all of my deeds."
    }
    
    init(request: CreateCoreValueRequest){
        self.id = UUID()
        self.title = request.title
        self.description = request.description
    }
    
    init(from coreValueEntity: CoreValueEntity){
        self.id = coreValueEntity.id ?? UUID()
        self.title = coreValueEntity.title ?? ""
        self.description = coreValueEntity.desc ?? ""
    }
    
    mutating func update(from request: UpdateCoreValueRequest) {
        description = request.description
    }
}
