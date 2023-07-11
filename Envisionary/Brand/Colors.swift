//
//  Colors.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/7/23.
//

import SwiftUI

enum CustomColor{
    
    //normal colors
    case red
    case yellow
    case green
    case blue
    case purple
    case pink
    
    //light colors
    case lightRed
    case lightYellow
    case lightGreen
    case lightBlue
    case lightPurple
    case lightPink
    
    //dark colors
    case darkRed
    case darkYellow
    case darkGreen
    case darkBlue
    case darkPurple
    case darkPink
    
    //greys
    case grey0
    case grey05
    case grey1
    case grey15
    case grey2
    case grey25
    case grey3
    case grey35
    case grey4
    case grey5
    case grey6
    case grey7
    case grey8
    case grey9
    case grey10
    
    case clear
}

extension Color {
    static func specify(color:CustomColor) -> Color {
        
        switch color {
        case .red:
            return Color("Red")
        case .yellow:
            return Color("Yellow")
        case .green:
            return Color("Green")
        case .blue:
            return Color("Blue")
        case .purple:
            return Color("Purple")
        case .pink:
            return Color("Pink")
        case .lightRed:
            return Color("LightRed")
        case .lightYellow:
            return Color("LightYellow")
        case .lightGreen:
            return Color("LightGreen")
        case .lightBlue:
            return Color("LightBlue")
        case .lightPurple:
            return Color("LightPurple")
        case .lightPink:
            return Color("LightPink")
        case .darkRed:
            return Color("DarkRed")
        case .darkYellow:
            return Color("DarkYellow")
        case .darkGreen:
            return Color("DarkGreen")
        case .darkBlue:
            return Color("DarkBlue")
        case .darkPurple:
            return Color("DarkPurple")
        case .darkPink:
            return Color("DarkPink")
        case .grey0:
            return Color("Grey0")
        case .grey05:
            return Color("Grey05")
        case .grey1:
            return Color("Grey1")
        case .grey15:
            return Color("Grey15")
        case .grey2:
            return Color("Grey2")
        case .grey25:
            return Color("Grey25")
        case .grey3:
            return Color("Grey3")
        case .grey35:
            return Color("Grey35")
        case .grey4:
            return Color("Grey4")
        case .grey5:
            return Color("Grey5")
        case .grey6:
            return Color("Grey6")
        case .grey7:
            return Color("Grey7")
        case .grey8:
            return Color("Grey8")
        case .grey9:
            return Color("Grey9")
        case .grey10:
            return Color("Grey10")
        case .clear:
            return Color("Clear")

        }
    }
}
