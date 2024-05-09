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
    let familyArray = ["👨‍👩‍👧‍👦","👩‍👧","👨‍👩‍👦","👨‍👧","👪","👨‍👨‍👧","👩‍👩‍👦"]
    @State var selectedFamily = ""
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
            selectedFamily = familyArray.randomElement()!
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
            
            switch item{
            case 0:
                "🏆".ToImage(imageSize: 120)
            case 1:
                "👔".ToImage(imageSize: 60)
            case 3:
                "💸".ToImage(imageSize: 38)
            case 6:
                selectedFamily.ToImage(imageSize:38)
            case 5:
                "💪".ToImage(imageSize: 20)
            default:
                let _ = "why"
                
            }
        }
        .interactiveLabel(labelValue: GetLabel(item: item), yOffset: 40)
        .offset(x: offset.x, y: offset.y)
        .wiggling(shouldWiggle: shouldWiggle, intensity: 1.2)
    }
    
    func GetLabel(item: Int) -> String{
        switch item{
        case 0:
            return "Your life's work"
        case 1:
            return "Your career"
        case 2:
            return "Your company"
        case 3:
            return "Making it big"
        case 4:
            return "The promotion"
        case 5:
            return "The grind"
        case 6:
            return "Happy family"
        case 7:
            return "Dream Vacation"
        default:
            return "Extra"
        }
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
