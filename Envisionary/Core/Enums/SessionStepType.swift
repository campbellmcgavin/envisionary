//
//  SessionStepType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/5/23.
//

import SwiftUI

enum SessionStepType: CaseIterable {
    case overview
    case selectTimeframe
    case addContent
    case alignValues
    case reviewUpcoming
    case saveCheckpoint
    case lookingForward
    case addJournal
    case conclude
    
    func toString() -> String{
        switch self {
        case .overview:
            return "Overview"
        case .selectTimeframe:
            return "Select Timeframe"
        case .addContent:
            return "Add Content"
        case .alignValues:
            return "Value Alignment"
        case .reviewUpcoming:
            return "Review Upcoming"
        case .addJournal:
            return "Add Journal"
        case .saveCheckpoint:
            return "Save Checkpoint"
        case .lookingForward:
            return "Looking Forward"
        case .conclude:
            return "Wrap-up"
        }
    }
    
    func toStepNumber() -> Int{
        switch self {
        case .overview:
            return 0
        case .selectTimeframe:
            return 1
        case .addContent:
            return 2
        case .alignValues:
            return 3
        case .reviewUpcoming:
            return 4
        case .saveCheckpoint:
            return 5
        case .lookingForward:
            return 6
        case .addJournal:
            return 7
        case .conclude:
            return 8
        }
    }
    
    func toIcon() -> IconType
    {
        switch self {
        case .overview:
            return .help
        case .selectTimeframe:
            return .timeframe
        case .addContent:
            return .add
        case .alignValues:
            return .value
        case .reviewUpcoming:
            return .arrow_right
        case .saveCheckpoint:
            return .confirm
        case .lookingForward:
            return .timeForward
        case .addJournal:
            return .entry
        case .conclude:
            return .journal
        }
    }
    
    func toDescription(timeframe: TimeframeType? = nil) -> String{
        
        switch self {
        case .overview:
            return "Understand the steps in a session."
        case .selectTimeframe:
            return "Select a timeframe and date for the focus of your planning session."
        case .alignValues:
            return "Align your goals with your core values."
        case .reviewUpcoming:
            return "Determine how to proceed with each goal."
        case .addJournal:
            return "Optionally add an entry to record your thoughts."
        case .lookingForward:
            if timeframe == nil {
                return "Optionally add any sub-goals to each major goal."
            }
            else{
                return "Optionally add any additional " + timeframe!.toChildTimeframe().toString() + " goals to each " + timeframe!.toString() + " goal."
            }
            
        case .conclude:
            return "Summarize the changes you've made."
        case .saveCheckpoint:
            return "Save your changes. You cannot reverse this action."
        case .addContent:
            return "Add content to the focus timeframe."
        }
    }
}
