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
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {

        LazyHStack(alignment: .top, spacing:0){
            ForEach(dateValues){dateValue in
                GanttMainDateColumn(dateValue: dateValue, frameWidth: columnWidth, timeframe: timeframeType)
                    .id(dateValue.id)
                    .frame(maxHeight:.infinity)
            }
        }
        .padding(.trailing,200)
        .padding(.leading,30)
        .frame(maxHeight:.infinity)
        
    }
}

struct GanttMainDateColumns_Previews: PreviewProvider {
    static var previews: some View {
        GanttMainDateColumns(dateValues: [DateValue](), columnWidth: 100, timeframeType: .day)//, goalId: UUID())
    }
}