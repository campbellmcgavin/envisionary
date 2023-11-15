//
//  Placement.swift
//  Envisionary
//
//  Created by Campbell McGavin on 11/9/23.
//
enum PlacementType{
    case above
    case on
    case below
    
    func toString() -> String{
        switch self {
        case .above:
            return "above"
        case .on:
            return "on"
        case .below:
            return "below"
        }
    }
}
