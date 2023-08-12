//
//  FilterType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 8/6/23.
//

import SwiftUI

enum FilterType: CaseIterable {
    case archived // bool
    case superGoal // 
    case aspect
    case priority
    case progress
 
    
    func toInt() -> Int{
        switch self {
        case .archived:
            return 0
        case .superGoal:
            return 1
        case .aspect:
            return 3
        case .priority:
            return 5
        case .progress:
            return 4
        }
    }
    func toString() -> String{
        switch self {
        case .archived:
            return "Archived"
        case .superGoal:
            return "Super Goals"
        case .aspect:
            return "Aspect"
        case .priority:
            return "Priority"
        case .progress:
            return "Progress"
        }
    }
    
    func hasDropDown() -> Bool{
        switch self {
        case .archived:
            return false
        case .superGoal:
            return false
        case .aspect:
            return true
        case .priority:
            return true
        case .progress:
            return true
        }
    }
}
