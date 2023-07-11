////
////  TutorialStepType.swift
////  Envisionary
////
////  Created by Campbell McGavin on 6/5/23.
////
//
//import SwiftUI
//
//enum TutorialStepType {
//    case welcome
//    case envisionary
//    case phases
//    case envision
//    case plan
//    case execute
//    case journal
////    case evaluate
//    case objects
//    case getStarted
//
//    func toString() -> String{
//        switch self {
//        case .welcome:
//            return "Welcome!"
//        case .envisionary:
//            return "Envisionary?"
//        case .phases:
//            return "Phases?"
//        case .envision:
//            return "Envision?"
//        case .plan:
//            return "Plan?"
//        case .execute:
//            return "Execute?"
//        case .journal:
//            return "Journal?"
////        case .evaluate:
////            return "Evaluate?"
//        case .objects:
//            return "Objects."
//        case .getStarted:
//            return "Get started!"
//        }
//    }
//
//    func getNext() -> Self{
//        switch self {
//        case .welcome:
//            return .envisionary
//        case .envisionary:
//            return .phases
//        case .phases:
//            return .envision
//        case .envision:
//            return .plan
//        case .plan:
//            return .execute
//        case .execute:
//            return .journal
//        case .journal:
//            return .evaluate
////        case .evaluate:
////            return .objects
//        case .objects:
//            return .getStarted
//        case .getStarted:
//            return .getStarted
//        }
//    }
//
//    func toContentType() -> ContentViewType?{
//        switch self {
//        case .welcome:
//            return nil
//        case .envisionary:
//            return nil
//        case .phases:
//            return nil
//        case .envision:
//            return .envision
//        case .plan:
//            return .plan
//        case .execute:
//            return .execute
//        case .journal:
//            return .journal
////        case .evaluate:
////            return .evaluate
//        case .objects:
//            return nil
//        case .getStarted:
//            return nil
//        }
//    }
//
//
//    func toDescription() -> String{
//        switch self {
//        case .welcome:
//            return "You’ve been waiting for this moment your entire life! You just didn’t know it yet."
//        case .envisionary:
//            return "A productivity platform that emboldens you to envision your entire life’s work, and then break it down into manageable chunks."
//        case .phases:
//            return "Distinct segments of the process for mapping out and accomplishing everything in life."
//        case .envision:
//            return "The phase for creating the vision of who you want to become."
//        case .plan:
//            return "The phase for mapping out concrete plans to achieve your vision."
//        case .execute:
//            return "The phase for executing day to day work that leads to the vision."
//        case .journal:
//            return "The phase for recording your thoughts, and emotions along the way."
//        case .evaluate:
//            return "The phase for quantifying performance, growth and progress."
//        case .objects:
//            return "For example, the envision phase allows you to create Values, Creed, Dreams and Aspects."
//        case .getStarted:
//            return "Let’s jump in and start adding your first objects."
//        }
//    }
//
//    func toCaption() -> String{
//        switch self {
//        case .welcome:
//            return "Hello, and"
//        case .envisionary:
//            return "What is"
//        case .phases:
//            return "What are"
//        case .envision:
//            return "What is"
//        case .plan:
//            return "What is"
//        case .execute:
//            return "What is"
//        case .journal:
//            return "What is"
//        case .evaluate:
//            return "What is"
//        case .objects:
//            return "Each phase has"
//        case .getStarted:
//            return "You're ready to"
//        }
//    }
//}
