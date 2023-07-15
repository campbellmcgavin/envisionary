//
//  ContentViewStack.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/16/23.
//

import SwiftUI

struct ContentViewStack: View {
    @EnvironmentObject var vm: ViewModel
    @Binding var isPresenting: Bool
    @Binding var modalType: ModalType
    
    @State var shouldExpandAll: Bool = true
    @StateObject var alerts = AlertsService()
    @State var isPresentingCalendar = false
    
    @State var headers = [String]()
    @State var propertiesDictionary: [String: [Properties]] = [String: [Properties]]()
    @State var propertiesList: [Properties] = [Properties]()
    
    @State var shouldUnlockObject: Bool = false
    
    
    var body: some View {
        
        VStack{
            if !vm.unlockedObjects.fromObject(object: vm.filtering.filterObject){
                BuildUnlockCard()
            }
            else{
                VStack{
                    AlertsBuilder()
                    
                    let objectType = vm.filtering.filterObject
                    ZStack{
                        if !GetHasContent(){
                            NoObjectsLabel(objectType: objectType, labelType: .page)
                        }
                        else if objectType == .creed{
                                CreedCard()
                                .frame(maxWidth:.infinity)
                                .padding(.top)
                        }
                        else if objectType.shouldGroup(){
                            GroupBuilder()
                        }
                        else{
                            ListBuilder()
                        }
                    }
                }
            }
        }
        .onChange(of: vm.unlockedObjects){ _ in
            vm.UpdateSetupStep()
            alerts.AddSetupUnlockAlert(object: vm.filtering.filterObject)
            UpdateData()
        }
        .onChange(of: shouldUnlockObject){
            _ in
            withAnimation{
                vm.unlockedObjects.unlockObject(object: vm.filtering.filterObject)
            }
        }
        .onAppear(){
            withAnimation{
                alerts.UpdateContentAlerts(content: vm.filtering.filterContent, shouldShow: vm.helpPrompts.content)
                alerts.UpdateObjectAlerts(object: vm.filtering.filterObject, shouldShow: vm.helpPrompts.object)
                
                alerts.UpdateCalendarAlerts(object: vm.filtering.filterObject, timeframe: vm.filtering.filterTimeframe, date: vm.filtering.filterDate, shouldShow: vm.helpPrompts.showing)
            }
            UpdateData()
        }
        .onChange(of: vm.helpPrompts){ _ in
            alerts.UpdateContentAlerts(content: vm.filtering.filterContent, shouldShow: vm.helpPrompts.content)
            alerts.UpdateObjectAlerts(object: vm.filtering.filterObject, shouldShow: vm.helpPrompts.object)
            alerts.UpdateCalendarAlerts(object: vm.filtering.filterObject, timeframe: vm.filtering.filterTimeframe, date: vm.filtering.filterDate, shouldShow: vm.helpPrompts.showing)
        }
        .onChange(of: vm.filtering){
            _ in
            UpdateData()
        }
        .onChange(of: vm.updates){
            _ in
            UpdateData()
        }
        .onChange(of: vm.grouping){
            _ in
            UpdateData()
        }
        .onChange(of: vm.filtering.filterContent){
            _ in
            shouldExpandAll = true
            withAnimation{
                alerts.UpdateContentAlerts(content: vm.filtering.filterContent, shouldShow: vm.helpPrompts.content)
            }
        }
        .onChange(of: vm.filtering.filterObject){
            _ in
            withAnimation{
                alerts.UpdateObjectAlerts(object: vm.filtering.filterObject, shouldShow: vm.helpPrompts.object)
                alerts.UpdateCalendarAlerts(object: vm.filtering.filterObject, timeframe: vm.filtering.filterTimeframe, date: vm.filtering.filterDate, shouldShow: vm.helpPrompts.showing)
            }
        }
        .onChange(of: vm.filtering.filterTimeframe){ _ in
            withAnimation{
                alerts.UpdateCalendarAlerts(object: vm.filtering.filterObject, timeframe: vm.filtering.filterTimeframe, date: vm.filtering.filterDate, shouldShow: vm.helpPrompts.showing)
            }
        }
        .onChange(of: vm.filtering.filterDate){ _ in
            withAnimation{
                alerts.UpdateCalendarAlerts(object: vm.filtering.filterObject, timeframe: vm.filtering.filterTimeframe, date: vm.filtering.filterDate, shouldShow: vm.helpPrompts.showing)
            }
        }
    }
    
    @ViewBuilder
    func AlertsBuilder() -> some View{
        VStack(spacing:0){
            ForEach(alerts.alerts){
                alert in
                AlertLabel(alert: alert)
            }
        }
        .environmentObject(alerts)
        .padding(.top)
    }
    
    @ViewBuilder
    func BuildUnlockCard() -> some View{
        VStack(alignment:.leading){
            
            ForEach(vm.filtering.filterObject.toTextArray(), id:\.self){
                text in
                Text(text)
                    .multilineTextAlignment(.leading)
                    .frame(alignment:.leading)
                    .font(.specify(style: .h5))
                    .foregroundColor(.specify(color: .grey9))
                    .frame(maxWidth:.infinity, alignment:.leading)
                    .padding()
                    .modifier(ModifierForm(color:.grey2))
                    .padding([.leading,.trailing], 8)
            }
            
            if vm.filtering.filterObject != .session && vm.filtering.filterObject != .home && vm.filtering.filterObject != .entry && vm.filtering.filterObject != .goal{
                
                let text = vm.filtering.filterObject == .creed ? "We built out your " + vm.filtering.filterObject.toPluralString().lowercased() + " based on the values for your archetype, the " + vm.archetype.toString() : "We built out your " + vm.filtering.filterObject.toPluralString() + " based on your archetype, the " + vm.archetype.toString()
                Text(text)
                    .multilineTextAlignment(.leading)
                    .frame(alignment:.leading)
                    .font(.specify(style: .h5))
                    .foregroundColor(.specify(color: .grey9))
                    .frame(maxWidth:.infinity, alignment:.leading)
                    .padding()
                    .modifier(ModifierForm(color:.grey2))
                    .padding([.leading,.trailing], 8)
            }
            
            TextButton(isPressed: $shouldUnlockObject, text: "Unlock " + vm.filtering.filterObject.toPluralString(), color: .grey0, backgroundColor: .grey10, style:.h3, shouldHaveBackground: true, shouldFill: true)
                
        }
        .padding([.top, .bottom],8)
        .modifier(ModifierCard())
    }
    
    func UpdateData(){
        withAnimation{
            switch vm.filtering.filterObject {
            case .value:
                propertiesList = vm.ListCoreValues(criteria: vm.filtering.GetFilters()).sorted(by: {$0.title < $1.title}).map({Properties(value: $0)})
            case .creed:
                propertiesList = vm.ListCoreValues(criteria: vm.filtering.GetFilters()).sorted(by: {$0.title < $1.title}).filter({$0.title != ValueType.Introduction.toString() && $0.title != ValueType.Conclusion.toString()}).map({Properties(value: $0)})
            case .dream:
                propertiesDictionary = vm.GroupDreams(criteria: vm.filtering.GetFilters(), grouping: vm.grouping.dream).mapValues({$0.map({Properties(dream: $0)})})
            case .aspect:
                propertiesList = vm.ListAspects(criteria: vm.filtering.GetFilters()).sorted(by: {$0.title < $1.title}).map({Properties(aspect: $0)})
            case .goal:
                propertiesDictionary = vm.GroupGoals(criteria: vm.filtering.GetFilters(), grouping: vm.grouping.goal).mapValues({$0.map({Properties(goal: $0)})})
            case .chapter:
                propertiesDictionary = vm.GroupChapters(criteria: vm.filtering.GetFilters(), grouping: vm.grouping.chapter).mapValues({$0.map({Properties(chapter: $0)})})
            case .entry:
                propertiesDictionary = vm.GroupEntries(criteria: vm.filtering.GetFilters(), grouping: vm.grouping.entry).mapValues({$0.map({Properties(entry: $0)})})
            case .session:
                propertiesList = vm.ListSessions(criteria: vm.filtering.GetFilters()).map({Properties(session: $0)})
            case .home:
                propertiesDictionary.removeAll()
                propertiesDictionary[HomeObjectType.habit.toPluralString()] = vm.ListRecurrences(criteria: GetHabitCriteria()).sorted(by: {!$0.isComplete && $1.isComplete}).map({Properties(recurrence: $0)})
                propertiesDictionary[HomeObjectType.favorite.toPluralString()] = vm.ListPrompts(criteria: Criteria(type: .favorite)).map({Properties(prompt: $0)})
                propertiesDictionary[HomeObjectType.hint.toPluralString()] = vm.ListPrompts(criteria: Criteria(type: .suggestion)).map({Properties(prompt: $0)})
                propertiesDictionary[HomeObjectType.goal.toPluralString()] = vm.ListGoals(criteria: GetTaskCriteria()).sorted(by: {$0.startDate < $1.startDate}).map({Properties(goal: $0)})
            case .habit:
                propertiesDictionary = vm.GroupHabits(criteria: vm.filtering.GetFilters(), grouping: vm.grouping.habit).mapValues({$0.map({Properties(habit: $0)})})
            case .emotion:
                propertiesDictionary = vm.GroupEmotions(criteria: vm.filtering.GetFilters()).mapValues({$0.map({Properties(emotion: $0)})})
            default:
                let _ = "why"
            }
            
            GetHeaders()
        }
    }
    
    func GetHabitCriteria() -> Criteria{
        var criteria = Criteria()
        criteria.date = Date()
        criteria.timeframe = .day
        return criteria
    }
    
    func GetTaskCriteria() -> Criteria{
        var criteria = Criteria()
        criteria.date = Date()
        criteria.timeframe = .day
        return criteria
    }
    
    @ViewBuilder
    func ListBuilder() -> some View{
        VStack(spacing:0){
            ForEach(propertiesList){ properties in
                
                let objectType = vm.filtering.filterObject
                
                if objectType == .value{
                    if properties.title != ValueType.Introduction.toString() && properties.title != ValueType.Conclusion.toString(){
                        PhotoCard(objectType: .value, objectId: properties.id, properties: properties)
                    }
                }
                else{
                    if properties.title != ValueType.Introduction.toString() && properties.title != ValueType.Conclusion.toString(){
                        PhotoCard(objectType: objectType, objectId: properties.id, properties: properties)
                    }
                }

                if propertiesList.last != properties{
                    StackDivider()
                }
            }
        }
        .modifier(ModifierCard())
        .padding(.top)
    }
        
    func GetHasContent() -> Bool{
        if vm.filtering.filterObject.shouldGroup(){
            return propertiesDictionary.keys.count > 0
        }
        else{
            return propertiesList.count > 0
        }
    }
    
    @ViewBuilder
    func HomeBuilder(header: String) -> some View{
        
        if let propertyList = propertiesDictionary[header]{
            if  (header == HomeObjectType.favorite.toPluralString() || header == HomeObjectType.hint.toPluralString()){
                
                ForEach(propertyList){ properties in
                    PromptCard(promptProperties: properties)
                    
                    if propertyList.last != properties{
                        StackDivider()
                    }
                }
            }
            else if header == HomeObjectType.goal.toPluralString(){
                ForEach(propertyList){ properties in
                    GoalTrackingCard(goalId: properties.id)

                    if propertyList.last != properties{
                        StackDivider()
                    }
                }
            }
            else if header == HomeObjectType.habit.toPluralString(){
                ForEach(propertyList){ properties in
                    
                    RecurrenceCard(habitId:  properties.habitId ?? UUID(), recurrenceId: .constant(properties.id), date: .constant(Date()))

                    if propertyList.last != properties{
                        StackDivider()
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func GroupBuilder() -> some View{
            
        VStack(spacing:0){
            let objectType = vm.filtering.filterObject
            
            HStack{
                let count = GetResultCount()
                
                Text("Showing " + String(count) +  (count == 1 ? " result, grouped by " : " results, grouped by ") + vm.grouping.fromObject(object: vm.filtering.filterObject).toPluralString().lowercased())
                    .font(.specify(style: .caption))
                    .foregroundColor(.specify(color: .grey3))
                    .multilineTextAlignment(.leading)
                    .frame(alignment:.leading)
                    .padding(.leading)
                
                Spacer()
            }

            HStack(alignment:.center){
                ParentHeaderButton(shouldExpandAll: $shouldExpandAll, color: .purple, header: "Expand All", headerCollapsed: "Collapse All")
                
                if vm.filtering.filterObject == .goal || vm.filtering.filterObject == .habit || vm.filtering.filterObject == .entry{
                    RadioButton(isSelected: $vm.filtering.filterIncludeCalendar, selectedColor: .grey8, deselectedColor: .grey4, switchColor: .grey2, iconColor: .grey2, iconType: .timeframe)
                        .padding([.leading,.trailing])
                        .offset(y:9)
                }
            }
            
            LazyVStack(spacing:0){
                ForEach(headers, id:\.self){ header in
                    VStack(spacing:0){
                        HeaderWithContent(shouldExpand: $shouldExpandAll, headerColor: .grey10, header: header, isExpanded: shouldExpandAll, content: {
                            VStack(spacing:0){
                                    

                                    
                                    if objectType == .home{
                                        HomeBuilder(header: header)
                                    }
                                    else{
                                        
                                        if let propertyList = propertiesDictionary[header]{
                                            ForEach(propertyList){ properties in
                                                
                                                PhotoCard(objectType: objectType, objectId: properties.id, properties: properties)
                                                
                                                if propertyList.last != properties{
                                                    StackDivider()
                                                }
                                            }
                                        }
                                    }
                            }
                            .modifier(ModifierCard())
                        })
                    }
                }
            }
        }

    }
    
    func GetHeaders(){
        
        headers = [String]()
        switch vm.filtering.filterObject{
        case .home:
            headers = Array(HomeObjectType.allCases.sorted(by: {$0.toInt() < $1.toInt()})).map({$0.toPluralString()})
        default:
            headers = Array(propertiesDictionary.keys.map({String($0)}).sorted(by: {$0 < $1}))
        }
    }
    
    func GetResultCount() -> Int{
        if vm.filtering.filterObject.shouldGroup(){
            return propertiesDictionary.values.compactMap({$0.count}).reduce(0, +)
        }
        else{
            return propertiesList.count
        }
    }
}

struct ContentViewStack_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewStack(isPresenting: .constant(false), modalType: .constant(.add))
            .environmentObject(ViewModel())
    }
}
