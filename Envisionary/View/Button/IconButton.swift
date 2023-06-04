//
//  AddButton.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/8/23.
//

import SwiftUI

struct IconButton: View {
    @Binding var isPressed: Bool
    let size: SizeType
    var iconType: IconType
    var iconColor: CustomColor
    var circleColor: CustomColor = .clear
    var opacity: Double = 1
    var circleOpacity: Double = 1
    var hasAnimation: Bool = false
    
    var body: some View {
        Button(action: {
            if hasAnimation{
                withAnimation{
                    isPressed.toggle()
                }
            }
            else{
                isPressed.toggle()
            }
        }) {
            IconLabel(size: size, iconType: iconType, iconColor: iconColor, circleColor: circleColor, opacity: opacity, circleOpacity: circleOpacity)
        }
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            
//            Circle()
//                .frame(width:100,height:100)
//                .foregroundColor(.specify(color: .purple))
//            Spacer()
//                .frame(maxWidth:.infinity)
//                .frame(height:50)
//                .background(Color.specify(color: .purple))
            HStack{
                IconButton(isPressed: .constant(true), size: .large, iconType: .add, iconColor: .grey10, circleColor: .purple)
                IconButton(isPressed: .constant(true), size: .large, iconType: .add, iconColor: .purple, circleColor: .clear)
                IconButton(isPressed: .constant(true), size: .medium, iconType: .add, iconColor: .purple, circleColor: .grey10)
                IconButton(isPressed: .constant(true), size: .medium, iconType: .add, iconColor: .grey10, circleColor: .grey2)
                IconButton(isPressed: .constant(true), size: .medium, iconType: .add, iconColor: .grey10, circleColor: .clear)
            }
            HStack{
                IconButton(isPressed: .constant(true), size: .medium, iconType: .delete, iconColor: .red, circleColor: .grey2)
                Spacer()
                IconButton(isPressed: .constant(true), size: .medium, iconType: .timeBack, iconColor: .grey10, circleColor: .grey2)
                IconButton(isPressed: .constant(true), size: .medium, iconType: .timeForward, iconColor: .grey10, circleColor: .grey2)
                IconButton(isPressed: .constant(true), size: .medium, iconType: .maximize, iconColor: .grey10, circleColor: .grey2)
                IconButton(isPressed: .constant(true), size: .medium, iconType: .edit, iconColor: .grey10, circleColor: .grey2)
                IconButton(isPressed: .constant(true), size: .medium, iconType: .add, iconColor: .grey10, circleColor: .grey2)
                IconButton(isPressed: .constant(true), size: .medium, iconType: .right, iconColor: .grey10, circleColor: .grey2)
            }

            HStack{
                IconButton(isPressed: .constant(true), size: .medium, iconType: .filter, iconColor: .grey10, circleColor: .clear)
                IconButton(isPressed: .constant(true), size: .medium, iconType: .group, iconColor: .grey10, circleColor: .clear)
                IconButton(isPressed: .constant(true), size: .medium, iconType: .help, iconColor: .grey10, circleColor: .clear)
                Spacer()
                IconButton(isPressed: .constant(true), size: .medium, iconType: .search, iconColor: .grey10, circleColor: .clear)
            }

            HStack{
                IconButton(isPressed: .constant(true), size: .medium, iconType: .left, iconColor: .purple, circleColor: .grey10)
                Spacer()
                IconButton(isPressed: .constant(true), size: .medium, iconType: .delete, iconColor: .red, circleColor: .grey10)
                IconButton(isPressed: .constant(true), size: .medium, iconType: .help, iconColor: .purple, circleColor: .grey10)
                IconButton(isPressed: .constant(true), size: .medium, iconType: .maximize, iconColor: .purple, circleColor: .grey10)
                IconButton(isPressed: .constant(true), size: .medium, iconType: .edit, iconColor: .purple, circleColor: .grey10)
            }

            HStack{
                IconButton(isPressed: .constant(true), size: .medium, iconType: .left, iconColor: .purple, circleColor: .grey10)
                IconButton(isPressed: .constant(true), size: .medium, iconType: .right, iconColor: .purple, circleColor: .grey10)
                IconButton(isPressed: .constant(true), size: .medium, iconType: .up, iconColor: .purple, circleColor: .grey10)
                IconButton(isPressed: .constant(true), size: .medium, iconType: .down, iconColor: .purple, circleColor: .grey10)

                IconButton(isPressed: .constant(true), size: .medium, iconType: .left, iconColor: .grey10, circleColor: .purple)
                IconButton(isPressed: .constant(true), size: .medium, iconType: .right, iconColor: .grey10, circleColor: .purple)
                IconButton(isPressed: .constant(true), size: .medium, iconType: .up, iconColor: .grey10, circleColor: .purple)
                IconButton(isPressed: .constant(true), size: .medium, iconType: .down, iconColor: .grey10, circleColor: .purple)
            }
            HStack{
                IconButton(isPressed: .constant(true), size: .small, iconType: .left, iconColor: .purple, circleColor: .clear)
                IconButton(isPressed: .constant(true), size: .small, iconType: .right, iconColor: .purple, circleColor: .clear)
                IconButton(isPressed: .constant(true), size: .small, iconType: .up, iconColor: .purple, circleColor: .clear)
                IconButton(isPressed: .constant(true), size: .small, iconType: .down, iconColor: .purple, circleColor: .clear)
                IconButton(isPressed: .constant(true), size: .medium, iconType: .left, iconColor: .purple, circleColor: .clear)
                IconButton(isPressed: .constant(true), size: .medium, iconType: .right, iconColor: .purple, circleColor: .clear)
                IconButton(isPressed: .constant(true), size: .medium, iconType: .up, iconColor: .purple, circleColor: .clear)
                IconButton(isPressed: .constant(true), size: .medium, iconType: .down, iconColor: .purple, circleColor: .clear)
            }
            HStack{
                IconButton(isPressed: .constant(true), size: .small, iconType: .left, iconColor: .grey10, circleColor: .clear)
                IconButton(isPressed: .constant(true), size: .small, iconType: .right, iconColor: .grey10, circleColor: .clear)
                IconButton(isPressed: .constant(true), size: .small, iconType: .up, iconColor: .grey10, circleColor: .clear)
                IconButton(isPressed: .constant(true), size: .small, iconType: .down, iconColor: .grey10, circleColor: .clear)
                IconButton(isPressed: .constant(true), size: .medium, iconType: .left, iconColor: .grey10, circleColor: .clear)
                IconButton(isPressed: .constant(true), size: .medium, iconType: .right, iconColor: .grey10, circleColor: .clear)
                IconButton(isPressed: .constant(true), size: .medium, iconType: .up, iconColor: .grey10, circleColor: .clear)
                IconButton(isPressed: .constant(true), size: .medium, iconType: .down, iconColor: .grey10, circleColor: .clear)
            }
            HStack{
                IconButton(isPressed: .constant(true), size: .small, iconType: .left, iconColor: .grey10, circleColor: .clear, opacity: 0.5)
                IconButton(isPressed: .constant(true), size: .small, iconType: .right, iconColor: .grey10, circleColor: .clear, opacity: 0.5)
                IconButton(isPressed: .constant(true), size: .small, iconType: .up, iconColor: .grey10, circleColor: .clear, opacity: 0.5)
                IconButton(isPressed: .constant(true), size: .small, iconType: .down, iconColor: .grey10, circleColor: .clear, opacity: 0.5)
                IconButton(isPressed: .constant(true), size: .medium, iconType: .left, iconColor: .grey10, circleColor: .clear, opacity: 0.5)
                IconButton(isPressed: .constant(true), size: .medium, iconType: .right, iconColor: .grey10, circleColor: .clear, opacity: 0.5)
                IconButton(isPressed: .constant(true), size: .medium, iconType: .up, iconColor: .grey10, circleColor: .clear, opacity: 0.5)
                IconButton(isPressed: .constant(true), size: .medium, iconType: .down, iconColor: .grey10, circleColor: .clear, opacity: 0.5)
            }
        }
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .background(Color.specify(color: .grey0))
    }
}
