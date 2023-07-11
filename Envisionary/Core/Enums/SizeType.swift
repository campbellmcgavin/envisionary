//
//  SizeType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/8/23.
//

import Foundation

enum SizeType {
    case tiny
    case extraSmall
    case small
    case medium
    case mediumLarge
    case largeMedium
    case large
    case largeish
    case larger
    case extralarge
    case giant
    
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
        case .tiny:
            return 14
        case .extraSmall:
            return 20
        case .small:
            return 29
        case .medium:
            return 39
        case .mediumLarge:
            return 50
        case .largeMedium:
            return 60
        case .large:
            return 70
        case .largeish:
            return 88
        case .larger:
            return 100
        case .extralarge:
            return 150
        case .giant:
            return 180
            
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
            return 67
            
        }
    }
}
