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
    var backgroundColor: CustomColor = .clear
    var style: CustomFont = .h2
    var shouldHaveBackground = false
    var shouldFill = true
    var body: some View {
        Button{
            isPressed.toggle()
        }
    label:{
        
        if !shouldHaveBackground{
            HStack{
                Text(text)
                    .font(.specify(style: style))
                    .foregroundColor(.specify(color: color))
    //                .padding([.leading,.trailing], backgroundColor != .clear ? 40 : 0)

                    .frame(minWidth: 0)
                    .padding(.leading)
                   
                    Spacer()
            }
        }
        else{
            HStack{
                Text(text)
                    .font(.specify(style: style))
                    .foregroundColor(.specify(color: color))
                    .frame(minWidth: 0)
                    .padding([.top,.bottom], backgroundColor != .clear ? 10 : 0)
                    .padding(.leading, backgroundColor == .clear ? 10 : 0)
                  
            }
            .modifier(ModifierMaxWidth(infinity: shouldFill && backgroundColor != .clear))
            .padding([.leading,.trailing])
            .background(
                Color.specify(color: backgroundColor)
                    .frame(maxWidth:.infinity)
                    .clipShape(RoundedRectangle(cornerRadius: SizeType.cornerRadiusSmall.ToSize()))
            )
//            .padding([.leading,.trailing])
        }

    }

    }
}

struct TextButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            TextButton(isPressed: .constant(false), text: "Clear all", color: .purple)
            TextButton(isPressed: .constant(false), text: "Take photo", color: .grey10, backgroundColor: .purple, shouldHaveBackground: true)
            TextButton(isPressed: .constant(false), text: "Camera roll", color: .grey10, backgroundColor: .grey3, shouldHaveBackground: true)
        }

    }
}
