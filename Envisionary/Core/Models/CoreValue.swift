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
    var position: String
    
    init(id: UUID = UUID(), coreValue: String, description: String, image: UUID?, position: String) {
        self.id = id
        self.title = coreValue
        self.description = description
        self.image = image
        self.position = position
    }
    
    init(title: String){
        self.id = UUID()
        self.title = title
        self.description = ""
        self.position = ""
    }
    
    init(){
        self.id = UUID()
        self.title = ValueType.Kindness.toString()
        self.description = "I am kind in all of my deeds."
        self.image = nil
        self.position = ""
    }
    
    init(from coreValueEntity: CoreValueEntity){
        self.id = coreValueEntity.id ?? UUID()
        self.title = coreValueEntity.title ?? ""
        self.description = coreValueEntity.desc ?? ""
        self.image = coreValueEntity.image
        self.position = coreValueEntity.position ?? ""
    }
    
    static func <(lhs: CoreValue, rhs: CoreValue) -> Bool {
        lhs.title.lowercased() < rhs.title.lowercased()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
