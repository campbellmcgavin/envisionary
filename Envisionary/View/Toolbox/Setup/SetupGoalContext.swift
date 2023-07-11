//
//  SetupGoalContext.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/12/23.
//

import SwiftUI

struct SetupGoalContext: View {
    @Binding var canProceed: Bool
    var body: some View {
        
        VStack{
            GetStack()
                .scaleEffect(1.05)
        }
        .frame(height:320)
        .padding([.top,.bottom],8)
        .onAppear(){
            canProceed = true
        }
    }
        
    @ViewBuilder
    func GetStack() -> some View {
        ZStack{
            
            "Shape_Envisionary_University".ToImage(imageSize: 300)
            "Shape_Flag".ToImage(imageSize: SizeType.small.ToSize())
                .offset(x:17, y:-110)
                .expensiveWiggling(shouldWiggle: true, intensity: 2.5, period: 40)
            
            "Shape_Tree".ToImage(imageSize: SizeType.medium.ToSize())
                .offset(x:35, y:32)
                .expensiveWiggling(shouldWiggle: true, intensity: 2.5, period: 50)
            "Shape_Tree".ToImage(imageSize: SizeType.medium.ToSize())
                .offset(x:-35, y:32)
                .expensiveWiggling(shouldWiggle: true, intensity: 3.0, period: 30)
            
            "Shape_Tree".ToImage(imageSize: SizeType.mediumLarge.ToSize())
                .offset(x:60, y:70)
                .expensiveWiggling(shouldWiggle: true, intensity: 2.5, period: 45)
            
            "Shape_Tree".ToImage(imageSize: SizeType.mediumLarge.ToSize())
                .offset(x:-60, y:70)
                .expensiveWiggling(shouldWiggle: true, intensity: 3.0, period: 35)
            
        }
        .frame(maxWidth:.infinity)
        
    }
}

struct SetupGoalContext_Previews: PreviewProvider {
    static var previews: some View {
        SetupGoalContext(canProceed: .constant(false))
    }
}
