//
//  EvaluationType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/5/23.
//

import SwiftUI

enum EvaluationType: String, CaseIterable, Hashable, Codable {

    case keepAsIs
    case editDetails
    case pushOffTillNext
    case deleteIt
    
    func toString() -> String{
        switch self {
        case .keepAsIs:
            return "Keep"
        case .editDetails:
            return "Edit"
        case .pushOffTillNext:
            return "Push"
        case .deleteIt:
            return "Delete"
        }
    }
    
    static func fromString(from string: String) -> Self{
        return Self.allCases.first(where: {$0.toString() == string}) ?? .keepAsIs

    }
}
