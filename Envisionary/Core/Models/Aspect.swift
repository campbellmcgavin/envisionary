//
//  Aspect.swift
//  Visionary
//
//  Created by Campbell McGavin on 12/31/21.
//

import Foundation
import SwiftUI

struct Aspect: Codable, Equatable, Hashable, Identifiable, Comparable {
    var id: UUID
    var title: String
    var description: String
    var image: UUID?
    
    init(id: UUID = UUID(), title: String, description: String, image: UUID?) {
        self.id = id
        self.title = title
        self.description = description
        self.image = image
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
        self.image = request.image
    }
    
    init(from entity: AspectEntity){
        self.id = entity.id ?? UUID()
        self.title = entity.title ?? ""
        self.description = entity.desc ?? ""
        self.image = entity.image
    }
    
    static func <(lhs: Aspect, rhs: Aspect) -> Bool {
        return lhs.title.lowercased() == rhs.title.lowercased()
    }
}
