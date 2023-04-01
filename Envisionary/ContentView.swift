//
//  ContentView.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/7/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dm: DataModel
    @EnvironmentObject var gs: GoalService
    
    @StateObject var alerts = AlertsService()
    
    @State var offset: CGPoint = CGPoint(x: 0, y: 0)
    @State var offsetRate: CGPoint = CGPoint(x: 0, y: 0)
//    @State var headers = [String]()
    @State var filteredObjectsDictionary = [String:[UUID]]()
    @State var objectFrame: CGSize = .zero
    @State var calendarFrame: CGSize = .zero
    @State var headerFrame: CGSize = .zero
    @State var gadgetFrame: CGSize = .zero
    @State var shouldExpandAll: Bool = true
    @State var screenHeight: CGSize = .zero
    @State var shouldPopScrollToHideHeader: Bool = false
    @State var isPresentingModal: Bool = false
    @State var isPresentingMainMenu: Bool = false
    @State var modalType: ModalType = .add
    @State private var scrollViewID = 1
    @State var isPresentingSplashScreen = true
    @State private var splashScreenTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var popHeaderTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var shouldDisableScrollViewTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State var filterCount = 0
    @State var shouldDisableScrollView = false
    
    var body: some View {
        NavigationStack{
            ZStack(alignment:.top){

                    
                    VStack(spacing:0){
                        
                        ScrollViewReader{
                            proxy in
                            ObservableScrollView(offset: $offset, content:{
                                
                                VStack{
                                    Spacer()
                                        .frame(height:0)
                                        .offset(y:-150)
                                        .id(0)
                                    ZStack(alignment:.top){
                                        
                                        GadgetsMenu(shouldPop: $shouldPopScrollToHideHeader, offset: $offset, isPresentingModal: $isPresentingModal, modalType: $modalType, filterCount: dm.filterCount)
                                            .offset(y:GetGadgetsOffset())
                                            .saveSize(in: $gadgetFrame)
                                        
                                        ExpandedMenu(offset: $offset.y, frame: $objectFrame)
                                            .saveSize(in: $objectFrame)
                                            .offset(y:GetObjectOffset())
                                    }
                                    
                                    
                                    
                                    VStack(spacing:0){
                                        
                                        Spacer()
                                            .frame(height:60)
                                            .offset(y:45)
                                            .id(1)
                                        
                                        ForEach(alerts.alerts){
                                            alert in
                                            AlertLabel(alert: alert)
                                        }
                                        
                                        
                                        GroupBySectionBuilder()

  
                                        
                                    }
                                        .padding(.top,GetStackOffset())

                                }
                                .onChange(of: shouldPopScrollToHideHeader){
                                    _ in
                                    withAnimation{
                                        proxy.scrollTo(1, anchor:.top)
                                        let impact = UIImpactFeedbackGenerator(style: .heavy)
                                              impact.impactOccurred()
                                    }
                                }
                                
                                .onChange(of: dm.contentType){ _ in
                                    withAnimation{
                                        proxy.scrollTo(0, anchor:.top)
                                        let impact = UIImpactFeedbackGenerator(style: .heavy)
                                              impact.impactOccurred()
                                    }
                                }
                                .onReceive(popHeaderTimer){ _ in
                                    withAnimation{
                                        
                                        
                                        popHeaderTimer.upstream.connect().cancel()
                                        shouldDisableScrollViewTimer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
                                        shouldDisableScrollView = true
                                        if offsetRate.y < 0 && offset.y < gadgetFrame.height + objectFrame.height {
                                            proxy.scrollTo(0, anchor:.top)
                                        }
                                        else{
                                            proxy.scrollTo(1, anchor:.top)
                                        }
                                        let impact = UIImpactFeedbackGenerator(style: .heavy)
                                              impact.impactOccurred()
                                    }
                                }
                                .frame(alignment:.top)
                               
                                Spacer()
                                    .frame(height:UIScreen.screenHeight)
                            })
                            .disabled(shouldDisableScrollView)
                        }
                    }
                    .frame(alignment:.top)

                
                //navigation
                VStack(spacing:0){
                    TopNavigationBar(offset: $offset.y, isPresentingMainMenu: $isPresentingMainMenu)
                    
                    Spacer()
                    
                    if (ShouldShowFloatingActionButton()){
                        FloatingActionButton(isPresentingModal: $isPresentingModal, modalType: $modalType)
                    }

                    BottomNavigationBar(selectedContentView: $dm.contentType)
                }

                ModalManager(isPresenting: $isPresentingModal, modalType: $modalType, objectType: dm.objectType, shouldDelete: .constant(false))
                
                SplashScreen(isPresenting: $isPresentingSplashScreen)
                
            }
            .background(Color.specify(color: .grey0))
            .saveSize(in:$screenHeight)
            .onReceive(splashScreenTimer){ _ in
                isPresentingSplashScreen = false
                splashScreenTimer.upstream.connect().cancel()
            }
            .onReceive(shouldDisableScrollViewTimer){ _ in
                shouldDisableScrollView = false
            }
            .onChange(of: dm.contentType){
                _ in
                withAnimation{
                    alerts.UpdateContentAlerts(content: dm.contentType)
                    UpdateFilteredObjectsDictionary()
                }
            }
            .onChange(of: gs.goalsDictionary){
                _ in
                withAnimation{
                    UpdateFilteredObjectsDictionary()
                }
            }
            .onChange(of: dm.objectType){
                _ in
                withAnimation{
                    alerts.UpdateObjectAlerts(object: dm.objectType)
                    alerts.UpdateCalendarAlerts(object: dm.objectType, timeframe: dm.timeframeType, date: dm.date)
                    UpdateFilteredObjectsDictionary()
                }
            }
            .onChange(of: dm.timeframeType){ _ in
                withAnimation{
                    alerts.UpdateCalendarAlerts(object: dm.objectType, timeframe: dm.timeframeType, date: dm.date)
                    UpdateFilteredObjectsDictionary()
                }
            }
            .onChange(of: dm.date){ _ in
                withAnimation{
                    alerts.UpdateCalendarAlerts(object: dm.objectType, timeframe: dm.timeframeType, date: dm.date)
                    UpdateFilteredObjectsDictionary()
                }
            }
            .onChange(of: offset){ [offset] newOffset in
                                
                DispatchQueue.global(qos:.userInteractive).async{
                    
                    if abs(newOffset.y - offset.y) > 3{
                        offsetRate = CGPoint(x: newOffset.x - offset.x, y: newOffset.y - offset.y)
                    }

                    
                    if offset.y < (objectFrame.height + gadgetFrame.height) + 100 && offset.y > 20 && abs(offset.y - (objectFrame.height + gadgetFrame.height)) > 10 {
                        popHeaderTimer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
                    }
                    else{
                        popHeaderTimer.upstream.connect().cancel()
                    }
                }
            }
            .onAppear{
                withAnimation{
                    alerts.UpdateContentAlerts(content: dm.contentType)
                    alerts.UpdateObjectAlerts(object: dm.objectType)
                    alerts.UpdateCalendarAlerts(object: dm.objectType, timeframe: dm.timeframeType, date: dm.date)
                }
                popHeaderTimer.upstream.connect().cancel()
                UpdateFilteredObjectsDictionary()
            }
        }

    }
    
    func UpdateFilteredObjectsDictionary() {
        
        filteredObjectsDictionary = gs.UpdateFilteredGoals(criteria: dm.GetFilterCriteria())

    }
    
    @ViewBuilder
    func GroupBySectionBuilder() -> some View{
           
        VStack(spacing:0){
            let headers: [String] = filteredObjectsDictionary.keys.map({$0.self}).sorted()
            
            if headers.count > 0 {
                ParentHeaderButton(shouldExpandAll: $shouldExpandAll, color: .purple, header: "Expand All", headerCollapsed: "Collapse All")
                            
                LazyVStack(spacing:0){
                    ForEach(headers, id:\.self){ listHeader in
                        
                        VStack(spacing:0){
                            HeaderWithContent(shouldExpand: $shouldExpandAll, headerColor: .grey10, header: listHeader, isExpanded: shouldExpandAll, content: {
                                VStack(spacing:0){
//                                    ForEach(headers, id:\.self){ item in
                                        
                                        GroupBySectionBuilderHelper(header: listHeader)
                                                                               
                                        
//                                    }
                                }
                                .modifier(ModifierCard())
                                
                            })
                            
                        }
                    }
                    
                }
            }
            else{
                if dm.objectType != .home && dm.objectType != .stats{
                    NoObjectsLabel(objectType: dm.objectType)
                }

            }
        }
        

    }
    
    @ViewBuilder
    func GroupBySectionBuilderHelper(header: String) -> some View{
        
        if let listOfObjectFromGroupBy = filteredObjectsDictionary[header]
        {
            ForEach(listOfObjectFromGroupBy, id: \.self){ goalId in
                if let goal = gs.goalsDictionary[goalId] {
                    PhotoCard(objectType: .goal, objectId: goalId, properties: Properties(goal:goal), header: goal.title, subheader: goal.description, caption: goal.startDate.toString(timeframeType: goal.timeframe, isStartDate: goal.timeframe == .week ? true : nil) + " - " + goal.endDate.toString(timeframeType: goal.timeframe, isStartDate: goal.timeframe == .week ? false : nil))
                    
                    if listOfObjectFromGroupBy.last != goalId{
                        Divider()
                            .overlay(Color.specify(color: .grey2))
                            .frame(height:1)
                            .padding(.leading,16+50+16)
                    }
                }
            }
        }
    }
    
    func ShouldShowFloatingActionButton() -> Bool{
        
        if dm.objectType != .home {
            return true
        }
        return false
    }

    @ViewBuilder
    func GetModalContent() -> some View {
        switch modalType {
        case .add:
            Text("Add new object")
        case .search:
            Text("Search")
        case .group:
            Text("Group")
        case .filter:
            Text("Filter")
        case .notifications:
            Text("Notifications")
        case .help:
            Text("Help")
        case .edit:
            Text("Edit")
        case .delete:
            Text("Delete")
        }
    }
    
    func GetObjectOffset() -> CGFloat {
        return 40
    }
    
    func GetCalendarOffset() -> CGFloat {
        if offset.y < 0 {
            return objectFrame.height + GetObjectOffset() - offset.y * 0.1
        }
        return objectFrame.height + GetObjectOffset()
    }
    
    func GetGadgetsOffset() -> CGFloat {
        
        if offset.y < 0 {
            return GetCalendarOffset() + calendarFrame.height - offset.y * 0.2
        }
        return GetCalendarOffset() + calendarFrame.height
    }
    
    func GetStackOffset() -> CGFloat {
        if offset.y < 0 {
            return -offset.y * 0.3 + 40
        }
        return  40
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataModel())
    }
}
