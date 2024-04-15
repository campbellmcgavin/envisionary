//
//  ModifierDisabled.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/11/24.
//

import SwiftUI

struct ModifierDisabled: ViewModifier {
    var disable: Bool
    
    init(disable: Bool){
        self.disable = disable
    }
    func body(content: Content) -> some View {
        content
            .if(disable, transform: {
                view in
                view
                    .overlay(
                        Color.specify(color: .darkRed)
                            .opacity(0.5))
                    .disabled(true)
            })
    }
}


extension View {
    
    func shouldDisable(disable: Bool) -> some View {
        modifier(ModifierDisabled(disable: disable))
    }
}
