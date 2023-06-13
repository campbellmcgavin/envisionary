//
//  SetupHome.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/12/23.
//

import SwiftUI

struct SetupHome: View {
    @Binding var canProceed: Bool
    @State var shouldWiggle: Bool = false
    
    var body: some View {
        
        let timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
        
        VStack{
            GetStack(shouldWiggle: shouldWiggle)
        }
        .offset(y:8)
        .frame(height:400)
        .padding([.top,.bottom],8)
        .modifier(ModifierForm())
        .onReceive(timer, perform: { _ in
            if !shouldWiggle{
                shouldWiggle = true
            }
        })
        .onAppear(){
            canProceed = true
        }
    }
        
    @ViewBuilder
    func GetStack(shouldWiggle: Bool) -> some View {
        ZStack{
            

            IconLabel(size: .larger, iconType: .confirm, iconColor: .grey10, circleColor: .green)
                .wiggling(shouldWiggle: shouldWiggle, intensity: 3.0)
                .offset(x:-90, y:-110)
            
            "Shape_Home".ToImage(imageSize: 300)
            
            "Shape_Tree".ToImage(imageSize: SizeType.large.ToSize())
                .wiggling(shouldWiggle: shouldWiggle, intensity: 4.5)
                .offset(x:90, y:20)
            
            "Shape_Tree".ToImage(imageSize: SizeType.large.ToSize())
                .wiggling(shouldWiggle: shouldWiggle, intensity: 4.0)
                .offset(x:-90, y:20)
            
        }
        .frame(maxWidth:.infinity)
        
    }
}

struct SetupHome_Previews: PreviewProvider {
    static var previews: some View {
        SetupHome(canProceed: .constant(false))
    }
}
