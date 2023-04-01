//
//  DateResetButton.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/30/23.
//

import SwiftUI

struct DateResetButton: View {
    @EnvironmentObject var dm: DataModel
    @State var shouldGoToToday: Bool = false
    
    var body: some View {
        VStack(spacing:0){
            if dm.date.isInThisTimeframe(timeframe: dm.timeframeType){
                IconLabel(size: .extraSmall, iconType: .confirm, iconColor: .grey10, circleColor: .grey10, opacity: 0.2, circleOpacity: 0.07)
            }
            else{
                IconButton(isPressed: $shouldGoToToday, size: .extraSmall, iconType: .undo, iconColor: .grey10, circleColor: .grey10, opacity: 0.9, circleOpacity: 0.1)
            }
        }
        .frame(width:25)
        .onChange(of: shouldGoToToday){
            _ in
            dm.pushToToday = true
            dm.date = Date()
        }
        
    }
}
