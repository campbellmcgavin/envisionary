//
//  ViewMenuButtons.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/30/23.
//

import SwiftUI

enum ViewMenuButtonType: CaseIterable {
    
    case delete
    case expand_all
    case expand
    case backward
    case forward
    case timeBack
    case timeForward
    case timeSubtract
    case timeAdd
    case photo
    case edit
    case add
    case goTo
    
    func toString() -> String{
        switch self {
        case .delete:
            return "Delete"
        case .expand_all:
            return "All"
        case .expand:
            return "Expand"
        case .forward:
            return "Right"
        case .backward:
            return "Left"
        case .timeBack:
            return "Back"
        case .timeForward:
            return "Forward"
        case .timeAdd:
            return "Extend"
        case .timeSubtract:
            return "Reduce"
        case .photo:
            return "Photo"
        case .edit:
            return "Edit"
        case .add:
            return "Add"
        case .goTo:
            return "Details"
        }
    }
}
