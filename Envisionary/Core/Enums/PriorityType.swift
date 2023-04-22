//
//  PriorityType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/11/23.
//

enum PriorityType: CaseIterable, Codable{
    case critical
    case high
    case moderate
    case low
        
    func toIcon() -> IconType{
        return .aspect
    }
    
    func toString() -> String{
        switch self {
        case .critical: return "Critical"
        case .high: return "High"
        case .moderate: return "Moderate"
        case .low: return "Low"
        }
    }
    
    func toLongString() -> String{
        switch self {
        case .critical: return "Critical Priority"
        case .high: return "High Priority"
        case .moderate: return "Moderate Priority"
        case .low: return "Low Priority"
        }
    }
}
