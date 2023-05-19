//
//  PromptType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/5/23.
//

import SwiftUI

enum PromptType: CaseIterable, Hashable, Codable {
    case favorite           // user-registed favorite object... will need sub-types here.
    case suggestion           // user-requested reminders, setup in settings
    
    func toString() -> String{
        switch self {
        case .favorite:
            return "Favorite"
        case .suggestion:
            return "Suggestion"
        }
    }
    
    func toPluralString() -> String{
        switch self {
        case .favorite:
            return "Favorites"
        case .suggestion:
            return "Suggestions"
        }
    }
    
    static func fromString(from string: String) -> Self{
        return Self.allCases.first(where: {$0.toString() == string}) ?? .suggestion
    }
}
