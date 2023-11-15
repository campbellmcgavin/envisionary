//
//  ActionType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/8/23.
//

import SwiftUI

enum IconType: CaseIterable {
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
    case up2
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
    
    case envision
    case plan
    case execute
    case journal
    case evaluate
    
    case envisionFilled
    case planFilled
    case executeFilled
    case journalFilled
    case evaluateFilled
    
    case favorite
    
    case time
    case ruler
    case amount
    case constructionCone
    case run
    case upDown
    
    case settings
    
    case zoomIn
    case zoomOut
    
    case chat
    case archived
    case archived_filled
    
    case maximize_all
    case minimize_all
    
    case time_add
    case time_subtract
    case notification
    case options
    
    
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
        case .up2:
            return "Icon_Chevron_Up_2"
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
        case .envision:
            return "Icon_Envision"
        case .plan:
            return "Icon_Plan"
        case .execute:
            return "Icon_Execute"
        case .journal:
            return "Icon_Journal"
        case .evaluate:
            return "Icon_Evaluate"
        case .envisionFilled:
            return "Icon_Envision_filled"
        case .planFilled:
            return "Icon_Plan_filled"
        case .executeFilled:
            return "Icon_Execute_filled"
        case .journalFilled:
            return "Icon_Journal_filled"
        case .evaluateFilled:
            return "Icon_Evaluate_filled"
        case .favorite:
            return "Icon_Star"
        case .time:
            return "Icon_Time_Start_Stop"
        case .ruler:
            return "Icon_Ruler"
        case .amount:
            return "Icon_Number"
        case .constructionCone:
            return "Icon_Construction_Cone"
        case .run:
            return "Icon_Run"
        case .upDown:
            return "Icon_UpDown"
        case .settings:
            return "Icon_Gear"
        case .zoomIn:
            return "Icon_Zoom_In"
        case .zoomOut:
            return "Icon_Zoom_Out"
        case .chat:
            return "Icon_Chat"
        case .archived:
            return "Icon_Archived"
        case .archived_filled:
            return "Icon_Archived_Filled"
        case .maximize_all:
            return "Icon_Maximize_All"
        case .minimize_all:
            return "Icon_Minimize_All"
        case .time_add:
            return "Icon_Time_Add"
        case .time_subtract:
            return "Icon_Time_Subtract"
        case .notification:
            return "Icon_Notification"
        case .options:
            return "Icon_Options"
        }
    }
}
