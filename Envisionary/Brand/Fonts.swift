//
//  Fonts.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/7/23.
//

import SwiftUI

enum CustomFont{
    
    //item in focus
    case h0
    case h1
    case h2
    case h3
    case h4
    case h5
    case h6

    case body1
    case body2
    case body3
    case body4
    
    case caption
    case subCaption
    
    case logo
}

extension Font {
    static func specify(style:CustomFont) -> Font {
        
        return .custom(Font.name(style:style), size: Font.size(style:style))
    }
    
    static func name(style:CustomFont) -> String{
        
        switch style{
            
            //item out of focus
        case .h0:
            return "ProximaNova-Bold"
        case .h1:
            return "ProximaNova-Bold"
        case .h2:
            return "ProximaNova-Bold"
        case .h3:
            return "ProximaNova-Bold"
        case .h4:
            return "ProximaNova-Bold"
        case .h5:
            return "ProximaNova-Bold"
        case .h6:
            return "ProximaNova-Bold"
            
        case .body1:
            return "ProximaNova-Regular"
        case .body2:
            return "ProximaNova-Regular"
        case .body3:
            return "ProximaNova-Regular"
        case .body4:
            return "ProximaNova-Regular"
            
            //other
        case .caption:
            return "ProximaNova-Bold"
        case .subCaption:
            return "ProximaNova-Bold"
            
        case .logo:
            return "ProximaNovaAExCn-Bold"

        }
    }
    
    static func size(style:CustomFont) -> CGFloat{
        switch style{
            
            //item out of focus
        case .h0:
            return 50
        case .h1:
            return 38
        case .h2:
            return 28
        case .h3:
            return 22
        case .h4:
            return 18
        case .h5:
            return 16
        case .h6:
            return 14
        case .caption:
            return 12
        case .subCaption:
            return 10
        case .body1:
            return 18
        case.body2:
            return 16
        case .body3:
            return 14
        case .body4:
            return 12
        case .logo:
            return 22
        }
    }
}
