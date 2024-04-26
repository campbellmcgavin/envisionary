//
//  FloatingActionButton.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/8/23.
//

import SwiftUI

struct FloatingActionButton: View {
    @Binding var shouldAct: Bool
    @Binding var modalType: ModalType
    
    @State var isPressed = false
    let xOffset: CGFloat = 70+16
    let yOffset: CGFloat = 70+16
    
    var body: some View {
        
        GeometryReader{
            geometry in
            
            IconButton(isPressed: $shouldAct, size: .large, iconType: .add, iconColor: .grey10, circleColor: .purple, hasAnimation: true)
                .offset(x:-xOffset+geometry.size.width, y:-yOffset + geometry.size.height)
                .onChange(of: isPressed){
                    _ in

                    modalType = .add
                }
        }
        

    }
    
    struct FloatingActionButton_Previews: PreviewProvider {
        static var previews: some View {
            FloatingActionButton(shouldAct: .constant(true), modalType: .constant(.search))
                .environmentObject(ViewModel())
        }
    }
}
