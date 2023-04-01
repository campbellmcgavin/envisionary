//
//  DateColumn.swift
//  Visionary
//
//  Created by Campbell McGavin on 5/10/22.
//

import SwiftUI

struct GanttMainDateColumn: View {
    let dateValue: DateValue
    let frameWidth: CGFloat
    let timeframe: TimeframeType
    
    var body: some View {
        VStack{
            ScrollPickerDateText(dateValue: dateValue, frameWidth: frameWidth - 20, filterTimeframe: timeframe, selectionDate: .constant(dateValue.date), isLight: false, showBubble: false)
            HStack{
                Spacer()
                Divider()
                Spacer()
            }
            .frame(alignment:.center)
        }
        .frame(alignment:.center)
        .frame(width:frameWidth)
    }
}

struct DateColumn_Previews: PreviewProvider {
    static var previews: some View {
        GanttMainDateColumn(dateValue: DateValue(day: 0, date: Date()), frameWidth: 100, timeframe: .decade)
    }
}
