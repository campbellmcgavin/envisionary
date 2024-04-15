//
//  GroupingType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/21/23.
//

import SwiftUI

enum GroupingType: CaseIterable {
    case title
    case aspect
    case priority
    case progress
    case schedule
    case chapter
    case hasImages
    
    func toString() -> String{
        switch self {
        case .title:
            return "Title"
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
        case .hasImages:
            return "Has Images"
        }
    }
    
    func toPluralString() -> String{
        switch self {
        case .title:
            return "Titles"
        case .hasImages:
            return "Has Images"
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
        
        switch object {
        case .value:
            return false
        case .creed:
            return false
        case .dream:
            switch self {
            case .title:
                return true
            case .aspect:
                return true
            case .priority:
                return false
            case .progress:
                return false
            case .schedule:
                return false
            case .chapter:
                return false
            case .hasImages:
                return false
            }
        case .aspect:
            return false
        case .goal:
            switch self {
            case .title:
                return true
            case .aspect:
                return true
            case .priority:
                return true
            case .progress:
                return true
            case .schedule:
                return false
            case .chapter:
                return false
            case .hasImages:
                return false
            }
        case .session:
            return false
        case .habit:
            switch self {
            case .title:
                return true
            case .aspect:
                return true
            case .priority:
                return true
            case .progress:
                return false
            case .schedule:
                return true
            case .chapter:
                return false
            case .hasImages:
                return false
            }
        case .home:
            return false
        case .journal:
            switch self {
            case .title:
                return true
            case .aspect:
                return true
            case .priority:
                return false
            case .progress:
                return false
            case .schedule:
                return false
            case .chapter:
                return false
            case .hasImages:
                return false
            }
        case .entry:
            switch self {
            case .title:
                return true
            case .aspect:
                return false
            case .priority:
                return false
            case .progress:
                return false
            case .schedule:
                return false
            case .chapter:
                return true
            case .hasImages:
                return true
            }
        case .prompt:
            return false
        case .recurrence:
            return false
        case .valueRating:
            return false
        case .favorite:
            return false
        }
    }
    
    static func fromString(from string: String) -> Self{
        return Self.allCases.first(where: {$0.toPluralString() == string}) ?? .title
    }
}
