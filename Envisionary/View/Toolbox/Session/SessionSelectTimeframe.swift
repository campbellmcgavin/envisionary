//
//  DetailPlanningSessionOverview.swift
//  Visionary
//
//  Created by Campbell McGavin on 8/15/22.
//

import SwiftUI

struct SessionSelectTimeframe: View {
    @Binding var timeframe: TimeframeType
    @Binding var date: Date
    @State var isExpanded: Bool = true
    
    @State var timeframeString: String = ""
    
    let isDisabled: Bool
    
    var body: some View {
        
        VStack{
            FormStackPicker(fieldValue: $timeframeString, fieldName: PropertyType.timeframe.toString(), options: .constant(TimeframeType.allCases.filter({$0 != .day}).map({$0.toString()})), iconType: .timeframe)
            FormCalendarPicker(fieldValue: $date, fieldName: PropertyType.startDate.toString(), timeframeType: timeframe, iconType: .timeframe)
        }
        .onAppear(){
            timeframeString = timeframe.toString()
        }
        .onChange(of: timeframeString){
            _ in
            timeframe = TimeframeType.fromString(input: timeframeString)
        }
    }
}

//struct PlanningSessionOverview_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailPlanningSessionOverview()
//    }
//}
