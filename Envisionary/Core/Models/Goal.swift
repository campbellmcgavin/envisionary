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
    var parentId: UUID?
    var valuesDictionary: [String: Bool]?
    
    init(id: UUID = UUID(), title: String, description: String, priority: PriorityType, startDate: Date, endDate: Date, percentComplete: Int, aspect: AspectType, timeframe: TimeframeType, image: UUID?, parent: UUID?, tasks: [UUID], journals: [UUID]){
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
        self.parentId = parent
        self.valuesDictionary = nil
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
        self.valuesDictionary = nil
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
        self.image = request.image
        self.parentId = request.parentId
    }
    
    init(from entity: GoalEntity){
        self.id = entity.id ?? UUID()
        self.title = entity.title ?? ""
        self.description = entity.desc ?? ""
        self.priority = PriorityType.allCases.first(where: {$0.toString() == entity.priority ?? ""}) ?? .low
        self.startDate = entity.startDate ?? Date()
        self.endDate = entity.endDate ?? Date()
        self.progress = Int(entity.progress)
        self.aspect = AspectType.fromString(input: entity.aspect ?? "")
        self.timeframe = TimeframeType.fromString(input: entity.timeframe ?? "")
        self.image = entity.image
        self.parentId = entity.parentId
        
        do {
            let valuesDictionaryDecoded = try JSONSerialization.jsonObject(with: entity.valuesDictionary ?? Data(), options: [])
            if let valuesDictionary = valuesDictionaryDecoded as? [String:Bool] {
                self.valuesDictionary = valuesDictionary
            }
        } catch {
            print(error.localizedDescription)
        }
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
        parentId = request.parent
    }
}



extension Goal {
    
    
    static let sampleGoals: [Goal] =
    [
        Goal(title: "Empty Goal", description: "Empty Description", priority: .low, startDate: Date(), endDate: Date().ComputeEndDate(timeframeType: .day, numberOfDates: 0), percentComplete: 0, aspect: AspectType.academic, timeframe: TimeframeType.day, image: nil, parent: nil, tasks: [UUID](), journals: []),
        
        Goal(title: "Company Startup", description: "Start my own company", priority: .moderate, startDate: Date(), endDate: Date().ComputeEndDate(timeframeType: TimeframeType.year, numberOfDates: 2), percentComplete: 0, aspect: .career, timeframe: TimeframeType.year, image: nil, parent: nil, tasks: [UUID](), journals: []),
        
        Goal(title: "Charity Startup", description: "International Charitable Organization", priority: .high, startDate: Date(), endDate: Date().ComputeEndDate(timeframeType: TimeframeType.month, numberOfDates: 7), percentComplete: 0, aspect: .philanthropy, timeframe: TimeframeType.month, image: nil, parent: nil, tasks: [UUID](), journals: []),
        
        Goal(title: "Become Governor", description: "Become state governor", priority: .critical, startDate: Date(), endDate: Date().ComputeEndDate(timeframeType: TimeframeType.week, numberOfDates: 10), percentComplete: 0, aspect: .political, timeframe: TimeframeType.week, image: nil, parent: nil, tasks: [UUID](), journals: []),
        
        Goal(title: "Be a good person", description: "Be a good person",priority: .high, startDate: Date(), endDate: Date().ComputeEndDate(timeframeType: TimeframeType.day, numberOfDates: 4), percentComplete: 0, aspect: .personal, timeframe: TimeframeType.day, image: nil,  parent: nil, tasks: [UUID](), journals: []),
        
        Goal(title: "Spring cleaning", description: "I need to get the house all cleaned up from winter.",priority: .moderate, startDate: Date(), endDate: Date().ComputeEndDate(timeframeType: TimeframeType.week, numberOfDates: 5), percentComplete: 0, aspect: .home, timeframe: TimeframeType.week, image: nil, parent: nil, tasks: [UUID](), journals: [])
    ]
}


