//
//  UpdateGoalRequest.swift
//  Envisionary
//
//  Updated by Campbell McGavin on 3/27/23.
//

import Foundation

struct UpdateGoalRequest{
    
        var title: String = ""
        var description: String = ""
        var priority: PriorityType = .moderate
        var startDate: Date = Date()
        var endDate: Date = Date()
        var progress: Int = 0
        var image: UUID? = nil
        var aspect: AspectType = .academic
        var children: [UUID] = []
        var parent: UUID? = nil
        var tasks: [UUID] = [UUID]()
        var journals: [UUID] = []
    

    init(title: String, description: String, priority: PriorityType, startDate: Date, endDate: Date, percentComplete: Int, image: UUID, aspect: AspectType, children: [UUID], parent: UUID, journals: [UUID])
    {
        self.title = title
        self.description = description
        self.priority = priority
        self.startDate = startDate
        self.endDate = endDate
        self.progress = percentComplete
        self.image = image
        self.aspect = aspect
        self.children = children
        self.parent = parent
    }
    
    init(goal: Goal){
        self.title = goal.title
        self.description = goal.description
        self.priority = goal.priority
        self.startDate = goal.startDate
        self.endDate = goal.endDate
        self.progress = goal.progress
        self.image = goal.image
        self.aspect = goal.aspect
        self.children = goal.children
        self.parent = goal.parent
        self.tasks = goal.tasks
        self.journals = goal.journals
    }
    
    init(properties: Properties){
        self.title = properties.title ?? ""
        self.description = properties.description ?? ""
        self.priority = properties.priority ?? .critical
        self.startDate = properties.startDate ?? Date()
        self.endDate = properties.endDate ?? Date()
        self.progress = properties.progress ?? 0
        self.image = properties.image
        self.aspect = properties.aspect ?? .academic
        self.parent = properties.parent
        self.children = properties.children ?? [UUID]()
    }
}
