//
//  TutorialObjects.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/5/23.
//

import SwiftUI

struct TutorialObjects: View {
    @Binding var canProceed: Bool
    
    @State var shouldWiggle = false
    
    var body: some View {
        let timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
        
        VStack{
            ZStack{
                SetupView()
        }
            .frame(maxWidth:.infinity)
            .offset(y:35)
            .onReceive(timer, perform: {
                _ in
                shouldWiggle = true
            })
            .onAppear(){
                canProceed = true
            }
Spacer()
        }
        .frame(height:350)
    }
    
    @ViewBuilder
    func SetupView() -> some View{
        IconLabel(size: .extralarge, iconType: ContentViewType.envision.toIcon(), iconColor: .grey10,circleColor: .purple)
            .wiggling(shouldWiggle: shouldWiggle, intensity: 12.0)
        
        SetupButton(object: .value)
            .offset(x:-110, y:90)
        SetupButton(object: .creed)
            .offset(x:-45, y:150)
        SetupButton(object: .dream)
            .offset(x:45, y:150)
        SetupButton(object: .aspect)
            .offset(x:110, y:90)
    }
    
    @ViewBuilder
    func SetupButton(object: ObjectType) -> some View{
        IconLabel(size: .large, iconType: object.toIcon(), iconColor: .grey10,circleColor: .purple)
            .opacity(1.0)
            .wiggling(shouldWiggle: shouldWiggle, intensity: 14.0)
    }
}

struct TutorialObjects_Previews: PreviewProvider {
    static var previews: some View {
        TutorialObjects(canProceed: .constant(true))
    }
}
