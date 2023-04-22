//
//  ActionType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/8/23.
//

import SwiftUI

enum IconType {
    case add
    case delete
    case edit
    
    case undo
    case redo
    
    //time
    case timeBack
    case timeForward
    
    //direction
    case right
    case left
    case up
    case down
    
    //navigation
    case arrow_right
    case arrow_left
    case arrow_down
    case arrow_up
    
    //operations
    case photo
    case minimize
    case maximize
    case confirm
    case cancel
    case help
    case info
    case info_nocircle
    case alert
    case confirm_small
    
    //gadgets
    case filter
    case group
    case search
    
    //objects
    case value
    case creed
    case aspect
    case goal
    case session
    case task
    case habit
    case chapter
    case entry
    case stat
    case dream
    case emotion
    
    //properties
    case timeframe
    case dates
    case priority
    case progress
    case title
    case description
    
    case hambugerMenu
    case lock
    
    func ToIconString() -> String{
        switch self {
        case .add:
            return "Icon_Add"
        case .delete:
            return "Icon_Trash_Delete"
        case .edit:
            return "Icon_Edit"
        case .photo:
            return "Icon_Camera"
        case .minimize:
            return "Icon_Minimize"
        case .maximize:
            return "Icon_Maximize"
        case .confirm:
            return "Icon_Check"
        case .cancel:
            return "Icon_Close"
        case .help:
            return "Icon_QuestionMark"
        case .arrow_left:
            return "Icon_Arrow_Left"
        case .arrow_right:
            return "Icon_Arrow_Right"
        case .arrow_up:
            return "Icon_Arrow_Up"
        case .arrow_down:
            return "Icon_Arrow_Down"
        case .undo:
            return "Icon_Undo"
        case .redo:
            return "Icon_Redo"
        case .timeBack:
            return "Icon_Clock_Backward"
        case .timeForward:
            return "Icon_Clock_Forward"
        case .right:
            return "Icon_Chevron_Right"
        case .left:
            return "Icon_Chevron_Left"
        case .up:
            return "Icon_Chevron_Up"
        case .down:
            return "Icon_Chevron_Down"
        case .filter:
            return "Icon_Filter"
        case .group:
            return "Icon_Group"
        case .search:
            return "Icon_Zoom"
        case .hambugerMenu:
            return "Icon_Menu"
        case .value:
            return "Icon_Value"
        case .creed:
            return "Icon_Sheet"
        case .aspect:
            return "Icon_Aspect"
        case .goal:
            return "Icon_Target"
        case .session:
            return "Icon_List"
        case .task:
            return "Icon_Execute"
        case .habit:
            return "Icon_Redo"
        case .chapter:
            return "Icon_Journal"
        case .entry:
            return "Icon_Write"
        case .stat:
            return "Icon_Evaluate"
        case .dates:
            return "Icon_Time_Start_Stop"
        case .priority:
            return "Icon_Priority"
        case .progress:
            return "Icon_Percent_Complete"
        case .timeframe:
            return "Icon_Calendar"
        case .title:
            return "Icon_Title"
        case .description:
            return "Icon_Description"
        case .dream:
            return "Icon_Dream"
        case .emotion:
            return "Icon_Emotion"
        case .info:
            return "Icon_Info"
        case .info_nocircle:
            return "Icon_Info_NoCircle"
        case .alert:
            return "Icon_Alert"
        case .confirm_small:
            return "Icon_Check_Small"
        case .lock:
            return "Icon_Lock"
        }
    }
}