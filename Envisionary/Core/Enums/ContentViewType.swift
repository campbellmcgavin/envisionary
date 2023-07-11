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
//    case evaluate = "Evaluate"
    
    
    func toInt() -> Int {
        switch self {
        case .envision:
            return 0
        case .plan:
            return 1
        case .execute:
            return 2
        case .journal:
            return 3
//        case .evaluate:
//            return 4
        }
    }
    
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
//        case .evaluate:
//            return .evaluate
        }
    }
    
    func getNext() -> Self?{
        switch self {
        case .envision:
            return .plan
        case .plan:
            return .execute
        case .execute:
            return .journal
        case .journal:
            return nil
//        case .evaluate:
//            return nil
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
//        case .evaluate:
//            return "provides performance insights."
        }
    }
    
    func toLongDescription() -> String{
        switch self{
        case .envision:
            return "Envision is the phase for creating the vision of who you want to become."
        case .plan:
            return "Plan is the phase for mapping out concrete plans to achieve your vision."
        case .execute:
            return "Execute is the phase for executing day to day work that leads to the vision."
        case .journal:
            return "Journal is the phase for recording your thoughts and emotions along the way."
//        case .evaluate:
//            return "Evaluate is the phase for quantifying performance, growth and progress."
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
//        case .evaluate:
//            return .evaluateFilled
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
//        case .evaluate:
//            return "Evaluate"
        }
    }
}
