//
//  ObjectType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/8/23.
//

enum ContentViewType: String, CaseIterable{
    case envision = "Envision"
    case plan = "Plan"
    case execute = "Execute"
    case journal = "Journal"
    case evaluate = "Evaluate"
    
    
    func toIconString() -> String {
        switch self {
        case .envision:
            return "Icon_Envision"
        case .plan:
            return "Icon_Plan"
        case .execute:
            return "Icon_Execute"
        case .journal:
            return "Icon_Journal"
        case .evaluate:
            return "Icon_Evaluate"
        }
    }
    
    func toDescription() -> String {
        switch self {
        case .envision:
            return "determines who you want to become."
        case .plan:
            return "creates the path to get where you want"
        case .execute:
            return "carries out your plans"
        case .journal:
            return "records lessons along the path."
        case .evaluate:
            return "provides performance insights."
        }
    }
    
    func toIconStringFilled() -> String {
        switch self {
        case .envision:
            return "Icon_Envision_filled"
        case .plan:
            return "Icon_Plan_filled"
        case .execute:
            return "Icon_Execute_filled"
        case .journal:
            return "Icon_Journal_filled"
        case .evaluate:
            return "Icon_Evaluate_filled"
        }
    }
    
    func toString() -> String {
        switch self {
        case .envision:
            return "Envision"
        case .plan:
            return "Plan"
        case .execute:
            return "Execute"
        case .journal:
            return "Journal"
        case .evaluate:
            return "Evaluate"
        }
    }
}
