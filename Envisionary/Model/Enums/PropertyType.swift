//
//  PropertyType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/11/23.
//

enum PropertyType: String, CaseIterable{
    case title = "title"
    case description = "description"
    case timeframe = "timeframe"
    case startDate = "startDate"
    case endDate = "endDate"
    
    case aspect = "aspect"
    case priority = "priority"
    case progress = "progress"
    
    case coreValue = "coreValue"
    
    // SESSIONS
    case edited = "edited"
    case leftAsIs = "leftAsIs"
    case pushedOff = "pushedOff"
    case deleted = "deleted"
    
    // CREED
    case start = "start"
    case end = "end"
    
    func toIcon() -> IconType{
        switch self {
        case .startDate:
            return .dates
        case .endDate:
            return .dates
        case .aspect:
            return .aspect
        case .priority:
            return .priority
        case .progress:
            return .progress
        case .timeframe:
            return .timeframe
        case .edited:
            return .edit
        case .leftAsIs:
            return .confirm
        case .pushedOff:
            return .timeForward
        case .deleted:
            return .cancel
        case .title:
            return .title
        case .description:
            return .description
        case .coreValue:
            return .value
        case .start:
            return .dates
        case .end:
            return .dates
        }
    }
    
    func toString() -> String{
        switch self {
        case .startDate:
            return "Start Date"
        case .endDate:
            return "End Date"
        case .aspect:
            return "Aspect"
        case .priority:
            return "Priority"
        case .progress:
            return "Progress"
        case .timeframe:
            return "Timeframe"
        case .edited:
            return "Edited"
        case .leftAsIs:
            return "Left as is"
        case .pushedOff:
            return "Pushed off"
        case .deleted:
            return "Deleted"
        case .title:
            return "Title"
        case .description:
            return "Description"
        case .coreValue:
            return "Value"
        case .start:
            return "Start"
        case .end:
            return "End"
        }
    }
}
