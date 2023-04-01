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
        
    @State var goal: Goal = Goal()
    @EnvironmentObject var gs: GoalService
    var body: some View {

            Button{
                withAnimation{
                    if focusGoal == goal.id {
                        focusGoal = UUID()
                    }
                    else {
                        focusGoal = goal.id
                    }
                }
            }

        label:{
                HStack{
                    Circle()
                        .frame(width:SizeType.minimumTouchTarget.ToSize(), height: SizeType.minimumTouchTarget.ToSize())
                        .foregroundColor(.specify(color: .grey5))
                    VStack(alignment:.leading){
                        Text(goal.title)
                            .font(.specify(style: .caption))
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.specify(color: .grey10))
                        Text(goal.timeframe.toString())
                            .textCase(.uppercase)
                            .font(.specify(style: .subCaption))
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.specify(color: focusGoal == goal.id ? .grey10 : .grey5))
                    }
                    Spacer()
                }
                .padding(7)
                .modifier(ModifierCard(color: focusGoal == goal.id ? .purple : .grey3))
                .frame(width:180)
                .frame(height:50)
                
            
                
        }
        .buttonStyle(.plain)
        .onAppear{
            goal = gs.GetGoal(id: goalId) ?? Goal()
        }
        

        
    }
}

struct BubbleView_Previews: PreviewProvider {
    static var previews: some View {
        BubbleView(goalId: UUID(), focusGoal: .constant(UUID()))
            .environmentObject(GoalService())
    }
}
