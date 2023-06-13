//
//  TutorialWelcome.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/5/23.
//

import SwiftUI

struct TutorialWelcome: View {
    @State var imageArray: [Image] = [Image]()
    
    var body: some View {
            ZStack(alignment:.center){
                ForEach(WelcomeTutorialEmojis.allCases, id:\.self){
                    emoji in
                    GetPin(emoji: emoji)
                }
                Spacer()
            }
            .frame(height:690)
            .offset(y:-290)
        .onAppear{
            imageArray = [Image]()
            for emoji in WelcomeTutorialEmojis.allCases {
                imageArray.append( emoji.rawValue.ToImageNative(imageSize: SizeType.medium.ToSize()))
            }
        }
    }
    
    @ViewBuilder
    func GetPin(emoji: WelcomeTutorialEmojis) -> some View{
        
        let itemNumber = Int(emoji.toCGFloat())
        let position = GetOffset(emoji: emoji)
        
        if imageArray.count > itemNumber{
            ZStack{
                ShapeLabel(size: .larger, shapeType: .pin, shapeColor: .purple)
                Circle()
                    .foregroundColor(.specify(color: .grey10))
                    .frame(width:SizeType.large.ToSize()-8)
                    .offset(y:-10)
                
                imageArray[itemNumber]
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: SizeType.medium.ToSize(), height: SizeType.medium.ToSize(), alignment: .center)
                    .offset(y:-10)
                    .foregroundColor(.specify(color: .purple))
            }
            .offset(y:-60)
            .wiggling()
            .offset(x: position.x, y: position.y)
            .padding(.bottom,-35)
        }
    }
    
    func GetOffset(emoji: WelcomeTutorialEmojis) -> Position{
        switch emoji {
        case .baby:
            return Position(x: 0, y: 0)
        case .girl:
            return Position(x: -80, y: 55)
        case .teenager:
            return Position(x: -120, y: 160)
        case .woman:
            return Position(x: -80, y: 160-55 + 160)
        case .school:
            return Position(x: 0, y: 265+55)
        case .graduate:
            return Position(x: 80, y: 265+55+55)
        case .celebrate:
            return Position(x: 120, y: 480)
        case .house:
            return Position(x: 80,y: 480-55 + 160)
        case .envisionary:
            return Position(x: 0, y: 480+160)
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
    case celebrate = "🎉"
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
        case .celebrate:
            return 6
        case .house:
            return 7
        case .envisionary:
            return 8
        }
    }
}

struct TutorialWelcome_Previews: PreviewProvider {
    static var previews: some View {
        TutorialWelcome()
    }
}
