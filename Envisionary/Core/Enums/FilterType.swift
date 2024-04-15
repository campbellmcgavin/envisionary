//
//  FilterType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 8/6/23.
//

import SwiftUI

enum FilterType: CaseIterable {
    case creed
    case entry
    case date
    case subGoals
    case aspect
    case priority
    case progress
    case archived
 
    
    func toIcon() -> IconType {
        switch self {
        case .date:
            return .filter
        case .creed:
            return .envisionFilled
        case .entry:
            return .envisionFilled
        case .subGoals:
            return .envisionFilled
        case .archived:
            return .envisionFilled
        case .aspect:
            return .filter
        case .priority:
            return .filter
        case .progress:
            return .filter

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
        case .progress:
            return 2
        case .creed:
            return -1
        case .entry:
            return -2
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
        case .progress:
            return "Progress"
        case .date:
            return "Date"
        case .creed:
            return "Creed"
        case .entry:
            return "Entries"
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
        case .progress:
            return true
        case .date:
            return true
        case .creed:
            return false
        case .entry:
            return false
        }
    }
}
