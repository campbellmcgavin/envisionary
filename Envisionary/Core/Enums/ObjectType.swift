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
    case aspect = 3
    case goal = 4
    case journal = 9
    case entry = 10
    case valueRating = 13
    case progressPoint = 14
    case na = 15
    
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
        case .journal:
            return true
        case .entry:
            return false
        case .valueRating:
            return false
        case .progressPoint:
            return false
        case .na:
            return false
        }
    }
    
    func hasSearch() -> Bool{
        switch self {
            
        case .goal:
            return true
        case .entry:
            return true
        case .journal:
            return true
        default:
            return false
        }
    }
    
    func hasFilter() -> Bool{
        return true
    }
    
    func hasCalendar() -> Bool{
        
        switch self{
        case .goal: return true
        case .entry: return true
        default: return false
        }
    }
    
    func hasFilters() -> Bool{
        switch self{
        case .goal: return true
        case .value: return true
        case .journal: return true
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
        case .journal:
            return "Journals"
        case .entry:
            return "Entries"
        case .creed:
            return "Creed"
        case .valueRating:
            return "Core Value Rating"
        case .progressPoint:
            return ""
        default:
            return ""
        }
    }
    
    func shouldGroup() -> Bool{
        switch self {
        case .value:
            return false
        case .creed:
            return false
        case .aspect:
            return false
        case .goal:
            return true
        case .journal:
            return true
        case .entry:
            return true
        case .valueRating:
            return false
        case .progressPoint:
            return false
        case .na:
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
        case .journal:
            return "Journal"
        case .entry:
            return "Entry"
        case .valueRating:
            return "Value Rating"
        case .progressPoint:
            return ""
        case .na:
            return ""
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
        case .journal:
            return .chapter
        case .entry:
            return .entry
        default:
            return .alert
        }
    }
    
    func toFilterDescription(date: Date, timeframe: TimeframeType) -> String {
        
        switch self {
        case .value:
            return "all " + self.toPluralString()
        case .creed:
            return "your entire life's " + self.toPluralString()
        case .aspect:
            return "all " + self.toPluralString()
        case .goal:
            return "only " + timeframe.toString() + " " + self.toPluralString() + " in " + date.toString(timeframeType: timeframe)
        case .journal:
            return "all " + self.toPluralString()
        case .entry:
            return "all " + self.toPluralString() + " in " + date.toString(timeframeType: timeframe)
        default:
            return ""
        }
    }
    
    func toDescription() -> String{
        switch self {
        case .value:
            return "are the most core parts of an individual."
        case .creed:
            return "combines values into a moral compass."
        case .aspect:
            return "are different boxes you organize life with."
        case .goal:
            return "are the base unit to accomplish everything."
        case .journal:
            return "are collections of journal entries."
        case .entry:
            return "are pages within a journal chapter."
        default:
            return ""
        }
    }
    
    func toLongDescription() -> String{
        switch self {
        case .value:
            return "Values, or core values, are the most core part of an individual. Take away you social network, career, and accomplishments and you're left with that which you hold most important."
        case .creed:
            return "Your creed combines the descriptions of all values into a descriptive moral compass."
        case .aspect:
            return "Aspects help compartmentalize your life. By having different boxes for different parts of you, it makes it easier to keep things clean and organized."
        case .goal:
            return "Goals are the base unit for accomplishing everything. A goal has a clear explanation of what needs to happen to complete the goal, as well as a start date and end date."
        case .journal:
            return "Chapters are collections of journal entries. A chapter typically encloses an a certain period or topic of your life."
        case .entry:
            return "Entries, or Journal Entries, are a page within a chapter."
        default:
            return ""
        }
    }
    
    func hasProperty(property:PropertyType) -> Bool{
        switch self {
        case .progressPoint:
            switch property{
            case .date:
                return true
            case .amount:
                return true
            case .parentId:
                return true
            default:
                return false
            }
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
            case .superId:
                return true
            case .isRecurring:
                return false
            case .amount:
                return false
            case .unit:
                return false
            case .timeframe:
                return false
            case .scheduleType:
                return false
            default:
                return false
            }
        case .journal:
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
        default:
            return false
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
        case .journal:
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
        case .valueRating:
            return false
        default:return false
        }
    }
    
    func hasFilter(filter: FilterType) -> Bool{
        switch self {
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
            case .progress:
                return true
            case .view:
                return true
            case .creed:
                return false
            case .entry:
                return false
            case .date:
                return true
            }
        case .journal:
            switch filter {
            case .archived:
                return true
            case .subGoals:
                return false
            case .aspect:
                return true
            case .priority:
                return false
            case .progress:
                return false
            case .view:
                return false
            case .creed:
                return false
            case .entry:
                return true
            case .date:
                return true
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
            case .progress:
                return false
            case .view:
                return true
            case .creed:
                return false
            case .entry:
                return false
            case .date:
                return true
            }
        case .value:
            switch filter{
            case .creed:
                return true
            default:
                return false
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
        case .journal:
            return detailStack == .children || detailStack == .images
        case .entry:
            return detailStack == .images
        default:
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
