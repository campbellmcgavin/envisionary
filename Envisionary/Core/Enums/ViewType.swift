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
    case checkOff
    case progress
    
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
        case .checkOff:
            return "Todo"
        case .progress:
            return "Progress"
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
        case .checkOff:
            return "Throttle the power of hierarchy and execution with a pyramid-style todo list."
        case .progress:
            return "Dive into graphs and metrics to see your performance."
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
    
    static func fromString(from string: String) -> Self{
        return Self.allCases.first(where: {$0.toString() == string}) ?? .tree
    }
}
