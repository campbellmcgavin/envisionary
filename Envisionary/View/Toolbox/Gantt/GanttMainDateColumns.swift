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
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {

        HStack(alignment: .top, spacing:0){
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
