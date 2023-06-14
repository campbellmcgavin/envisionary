//
//  TutorialEnvisionary.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/5/23.
//

import SwiftUI

struct TutorialEnvisionary: View {
    @Binding var canProceed: Bool
    @State var shouldWiggle: Bool = false
    var body: some View {
        
        let timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
        
        VStack{
            ZStack{
                ForEach(0...7, id:\.self){
                    number in
                    BuildCircle(item: number)
                }
            }
            .frame(maxWidth:.infinity)
            Spacer()
        }
        .frame(height:500)
        .offset(y:30)
        .onAppear{
            canProceed = true
        }
        .onReceive(timer){
            _ in
            shouldWiggle = true
        }
    }
    
    @ViewBuilder
    func BuildCircle(item: Int) -> some View{
        let offset = GetOffset(item: item)
        ZStack{
            let size = GetSize(item: item).ToSize()
            
            Circle()
                .foregroundColor(.specify(color: .purple))
                .frame(width:size, height: size)
            Circle()
                .foregroundColor(.specify(color: .grey10))
                .frame(width:size - 25, height: size - 25)
            
            if item == 0{
                "🏆".ToImage(imageSize: 120)
            }
        }
        .offset(x: offset.x, y: offset.y)
        .wiggling(shouldWiggle: shouldWiggle, intensity: 1.2)
    }
    
    func GetOffset(item: Int) -> Position{
        switch item{
        case 0:
            return Position(x: 0, y: 0)
        case 1:
            return Position(x: -75, y: 150)
        case 2:
            return Position(x: -75-50, y: 150+70)
        case 3:
            return Position(x: -75+50, y: 150+90)
        case 4:
            return Position(x: -75+10, y: 150+90+60)
        case 5:
            return Position(x: -75+70, y: 150+90+80)
        case 6:
            return Position(x: 90, y: 130)
        case 7:
            return Position(x: 90, y: 200)
        default:
            return Position(x: 0, y: 0)
        }
    }
    
    func GetSize(item: Int) -> SizeType{
        switch item{
        case 0:
            return .giant
        case 1:
            return .larger
        case 2:
            return .medium
        case 3:
            return .large
        case 4:
            return .medium
        case 5:
            return .mediumLarge
        case 6:
            return .large
        default:
            return .medium
        }
    }
}

struct Position{
    let x: CGFloat
    let y: CGFloat
}

struct TutorialEnvisionary_Previews: PreviewProvider {
    static var previews: some View {
        TutorialEnvisionary(canProceed: .constant(true))
    }
}
