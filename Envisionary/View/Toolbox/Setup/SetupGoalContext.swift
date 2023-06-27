//
//  SetupGoalContext.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/12/23.
//

import SwiftUI

struct SetupGoalContext: View {
    @Binding var canProceed: Bool
    @State var shouldWiggle: Bool = false
    var body: some View {
        
        let timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
        
        VStack{
            GetStack(shouldWiggle: shouldWiggle)
                .scaleEffect(1.05)
        }
        .frame(height:320)
        .padding([.top,.bottom],8)
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
            
            "Shape_Envisionary_University".ToImage(imageSize: 300)
            "Shape_Flag".ToImage(imageSize: SizeType.small.ToSize())
                .offset(x:17, y:-110)
                .wiggling(shouldWiggle: shouldWiggle, intensity: 1.0)
            
            "Shape_Tree".ToImage(imageSize: SizeType.medium.ToSize())
                .offset(x:35, y:32)
                .wiggling(shouldWiggle: shouldWiggle, intensity: 1.7)
            "Shape_Tree".ToImage(imageSize: SizeType.medium.ToSize())
                .offset(x:-35, y:32)
                .wiggling(shouldWiggle: shouldWiggle, intensity: 1.7)
            
            "Shape_Tree".ToImage(imageSize: SizeType.mediumLarge.ToSize())
                .offset(x:60, y:70)
                .wiggling(shouldWiggle: shouldWiggle, intensity: 1.3)
            
            "Shape_Tree".ToImage(imageSize: SizeType.mediumLarge.ToSize())
                .offset(x:-60, y:70)
                .wiggling(shouldWiggle: shouldWiggle, intensity: 1.3)
            
        }
        .frame(maxWidth:.infinity)
        
    }
}

struct SetupGoalContext_Previews: PreviewProvider {
    static var previews: some View {
        SetupGoalContext(canProceed: .constant(false))
    }
}
