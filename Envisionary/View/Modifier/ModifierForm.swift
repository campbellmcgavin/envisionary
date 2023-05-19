//
//  ModifierForm.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/19/23.
//

import SwiftUI

struct ModifierForm: ViewModifier {
    var color: CustomColor?
    var opacity: CGFloat = 1.0
    func body(content: Content) -> some View {
        content
            .background(Color.specify(color:color == nil ? .grey2 : color!).opacity(opacity))
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: SizeType.cornerRadiusForm.ToSize()))
    }
}
