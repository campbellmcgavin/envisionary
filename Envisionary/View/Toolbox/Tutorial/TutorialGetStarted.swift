//
//  TutorialGetStarted.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/5/23.
//

import SwiftUI

struct TutorialGetStarted: View {
    @Binding var canProceed: Bool
    
    @State var shouldWiggle = false
    
    var body: some View {
        VStack{
            ZStack{
                BuildView()
        }
            .onAppear(){
                canProceed = true
            }
Spacer()
        }
        .offset(x: -20, y:140)
        .frame(height:510)
        .frame(maxWidth:.infinity)
        .onAppear{
            shouldWiggle = true
        }
    }
    
    @ViewBuilder
    func BuildView() -> some View{
        IconLabel(size: .extralarge, iconType: .confirm, iconColor: .grey10,circleColor: .green)
            .wiggling(shouldWiggle: shouldWiggle, intensity: 10.0)

        IconLabel(size: .mediumLarge, iconType: .confirm, iconColor: .grey10,circleColor: .green)
            .wiggling(shouldWiggle: shouldWiggle, intensity: 5.0)
            .offset(x:-100, y:100)

        IconLabel(size: .largeish, iconType: .confirm, iconColor: .grey10,circleColor: .green)
            .wiggling(shouldWiggle: shouldWiggle, intensity: 12.0)
            .offset(x:100, y:-140)

        IconLabel(size: .medium, iconType: .confirm, iconColor: .grey10,circleColor: .green)
            .wiggling(shouldWiggle: shouldWiggle, intensity: 6.0)
            .offset(x:60, y:120)

        IconLabel(size: .larger, iconType: .confirm, iconColor: .grey10,circleColor: .green)
            .wiggling(shouldWiggle: shouldWiggle, intensity: 6.0)
            .offset(x:-30, y:190)

        IconLabel(size: .largeMedium, iconType: .confirm, iconColor: .grey10,circleColor: .green)
            .wiggling(shouldWiggle: shouldWiggle, intensity: 11.0)
            .offset(x:-80, y:-100)

        IconLabel(size: .large, iconType: .confirm, iconColor: .grey10,circleColor: .green)
            .wiggling(shouldWiggle: shouldWiggle, intensity: 11.0)
            .offset(x:80, y:200)

        IconLabel(size: .mediumLarge, iconType: .confirm, iconColor: .grey10,circleColor: .green)
            .wiggling(shouldWiggle: shouldWiggle, intensity: 9.0)
            .offset(x:120, y:30)
    }
}

struct TutorialGetStarted_Previews: PreviewProvider {
    static var previews: some View {
        TutorialGetStarted(canProceed: .constant(true))
    }
}
