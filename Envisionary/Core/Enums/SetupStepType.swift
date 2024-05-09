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
        case .thePoint:
            return "thePoint"
        case .getStarted:
            return "getStarted"
        case .done:
            return "done"
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
        case .getStarted:
            return "You're ready to"
        case .thePoint:
            return "Go ahead and choose"
        case .done:
            return ""
        case .loadPreviousData:
            return "Looks like we found"
        case .oneMoreThing:
            return "Please enable"
        }
    }

    func GetHeader() -> String{
        switch self {
        case .welcome:
            return "Welcome!"
        case .envisionary:
            return "Envisionary?"
        case .getStarted:
            return "Get started!"
        case .thePoint:
            return "A few goals..."
        case .done:
            return ""
        case .loadPreviousData:
            return "Something!"
        case .oneMoreThing:
            return "Notifications"
        }
    }
    
    func GetNext() -> Self{
        switch self {
        case .welcome:
            return .envisionary
        case .envisionary:
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
        case .thePoint:
            return .envisionary
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
        case .thePoint:
            array.append("We area dreamers and we know you are too! 🤩")
            array.append("Here are a few curated goals we thought could interest you.")
            array.append("Go ahead and choose a few! 🎁")
        case .getStarted:
            array.append("Tah-tah, off you go now. 👋")
            array.append("Imagine all the places you'll go! We'll be here to support you. 🤗")
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
