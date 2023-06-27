//
//  ScrollPickerSelectedRectangle.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/29/23.
//

import SwiftUI

struct ScrollPickerSelectedRectangle: View {
    var color: CustomColor = .grey10
    var body: some View {
        Rectangle()
            .frame(width:SizeType.scrollPickerWidth.ToSize(), height:SizeType.minimumTouchTarget.ToSize() - 10)
            .opacity(0.1)
            .foregroundColor(.specify(color: color))
            .cornerRadius(12)
    }
}

struct ScrollPickerSelectedRectangle_Previews: PreviewProvider {
    static var previews: some View {
        ScrollPickerSelectedRectangle()
    }
}
