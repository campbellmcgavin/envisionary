//
//  StackDivider.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/8/23.
//

import SwiftUI

struct StackDivider: View {
    var shouldIndent = true
    var color: CustomColor = .grey2
    var body: some View {
        Divider()
            .overlay(Color.specify(color: color))
            .frame(height:1)
            .padding(.leading, shouldIndent ? 16+50+16 : 0)
    }
}
