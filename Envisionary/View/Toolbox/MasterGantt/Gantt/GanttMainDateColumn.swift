//
//  DateColumn.swift
//  Visionary
//
//  Created by Campbell McGavin on 5/10/22.
//

import SwiftUI

struct GanttMainDateColumn: View {
    let dateValue: DateValue
    var frameWidth: CGFloat
    var timeframe: TimeframeType
    
    var body: some View {
        VStack{
            ScrollPickerDateText(dateValue: dateValue, frameWidth: frameWidth - 20, filterTimeframe: timeframe, selectionDate: .constant(dateValue.date), isLight: false, showBubble: false)
                .frame(height:SizeType.medium.ToSize() + 10)
              
            
            HStack{
                Spacer()
                Divider()
                Spacer()
            }
            .padding(.top,35)
            .padding(.bottom,-100)
            .frame(alignment:.center)
            .frame(maxHeight:.infinity)
        }
        .frame(alignment:.center)
        .frame(width:frameWidth)
        .frame(maxHeight:.infinity)
    }
}

struct DateColumn_Previews: PreviewProvider {
    static var previews: some View {
        GanttMainDateColumn(dateValue: DateValue(day: 0, date: Date()), frameWidth: SizeType.ganttColumnWidth.ToSize(), timeframe: .decade)
    }
}
