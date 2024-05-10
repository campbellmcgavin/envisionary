//
//  DateFilterType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/9/24.
//

import SwiftUI

enum ViewFilterType: CaseIterable, Identifiable {
    
    var id: Self {
        return self
    }
    case todo
    case gantt
    case progress
    case none
    
    func toString() -> String{
        switch self {
        case .gantt:
            return "Gantt"
        case .todo:
            return "Todo"
        case .progress:
            return "Progress"
        case .none:
            return "None"
        }
    }
    
    static func fromString(from string: String) -> Self{
        return Self.allCases.first(where: {$0.toString() == string}) ?? .none
    }
}
