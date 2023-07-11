//
//  SetupType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/8/23.
//

import SwiftUI

enum SetupStepType: CaseIterable {
    
    case welcome
    case envisionary
    case phases
    case archetype
    case thePoint
    case getStarted
    case done
    
    func toString() -> String{
        switch self {
        case .welcome:
            return "welcome"
        case .envisionary:
            return "envisionary"
        case .phases:
            return "phases"
        case .archetype:
            return "Archetype"
        case .getStarted:
            return "getStarted"
        case .done:
            return "done"
        case .thePoint:
            return "thePoint"
        }
    }
//
//    func toContentView() -> ContentViewType{
//        switch self {
//        case .welcome:
//            return .envision
//        case .envisionary:
//            return .envision
//        case .phases:
//            return .envision
//        case .archetype:
//            return .envision
//        case .getStarted:
//            return .envision
//        case .value:
//            return .envision
//        case .creed:
//            return .envision
//        case .dream:
//            return .envision
//        case .aspect:
//            return .envision
//        case .goalIntro:
//            return .plan
//        case .habit:
//            return .plan
//        case .session:
//            return .plan
//        case .home:
//            return .execute
//        case .chapter:
//            return .journal
//        case .entry:
//            return .journal
//        case .emotion:
//            return .journal
//        default:
//            return .execute
//        }
//    }
//
//    func hasObject() -> Bool{
//        switch self {
//        case .welcome:
//            return false
//        case .envisionary:
//            return false
//        case .phases:
//            return false
//        case .archetype:
//            return false
//        case .getStarted:
//            return false
//        default:
//            return true
//        }
//    }
//
//    func toObject() -> ObjectType{
//        switch self {
//        case .value:
//            return .value
//        case .creed:
//            return .creed
//        case .dream:
//            return .dream
//        case .aspect:
//            return .aspect
//        case .goalIntro:
//            return .goal
//        case .habit:
//            return .habit
//        case .session:
//            return .session
//        case .home:
//            return .home
//        case .chapter:
//            return .chapter
//        case .entry:
//            return .entry
//        case .emotion:
//            return .emotion
//        default:
//            return .emotion
//        }
//    }
//
    func GetSubheader() -> String{
        switch self {
        case .welcome:
            return "Hello, and"
        case .envisionary:
            return "What is"
        case .phases:
            return "What are"
        case .archetype:
            return "What is your"
        case .getStarted:
            return "You're ready to"
        case .done:
            return ""
        case .thePoint:
            return "Hey there,"
        }
    }

    func GetHeader(archetype: ArchetypeType? = nil) -> String{
        switch self {
        case .welcome:
            return "Welcome!"
        case .envisionary:
            return "Envisionary?"
        case .phases:
            return "Phases?"
        case .archetype:
            return "Archetype?"
        case .getStarted:
            return "Get started!"
        case .done:
            return ""
        case .thePoint:
            if let archetype{
                return archetype.toString() + "!"
            }
            return ""
        }
    }
//
//    func GetColor() -> CustomColor {
//        switch self {
//        case .welcome:
//            return .grey2
//        case .envisionary:
//            return .grey2
//        case .phases:
//            return .grey2
//        case .archetype:
//            return .grey2
//        case .getStarted:
//            return .grey2
//        default:
//            return .purple
//        }
//    }
//
//    func HasNext() -> Bool{
//        return false
//    }
    
    func GetNext() -> Self{
        switch self {
        case .welcome:
            return .envisionary
        case .envisionary:
            return .phases
        case .phases:
            return .archetype
        case .archetype:
            return .thePoint
        case .thePoint:
            return .getStarted
        case .getStarted:
            return .done
        case .done:
            return .done
        }
    }
    
    func GetPrevious() -> Self{
        switch self {
        case .welcome:
            return .welcome
        case .envisionary:
            return .welcome
        case .phases:
            return .envisionary
        case .archetype:
            return .phases
        case .thePoint:
            return .archetype
        case .getStarted:
            return .thePoint
        case .done:
            return .getStarted

        }
    }
    
    func toTextArray() -> [String]{
        
        var array = [String]()
        
        switch self {
        case .welcome:
            array.append("We believe humans have truly infinite potential...")
            array.append("And we want to help you achieve that potential by using Envisionary!")
        case .envisionary:
            array.append("A productivity platform that emboldens you to envision your entire life’s work... 🏆")
            array.append("... and then break it down into manageable chunks. 🧀")
        case .phases:
            array.append("Distinct segments of the process for mapping out and accomplishing everything in life.")
        case .archetype:
            array.append("Your archetype is a profile fitted just for you.")
            array.append("It will be used to help create a streamlined setup of the entire app. 🏎💨")
            array.append("You will be able to edit or change anything after the fact.")
            array.append("Go ahead and pick the archetype that fits you best!")
        case .thePoint:
            array.append("You are looking great. Can we just say that??")
            array.append("As promised, we've filled everything out for you. You'll be able to delete or edit anything you want.")
            array.append("And... one final surprise! We made you your FIRST goal. We think you'll love it. 🥹")
            array.append("Notice how the big idea is broken into smaller ideas, starting at Decade, then year, etc...")
        case .getStarted:
            array.append("Tah-tah, off you go now. 👋")
            array.append("Just remember, this is a productivity platform with many tools, so don't feel like you need to use everything all at once.")
        default:
            let _ = "why"
        }
                         
         return array
    }
    
    static func fromString(from string: String) -> Self{
        return Self.allCases.first(where: {$0.toString() == string}) ?? .welcome
    }
}
