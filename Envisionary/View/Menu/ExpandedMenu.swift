//
//  ExpandedMenu.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/9/23.
//

import SwiftUI

struct ExpandedMenu: View {
    @EnvironmentObject var dm: DataModel
    @Binding var offset: CGFloat
    @Binding var frame: CGSize
    let radius: CGFloat = 36

    @State var shouldMoveDateForward = false
    @State var shouldMoveDateBackward = false
    @State var isPresentingExpandedCalendar = false

    var body: some View {
        
        VStack(alignment:.leading, spacing:0){
            
            VStack(alignment:.leading,spacing:0){
                Text(dm.contentType.toString())
                    .textCase(.uppercase)
                    .font(.specify(style: .caption))
                    .opacity(0.5)
                    .padding(.bottom,-10)
                Text(dm.objectType.toPluralString())

                    .font(.specify(style: .h1))
                    .padding(.bottom,-5)
            }
            .scaleEffect(offset > 0 ?  1.0 : 1.0 - 0.001 * offset, anchor: .bottomLeading)

            
            
            VStack(alignment:.center){
                ScrollPickerObject(objectType: $dm.objectType, isSearch: false)
//                        .padding(.top,5)
                
            }
            .padding(.bottom, ShouldShowCalendar() ? 5 : 17)
//            .padding(.bottom,10)
            
            if(ShouldShowCalendar()){
                HStack(spacing:0){
                    VStack(alignment: .leading, spacing: 0){
                        Text(dm.timeframeType.toString())
                            .textCase(.uppercase)
                            .font(.specify(style: .caption))
                            .opacity(0.5)
                            .padding(.bottom,-8)
                        HStack{
                            
                            Text(dm.date.toString(timeframeType: dm.timeframeType))
                                .font(.specify(style: .h3))
                            
                            DateResetButton()
                        }
   
                    }

                    Spacer()
                    if ShouldShowDates(){
                        IconButton(isPressed: $shouldMoveDateBackward, size: .small, iconType: .left, iconColor: .grey10)
                        IconButton(isPressed: $shouldMoveDateForward, size: .small, iconType: .right, iconColor: .grey10)
                    }
                }
                .padding(.trailing,-12)
                .padding(.top,10)
                VStack(alignment:.center, spacing:0){
                    ScrollPickerTimeframe()
//                        .padding(.top,10)
                        .padding(.bottom,ShouldShowDates() ? 0 : 20)
                    if(ShouldShowDates()){

                        if isPresentingExpandedCalendar{
                            CalendarPickerBody(date: $dm.date, timeframe: $dm.timeframeType, localized: false)
                                .padding(.top,20)
                                .padding(.bottom,10)
                        }
                        else{
                            ScrollPickerDates()
                                .padding(.top,0)
                        }

                        HStack{
//                            IconButton(isPressed: .constant(false), size: .small, iconType: .down, iconColor: .grey10)
//                                .disabled(true)
//                                .opacity(0)
//                            Spacer()
                            IconButton(isPressed: $isPresentingExpandedCalendar, size: .small, iconType: .down, iconColor: .grey10)
                                .rotationEffect(Angle(degrees: isPresentingExpandedCalendar ? 180 : 0))
                            
//                            Spacer()
                            

                            
                            
                        }

                    }
                }

                .frame(maxWidth:.infinity, alignment:.center)
            }

        }
        .frame(maxWidth:.infinity, alignment:.leading)
        .padding([.leading,.trailing])
        .foregroundColor(.specify(color: .grey10))
        .opacity(GetOpacity())
        .background(
            Color.specify(color: .purple)
                .modifier(ModifierRoundedCorners(radius: GetRadius()))
                .edgesIgnoringSafeArea(.all)
                .padding(.top,-1000)
                .frame(maxHeight:.infinity))
        .onChange(of:shouldMoveDateForward){
            _ in
            if shouldMoveDateForward{
                dm.pushToToday = true
                dm.date = dm.date.AdvanceDate(timeframe: dm.timeframeType, forward: true)
            }
            shouldMoveDateForward = false
        }
        .onChange(of:shouldMoveDateBackward){
            _ in
            if shouldMoveDateBackward{
                dm.pushToToday = true
                dm.date = dm.date.AdvanceDate(timeframe: dm.timeframeType, forward: false)
            }
            shouldMoveDateBackward = false
        }
        .transition(.move(edge:.bottom))
        .animation(.easeInOut)
    }
    
    func GetOpacity() -> CGFloat{
        if offset > 0 {
            let num = 1.0 - ((1.0 * offset/frame.height*2))
            if num < 0 {
                return 0
            }
            return num
        }
        return 1.0
    }
    
    func GetRadius() -> CGFloat{
        if offset > 0 {
            return abs( 36 - ((36 * offset/frame.height)))
        }
        return 36
    }
    
    func ShouldShowCalendar() -> Bool{

        switch dm.objectType {
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

        switch dm.objectType {
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

struct ExpandedMenu_Previews: PreviewProvider {
    static var previews: some View {
        ExpandedMenu(offset: .constant(30), frame: .constant(CGSize(width: 100, height: 370)))
            .environmentObject(DataModel())
    }
}
