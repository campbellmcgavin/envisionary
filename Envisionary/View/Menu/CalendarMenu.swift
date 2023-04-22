//
//  CalendarMenu.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/21/23.
//

import SwiftUI

struct CalendarMenu: View {
    @EnvironmentObject var vm: ViewModel
    
    @State var shouldMoveDateForward = false
    @State var shouldMoveDateBackward = false
    @State var isPresentingExpandedCalendar = false
    
    var body: some View {
        
        VStack(spacing:0){
            
            if(ShouldShowCalendar()){
                
                VStack{
                    // headers
                    HStack(spacing:0){
                        VStack(alignment: .leading, spacing: 0){
                            Text(vm.filtering.filterTimeframe.toString())
                                .textCase(.uppercase)
                                .font(.specify(style: .caption))
                                .foregroundColor(.specify(color: .grey4))
                                .padding(.bottom,-3)
                            Text(vm.filtering.filterDate.toString(timeframeType: vm.filtering.filterTimeframe))
                                .font(.specify(style: .h3))
                                .foregroundColor(.specify(color: .grey9))
                        }
                        
                        Spacer()
                        if ShouldShowDates(){
                            IconButton(isPressed: $shouldMoveDateBackward, size: .small, iconType: .left, iconColor: .grey9)
                            IconButton(isPressed: $shouldMoveDateForward, size: .small, iconType: .right, iconColor: .grey9)
                        }
                    }
                    .padding(.trailing,-12)
                    .padding(.top,12)
                    
                    //timeframe picker
                    VStack(alignment:.center, spacing:0){
                        ScrollPickerTimeframe()
                            .padding(.bottom,ShouldShowDates() ? 0 : 8)
                            .padding(.top,-10)
                        if(ShouldShowDates()){
                            
                            //dates
                            if isPresentingExpandedCalendar{
                                CalendarPickerBody(date: $vm.filtering.filterDate, timeframe: $vm.filtering.filterTimeframe, localized: false)
                                    .padding(.top,10)
                            }
                            
                            //mini dates
                            else{
                                ScrollPickerDates()
//                                    .padding(.top,5)
                            }
                            
                            IconButton(isPressed: $isPresentingExpandedCalendar, size: .small, iconType: .down, iconColor: .grey10)
                                .rotationEffect(Angle(degrees: isPresentingExpandedCalendar ? 180 : 0))
                            
                        }
                    }
                    //                    .padding(.bottom,15)
                }
                //                .offset(y:-15)
            }
            
        }
//        .padding(.bottom, ShouldShowCalendar() ? 0 : 25)
        .frame(maxWidth:.infinity, alignment:.center)
        .padding([.leading,.trailing])

//        .frame(height:50)
        .background(
            Color.specify(color: .grey1)
                .modifier(ModifierRoundedCorners(radius: 36))
                .edgesIgnoringSafeArea(.all)
                .padding(.top,-400)
//                .frame(maxHeight:.infinity)
        )
            .onChange(of:shouldMoveDateForward){
                _ in
                if shouldMoveDateForward{
                    vm.filtering.filterDate = vm.filtering.filterDate.AdvanceDate(timeframe: vm.filtering.filterTimeframe, forward: true)
                }
                shouldMoveDateForward = false
            }
            .onChange(of:shouldMoveDateBackward){
                _ in
                if shouldMoveDateBackward{
                    vm.filtering.filterDate = vm.filtering.filterDate.AdvanceDate(timeframe: vm.filtering.filterTimeframe, forward: false)
                }
                shouldMoveDateBackward = false
            }
                .transition(.move(edge:.bottom))
                .animation(.easeInOut)

    }
    
    func ShouldShowCalendar() -> Bool{
        
        switch vm.filtering.filterObject {
        case .value:
            return false
        case .creed:
            return false
        case .aspect:
            return false
        case .goal:
            return true
        case .session:
            return true
        case .task:
            return true
        case .habit:
            return true
        case .home:
            return false
        case .chapter:
            return false
        case .entry:
            return true
        case .stats:
            return false
        case .emotion:
            return true
        case .dream:
            return false
        }
    }
    
    func ShouldShowDates() -> Bool{
        
        switch vm.filtering.filterObject {
        case .value:
            return false
        case .creed:
            return false
        case .aspect:
            return false
        case .goal:
            return true
        case .session:
            return false
        case .task:
            return true
        case .habit:
            return true
        case .home:
            return false
        case .chapter:
            return false
        case .entry:
            return true
        case .stats:
            return false
        case .emotion:
            return true
        case .dream:
            return false
        }
    }
}

struct CalendarMenu_Previews: PreviewProvider {
    static var previews: some View {
        CalendarMenu()
    }
}
