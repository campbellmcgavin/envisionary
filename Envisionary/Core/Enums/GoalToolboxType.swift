//
//  GoalToolboxType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 8/9/23.
//

import SwiftUI

enum GoalToolboxType {
    case tree
    case gantt
    case kanban
    
    func toString() -> String{
        switch self {
        case .tree:
            return "Tree"
        case .gantt:
            return "Gantt"
        case .kanban:
            return "Kanban"
        }
    }
}
