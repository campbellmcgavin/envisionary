//
//  TutorialObjects.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/5/23.
//

import SwiftUI

struct TutorialObjects: View {
    var body: some View {
        VStack{
            ZStack{
                IconLabel(size: .extralarge, iconType: ContentViewType.envision.toIcon(), iconColor: .grey10,circleColor: .purple)
                    .wiggling(shouldWiggle: true, intensity: 12.0)
                
                SetupButton(object: .value)
                    .offset(x:-110, y:90)
                SetupButton(object: .creed)
                    .offset(x:-45, y:150)
                SetupButton(object: .dream)
                    .offset(x:45, y:150)
                SetupButton(object: .aspect)
                    .offset(x:110, y:90)
                
        }
Spacer()
        }
        .frame(height:350)
    }
    
    @ViewBuilder
    func SetupButton(object: ObjectType) -> some View{
        IconLabel(size: .large, iconType: object.toIcon(), iconColor: .grey10,circleColor: .purple)
            .opacity(1.0)
            .wiggling(shouldWiggle: true, intensity: 14.0)
    }
}

struct TutorialObjects_Previews: PreviewProvider {
    static var previews: some View {
        TutorialObjects()
    }
}
