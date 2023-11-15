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
    
    case tutorial_step
    
    case help_prompts_object
    case help_prompts_content
    case help_prompts_showing
    
    case archetype_type
    
    case unlock_value
    case unlock_creed
    case unlock_dream
    case unlock_aspect
    case unlock_goal
    case unlock_habit
    case unlock_session
    case unlock_home
    case unlock_chapter
    case unlock_entry
    case unlock_favorite
    
    case notification_digest
    case notification_entry
    case notification_value_align
    
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
        case .finishedFirstLaunch:
            return "finishedFirstLaunch"
        case .tutorial_step:
            return "tutorial_step"
        case .help_prompts_object:
            return "help_prompts_object"
        case .help_prompts_content:
            return "help_prompts_content"
        case .help_prompts_showing:
            return "help_prompts_showing"
        case .archetype_type:
            return "archetype_type"
        case .unlock_value:
            return "unlock_value"
        case .unlock_creed:
            return "unlock_creed"
        case .unlock_dream:
            return "unlock_dream"
        case .unlock_aspect:
            return "unlock_aspect"
        case .unlock_goal:
            return "unlock_goal"
        case .unlock_habit:
            return "unlock_habit"
        case .unlock_session:
            return "unlock_session"
        case .unlock_home:
            return "unlock_home"
        case .unlock_chapter:
            return "unlock_chapter"
        case .unlock_entry:
            return "unlock_entry"
        case .notification_entry:
            return "notification_entry"
        case .notification_value_align:
            return "notification_value_align"
        case .notification_digest:
            return "notification_digest"
        case .unlock_favorite:
            return "unlock_favorite"
        }
    }
}
