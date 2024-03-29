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
    var opacity: CGFloat = 1.0
    var padding: CGFloat = 4
    func body(content: Content) -> some View {
        content
            .background(Color.specify(color:color)
                .opacity(opacity))
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: radius))
            .padding(.top, padding)
            .padding(.bottom, padding)
            
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
