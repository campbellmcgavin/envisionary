//
//  PromptType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/5/23.
//

import SwiftUI

enum PromptType: CaseIterable, Hashable, Codable {
    case favorite           // user-registed favorite object... will need sub-types here.
    case entry              // once a day in the evening
    case digest             // once a day in the morning
    case valueAlignment     // once a month in the evening
    
    func toString() -> String{
        switch self {
        case .favorite:
            return "Favorite"
        case .entry:
            return "Entry"
        case .digest:
            return "Morning Digest"
        case .valueAlignment:
            return "Value Alignment"
        }
    }
    
    func toPluralString() -> String{
        switch self {
        case .favorite:
            return "Favorites"
        case .entry:
            return "Entries"
        case .digest:
            return "Daily Digest"
        case .valueAlignment:
            return "Value Alignment"
        }
    }
    
    func toDescription() -> String{
        switch self {
        case .favorite:
            return "Give you that gentle nudge to re-center on your favorite items."
        case .entry:
            return "Finish strong by giving yourself a minute to write about your day."
        case .digest:
            return "Start the day off right by seeing what you have going on."
        case .valueAlignment:
            return "Re-evaluate your core values, and align assess goal alignment."
        }
    }
    
    func toScheduleType() -> TimeOfDayType{
        switch self {
        case .favorite:
            return .morning
        case .entry:
            return .evening
        case .digest:
            return .morning
        case .valueAlignment:
            return .evening
        }
    }
    
    func toTimeOfDay() -> Int{
        switch self {
        case .favorite:
            return 9
        case .digest:
            return 9
        case .valueAlignment:
            return 9
        case .entry:
            return 21
        }
    }
    
    static func fromString(from string: String) -> Self{
        return Self.allCases.first(where: {$0.toString() == string}) ?? .favorite
    }
}
