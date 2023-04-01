//
//  CreateGoalRequest.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/27/23.
//

import Foundation

struct CreateGoalRequest{
    
        var title: String = ""
        var description: String = ""
        var priority: PriorityType = .moderate
        var startDate: Date = Date()
        var endDate: Date = Date()
        var progress: Int = 0
        var image: UUID? = nil
        var aspect: AspectType = .academic
        var timeframe: TimeframeType = .day
        var parent: UUID? = nil
        var tasks: [UUID] = [UUID]()
        var journals: [UUID] = []
    

    init(title: String, description: String, priority: PriorityType, startDate: Date, endDate: Date, percentComplete: Int, image: UUID, aspect: AspectType, timeframe: TimeframeType, parent: UUID, journals: [UUID])
    {
        self.title = title
        self.description = description
        self.priority = priority
        self.startDate = startDate
        self.endDate = endDate
        self.progress = percentComplete
        self.image = image
        self.aspect = aspect
        self.timeframe = timeframe
        self.parent = parent
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
        self.timeframe = properties.timeframe ?? .day
        self.parent = properties.parent
    }
}
