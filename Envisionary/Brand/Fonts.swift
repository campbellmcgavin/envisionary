//
//  Fonts.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/7/23.
//

import SwiftUI

enum CustomFont: CaseIterable{
    
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
    
    func GetHeight() -> CGFloat{
        switch self {
        case .h0:
            return 48
        case .h1:
            return 40
        case .h2:
            return 36
        case .h3:
            return 34
        case .h4:
            return 32
        case .h5:
            return 30
        case .h6:
            return 30
        case .body1:
            return 30
        case .body2:
            return 28
        case .body3:
            return 26
        case .body4:
            return 24
        case .caption:
            return 24
        case .subCaption:
            return 22
        case .logo:
            return 40
        }
    }
    
    func toString() -> String{
        switch self {
        case .h0:
            return "h0"
        case .h1:
            return "h1"
        case .h2:
            return "h2"
        case .h3:
            return "h3"
        case .h4:
            return "h4"
        case .h5:
            return "h5"
        case .h6:
            return "h6"
        case .body1:
            return "b1"
        case .body2:
            return "b2"
        case .body3:
            return "b3"
        case .body4:
            return "b4"
        case .caption:
            return "caption"
        case .subCaption:
            return "subCaption"
        case .logo:
            return "logo"
        }
    }
}

extension Font {
    static func specify(style:CustomFont) -> Font {
        
        return .custom(Font.name(style:style), size: Font.size(style:style))
    }
    
    static func name(style:CustomFont) -> String{
        
        switch style{
            
            //item out of focus
        case .h0:
            return "Figtree-Light_Bold"
        case .h1:
            return "Figtree-Light_Bold"
        case .h2:
            return "Figtree-Light_Bold"
        case .h3:
            return "Figtree-Light_Bold"
        case .h4:
            return "Figtree-Light_Bold"
        case .h5:
            return "Figtree-Light_Bold"
        case .h6:
            return "Figtree-Light_Bold"
            
        case .body1:
            return "Figtree-Light-Regular"
        case .body2:
            return "Figtree-Light-Regular"
        case .body3:
            return "Figtree-Light-Regular"
        case .body4:
            return "Figtree-Light-Regular"
            
            //other
        case .caption:
            return "Figtree-Light_Bold"
        case .subCaption:
            return "Figtree-Light_Bold"
            
        case .logo:
            return "ProximaNovaExCn-Bold"

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
