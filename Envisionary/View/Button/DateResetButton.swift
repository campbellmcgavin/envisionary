//
//  DateResetButton.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/30/23.
//

import SwiftUI

struct DateResetButton: View {
    @EnvironmentObject var vm: ViewModel
    @State var shouldGoToToday: Bool = false
    
    var body: some View {
        VStack(spacing:0){
            if vm.filtering.filterDate.isInThisTimeframe(timeframe: vm.filtering.filterTimeframe){
                IconLabel(size: .extraSmall, iconType: .confirm, iconColor: .grey10, circleColor: .grey10, opacity: 0.2, circleOpacity: 0.07)
            }
            else{
                IconButton(isPressed: $shouldGoToToday, size: .extraSmall, iconType: .undo, iconColor: .grey10, circleColor: .grey10, opacity: 0.9, circleOpacity: 0.1)
            }
        }
        .frame(width:25)
        .onChange(of: shouldGoToToday){
            _ in
            vm.pushToToday = true
            vm.filtering.filterDate = Date()
        }
        
    }
}
