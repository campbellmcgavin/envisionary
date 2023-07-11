//
//  SetupHome.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/12/23.
//

import SwiftUI

struct SetupHome: View {
    @Binding var canProceed: Bool
    
    var body: some View {
        
        VStack{
            GetStack()
        }
        .offset(y:8)
        .frame(height:400)
        .padding([.top,.bottom],8)
        .onAppear(){
            canProceed = true
        }
    }
        
    @ViewBuilder
    func GetStack() -> some View {
        ZStack{
            IconLabel(size: .larger, iconType: .confirm, iconColor: .grey10, circleColor: .green)
                .expensiveWiggling(shouldWiggle: true, intensity: 3.0, period: 55)
                .offset(x:-90, y:-110)
            
            "Shape_Home".ToImage(imageSize: 300)
            
            "Shape_Tree".ToImage(imageSize: SizeType.large.ToSize())
                .expensiveWiggling(shouldWiggle: true, intensity: 4.5, period:40)
                .offset(x:90, y:20)
            
            "Shape_Tree".ToImage(imageSize: SizeType.large.ToSize())
                .expensiveWiggling(shouldWiggle: true, intensity: 4.0, period: 35)
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
