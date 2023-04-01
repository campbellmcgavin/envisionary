//
//  GenericMember.swift
//  Visionary
//
//  Created by Campbell McGavin on 4/1/22.
//

import Foundation
import SwiftUI

struct TaskStatus: Identifiable, Codable, Equatable, Hashable{
    
    let id: UUID
    var title: String
    var startRange: Int
    var endRange: Int

    
    init(id: UUID = UUID(), title: String, startRange: Int, endRange: Int) {
        self.id = id
        self.title = title
        self.startRange = startRange
        self.endRange = endRange
    }

    
    
    static func ==(lhs: TaskStatus, rhs: TaskStatus) -> Bool {
        
        return lhs.title == rhs.title && lhs.startRange == rhs.startRange && lhs.endRange == rhs.endRange
    }
}

extension TaskStatus {
    
    
    struct EditableData: Identifiable, Equatable, Hashable {
        let id: UUID = UUID()
        var title: String = ""
        var startRange: Int = 0
        var endRange: Int = 0
    }

    var editableData: EditableData {
        EditableData(title: title, startRange: startRange, endRange: endRange)
    }
    
    mutating func update(from editableData: EditableData) {
        title = editableData.title
        startRange = editableData.startRange
        endRange = editableData.endRange
    }

    init(editableData: EditableData) {
        id = UUID()
        title = editableData.title
        startRange = editableData.startRange
        endRange = editableData.endRange
    }
    
}

extension TaskStatus {
    static let taskStatuses: [TaskStatus] =
    [
        TaskStatus(title: "Not Started", startRange: 0, endRange: 1),
        TaskStatus(title: "In Progress", startRange: 2, endRange: 98),
        TaskStatus(title: "Completed",  startRange: 99, endRange: 100)

    ]
}

