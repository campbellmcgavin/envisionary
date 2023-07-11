//
//  SetupGraduation.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/12/23.
//

import SwiftUI

struct SetupGraduation: View {
    @Binding var shouldClose: Bool
    @State var shouldWiggle = false
    let responses = ["Yay!", "Yippee!", "Wahoo!", "So exciting!"]
    var body: some View {
        
        let timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
        
        ZStack{
            BuildView()
        }
        .frame(maxWidth:.infinity)
        .frame(height:400)
        .offset(y:80)
        .onReceive(timer, perform: { _ in
            if !shouldWiggle{
                shouldWiggle = true
            }
        })
        .onAppear(){
            shouldClose = true
        }
    }
    
    @ViewBuilder
    func BuildView() -> some View{
        
        "Shape_Gradhat".ToImage(imageSize: 140)
            .interactiveLabel(labelValue: toLabel(), yOffset: 30)
            .expensiveWiggling(shouldWiggle: shouldWiggle, intensity: 5.0)
            .offset(x: 15, y:-185)
        "Shape_Gradhat".ToImage(imageSize: 200)
            .interactiveLabel(labelValue: toLabel(), yOffset: 30)
            .expensiveWiggling(shouldWiggle: shouldWiggle, intensity: 5.0)
        
        "Shape_Gradhat".ToImage(imageSize: 100)
            .interactiveLabel(labelValue: toLabel(), yOffset: 30)
            .expensiveWiggling(shouldWiggle: shouldWiggle, intensity: 6.5)
            .offset(x:-100, y:-120)
        
        "Shape_Gradhat".ToImage(imageSize: 70)
            .interactiveLabel(labelValue: toLabel(), yOffset: 30)
            .expensiveWiggling(shouldWiggle: shouldWiggle, intensity: 6.5)
            .offset(x:90, y:-90)
    }
    
    func toLabel() -> String{
        return responses.randomElement()!
    }
}

struct SetupGraduation_Previews: PreviewProvider {
    static var previews: some View {
        SetupGraduation(shouldClose: .constant(false))
    }
}
