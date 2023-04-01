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
}
