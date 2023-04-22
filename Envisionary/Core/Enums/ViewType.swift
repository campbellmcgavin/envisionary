//
//  ViewType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/30/23.
//

import Foundation

enum ViewType: CaseIterable {
    case tree
    case gantt
    case kanban
    case creed
    
    func toString() -> String{
        switch self {
        case .tree:
            return "Tree"
        case .gantt:
            return "Gantt"
        case .kanban:
            return "Kanban"
        case .creed:
            return "Editor"
        }
    }
        
    func toDescription() -> String{
        switch self {
        case .tree:
            return "See the hierarchy of goals and create big picture structure."
        case .gantt:
            return "Master timelines and dependencies to stay on top of your game."
        case .kanban:
            return "Carry goals from start to finish."
        case .creed:
            return "Take your core values and create a life's mission statement."
        }
    }
    
    func shouldHaveButton(button: ViewMenuButtonType) -> Bool {
        switch self {
        case .tree:
            switch button {
            case .delete:
                return true
            case .timeBack:
                return false
            case .timeForward:
                return false
            case .expand:
                return true
            case .photo:
                return true
            case .edit:
                return true
            case .add:
                return true
            case .goTo:
                return true
            case .forward:
                return false
            case .backward:
                return false
            }
        case .gantt:
            switch button {
            case .delete:
                return true
            case .timeBack:
                return true
            case .timeForward:
                return true
            case .expand:
                return true
            case .photo:
                return false
            case .edit:
                return true
            case .add:
                return true
            case .goTo:
                return true
            case .forward:
                return false
            case .backward:
                return false
            }
        case .kanban:
            switch button {
            case .delete:
                return true
            case .timeBack:
                return false
            case .timeForward:
                return false
            case .expand:
                return false
            case .photo:
                return false
            case .edit:
                return true
            case .add:
                return true
            case .goTo:
                return true
            case .forward:
                return true
            case .backward:
                return true
            }
        case .creed:
            switch button {
            case .delete:
                return true
            case .forward:
                return false
            case .backward:
                return false
            case .timeBack:
                return false
            case .timeForward:
                return false
            case .expand:
                return false
            case .photo:
                return false
            case .edit:
                return true
            case .add:
                return false
            case .goTo:
                return true
            }
        }
    }
}
