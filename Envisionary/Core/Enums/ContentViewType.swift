//
//  ObjectType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/8/23.
//

enum ContentViewType: String, CaseIterable{
    case values = "Values"
    case goals = "Goals"
    case execute = "Execute"
    case journals = "Journals"
//    case evaluate = "Evaluate"
    
    
    func toInt() -> Int {
        switch self {
        case .values:
            return 0
        case .goals:
            return 1
        case .execute:
            return 2
        case .journals:
            return 3
//        case .evaluate:
//            return 4
        }
    }
    
    func toIcon() -> IconType {
        switch self {
        case .values:
            return .envision
        case .goals:
            return .plan
        case .execute:
            return .execute
        case .journals:
            return .journal
//        case .evaluate:
//            return .evaluate
        }
    }
    
    func getNext() -> Self?{
        switch self {
        case .values:
            return .goals
        case .goals:
            return .execute
        case .execute:
            return .journals
        case .journals:
            return nil
//        case .evaluate:
//            return nil
        }
    }
    
    func toDescription() -> String {
        switch self {
        case .values:
            return "determines who you want to become."
        case .goals:
            return "creates the path to get where you want"
        case .execute:
            return "carries out your plans"
        case .journals:
            return "records lessons along the path."
//        case .evaluate:
//            return "provides performance insights."
        }
    }
    
    func toLongDescription() -> String{
        switch self{
        case .values:
            return "Envision is the phase for creating the vision of who you want to become."
        case .goals:
            return "Plan is the phase for mapping out concrete plans to achieve your vision."
        case .execute:
            return "Execute is the phase for executing day to day work that leads to the vision."
        case .journals:
            return "Journal is the phase for recording your thoughts and feelings along the way."
        }

    }
    
    func toFilledIcon() -> IconType{
        switch self {
        case .values:
            return .envisionFilled
        case .goals:
            return .planFilled
        case .execute:
            return .executeFilled
        case .journals:
            return .journalFilled
//        case .evaluate:
//            return .evaluateFilled
        }
    }
    
    func toString() -> String {
        switch self {
        case .values:
            return "Values"
        case .goals:
            return "Goals"
        case .execute:
            return "Execute"
        case .journals:
            return "Journals"
        }
    }
}
