//
//  CalendarPicker.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/20/23.
//

import SwiftUI

struct CalendarPicker: View {
    
    @EnvironmentObject var vm: ViewModel
    @Binding var date: Date
    @Binding var timeframeType: TimeframeType
    
    var localized: Bool
    
    
    var body: some View {
        VStack{
            
            CalendarPickerHeader(date: $date, timeframeType: $timeframeType, localized: localized)
            CalendarPickerBody(date: $date, timeframe: $timeframeType, localized: localized)
        }
    }
}

struct CalendarPicker_Previews: PreviewProvider {
    static var previews: some View {
        CalendarPicker(date: .constant(Date()), timeframeType: .constant(TimeframeType.day), localized: true)
    }
}
