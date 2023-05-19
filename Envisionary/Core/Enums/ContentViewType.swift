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
    
    
    func toIcon() -> IconType {
        switch self {
        case .envision:
            return .envision
        case .plan:
            return .plan
        case .execute:
            return .execute
        case .journal:
            return .journal
        case .evaluate:
            return .evaluate
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
    
    func toFilledIcon() -> IconType{
        switch self {
        case .envision:
            return .envisionFilled
        case .plan:
            return .planFilled
        case .execute:
            return .executeFilled
        case .journal:
            return .journalFilled
        case .evaluate:
            return .evaluateFilled
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
