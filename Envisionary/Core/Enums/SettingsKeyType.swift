//
//  SettingsKeyType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/19/23.
//

import SwiftUI

enum SettingsKeyType {
    case finishedFirstLaunch
    case group_dream
    case group_goal
    case group_session
    case group_task
    case group_habit
    case group_chapter
    case group_entry
    case group_emotion
    
    case setup_step
    
    func toString() -> String{
        switch self {
        case .group_dream:
            return "group_dream"
        case .group_goal:
            return "group_goal"
        case .group_session:
            return "group_session"
        case .group_task:
            return "group_task'"
        case .group_habit:
            return "group_habit"
        case .group_chapter:
            return "group_chapter"
        case .group_entry:
            return "group_entry"
        case .group_emotion:
            return "group_emotion"
        case .finishedFirstLaunch:
            return "finishedFirstLaunch"
        case .setup_step:
            return "setup_step"
        }
    }
}
