//
//  LabelAstronaut.swift
//  Envisionary
//
//  Created by Campbell McGavin on 8/5/23.
//

import SwiftUI

struct LabelAstronaut: View {
    var opacity: CGFloat
    var body: some View {
        ZStack{
            "shape_astronaut_cable".ToImage(imageSize:110)
                .offset(x:75,y:-75)
                .opacity(0.8)
            "shape_astronaut_lost".ToImage(imageSize: 150)
                .expensiveWiggling()
        }
        .opacity(opacity)
    }
}

struct LabelAstronaut_Previews: PreviewProvider {
    static var previews: some View {
        LabelAstronaut(opacity: 1.0)
    }
}
