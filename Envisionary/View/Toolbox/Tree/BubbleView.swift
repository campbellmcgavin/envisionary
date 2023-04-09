//
//  BubbleView.swift
//  Visionary
//
//  Created by Campbell McGavin on 2/4/22.
//

import SwiftUI

struct BubbleView: View {
    let goalId: UUID
    @Binding var focusGoal: UUID
    var width: CGFloat = 180
    var height: CGFloat = 50
    var offset: CGFloat = 0
    var shouldShowDetails = true
    @State var goal: Goal? = Goal()
    @EnvironmentObject var gs: GoalService
    var body: some View {

            Button{
                withAnimation{
                    if focusGoal == goalId {
                        focusGoal = UUID()
                    }
                    else {
                        focusGoal = goalId
                    }
                }
            }

        label:{
            HStack{
                    Circle()
                        .frame(width:SizeType.minimumTouchTarget.ToSize(), height: SizeType.minimumTouchTarget.ToSize())
                        .foregroundColor(.specify(color: .grey5))
//                        .padding(.trailing, goal.title.count == "" ? 0 : -7)
                    if goal != nil && width > 50{
                        VStack(alignment:.leading){
                            Text(goal!.title)
                                .font(.specify(style: .caption))
                                .lineLimit(2)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.specify(color: .grey10))
                            Text(goal!.timeframe.toString())
                                .textCase(.uppercase)
                                .font(.specify(style: .subCaption))
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.specify(color: focusGoal == goalId ? .grey10 : .grey5))
                        }
                        Spacer()
                    }

                }
                .opacity(shouldShowDetails ? 1.0 : 0.0)
                .padding(7)
                .modifier(ModifierCard(color: focusGoal == goalId ? .purple : .grey3))
                .offset(x: offset)
                .frame(width:width < 50 ? 50 : width, height:50)
                
            
                
        }
        .buttonStyle(.plain)
        .onAppear{
//            if shouldShowDetails{
                goal = gs.GetGoal(id: goalId)
//            }

        }
        

        
    }
}

struct BubbleView_Previews: PreviewProvider {
    static var previews: some View {
        BubbleView(goalId: UUID(), focusGoal: .constant(UUID()), width: 3)
            .environmentObject(GoalService())
    }
}
