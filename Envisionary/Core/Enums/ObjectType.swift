//
//  ObjectType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/8/23.
//

import SwiftUI

enum ObjectType: Int, Identifiable, CaseIterable, Codable{
    
    var id: Self {
        return self
    }
    
    case value = 0
    case creed = 1
    case dream = 2
    case aspect = 3
    case goal = 4
    case habit = 5
    case session = 6
//    case task = 7
    case home = 7
    case favorite = 8
    case chapter = 9
    case entry = 10
    case prompt = 11
    case recurrence = 12
    case valueRating = 13
    
    func ShouldShowImage() -> Bool{
        switch self {
        case .value:
            return true
        case .creed:
            return false
        case .aspect:
            return true
        case .goal:
            return true
        case .session:
            return false
//        case .task:
//            return false
        case .habit:
            return true
        case .home:
            return false
        case .chapter:
            return true
        case .entry:
            return false
//        case .stats:
//            return false
        case .dream:
            return true
        case .prompt:
            return false
        case .recurrence:
            return false
        case .valueRating:
            return false
        case .favorite:
            return false
        }
    }
    
    func hasSearch() -> Bool{
        switch self {
            
        case .goal:
            return true
        case .habit:
            return true
        case .entry:
            return true
        case .chapter:
            return true
        case .dream:
            return true
        default:
            return false
        }
    }
    
    func hasFilter() -> Bool{
        return self != .home && self != .favorite
    }
    
    func hasCalendar() -> Bool{
        
        switch self{
        case .goal: return true
        case .habit: return true
        case .session: return true
        case .entry: return true
        default: return false
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
        case .habit:
            return "Habits"
        case .chapter:
            return "Chapters"
        case .entry:
            return "Entries"
        case .session:
            return "Sessions"
        case .creed:
            return "Creed"
        case .home:
            return "Today"
        case .dream:
            return "Dreams"
        case .prompt:
            return "Prompts"
        case .recurrence:
            return "Recurrences"
        case .valueRating:
            return "Core Value Rating"
        case .favorite:
            return "Faves"
        }
    }
    
    func shouldGroup() -> Bool{
        switch self {
        case .value:
            return false
        case .creed:
            return false
        case .dream:
            return true
        case .aspect:
            return false
        case .goal:
            return true
        case .habit:
            return true
        case .session:
            return false
        case .home:
            return true
        case .chapter:
            return true
        case .entry:
            return true
        case .prompt:
            return false
        case .recurrence:
            return false
        case .valueRating:
            return false
        case .favorite:
            return false
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
        case .habit:
            return "Habit"
        case .home:
            return "Today"
        case .chapter:
            return "Chapter"
        case .entry:
            return "Entry"
        case .dream:
            return "Dream"
        case .prompt:
            return "Prompt"
        case .recurrence:
            return "Recurrence"
        case .valueRating:
            return "Value Rating"
        case .favorite:
            return "Fave"
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
//        case .task:
//            return .task
        case .habit:
            return .habit
        case .home:
            return .task
        case .chapter:
            return .chapter
        case .entry:
            return .entry
        case .dream:
            return .dream
        case .prompt:
            return .favorite
        case .recurrence:
            return .habit
        case .valueRating:
            return .amount
        case .favorite:
            return .favorite
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
//        case .task:
//            return "all " + self.toPluralString() + " in " + date.toString(timeframeType: timeframe)
        case .habit:
            return "all " + self.toPluralString() + " in " + date.toString(timeframeType: timeframe)
        case .home:
            return "your most important items"
        case .chapter:
            return "all " + self.toPluralString()
        case .entry:
            return "all " + self.toPluralString() + " in " + date.toString(timeframeType: timeframe)
//        case .stats:
//            return "all " + self.toPluralString() + " in " + date.toString(timeframeType: timeframe)
        case .prompt:
            return ""
        case .recurrence:
            return ""
        case .valueRating:
            return ""
        case .favorite:
            return "all " + self.toPluralString()
        }
    }
    
    func toDescription() -> String{
        switch self {
        case .value:
            return "are the most core parts of an individual."
        case .creed:
            return "combines values into a moral compass."
        case .dream:
            return "are ideas without limitations."
        case .aspect:
            return "are different boxes you organize life with."
        case .goal:
            return "are the base unit to accomplish everything."
        case .session:
            return "are the mechanism for changing the plan."
//        case .task:
//            return "are the smallest, most bite-sized action."
        case .habit:
            return "are actions that repeat themselves."
        case .home:
            return "is what you need to get done today."
        case .chapter:
            return "are collections of journal entries."
        case .entry:
            return "are pages within a journal chapter."
//        case .stats:
//            return "are performance insights."
        case .prompt:
            return ""
        case .recurrence:
            return ""
        case .valueRating:
            return ""
        case .favorite:
            return "are anything you mark with a star."
        }
    }
    
    func toContentType() -> ContentViewType{
        switch self {
        case .value:
            return .envision
        case .creed:
            return .envision
        case .dream:
            return .envision
        case .aspect:
            return .envision
        case .goal:
            return .plan
        case .session:
            return .plan
//        case .task:
//            return .plan
        case .habit:
            return .plan
        case .home:
            return .execute
        case .chapter:
            return .journal
        case .entry:
            return .journal
//        case .stats:
//            return .evaluate
        case .prompt:
            return .execute
        case .recurrence:
            return .execute
        case .valueRating:
            return .execute
        case .favorite:
            return .execute
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
//        case .task:
//            return "Tasks are at the bottom of the execution pyramid and are the smallest, most bite-sized action."
        case .habit:
            return "Habits are tasks that repeat themselves over a specific schedule, with a start date and an end date."
        case .home:
            return ""
        case .chapter:
            return "Chapters are collections of journal entries. A chapter typically encloses an a certain period or topic of your life."
        case .entry:
            return "Entries, or Journal Entries, are a page within a chapter."
//        case .stats:
//            return "Stats, or statistics, offer performance insight into various areas of your life."
        case .prompt:
            return ""
        case .recurrence:
            return ""
        case .valueRating:
            return ""
        case .favorite:
            return "Favorites are anything you mark with a star."
        }
    }
    
    func toTextArray() -> [String]{
        
        var array = [String]()
        
        array.append(self.toPluralString() + " " + self.toDescription())
        
        switch self {
        case .goal:
            array.append("You can break big goals down into smaller goals 🌷. Each goal is locked to a timeframe (decades, years, months, weeks and days ☀️).")
        case .session:
            array.append("Pick a date, and then sessions automatically gathers everything you have planned for that period. 🦄")
            array.append("You'll be able to align everything with your values, and evaluate how to proceed with each goal. ❤️")
        case .home:
            array.append("You'll see the goals and habits that are happening now, as well as your favorites and reminders.")
        case .chapter:
            array.append("Just like chapters in your book of life!")
        case .entry:
            array.append("Think... pages in a chapter... in your book of life. ☀️🐇")
        default:
            let _ = "why"
        }
                         
         return array
    }
    
    func hasProperty(property:PropertyType) -> Bool{
        switch self {
        case .value:
            switch property {
            case .description:
                return true
            case .title:
                return true
            case .image:
                return true
            default:
                return false
            }
        case .creed:
            switch property {
            case .title:
                return true
            case .description:
                return true
            case .start:
                return true
            case .end:
                return true
            default:
                return false
            }
        case .aspect:
            switch property {
            case .description:
                return true
            case .title:
                return true
            case .image:
                return true
            default:
                return false
            }
        case .goal:
            switch property {
            case .title:
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
            case .parentId:
                return true
            case .image:
                return true
            case .archived:
                return true
            default:
                return false
            }
        case .session:
            switch property {
            case .timeframe:
                return true
            case .date:
                return true
            case .dateCompleted:
                return true
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
            default:
                return false
            }
        case .habit:
            switch property {
            case .title:
                return true
            case .description:
                return true
            case .timeframe:
                return false
            case .startDate:
                return true
            case .endDate:
                return true
            case .aspect:
                return true
            case .priority:
                return true
            case .parentId:
                return true
            case .scheduleType:
                return true
            case .amount:
                return true
            case .unit:
                return true
            case .archived:
                return true
            default:
                return false
            }
        case .home:
            return false
        case .favorite:
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
            case .image:
                return true
            case .archived:
                return true
            default:
                return false
            }
        case .entry:
            switch property {
            case .startDate:
                return true
            case .title:
                return true
            case .description:
                return true
            case .chapter:
                return true
            case .images:
                return true
            case .archived:
                return true
            default:
                return false
            }
//        case .stats:
//            return false
        case .dream:
            switch property {
            case .title:
                return true
            case .description:
                return true
            case .aspect:
                return true
            case .archived:
                return true
            case .image:
                return true
            default:
                return false
            }
        case .prompt:
            if property == .promptType{
                return true
            }
            return false
        case .recurrence:
            switch property {
            case .startDate:
                return true
            case .endDate:
                return true
            case .scheduleType:
                return true
            case .unit:
                return true
            case .amount:
                return true
            case .habitId:
                return true
            case .archived:
                return true
            default:
                return false
            }
        case .valueRating:
            switch property {
            case .valueId:
                return true
            case .parentId:
                return true
            case .amount:
                return true
            default:
                return false
            }
        }
    }
    
    func hasDetailMenuButton(button: DetailMenuButtonType) -> Bool{
        switch self {
        case .value:
            switch button {
            case .delete:
                return true
            case .help:
                return true
            case .edit:
                return true
            case .add:
                return false
            case .favorite:
                return true
            case .archive:
                return false
            }
        case .creed:
            switch button {
            case .delete:
                return false
            case .help:
                return true
            case .edit:
                return false
            case .add:
                return true
            case .favorite:
                return true
            case .archive:
                return false
            }
        case .dream:
            switch button {
            case .delete:
                return true
            case .help:
                return true
            case .edit:
                return true
            case .add:
                return false
            case .favorite:
                return true
            case .archive:
                return true
            }
        case .aspect:
            switch button {
            case .delete:
                return true
            case .help:
                return true
            case .edit:
                return true
            case .add:
                return false
            case .favorite:
                return false
            case .archive:
                return false
            }
        case .goal:
            switch button {
            case .delete:
                return true
            case .help:
                return true
            case .edit:
                return true
            case .add:
                return true
            case .favorite:
                return true
            case .archive:
                return true
            }
        case .session:
            switch button {
            case .delete:
                return true
            case .help:
                return true
            case .edit:
                return false
            case .add:
                return false
            case .favorite:
                return false
            case .archive:
                return false
            }
        case .habit:
            switch button {
            case .delete:
                return true
            case .help:
                return true
            case .edit:
                return true
            case .add:
                return false
            case .favorite:
                return true
            case .archive:
                return true
            }
        case .home:
            return false
        case .favorite:
            return false
        case .chapter:
            switch button {
            case .delete:
                return true
            case .help:
                return true
            case .edit:
                return true
            case .add:
                return true
            case .favorite:
                return true
            case .archive:
                return true
            }
        case .entry:
            switch button {
            case .delete:
                return true
            case .help:
                return true
            case .edit:
                return true
            case .add:
                return false
            case .favorite:
                return false
            case .archive:
                return true
            }
        case .prompt:
            return false
        case .recurrence:
            return false
        case .valueRating:
            return false
        }
    }
    
    func hasFilter(filter: FilterType) -> Bool{
        switch self {
        case .dream:
            switch filter {
            case .archived:
                return true
            case .subGoals:
                return false
            case .aspect:
                return true
            case .priority:
                return false
            case .completed:
                return false
            case .date:
                return false
            }
        case .goal:
            switch filter {
            case .archived:
                return true
            case .subGoals:
                return true
            case .aspect:
                return true
            case .priority:
                return true
            case .completed:
                return true
            case .date:
                return true
            }
        case .habit:
            switch filter {
            case .archived:
                return true
            case .subGoals:
                return false
            case .aspect:
                return true
            case .priority:
                return true
            case .completed:
                return false
            case .date:
                return true
            }
        case .chapter:
            switch filter {
            case .archived:
                return true
            case .subGoals:
                return false
            case .aspect:
                return true
            case .priority:
                return false
            case .completed:
                return false
            case .date:
                return false
            }
        case .entry:
            switch filter {
            case .archived:
                return true
            case .subGoals:
                return false
            case .aspect:
                return true
            case .priority:
                return false
            case .completed:
                return false
            case .date:
                return true
            }
        default:
            return false
        }
    }
    
    func GetPromptTitle() -> String{
        switch self {
        case .value:
            return PromptHelper.valuePrompts.randomElement()!
        case .creed:
            return PromptHelper.valuePrompts.randomElement()!
        case .dream:
            return PromptHelper.dreamPrompts.randomElement()!
        case .session:
            return PromptHelper.sessionPrompts.randomElement()!
        case .entry:
            return PromptHelper.entryPrompts.randomElement()!
        default:
            return ""
        }
    }
    
    func hasDetailStack(detailStack: DetailStackType) -> Bool{
        
        if detailStack == .properties || detailStack == .archived || detailStack == .parentHeader {
            return true
        }
        switch self {
        case .value:
            return detailStack == .valueGoalAlignment
        case .creed:
            return detailStack == .creed
        case .dream:
            return detailStack == .convertToGoal
        case .aspect:
            return false
        case .goal:
            switch detailStack {
            case .superCard:
                return true
            case .finishUp:
                return true
            case .toolbox:
                return true
            case .goalValueAlignment:
                return true
            default:
                return false
            }
        case .habit:
            return detailStack == .habitProgress
        case .session:
            return detailStack == .affectedGoals
        case .home:
            return false
        case .favorite:
            return false
        case .chapter:
            return detailStack == .children || detailStack == .images
        case .entry:
            return detailStack == .images
        case .prompt:
            return false
        case .recurrence:
            return false
        case .valueRating:
            return false
        }
    }
    
    func StartsWithVowel() -> Bool{
        if self == .aspect || self == .entry {
            return true
        }
        else {
            return false
        }
    }
    
    static func fromString(from string: String) -> Self{
        return Self.allCases.first(where: {$0.toString() == string}) ?? .goal
    }
    
    
    
}
