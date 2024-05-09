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
        VStack{
            ZStack{
                "shape_astronaut_cable".ToImage(imageSize:110)
                    .offset(x:75,y:-75)
                    .opacity(0.8)
                "shape_astronaut_lost".ToImage(imageSize: 150)
                    .wiggling(intensity:3.0)
            }
            Text("Nothing to see out here.")
                .font(.specify(style: .h6))
                .foregroundColor(.specify(color: .grey4))
                .padding(.top,40)
            
            Text("Try removing a filter or creating something new.")
                .font(.specify(style: .caption))
                .foregroundColor(.specify(color: .grey3))
                .padding(.top,-6)
            
        }

        .opacity(opacity)
    }
}

struct LabelAstronaut_Previews: PreviewProvider {
    static var previews: some View {
        LabelAstronaut(opacity: 1.0)
    }
}
