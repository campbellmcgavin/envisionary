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
    var aspect: String = AspectType.academic.toString()
    var parent: UUID? = nil
    var valuesDictionary: [String:Bool]? = nil
    var archived: Bool = false
    var completedDate: Date? = nil
    var reorderGoalId: UUID? = nil
    var reorderPlacement: PlacementType? = nil
    var position: String = ""
    var superId: UUID?

    init(title: String, description: String, priority: PriorityType, startDate: Date, endDate: Date, percentComplete: Int, image: UUID, aspect: String, parent: UUID, valuesDictionary: [String:Bool], archived: Bool, completedDate: Date?, superId: UUID?)
    {
        self.title = title
        self.description = description
        self.priority = priority
        self.startDate = startDate
        self.endDate = endDate
        self.progress = percentComplete
        self.image = image
        self.aspect = aspect
        self.parent = parent
        self.valuesDictionary = valuesDictionary
        self.archived = archived
        self.completedDate = completedDate
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
        self.parent = goal.parentId
        self.archived = goal.archived
        self.position = goal.position
        self.completedDate = goal.completedDate
        self.superId = goal.superId
    }
    
    init(properties: Properties){
        self.title = properties.title ?? ""
        self.description = properties.description ?? ""
        self.priority = properties.priority ?? .critical
        self.startDate = properties.startDate ?? Date()
        self.endDate = properties.endDate ?? Date()
        self.progress = properties.progress ?? 0
        self.image = properties.image
        self.aspect = properties.aspect ?? AspectType.academic.toString()
        self.parent = properties.parentGoalId
        self.archived = properties.archived ?? false
        self.position = properties.position ?? ""
        self.completedDate = properties.completedDate
        self.superId = properties.superId
    }
}
