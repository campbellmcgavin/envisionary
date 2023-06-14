//
//  TutorialWelcome.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/5/23.
//

import SwiftUI

struct TutorialWelcome: View {
    @Binding var canProceed: Bool
    @State var imageArray: [Image] = [Image]()
    @State var isWiggling = false
    var body: some View {
        let timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
            ZStack(alignment:.center){
                ForEach(WelcomeTutorialEmojis.allCases, id:\.self){
                    emoji in
                    GetPin(emoji: emoji)
                }
                Spacer()
            }
            .frame(height:440)
            .offset(y:-110)
            .frame(maxWidth:.infinity)
        .onAppear{
            imageArray = [Image]()
            for emoji in WelcomeTutorialEmojis.allCases {
                imageArray.append( emoji.rawValue.ToImageNative(imageSize: SizeType.medium.ToSize()))
            }
            canProceed = true
        }
        .onReceive(timer){ _ in
            isWiggling = true
        }
    }
    
    @ViewBuilder
    func GetPin(emoji: WelcomeTutorialEmojis) -> some View{
        
        let itemNumber = Int(emoji.toCGFloat())
        let position = GetOffset(emoji: emoji)
        
        if imageArray.count > itemNumber{
            ZStack{
                ShapeLabel(size: emoji == .envisionary ? .extralarge : .largeish, shapeType: .pin, shapeColor: .purple)
                Circle()
                    .foregroundColor(.specify(color: .grey10))
                    .frame(width:emoji == .envisionary ? 90 : SizeType.largeMedium.ToSize()-8)
                    .offset(y:emoji == .envisionary ? -16 : -10)
                
                imageArray[itemNumber]
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: emoji == .envisionary ? 70 : SizeType.medium.ToSize(), alignment: .center)
                    .offset(y:emoji == .envisionary ? -16 : -10)
                    .foregroundColor(.specify(color: .purple))
            }
            .offset(y:-60)
            .wiggling(shouldWiggle: isWiggling)
            .offset(x: position.x, y: position.y)
            .padding(.bottom,-35)
        }
    }
    
    func GetOffset(emoji: WelcomeTutorialEmojis) -> Position{
        switch emoji {
        case .baby:
            return Position(x: -120, y: 0)
        case .girl:
            return Position(x: -40, y: 0)
        case .teenager:
            return Position(x: 40, y: 0)
        case .woman:
            return Position(x: 120, y: 0)
        case .school:
            return Position(x: -80, y: 120)
        case .graduate:
            return Position(x:0, y: 120)
        case .house:
            return Position(x: 80,y: 120)
        case .envisionary:
            return Position(x: 0, y: 260)
        }
    }
}

enum WelcomeTutorialEmojis: String,CaseIterable{
    case baby = "👶"
    case girl = "👧"
    case teenager = "🙇‍♀️"
    case woman = "💁‍♀️"
    case school = "📚"
    case graduate = "👩‍🎓"
    case house = "🏡"
    case envisionary = "logo"
    
    func toCGFloat() -> CGFloat{
        switch self {
        case .baby:
            return 0
        case .girl:
            return 1
        case .teenager:
            return 2
        case .woman:
            return 3
        case .school:
            return 4
        case .graduate:
            return 5
        case .house:
            return 6
        case .envisionary:
            return 7
        }
    }
}

struct TutorialWelcome_Previews: PreviewProvider {
    static var previews: some View {
        TutorialWelcome(canProceed: .constant(true))
    }
}
