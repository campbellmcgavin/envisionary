//
//  UnitType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/21/23.
//

import SwiftUI

enum UnitType: CaseIterable, Codable, Equatable, Hashable {
    case minutes
    case hours
    case times
    case dollars
    case pounds
    case kilograms
    case miles
    case kilometers
    
    func toString() -> String{
        switch self {
        case .minutes:
            return "minutes"
        case .hours:
            return "hours"
        case .times:
            return "times"
        case .dollars:
            return "dollars"
        case .pounds:
            return "pounds"
        case .kilograms:
            return "kilograms"
        case .miles:
            return "miles"
        case .kilometers:
            return "kilometers"
        }
    }
    
    func toStringShort() -> String{
        switch self {
        case .minutes:
            return "mins"
        case .hours:
            return "hrs"
        case .times:
            return "times"
        case .dollars:
            return "dollars"
        case .pounds:
            return "lbs"
        case .kilograms:
            return "kgs"
        case .miles:
            return "mi"
        case .kilometers:
            return "km"
        }
    }
    
    static func fromString(input: String) -> Self{
        return Self.allCases.first(where: {$0.toString() == input}) ?? .minutes
    }
}
