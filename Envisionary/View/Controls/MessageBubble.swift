//
//  MessageBubble.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/8/23.
//

import SwiftUI

struct MessageBubble: View {
    @Binding var shouldShow: Bool
    @State var selectedCircle = 0
    @State var timer = Timer.publish(every: 0.7, on: .main, in: .common).autoconnect()
    var body: some View {
        
        if shouldShow{
            
            ZStack{
                RoundedRectangle(cornerRadius: 22.5)
                    .frame(width: 80, height:45)
                    .foregroundColor(.specify(color: .grey2))
                
                ZStack{
                    Circle()
                        .frame(width:selectedCircle == 0 ? 14 : 10)
                        .offset(x:-20)
                    Circle()
                        .frame(width:selectedCircle == 1 ? 14 : 10)
                    Circle()
                        .frame(width:selectedCircle == 2 ? 14 : 10)
                        .offset(x:20)
                }
                .foregroundColor(.specify(color: .grey4))
            }
            .onReceive(timer){
                _ in
                withAnimation{
                    GetSize()
                }
            }
        }
    }
    
    func GetSize(){
        
        switch selectedCircle {
        case 0:
            selectedCircle = 1
        case 1:
            selectedCircle = 2
        case 2:
            selectedCircle = 0
        default:
            let _ = "why"
        }
    }
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        MessageBubble(shouldShow: .constant(true))
    }
}
