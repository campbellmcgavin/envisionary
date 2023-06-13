//
//  SetupSession.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/12/23.
//

import SwiftUI

struct SetupSession: View {
    @Binding var canProceed: Bool
//    @State var goals: [Goal] = [Goal]()
    
//    @EnvironmentObject var vm: ViewModel
    @State var shouldWiggle: Bool = false

    var body: some View {
        let timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
        ZStack(){
            
            ZStack{
                ForEach(0...3, id:\.self){
                    number in
                    BuildLabel(index: number)
                }
            }
        }
        .frame(height:450)
        .offset(x:25, y:-150)
            .onAppear(){
//                goals = vm.ListGoals(limit:7)
                canProceed = true
            }
            .frame(maxWidth:.infinity)
            .modifier(ModifierForm())
            .onReceive(timer){
                _ in
                shouldWiggle = true
            }
    }
    
    @ViewBuilder
    func BuildLabel(index: Int) -> some View{
        let offset = toOffset(item: index)
        let icon = toIcon(index: index)
        let color = toColor(icon: icon)
        
        ZStack{


            HStack{
                Text(toText(item:index))
                    .font(.specify(style: .h1))
                Spacer()
            }
            .foregroundColor(.specify(color: .grey10))
            .padding()
            .padding(.leading,10)
            .frame(width:120, height:70)
            .background{
                Capsule()
                    .foregroundColor(.specify(color: color))
            }
            .offset(x:-25)

//            TextButton(isPressed: .constant(false), text: toText(item: index), color: .grey10, backgroundColor: toColor(icon: icon), style:.h4, shouldHaveBackground: true, shouldFill: false, height: .larger)
//                .frame(width:150, height:100)
//                .offset(x:-50)
            IconLabel(size: .largeMedium, iconType: icon, iconColor: .grey10)
                .offset(x:-5)

            
//            BubbleView(goalId: goal.id, focusGoal: .constant(id))
//                .rotationEffect(toAngle(index: index))
        
        }
        .wiggling(shouldWiggle: shouldWiggle, intensity:6)
        .offset(x: offset.x, y: offset.y)

    }
    
    func toIcon(index: Int) -> IconType {
        switch index {
        case 0:
            return .add
        case 1:
            return .arrow_right
        case 2:
            return .delete
        case 3:
            return .edit
        case 4:
            return .arrow_right
        case 5:
            return .delete
        case 6:
            return .add
        default:
            return .arrow_right
        }
    }
    
    func toColor(icon: IconType) -> CustomColor{
        switch icon{
        case .add:
            return .green
        case .arrow_right:
            return .pink
        case .edit:
            return .yellow
        case .delete:
            return .red
        default:
            return .grey10
        }
    }
    
    func toOffset(item: Int) -> Position{
        switch item{
        case 0:
            return Position(x: -60, y: 0)
        case 1:
            return Position(x: 60, y: 90)
        case 2:
            return Position(x: -60, y: 180)
        case 3:
            return Position(x: 60, y: 270)
        default:
            return Position(x: -55, y: 360)
        }
    }
    
    func toText(item: Int) -> String{
        switch item{
        case 0:
            return "4"
        case 1:
            return "3"
        case 2:
            return "5"
        case 3:
            return "5"
        default:
            return ""
        }
    }
    
    func toAngle(index: Int) -> Angle{
        switch index {
        case 0:
            return Angle(degrees: 10)
        case 1:
            return Angle(degrees: -5)
        case 2:
            return Angle(degrees: 13)
        case 3:
            return Angle(degrees: 3)
        case 4:
            return Angle(degrees: -8)
        case 5:
            return Angle(degrees: 14)
        case 6:
            return Angle(degrees: -4)
        default:
            return Angle(degrees: 2)
        }
    }
}

struct SetupSession_Previews: PreviewProvider {
    static var previews: some View {
        SetupSession(canProceed: .constant(false))
    }
}
