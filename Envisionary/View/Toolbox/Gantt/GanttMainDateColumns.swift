//
//  GanttDiagram.swift
//  Visionary
//
//  Created by Campbell McGavin on 5/10/22.
//

import SwiftUI

struct GanttMainDateColumns: View {
    
    var dateValues: [DateValue]
    var columnWidth: CGFloat
    var timeframeType: TimeframeType
//    let goalId: UUID
    
    @EnvironmentObject var gs: GoalService
    
    var body: some View {
//        let goal = gs.GetGoal(id: goalId) ?? Goal()
        

        HStack(alignment: .top, spacing:0){
//            Text(goal.startDate.toString(timeframeType: goal.timeframe, isStartDate: goal.timeframe == .week ? true : nil) + " - " + goal.endDate.toString(timeframeType: goal.timeframe, isStartDate: goal.timeframe == .week ? false : nil))
//                .frame(width:columnWidth * 2)
//                .foregroundColor(.specify(color: .grey10))
//                .font(.specify(style: .h6))
//                .padding(.top,2)
//                .padding(.leading,25)
            ForEach(dateValues){dateValue in
                GanttMainDateColumn(dateValue: dateValue, frameWidth: columnWidth, timeframe: timeframeType)
            }
        }
        .padding(.trailing,200)
        .padding(.leading,30)
    }
}

struct GanttMainDateColumns_Previews: PreviewProvider {
    static var previews: some View {
        GanttMainDateColumns(dateValues: [DateValue](), columnWidth: 100, timeframeType: .day)//, goalId: UUID())
    }
}
