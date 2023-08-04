//
//  SetupType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/8/23.
//

import SwiftUI

enum SetupStepType: CaseIterable {
    
    case welcome
    case loadPreviousData
    case envisionary
    case phases
    case archetype
    case thePoint
    case oneMoreThing
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
        case .loadPreviousData:
            return "loadPreviousData"
        case .oneMoreThing:
            return "oneMoreThing"
        }
    }
    
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
        case .loadPreviousData:
            return "Looks like we found"
        case .oneMoreThing:
            return "Please enable"
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
        case .loadPreviousData:
            return "Something!"
        case .oneMoreThing:
            return "Notifications"
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
            return .oneMoreThing
        case .getStarted:
            return .done
        case .done:
            return .done
        case .loadPreviousData:
            return .oneMoreThing
        case .oneMoreThing:
            return .getStarted
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
        case .loadPreviousData:
            return .welcome
        case .oneMoreThing:
            return .thePoint
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
            array.append("And... one final surprise! We have a little present for you. 🥹")
        case .getStarted:
            array.append("Tah-tah, off you go now. 👋")
            array.append("Just remember, this is a productivity platform with many tools, so don't feel like you need to use everything all at once.")
        case .loadPreviousData:
            array.append("You have app data from a previous install.")
            array.append("Typically, you'll want to use the existing data.")
        case .oneMoreThing:
            array.append("We promise we'll only help you fulfill your dreams!")
        default:
            let _ = "why"
        }
                         
         return array
    }
    
    static func fromString(from string: String) -> Self{
        return Self.allCases.first(where: {$0.toString() == string}) ?? .welcome
    }
}
