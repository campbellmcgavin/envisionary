//
//  FilterType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 8/6/23.
//

import SwiftUI

enum FilterType: CaseIterable {
    case date
    case subGoals
    case aspect
    case priority
    case completed
    case archived
 
    func toIcon() -> IconType {
        switch self {
        case .date:
            return .filter
        case .subGoals:
            return .envisionFilled
        case .archived:
            return .envisionFilled
        case .aspect:
            return .filter
        case .priority:
            return .filter
        case .completed:
            return .envisionFilled
        }
    }
    
    func toInt() -> Int{
        switch self {
        case .date:
            return 0
        case .subGoals:
            return 1
        case .archived:
            return 5
        case .aspect:
            return 4
        case .priority:
            return 3
        case .completed:
            return 2
        }
    }
    func toString() -> String{
        switch self {
        case .archived:
            return "Archived"
        case .subGoals:
            return "Subgoals"
        case .aspect:
            return "Aspect"
        case .priority:
            return "Priority"
        case .completed:
            return "Completed"
        case .date:
            return "Date"
        }
    }
    
    func hasDropDown() -> Bool{
        switch self {
        case .archived:
            return false
        case .subGoals:
            return false
        case .aspect:
            return true
        case .priority:
            return true
        case .completed:
            return false
        case .date:
            return false
        }
    }
}
