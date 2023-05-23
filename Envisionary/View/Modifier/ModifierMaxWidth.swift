//
//  ModifierMaxWidth.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/15/23.
//

import SwiftUI

struct ModifierMaxWidth : ViewModifier {
    var infinity : Bool
    
    @ViewBuilder func body(content: Content) -> some View {
        if infinity {
            content.frame(maxWidth: .infinity)
        } else {
            content
        }
    }
}
