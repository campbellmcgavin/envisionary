//
//  ModifierMaxWidth.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/15/23.
//

import SwiftUI

struct ModifierInteractiveLabel : ViewModifier {
    let labelValue: String
    let yOffset: CGFloat
    var xOffset: CGFloat = 0
    @State var isTapped = false
    @ViewBuilder func body(content: Content) -> some View {
        Button{
            isTapped.toggle()
        }
    label:{
        ZStack{
            content
            
                Text(labelValue)
                    .font(.specify(style: .caption))
                    .foregroundColor(.specify(color: .grey9))
                    .padding(4)
                    .background(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)).foregroundColor(.specify(color: .grey3)))
                    .offset(x: xOffset, y:yOffset)
                    .opacity(isTapped ? 1.0 : 0.0)
        }
        .onChange(of: isTapped){
            _ in
            if isTapped {
                Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
                    withAnimation{
                        self.isTapped = false
                    }
                }
            }
        }
    }
    }
}

extension View {
    
    func interactiveLabel(labelValue: String, yOffset: CGFloat, xOffset: CGFloat = 0.0) -> some View {
        modifier(ModifierInteractiveLabel(labelValue: labelValue, yOffset: yOffset, xOffset: xOffset))
    }
}
