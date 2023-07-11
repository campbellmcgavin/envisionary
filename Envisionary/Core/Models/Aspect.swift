//
//  Aspect.swift
//  Visionary
//
//  Created by Campbell McGavin on 12/31/21.
//

import Foundation
import SwiftUI

struct Aspect: Codable, Equatable, Hashable, Identifiable {
    var id: UUID
    var title: String
    var description: String
    
    init(id: UUID = UUID(), title: String, description: String) {
        self.id = id
        self.title = title
        self.description = description
    }
    
    init(){
        self.id = UUID()
        self.title = AspectType.academic.toString()
        self.description = "I am kind in all of my deeds."
    }
    
    init(request: CreateAspectRequest){
        self.id = UUID()
        self.title = request.title
        self.description = request.description
    }
    
    init(from entity: AspectEntity){
        self.id = entity.id ?? UUID()
        self.title = entity.title ?? ""
        self.description = entity.desc ?? ""
    }
    
    mutating func update(from request: UpdateAspectRequest) {
        description = request.description
    }
}
