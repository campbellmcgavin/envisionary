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
    var aspect: String
    var image: UUID?
    var parentId: UUID?
    var valuesDictionary: [String: Bool]?
    var archived: Bool
    
    init(id: UUID = UUID(), title: String, description: String, priority: PriorityType, startDate: Date, endDate: Date, percentComplete: Int, aspect: String, image: UUID?, parent: UUID?, tasks: [UUID], journals: [UUID]){
        self.id = id
        self.title = title
        self.description = description
        self.priority = priority
        self.startDate = startDate
        self.endDate = endDate
        self.progress = percentComplete
        self.image = image
        self.aspect = aspect
        self.parentId = parent
        self.valuesDictionary = nil
        self.archived = false
    }
    
    init(){
        self.id = UUID()
        self.title = "New Goal"
        self.description = "New Description"
        self.priority = .moderate
        self.startDate = Date()
        self.endDate = Date()
        self.progress = 0
        self.aspect = AspectType.academic.toString()
        self.valuesDictionary = nil
        self.archived = false
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
        self.image = request.image
        self.parentId = request.parentId
        self.archived = false
    }
    
    init(from entity: GoalEntity){
        self.id = entity.id ?? UUID()
        self.title = entity.title ?? ""
        self.description = entity.desc ?? ""
        self.priority = PriorityType.allCases.first(where: {$0.toString() == entity.priority ?? ""}) ?? .low
        self.startDate = entity.startDate ?? Date()
        self.endDate = entity.endDate ?? Date()
        self.progress = Int(entity.progress)
        self.aspect = entity.aspect ?? ""
        self.image = entity.image
        self.parentId = entity.parentId
        self.archived = entity.archived
        
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
        archived = request.archived
    }
}
