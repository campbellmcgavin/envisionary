//
//  Aspect.swift
//  Visionary
//
//  Created by Campbell McGavin on 12/31/21.
//

import Foundation
import SwiftUI

struct Aspect: Codable, Equatable, Hashable {
    var id: UUID
    var aspect: AspectType
    var description: String
    
    init(id: UUID = UUID(), aspect: AspectType, description: String) {
        self.id = id
        self.aspect = aspect
        self.description = description
    }
    
    init(){
        self.id = UUID()
        self.aspect = .academic
        self.description = "I am kind in all of my deeds."
    }
    
    init(request: CreateAspectRequest){
        self.id = UUID()
        self.aspect = request.aspect
        self.description = request.description
    }
    
    mutating func update(from request: UpdateAspectRequest) {
        description = request.description
    }
}
