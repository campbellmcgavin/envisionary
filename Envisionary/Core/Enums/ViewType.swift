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
    case goalValueAlignment
    case creed
    case valueGoalAlignment
    
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
        case .goalValueAlignment:
            return "Values"
        case .valueGoalAlignment:
            return "Alignment"
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
        case .goalValueAlignment:
            return "Ensure that your goals are in-line with your core values, and who you want to become."
        case .valueGoalAlignment:
            return "Ensure that your goals are in-line with your core values, and who you want to become."
        }
    }
    
    func toSubDescription() -> String?{
        switch self {
        case .goalValueAlignment:
            return "FYI, you only need to align your values on super goals. You won't see this on your sub goals."
        case .valueGoalAlignment:
            return "FYI, you only need to align your values on super goals. You won't see this on your sub goals."
        default:
            return nil
        }
    }
    
    func shouldHaveButton(button: ViewMenuButtonType) -> Bool {
        switch self {
        case .goalValueAlignment:
            return false
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
            case .expand_all:
                return true
            case .timeAdd:
                return false
            case .timeSubtract:
                return false
            }
        case .gantt:
            switch button {
            case .delete:
                return false
            case .timeBack:
                return true
            case .timeForward:
                return true
            case .expand:
                return true
            case .photo:
                return false
            case .edit:
                return false
            case .add:
                return false
            case .goTo:
                return true
            case .forward:
                return false
            case .backward:
                return false
            case .expand_all:
                return true
            case .timeAdd:
                return true
            case .timeSubtract:
                return true
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
                return false
            case .add:
                return false
            case .goTo:
                return true
            case .forward:
                return true
            case .backward:
                return true
            default:
                return false
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
            default:
                return false
            }
        case .valueGoalAlignment:
            return false
        }
    }
    
    static func fromString(from string: String) -> Self{
        return Self.allCases.first(where: {$0.toString() == string}) ?? .tree
    }
}
