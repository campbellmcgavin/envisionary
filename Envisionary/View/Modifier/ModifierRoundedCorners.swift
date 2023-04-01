//
//  ModifierRoundedCorners.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/9/23.
//
import SwiftUI

struct ModifierRoundedCorners: ViewModifier {
    var radius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .cornerRadius(radius, corners: [.bottomLeft, .bottomRight])
            .background(Color.clear)
    }

}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
