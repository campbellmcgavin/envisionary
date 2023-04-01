//
//  ModifierCard.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/9/23.
//

import SwiftUI

struct ModifierCard: ViewModifier {
    var color: CustomColor = .grey1
    var radius: CGFloat = SizeType.cornerRadiusLarge.ToSize()
    func body(content: Content) -> some View {
        content
            .background(Color.specify(color:color))
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: radius))
            .padding(.top,4)
            .padding(.bottom,4)
    }
}


struct ModifierSmallCard: ViewModifier {
    var color: CustomColor = .grey1
    var opacity: CGFloat = 1.0
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .background(Color.specify(color: color)
                .opacity(opacity))
            .cornerRadius(SizeType.cornerRadiusSmall.ToSize())
            .padding(.top,4)
            .padding(.bottom,4)

    }
}
