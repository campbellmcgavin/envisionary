//
//  Goal.swift
//  Visionary
//
//  Created by Campbell McGavin on 12/31/21.
//

import Foundation
import SwiftUI

struct Goal: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    var title: String
    var description: String
    var priority: PriorityType
    var startDate: Date
    var endDate: Date
    var progress: Int
    var aspect: AspectType
    var timeframe: TimeframeType
    var image: UUID?
    var children: [UUID]
    var parent: UUID?
    var tasks: [UUID]
    var journals: [UUID]
    
    init(id: UUID = UUID(), title: String, description: String, priority: PriorityType, startDate: Date, endDate: Date, percentComplete: Int, aspect: AspectType, timeframe: TimeframeType, image: UUID?, children: [UUID], parent: UUID?, tasks: [UUID], journals: [UUID]) {
        self.id = id
        self.title = title
        self.description = description
        self.priority = priority
        self.startDate = startDate
        self.endDate = endDate
        self.progress = percentComplete
        self.image = image
        self.aspect = aspect
        self.timeframe = timeframe
        self.children = children
        self.parent = parent
        self.tasks = tasks
        self.journals = journals
    }
    
    init(){
        self.id = UUID()
        self.title = "New Goal"
        self.description = "New Description"
        self.priority = .moderate
        self.startDate = Date()
        self.endDate = Date()
        self.progress = 0
        self.aspect = AspectType.academic
        self.timeframe = TimeframeType.day
        self.children = [UUID]()
        self.journals = [UUID]()
        self.tasks = [UUID]()
    }
    
    init(request: CreateGoalRequest){
        self.id = UUID()
        self.title = request.title
        self.description = request.description
        self.priority = request.priority
        self.startDate = request.startDate
        self.endDate = request.endDate
        self.progress = request.progress
        self.aspect = request.aspect
        self.timeframe = request.timeframe
        self.journals = request.journals
        self.tasks = request.tasks
        self.image = request.image
        self.children = [UUID]()
        self.parent = request.parent
    }
    
    mutating func update(from request: UpdateGoalRequest) {
        title = request.title
        description = request.description
        priority = request.priority
        startDate = request.startDate
        endDate = request.endDate
        progress = request.progress
        image = request.image
        aspect = request.aspect
        children = request.children
        parent = request.parent
        journals = request.journals
        tasks = request.tasks
    }
}



extension Goal {
    
    
    static let sampleGoals: [Goal] =
    [
        Goal(title: "Empty Goal", description: "Empty Description", priority: .low, startDate: Date(), endDate: Date().ComputeEndDate(timeframeType: .day, numberOfDates: 0), percentComplete: 0, aspect: AspectType.academic, timeframe: TimeframeType.day, image: nil, children: [], parent: nil, tasks: [UUID](), journals: []),
        
        Goal(title: "Company Startup", description: "Start my own company", priority: .moderate, startDate: Date(), endDate: Date().ComputeEndDate(timeframeType: TimeframeType.year, numberOfDates: 2), percentComplete: 0, aspect: .career, timeframe: TimeframeType.year, image: nil, children: [], parent: nil, tasks: [UUID](), journals: []),
        
        Goal(title: "Charity Startup", description: "International Charitable Organization", priority: .high, startDate: Date(), endDate: Date().ComputeEndDate(timeframeType: TimeframeType.month, numberOfDates: 7), percentComplete: 0, aspect: .philanthropy, timeframe: TimeframeType.month, image: nil, children: [], parent: nil, tasks: [UUID](), journals: []),
        
        Goal(title: "Become Governor", description: "Become state governor", priority: .critical, startDate: Date(), endDate: Date().ComputeEndDate(timeframeType: TimeframeType.week, numberOfDates: 10), percentComplete: 0, aspect: .political, timeframe: TimeframeType.week, image: nil, children: [], parent: nil, tasks: [UUID](), journals: []),
        
        Goal(title: "Be a good person", description: "Be a good person",priority: .high, startDate: Date(), endDate: Date().ComputeEndDate(timeframeType: TimeframeType.day, numberOfDates: 4), percentComplete: 0, aspect: .personal, timeframe: TimeframeType.day, image: nil, children: [], parent: nil, tasks: [UUID](), journals: []),
        
        Goal(title: "Spring cleaning", description: "I need to get the house all cleaned up from winter.",priority: .moderate, startDate: Date(), endDate: Date().ComputeEndDate(timeframeType: TimeframeType.week, numberOfDates: 5), percentComplete: 0, aspect: .home, timeframe: TimeframeType.week, image: nil, children: [], parent: nil, tasks: [UUID](), journals: [])
    ]
}


