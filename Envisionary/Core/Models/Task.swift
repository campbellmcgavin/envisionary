//
//  Task.swift
//  Visionary
//
//  Created by Campbell McGavin on 3/10/22.
//
import SwiftUI
import Foundation

struct Task: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
//    var parentId: UUID?
//    var isAllDay: Bool
//    var isScratchpad: Bool
    var title: String
    var description: String
    var startDate: Date
    var endDate: Date

    var progress: Int
//    var taskStatus: TaskStatusType
//    var isRecurring: Bool
//    var recurrence: Recurrence?

    init(title: String, description: String) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.startDate = Date()
        self.endDate = Date()
        self.progress = 0
    }

    init(){
        self.id = UUID()
        self.title = ""
        self.description = ""
        self.progress = 0
        self.startDate = Date()
        self.endDate = Date()
    }
    
    init(from entity: TaskEntity){
        self.id = entity.id ?? UUID()
        self.title = entity.title ?? ""
        self.description = entity.desc ?? ""
        self.startDate = entity.startDate ?? Date()
        self.endDate = entity.endDate ?? Date()
        self.progress = Int(entity.progress)
    }

    mutating func update(from request: UpdateTaskRequest) {
        title = request.title
        description = request.description
        startDate = request.startDate
        endDate = request.endDate
        progress = request.progress
    }
}

extension Task {


    static let sampleTasks: [Task] =
    [
        Task(),
        Task(title: "Comb the dog", description: "But do it emphatically so you they know who's boss."),
        Task(title: "Wash the dog", description: "Like it's swimming in a lake."),
        Task(title: "Dry the dog", description: "Without getting wet yourself."),
        Task(title: "Cut the dog's hair", description: "But not it's skin or eyeballs."),
        Task(title: "Hug the dog", description: "Yes yes yesyesyeysyesyeyseyes. Eyes."),
        Task(title: "Tell the dog they're a good boy", description: "Such a good boy!!!!!!!!!!!!")
    ]
}
