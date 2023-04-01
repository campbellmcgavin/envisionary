//
//  TextButton.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/25/23.
//

import SwiftUI

struct TextButton: View {
    @Binding var isPressed: Bool
    let text: String
    let color: CustomColor
    var body: some View {
        Button{
            isPressed.toggle()
        }
    label:{
        HStack{
            Text(text)
                .font(.specify(style: .h3))
                .foregroundColor(.specify(color: color))
                .padding(.leading)
            Spacer()
        }

    }

    }
}

struct TextButton_Previews: PreviewProvider {
    static var previews: some View {
        TextButton(isPressed: .constant(false), text: "Clear all", color: .purple)
    }
}
