//
//  DateFilterType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/9/24.
//

import SwiftUI

enum DateFilterType: CaseIterable, Identifiable {
    
    var id: Self {
        return self
    }
    
    case list
    case gantt
    case none
    
    func toString() -> String{
        switch self {
        case .list:
            return "List"
        case .gantt:
            return "Gantt"
        case .none:
            return "None"
        }
    }
    
    static func fromString(from string: String) -> Self{
        return Self.allCases.first(where: {$0.toString() == string}) ?? .none
    }
}
