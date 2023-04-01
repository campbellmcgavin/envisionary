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
    case grey3
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
            return Color("red")
        case .yellow:
            return Color("yellow")
        case .green:
            return Color("green")
        case .blue:
            return Color("blue")
        case .purple:
            return Color("purple")
        case .pink:
            return Color("pink")
        case .lightRed:
            return Color("lightRed")
        case .lightYellow:
            return Color("lightYellow")
        case .lightGreen:
            return Color("lightGreen")
        case .lightBlue:
            return Color("lightBlue")
        case .lightPurple:
            return Color("lightPurple")
        case .lightPink:
            return Color("lightPink")
        case .darkRed:
            return Color("darkRed")
        case .darkYellow:
            return Color("darkYellow")
        case .darkGreen:
            return Color("darkGreen")
        case .darkBlue:
            return Color("darkBlue")
        case .darkPurple:
            return Color("darkPurple")
        case .darkPink:
            return Color("darkPink")
        case .grey0:
            return Color("grey0")
        case .grey05:
            return Color("grey05")
        case .grey1:
            return Color("grey1")
        case .grey15:
            return Color("grey15")
        case .grey2:
            return Color("grey2")
        case .grey3:
            return Color("grey3")
        case .grey4:
            return Color("grey4")
        case .grey5:
            return Color("grey5")
        case .grey6:
            return Color("grey6")
        case .grey7:
            return Color("grey7")
        case .grey8:
            return Color("grey8")
        case .grey9:
            return Color("grey9")
        case .grey10:
            return Color("grey10")
        case .clear:
            return Color("clear")

        }
    }
}
