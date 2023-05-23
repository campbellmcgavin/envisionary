//
//  UpdateHabitRequest.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/21/23.
//

import SwiftUI

struct UpdateHabitRequest {
    
    var title: String = ""
    var description: String = ""
    var priority: PriorityType = .moderate
    var image: UUID? = nil
    var aspect: AspectType = .academic
    
    init(properties: Properties){
        self.title = properties.title ?? ""
        self.description = properties.description ?? ""
        self.priority = properties.priority ?? .critical
        self.image = properties.image
        self.aspect = properties.aspect ?? .academic
    }
}
