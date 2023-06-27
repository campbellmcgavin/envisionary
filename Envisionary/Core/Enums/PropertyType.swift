//
//  PropertyType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/11/23.
//

enum PropertyType: String, CaseIterable, Identifiable{
    
    var id: Self{
        return self
    }
    
    case title = "title"
    case description = "description"
    case timeframe = "timeframe"
    case date = "date"
    case dateCompleted = "dateCompleted"
    case startDate = "startDate"
    case endDate = "endDate"
    
    case aspect = "aspect"
    case priority = "priority"
    case progress = "progress"
    case parentId = "parentId"
    
    // SESSIONS
    case leftAsIs = "leftAsIs"
    case edited = "edited"
    case pushedOff = "pushedOff"
    case deleted = "deleted"
    
    // CREED
    case start = "start"
    case end = "end"
    
    // ENTRY
    case chapter = "chapter"
    case image = "image"
    case images = "images"
    
    // PROMPTS
    case promptType = "type"
    
    // HABITS
    case scheduleType = "scheduleType"
    case unit = "unit"
    case amount = "amount"
    case isComplete = "isComplete"
    case habitId = "habitId"
    
    // EMOTIONS
    case emotionalState = "emotionalState"
    case emotions = "emotions"
    case activities = "activities"
    
    func toIcon() -> IconType{
        switch self {
        case .startDate:
            return .dates
        case .endDate:
            return .dates
        case .date:
            return .dates
        case .dateCompleted:
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
        case .start:
            return .dates
        case .end:
            return .dates
        case .parentId:
            return .goal
        case .chapter:
            return .chapter
        case .images:
            return .photo
        case .image:
            return .photo
        case .promptType:
            return .favorite
        case .scheduleType:
            return .timeframe
        case .amount:
            return .amount
        case .unit:
            return .ruler
        case .isComplete:
            return .confirm
        case .habitId:
            return .habit
        case .emotions:
            return .emotion
        case .activities:
            return .run
        case .emotionalState:
            return .upDown
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
        case .start:
            return "Start"
        case .end:
            return "End"
        case .parentId:
            return "Parent"
        case .chapter:
            return "Chapter"
        case .images:
            return "Images"
        case .image:
            return "Image"
        case .date:
            return "Session Date"
        case .dateCompleted:
            return "Date Completed"
        case .promptType:
            return "Prompt Type"
        case .scheduleType:
            return "Schedule Type"
        case .amount:
            return "Amount"
        case .unit:
            return "Unit of Measurement"
        case .isComplete:
            return "Completion"
        case .habitId:
            return "Habit"
        case .emotions:
            return "Emotions"
        case .activities:
            return "Activities"
        case .emotionalState:
            return "Emotional State"
        }
    }
    
    func isSimple() -> Bool
    {
        switch self {
        case .title:
            return true
        case .description:
            return false
        case .timeframe:
            return false
        case .startDate:
            return false
        case .endDate:
            return false
        case .aspect:
            return true
        case .priority:
            return true
        case .progress:
            return false
        case .parentId:
            return false
        case .leftAsIs:
            return false
        case .edited:
            return false
        case .pushedOff:
            return false
        case .deleted:
            return false
        case .start:
            return false
        case .end:
            return false
        case .chapter:
            return true
        case .image:
            return false
        case .images:
            return false
        case .date:
            return false
        case .dateCompleted:
            return false
        case .promptType:
            return false
        case .scheduleType:
            return false
        case .amount:
            return false
        case .unit:
            return false
        case .habitId:
            return false
        default:
            return false
        }
    }
}
