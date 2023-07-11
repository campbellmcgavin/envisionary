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
    var iconType: IconType? = nil
    var height: SizeType = .minimumTouchTarget
    var hasPadding: Bool = true
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
        else if iconType != nil {
            HStack{
                Text(text)
                    .font(.specify(style: style))
                    .foregroundColor(.specify(color: color))
                    .frame(minWidth: 0)
                    .padding([.top,.bottom], backgroundColor != .clear ? 10 : 0)
                    .padding(.leading, backgroundColor == .clear ? 10 : 0)
                
                if iconType != nil {
                    Spacer()
                    IconLabel(size: .medium, iconType: iconType!, iconColor: backgroundColor, circleColor: color)
                        .padding(8)
                }
                  
            }
            .frame(height:height.ToSize())
            .modifier(ModifierMaxWidth(infinity: shouldFill && backgroundColor != .clear))
//            .padding([.leading,.trailing])
            .padding(.leading, iconType != nil ? 12 : 0)
            .background(Capsule()
                .foregroundColor(.specify(color: backgroundColor))
                        
            )
            .frame(height:height.ToSize())
        }
        else{
            ZStack{
                Capsule()
                    .foregroundColor(.specify(color: backgroundColor))
                    .frame(height:height.ToSize())
                    
                HStack{
                    Text(text)
                        .font(.specify(style: style))
                        .foregroundColor(.specify(color: color))
                        .frame(minWidth: 0)
                        .padding([.top,.bottom], backgroundColor != .clear ? 10 : 0)
                        .padding(.leading, backgroundColor == .clear ? 10 : 0)
                    
                    if iconType != nil {
                        Spacer()
                        IconLabel(size: .medium, iconType: iconType!, iconColor: backgroundColor, circleColor: color)
                            .padding(8)
                    }
                      
                }
                .modifier(ModifierMaxWidth(infinity: shouldFill && backgroundColor != .clear))
            }
            .padding([.leading,.trailing], hasPadding ? 10 : 0)
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
