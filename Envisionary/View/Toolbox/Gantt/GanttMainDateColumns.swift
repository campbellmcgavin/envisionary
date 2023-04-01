//
//  GanttDiagram.swift
//  Visionary
//
//  Created by Campbell McGavin on 5/10/22.
//

import SwiftUI

struct GanttMainDateColumns: View {
    
    @Binding var dateValues: [DateValue]
    let columnWidth: CGFloat
    let timeframeType: TimeframeType
    
    var body: some View {

        HStack(spacing:0){
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
        GanttMainDateColumns(dateValues: .constant([DateValue]()), columnWidth: 100, timeframeType: .day)
    }
}
