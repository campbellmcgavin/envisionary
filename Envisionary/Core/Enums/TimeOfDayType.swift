//
//  TimeOfDayType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/21/23.
//

import SwiftUI

enum TimeOfDayType: CaseIterable, Codable, Equatable, Hashable  {
    case morning
    case evening
    case notApplicable
    
    func toString() -> String{
        switch self {
        case .morning:
            return "Morning"
        case .evening:
            return "Evening"
        case .notApplicable:
            return ""
        }
    }
    
    static func fromString(input: String) -> TimeOfDayType{
        return Self.allCases.first(where: {$0.toString() == input}) ?? .notApplicable
    }
}
