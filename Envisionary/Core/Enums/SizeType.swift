//
//  SizeType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/8/23.
//

import Foundation

enum SizeType {
    case extraSmall
    case small
    case medium
    case large
    case extralarge
    
    case minimumTouchTarget
    case cornerRadiusLarge
    case cornerRadiusForm
    case cornerRadiusSmall
    case cornerRadiusExtraSmall
    case headerCircle
    
    case expandedMenuObjects
    case expandedMenuScrollCalendar
    case expandedMenuLargeCalendar
    
    case ganttColumnWidth
    case scrollPickerWidth
    
    func ToSize() -> CGFloat{
        switch self {
        case .extraSmall:
            return 20
        case .small:
            return 29
        case .medium:
            return 39
        case .large:
            return 70
        case .extralarge:
            return 150
            
        case .minimumTouchTarget:
            return 44
        case .cornerRadiusLarge:
            return 36
        case .cornerRadiusForm:
            return 30
        case .cornerRadiusSmall:
            return 22
        case .cornerRadiusExtraSmall:
            return 12
        case .expandedMenuObjects:
            return 151
        case .expandedMenuScrollCalendar:
            return 170
        case .expandedMenuLargeCalendar:
            return 280
        case .headerCircle:
            return 200
        case .ganttColumnWidth:
            return 100
        case .scrollPickerWidth:
            return 65
        }
    }
}
