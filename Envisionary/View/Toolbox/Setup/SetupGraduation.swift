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
            .wiggling(shouldWiggle: shouldWiggle, intensity: 5.0)
            .offset(x: 15, y:-185)
        "Shape_Gradhat".ToImage(imageSize: 200)
            .wiggling(shouldWiggle: shouldWiggle, intensity: 5.0)
        
        "Shape_Gradhat".ToImage(imageSize: 100)
            .wiggling(shouldWiggle: shouldWiggle, intensity: 6.5)
            .offset(x:-100, y:-120)
        
        "Shape_Gradhat".ToImage(imageSize: 70)
            .wiggling(shouldWiggle: shouldWiggle, intensity: 6.5)
            .offset(x:90, y:-90)
    }
}

struct SetupGraduation_Previews: PreviewProvider {
    static var previews: some View {
        SetupGraduation(shouldClose: .constant(false))
    }
}
