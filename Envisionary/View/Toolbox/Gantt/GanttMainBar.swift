//
//  BarView.swift
//  Visionary
//
//  Created by Campbell McGavin on 5/10/22.
//

import SwiftUI

struct GanttMainBar: View {
    
    @EnvironmentObject var dataModel: DataModel
    @Binding var focusGoal: UUID
    let width: CGFloat
    let offsetX: CGFloat
    var goal: Goal
    let height: CGFloat = 30
    
    
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
        ZStack(alignment:.leading){
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .fill(focusGoal == goal.id ? Color.specify(color: .foregroundSelected) : Color.specify(color: .foregroundTertiary))
                .frame(width: width < 20 ? 20 : width, height: height)

            
            HStack{
                LabelGoalImage(goal: goal, propertyType: .timeframe)
                    .environmentObject(dataModel)
                Text(goal.title)
            }
                .padding(.leading,10)
        }
        .padding([.top,.bottom],1)
    }
    .offset(x: offsetX)
    .buttonStyle(.plain)


    }
}

struct BarView_Previews: PreviewProvider {
    static var previews: some View {
        GanttMainBar(focusGoal: .constant(UUID()), width: 300, offsetX: 0, goal: Goal.sampleGoals[0])
            .environmentObject(DataModel())
    }
}
