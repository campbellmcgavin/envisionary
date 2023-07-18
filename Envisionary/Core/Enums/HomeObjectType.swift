//
//  HomeObjectTypes.swift
//  Envisionary
//
//  Created by Campbell McGavin on 7/11/23.
//

import SwiftUI

enum HomeObjectType: CaseIterable {
    case habit
    case goal
    case favorite
    case hint
    
    
    func toPluralString() -> String{
        switch self {
        case .habit:
            return "Habits"
        case .goal:
            return "Goals"
        case .favorite:
            return "Favorites"
        case .hint:
            return "Hints"
        }
    }
    
    func toObject() -> ObjectType{
        switch self {
        case .habit:
            return .recurrence
        case .goal:
            return .goal
        case .favorite:
            return .prompt
        case .hint:
            return .prompt
        }
    }
    
    func toInt() -> Int{
        switch self {
        case .habit:
            return 3
        case .goal:
            return 2
        case .favorite:
            return 1
        case .hint:
            return 0
        }
    }
    
    static func fromString(from string: String) -> Self{
        return Self.allCases.first(where: {$0.toPluralString() == string}) ?? .hint
    }
}
