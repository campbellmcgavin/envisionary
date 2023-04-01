//
//  ModifierForm.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/19/23.
//

import SwiftUI

struct ModifierForm: ViewModifier {
    var color: CustomColor?
    
    func body(content: Content) -> some View {
        content
            .background(Color.specify(color:color == nil ? .grey2 : color!))
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: SizeType.cornerRadiusForm.ToSize()))

    }
}
