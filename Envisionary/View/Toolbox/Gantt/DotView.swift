//
//  DotView.swift
//  Visionary
//
//  Created by Campbell McGavin on 2/4/22.
//

import SwiftUI

struct DotView: View {
    let goalId: UUID
    @Binding var focusGoal: UUID
    @State var goal: Goal = Goal()
    @EnvironmentObject var gs: GoalService
    var body: some View {

        HStack{
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
                ZStack{
                    Circle()
                        .frame(width:SizeType.minimumTouchTarget.ToSize() + 14, height: SizeType.minimumTouchTarget.ToSize() + 14)
                        .foregroundColor(.specify(color: focusGoal != goalId ? .grey3 : .purple))
                    Circle()
                        .frame(width:SizeType.minimumTouchTarget.ToSize(), height: SizeType.minimumTouchTarget.ToSize())
                        .foregroundColor(.specify(color: .grey5))
                    
                }
                .padding(7)
                .frame(width:50, height:50)
                    
                
                    
            }
            .buttonStyle(.plain)
            .onAppear{
                    goal = gs.GetGoal(id: goalId) ?? Goal()
            }
            .padding(.trailing,3)
            HStack(spacing:0){
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
                        .foregroundColor(.specify(color: focusGoal == goalId ? .grey10 : .grey5))
                }
                Spacer()
            }
        }
        .frame(width:180)
    }
}

struct DotView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(1...30, id:\.self){
                        number in
                            Text(String(number))
                    }
                }

            }
            DotView(goalId: UUID(), focusGoal: .constant(UUID()))
                .environmentObject(GoalService())
        }
        
    }
}
