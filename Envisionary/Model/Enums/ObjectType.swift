//
//  ObjectType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/8/23.
//

import SwiftUI

enum ObjectType: Int, Identifiable, CaseIterable{
    
    var id: Self {
        return self
    }
    
    case value = 0
    case creed = 1
    case dream = 2
    case aspect = 3
    case goal = 4
    case session = 5
    case task = 6
    case habit = 7
    case home = 8
    case chapter = 9
    case entry = 10
    case emotion = 11
    case stats = 12
    
    func ShouldShowImage() -> Bool{
        switch self {
        case .value:
            return false
        case .creed:
            return false
        case .aspect:
            return false
        case .goal:
            return true
        case .session:
            return false
        case .task:
            return false
        case .habit:
            return false
        case .home:
            return false
        case .chapter:
            return false
        case .entry:
            return false
        case .stats:
            return false
        case .emotion:
            return false
        case .dream:
            return false
        }
    }

    func toPluralString() -> String{
        switch self {
        case .value:
            return "Values"
        case .aspect:
            return "Aspects"
        case .goal:
            return "Goals"
        case .task:
            return "Tasks"
        case .habit:
            return "Habits"
        case .chapter:
            return "Chapters"
        case .entry:
            return "Entries"
        case .session:
            return "Sessions"
        case .stats:
            return "Stats"
        case .creed:
            return "Creed"
        case .home:
            return "Home"
        case .emotion:
            return "Emotions"
        case .dream:
            return "Dreams"
        }
    }
    
    func toString() -> String{
        switch self {
        case .aspect:
            return "Aspect"
        case .value:
            return "Value"
        case .creed:
            return "Creed"
        case .goal:
            return "Goal"
        case .session:
            return "Session"
        case .task:
            return "Task"
        case .habit:
            return "Habit"
        case .home:
            return "Home"
        case .chapter:
            return "Chapter"
        case .entry:
            return "Entry"
        case .stats:
            return "Stat"
        case .emotion:
            return "Emotion"
        case .dream:
            return "Dream"
        }
    }
    
    func toIcon() -> IconType{
        switch self {
        case .value:
            return .value
        case .creed:
            return .creed
        case .aspect:
            return .aspect
        case .goal:
            return .goal
        case .session:
            return .session
        case .task:
            return .task
        case .habit:
            return .habit
        case .home:
            return .task
        case .chapter:
            return .chapter
        case .entry:
            return .entry
        case .stats:
            return .stat
        case .emotion:
            return .emotion
        case .dream:
            return .dream
            
        }
    }
    
    func toFilterDescription(date: Date, timeframe: TimeframeType) -> String {
                
        switch self {
        case .value:
            return "all " + self.toPluralString()
        case .creed:
            return "your entire life's " + self.toPluralString()
        case .dream:
            return "all " + self.toPluralString()
        case .aspect:
            return "all " + self.toPluralString()
        case .goal:
            return "only " + timeframe.toString() + " " + self.toPluralString() + " in " + date.toString(timeframeType: timeframe)
        case .session:
            return "only " + timeframe.toString() + " " + self.toPluralString()
        case .task:
            return "all " + self.toPluralString() + " in " + date.toString(timeframeType: timeframe)
        case .habit:
            return "all " + self.toPluralString() + " in " + date.toString(timeframeType: timeframe)
        case .home:
            return "your most important items"
        case .chapter:
            return "all " + self.toPluralString()
        case .entry:
            return "all " + self.toPluralString() + " in " + date.toString(timeframeType: timeframe)
        case .emotion:
            return "all " + self.toPluralString() + " in " + date.toString(timeframeType: timeframe)
        case .stats:
            return "all " + self.toPluralString() + " in " + date.toString(timeframeType: timeframe)
        }
    }
    
    func toDescription() -> String{
        switch self {
        case .value:
            return "are the most core part of an individual."
        case .creed:
            return "combines values into a moral compass."
        case .dream:
            return "are ideas without limitations."
        case .aspect:
            return "are the different parts of your life."
        case .goal:
            return "are the base unit to accomplish everything."
        case .session:
            return "are the mechanism for changing the plan."
        case .task:
            return "are the smallest, most bite-sized action."
        case .habit:
            return "are tasks that repeat themselves."
        case .home:
            return " is what you need to get done today."
        case .chapter:
            return "are collections of journal entries."
        case .entry:
            return "are pages within a journal chapter."
        case .emotion:
            return "are a snapshot of an emotional state."
        case .stats:
            return "are performance insights."
        }
    }
    
    
    func toLongDescription() -> String{
        switch self {
        case .value:
            return "Values, or core values, are the most core part of an individual. Take away you social network, career, and accomplishments and you're left with that which you hold most important."
        case .creed:
            return "Your creed combines the descriptions of all values into a descriptive moral compass."
        case .dream:
            return "Your dreams are without bounds and without limitations. No rules, no walls, just imagination."
        case .aspect:
            return "Aspects help compartmentalize your life. By having different boxes for different parts of you, it makes it easier to keep things clean and organized."
        case .goal:
            return "Goals are the base unit for accomplishing everything. A goal has a clear explanation of what needs to happen to complete the goal, as well as a start date and end date."
        case .session:
            return "Sessions, or Planning Sessions, are the mechanism for constantly evaluating and re-evaluating your plans. Sessions allow you to choose a timeframe and date, view the currently planned goals, and then walk through and make revisions and additions to the affected goals."
        case .task:
            return "Tasks are at the bottom of the execution pyramid and are the smallest, most bite-sized action."
        case .habit:
            return "Habits are tasks that repeat themselves over a specific schedule, with a start date and an end date."
        case .home:
            return ""
        case .chapter:
            return "Chapters are collections of journal entries. A chapter typically encloses an a certain period or topic of your life."
        case .entry:
            return "Entries, or Journal Entries, are a page within a chapter."
        case .emotion:
            return "Emotions are evaluations of your emotional state at a moment in time."
        case .stats:
            return "Stats, or statistics, offer performance insight into various areas of your life."
        }
    }
    
    func hasProperty(property:PropertyType) -> Bool{
        switch self {
        case .value:
            switch property {
            case .title:
                return true
            case .description:
                return true
            default:
                return false
            }
        case .creed:
            return false
        case .aspect:
            switch property {
            case .title:
                return true
            case .description:
                return true
            default:
                return false
            }
        case .goal:
            switch property {
            case .title:
                return true
            case .timeframe:
                return true
            case .startDate:
                return true
            case .endDate:
                return true
            case .aspect:
                return true
            case .priority:
                return true
            case .progress:
                return true
            case .description:
                return true
            default:
                return false
            }
        case .session:
            switch property {
            case .timeframe:
                return true
            case .startDate:
                return true
            case .endDate:
                return true
            case .aspect:
                return false
            case .priority:
                return false
            case .progress:
                return false
            case .edited:
                return true
            case .leftAsIs:
                return true
            case .pushedOff:
                return true
            case .deleted:
                return true
            case .title:
                return true
            case .description:
                return true
            }
        case .task:
            switch property {
            case .timeframe:
                return false
            case .startDate:
                return true
            case .endDate:
                return false
            case .aspect:
                return true
            case .priority:
                return false
            case .progress:
                return true
            case .edited:
                return false
            case .leftAsIs:
                return false
            case .pushedOff:
                return false
            case .deleted:
                return false
            case .title:
                return true
            case .description:
                return false
            }
        case .habit:
            return false
        case .home:
            return false
        case .chapter:
            switch property {
            case .timeframe:
                return false
            case .startDate:
                return false
            case .endDate:
                return false
            case .aspect:
                return true
            case .priority:
                return false
            case .progress:
                return false
            case .edited:
                return false
            case .leftAsIs:
                return false
            case .pushedOff:
                return false
            case .deleted:
                return false
            case .title:
                return true
            case .description:
                return true
            }
        case .entry:
            switch property {
            case .timeframe:
                return false
            case .startDate:
                return true
            case .endDate:
                return true
            case .aspect:
                return false
            case .priority:
                return false
            case .progress:
                return false
            case .edited:
                return false
            case .leftAsIs:
                return false
            case .pushedOff:
                return false
            case .deleted:
                return false
            case .title:
                return true
            case .description:
                return true
            }
        case .stats:
            return false
        case .emotion:
            return true
        case .dream:
            return true
        }
    }
}
