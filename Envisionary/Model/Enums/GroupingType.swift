//
//  GroupingType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/21/23.
//

import SwiftUI

enum GroupingType: CaseIterable {
    case title
    case date
    case aspect
    case priority
    case progress
    case schedule
    case chapter
    
    func toString() -> String{
        switch self {
        case .title:
            return "Title"
        case .date:
            return "Date"
        case .aspect:
            return "Aspect"
        case .priority:
            return "Priority"
        case .progress:
            return "Progress"
        case .schedule:
            return "Schedule"
        case .chapter:
            return "Chapter"
        }
    }
    
    func toPluralString() -> String{
        switch self {
        case .title:
            return "Titles"
        case .date:
            return "Dates"
        case .aspect:
            return "Aspects"
        case .priority:
            return "Priorities"
        case .progress:
            return "Progress"
        case .schedule:
            return "Schedules"
        case .chapter:
            return "Chapters"
        }
    }
    
    func hasObject(object: ObjectType) -> Bool {
        switch self {
        case .title:
            switch object {
            
            case .dream:
                return true
            
            case .goal:
                return true
            case .session:
                return false
            case .task:
                return true
            case .habit:
                return true
            case .home:
                return false
            case .chapter:
                return true
            case .entry:
                return true
            case .emotion:
                return true
            case .stats:
                return false
            default:
                return false
            }
        case .date:
            switch object {
            
            case .dream:
                return false
            
            case .goal:
                return true
//            case .session:
//                <#code#>
//            case .task:
//                <#code#>
//            case .habit:
//                <#code#>
//            case .home:
//                <#code#>
//            case .chapter:
//                <#code#>
//            case .entry:
//                <#code#>
//            case .emotion:
//                <#code#>
//            case .stats:
//                <#code#>
            default:
                return false
            }
        case .aspect:
            switch object {
            
            case .dream:
                return true
            
            case .goal:
                return true
//            case .session:
//                <#code#>
//            case .task:
//                <#code#>
//            case .habit:
//                <#code#>
//            case .home:
//                <#code#>
//            case .chapter:
//                <#code#>
//            case .entry:
//                <#code#>
//            case .emotion:
//                <#code#>
//            case .stats:
//                <#code#>
            default:
                return false
            }
        case .priority:
            switch object {
            
            case .dream:
                return false
            
            case .goal:
                return true
//            case .session:
//                <#code#>
//            case .task:
//                <#code#>
//            case .habit:
//                <#code#>
//            case .home:
//                <#code#>
//            case .chapter:
//                <#code#>
//            case .entry:
//                <#code#>
//            case .emotion:
//                <#code#>
//            case .stats:
//                <#code#>
            default:
                return false
            }
        case .progress:
            switch object {
            
            case .dream:
                return false
            
            case .goal:
                return true
//            case .session:
//                <#code#>
//            case .task:
//                <#code#>
//            case .habit:
//                <#code#>
//            case .home:
//                <#code#>
//            case .chapter:
//                <#code#>
//            case .entry:
//                <#code#>
//            case .emotion:
//                <#code#>
//            case .stats:
//                <#code#>
            default:
                return false
            }
        case .schedule:
            switch object {
            
            case .dream:
                return false
            
            case .goal:
                return false
//            case .session:
//                <#code#>
//            case .task:
//                <#code#>
//            case .habit:
//                <#code#>
//            case .home:
//                <#code#>
//            case .chapter:
//                <#code#>
//            case .entry:
//                <#code#>
//            case .emotion:
//                <#code#>
//            case .stats:
//                <#code#>
            default:
                return false
            }
        case .chapter:
            switch object {
            
            case .dream:
                return false
            
            case .goal:
                return false
//            case .session:
//                <#code#>
//            case .task:
//                <#code#>
//            case .habit:
//                <#code#>
//            case .home:
//                <#code#>
//            case .chapter:
//                <#code#>
//            case .entry:
//                <#code#>
//            case .emotion:
//                <#code#>
//            case .stats:
//                <#code#>
            default:
                return false
            }
        }
    }
}
