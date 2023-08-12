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
    var aspect: String = AspectType.academic.toString()
    var archived: Bool = false
    
    init(properties: Properties){
        self.title = properties.title ?? ""
        self.description = properties.description ?? ""
        self.priority = properties.priority ?? .critical
        self.image = properties.image
        self.aspect = properties.aspect ?? AspectType.academic.toString()
        self.archived = properties.archived ?? false
    }
    
    init(habit: Habit){
        self.title = habit.title
        self.description = habit.description
        self.priority = habit.priority
        self.image = habit.image
        self.aspect = habit.aspect
        self.archived = habit.archived
    }
}
