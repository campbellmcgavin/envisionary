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
    @Binding var offset: CGPoint
    
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
                        
                        if objectType == .creed{
                                CreedCard()
                                .frame(maxWidth:.infinity)
                                .padding(.top)
                        }
                        else{
                            ContentBuilder()
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
            }
            UpdateData()
        }
        .onChange(of: vm.helpPrompts){ _ in
            alerts.UpdateContentAlerts(content: vm.filtering.filterContent, shouldShow: vm.helpPrompts.content)
            alerts.UpdateObjectAlerts(object: vm.filtering.filterObject, shouldShow: vm.helpPrompts.object)
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
                vm.filtering.filterIncludeCalendar = false
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
        VStack{
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
                
                let object = vm.filtering.filterObject
                let noCustomizeArray: [ObjectType] = [.session, .home, .entry, .emotion]
                if !noCustomizeArray.contains(object){
                    
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
                
                
                
            }
            .padding([.top, .bottom],8)
            .modifier(ModifierCard())
            .padding(.top)
        TextIconButton(isPressed: $shouldUnlockObject, text: "Unlock " + vm.filtering.filterObject.toPluralString(), color: .grey0, backgroundColor: .grey10, fontSize: .h3, shouldFillWidth: true)
            .padding(.top)
            .padding([.leading,.trailing],8)
        }
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
                propertiesDictionary = vm.GroupGoals(criteria: vm.filtering.GetFilters(), grouping: vm.grouping.goal, excludeGoalsWithChildren: vm.filtering.filterIncludeCalendar).mapValues({$0.map({Properties(goal: $0)})})
            case .chapter:
                propertiesDictionary = vm.GroupChapters(criteria: vm.filtering.GetFilters(), grouping: vm.grouping.chapter).mapValues({$0.map({Properties(chapter: $0)})})
            case .entry:
                propertiesDictionary = vm.GroupEntries(criteria: vm.filtering.GetFilters(), grouping: vm.grouping.entry).mapValues({$0.map({Properties(entry: $0)})})
                propertiesList = vm.ListEntries(criteria: vm.filtering.GetFilters()).sorted(by: {$0.startDate > $1.startDate}).map({Properties(entry: $0)})
            case .session:
                propertiesList = vm.ListSessions(criteria: vm.filtering.GetFilters()).sorted(by: {$0.dateCompleted > $1.dateCompleted}).map({Properties(session: $0)})
            case .home:
                propertiesDictionary.removeAll()
                let recurrences = vm.ListRecurrences(criteria: GetRecurrenceCriteria()).sorted(by: {!$0.isComplete && $1.isComplete}).map({Properties(recurrence: $0)})
                let favorites = vm.ListPrompts(criteria: Criteria(type: .favorite)).map({Properties(prompt: $0)})
                let hints = vm.ListPrompts(criteria: Criteria(type: .suggestion)).map({Properties(prompt: $0)})
                let goals = vm.ListGoals(criteria: GetGoalCriteria()).sorted(by: {$0.startDate < $1.startDate})
                    
                let goalsFiltered = goals.filter({vm.ListChildGoals(id: $0.id).count == 0}).map({Properties(goal: $0)})
                
                if recurrences.count > 0 {
                    propertiesDictionary[HomeObjectType.habit.toPluralString()] = recurrences
                }
                if favorites.count > 0{
                    propertiesDictionary[HomeObjectType.favorite.toPluralString()] = favorites
                }
                if hints.count > 0{
                    propertiesDictionary[HomeObjectType.hint.toPluralString()] = hints
                }
                if goals.count > 0{
                    propertiesDictionary[HomeObjectType.goal.toPluralString()] = goalsFiltered
                }
            case .habit:
                propertiesDictionary = vm.GroupHabits(criteria: vm.filtering.GetFilters(), grouping: vm.grouping.habit).mapValues({$0.map({Properties(habit: $0)})})
            case .emotion:
                propertiesDictionary = vm.GroupEmotions(criteria: vm.filtering.GetFilters()).mapValues({$0.map({Properties(emotion: $0)})})
                propertiesList = vm.ListEmotions(criteria: vm.filtering.GetFilters()).sorted(by: {$0.date > $1.date}).map({Properties(emotion: $0)})
            default:
                let _ = "why"
            }
            
            GetHeaders()
        }
    }
    
    func GetRecurrenceCriteria() -> Criteria{
        var criteria = Criteria()
        criteria.date = Date()
        criteria.timeframe = .day
        criteria.archived = false
        return criteria
    }
    
    func GetGoalCriteria() -> Criteria{
        var criteria = Criteria()
        criteria.date = Date()
        criteria.timeframe = .day
        criteria.archived = false
        return criteria
    }
    
    @ViewBuilder
    func ListBuilder() -> some View{
        VStack(spacing:0){
            let objectType = vm.filtering.filterObject
            ForEach(propertiesList){ properties in
                
                if objectType == .value{
                    if properties.title != ValueType.Introduction.toString() && properties.title != ValueType.Conclusion.toString(){
                        PhotoCard(objectType: objectType, objectId: properties.id, properties: properties)
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
        if GetShouldGroup(){
            return propertiesDictionary.keys.count > 0
        }
        else{
            return propertiesList.count > 0
        }
    }
    
    @ViewBuilder
    func HomeBuilder(header: String) -> some View{
        
        if let propertyList = propertiesDictionary[header]{
            
            let homeObjectType = HomeObjectType.fromString(from: header)
            if propertyList.count > 0{
                
                ForEach(propertyList){properties in
                    switch homeObjectType{
                    case .hint:
                        let _ = "why"
                    case .favorite:
                        PromptCard(promptProperties: properties)
                    case .goal:
                        GoalTrackingCard(goalId: properties.id)
                    case .habit:
                        RecurrenceCard(habitId:  properties.habitId ?? UUID(), recurrenceId: .constant(properties.id), date: .constant(Date()))
                    }
                    if propertyList.last != properties{
                        StackDivider()
                    }
                }
            }
            else{
                Text(GetHomeNoObjectCaption(homeObjectType: homeObjectType))
                    .font(.specify(style: .caption))
                    .foregroundColor(.specify(color: .grey3))
                    .multilineTextAlignment(.leading)
                    .frame(alignment:.leading)
                    .padding(.leading)
                    .frame(maxWidth:.infinity)
                    .frame(minHeight: 55)
            }
        }
    }
    
    func GetHomeNoObjectCaption(homeObjectType: HomeObjectType) -> String{
        switch homeObjectType {
        case .habit:
            return "Looks like you don't have any habits scheduled for today."
        case .goal:
            return "Looks like you don't have any goals scheduled for today."
        case .favorite:
            return "Looks like you don't have any favorites. Mark any object as a favorite by tapping on the ★ button."
        case .hint:
            return "Looks like you wrapped up all your hints for today."
        }
    }
    
    func GetContentCaption() -> String{
        let count = GetResultCount()
        let shouldGroup = GetShouldGroup()
        let object = vm.filtering.filterObject
        let includeCalendar = vm.filtering.filterIncludeCalendar
        let showingString = "Showing " + String(count) +  (count == 1 ? " result, " : " results, ")
        let formatString = shouldGroup ? ("grouped by " + vm.grouping.fromObject(object: object).toString().lowercased() + ".") : "sorted by "
        var sortedString = ""
        if !shouldGroup{
            sortedString = !object.shouldGroup() ? "title." : "date."
        }
        
        var topLevelGoalString = ""
        
        if object == .goal && !includeCalendar{
            topLevelGoalString = " Only super goals shown."
        }
        
        var limitingResultsString = ""
        
        if includeCalendar && object.hasCalendar(){
            limitingResultsString = " Results limited by date."
        }
        
        return showingString + formatString + sortedString + topLevelGoalString + limitingResultsString
    }
    
    @ViewBuilder
    func ContentBuilder() -> some View{
            
            
            VStack{
                HStack(alignment:.center){
                    if !GetHasContent(){
                        NoObjectsLabel(objectType: vm.filtering.filterObject, labelType: .page, shouldLeftAlign: true)
                        Spacer()
                    }
                    else{
                        Text(GetContentCaption())
                            .font(.specify(style: .caption))
                            .foregroundColor(.specify(color: .grey3))
                            .multilineTextAlignment(.leading)
                            .frame(alignment:.leading)
                            .padding(.leading)
                        
                        Spacer()
                    }
                    
                    if vm.filtering.filterObject.hasCalendar(){
                        TextIconButton(isPressed: $vm.filtering.filterIncludeCalendar, text: "Calendar", color: vm.filtering.filterIncludeCalendar ? .grey10 : .grey8, backgroundColor: vm.filtering.filterIncludeCalendar ? .purple : .grey15, fontSize: .caption, shouldFillWidth: false, iconType: .timeframe)
                            .padding([.leading,.trailing])
                    }
                }
                .padding(.top, alerts.alerts.count > 0 ? 15 : 0)
                .padding(.bottom, -10)
                
                if GetHasContent(){
                    VStack(spacing:0){
                        if GetShouldGroup(){
                            HStack{
                                ParentHeaderButton(shouldExpandAll: $shouldExpandAll, color: .purple, header: "Expand All", headerCollapsed: "Collapse All")
                                Spacer()
                            }
                            GroupBuilder()
                        }
                        else{
                            ListBuilder()
                        }
                    }
                }
                else{
                    LabelAstronaut(opacity: GetOpacity())
                        .offset(y:110)
                }
                Spacer()
            }
    }
    
    func GetOpacity() -> CGFloat{
        let opacity = offset.y < 100 ? ((offset.y) * 0.7) / 100.0 : 0.7
        return opacity
    }
    
    @ViewBuilder
    func GroupBuilder() -> some View{
        
        let objectType = vm.filtering.filterObject
        let shouldShowFlatStack = objectType == .goal && vm.filtering.filterIncludeCalendar && GetResultCount() < 10
        
        if shouldShowFlatStack{
            VStack(spacing:0){
                GroupBuilderHelper()
            }
        }
        else{
            LazyVStack(spacing:0){
                GroupBuilderHelper()
            }
        }

    }
    
    @ViewBuilder
    func GroupBuilderHelper() -> some View{
        let objectType = vm.filtering.filterObject
        let shouldShowFlatStack = objectType == .goal && vm.filtering.filterIncludeCalendar
        
        ForEach(headers, id:\.self){ header in
            VStack(alignment:.leading, spacing:0){
                HeaderWithContent(shouldExpand: $shouldExpandAll, headerColor: .grey10, header: header, isExpanded: shouldExpandAll, content: {
                    VStack(alignment:.leading,spacing:0){
                        
                            if objectType == .home{
                                HomeBuilder(header: header)
                            }
                            else{
                                
                                if let propertyList = propertiesDictionary[header]{
                                    if shouldShowFlatStack{
                                        ForEach(propertyList){ properties in
                                            VStack{
                                                GoalTrackingCard(goalId: properties.id)
                                            }
                                            
                                            if propertyList.last != properties{
                                                StackDivider()
                                            }
                                        }
                                    }
                                    else{
                                        ForEach(propertyList){ properties in
                                            
                                            VStack{
                                                PhotoCard(objectType: objectType, objectId: properties.id, properties: properties)
                                            }
                                            
                                            if propertyList.last != properties{
                                                StackDivider()
                                            }
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
    
    func GetShouldGroup() -> Bool{
        
        let object = vm.filtering.filterObject
        let calendarOn = vm.filtering.filterIncludeCalendar
        
        switch object {
        case .value:
            return false
        case .creed:
            return false
        case .dream:
            return true
        case .aspect:
            return false
        case .goal:
            return true
        case .habit:
            return true
        case .session:
            return false
        case .home:
            return true
        case .chapter:
            return true
        case .entry:
            return calendarOn
        case .emotion:
            return calendarOn
        case .prompt:
            return false
        case .recurrence:
            return false
        default:
            return false
        }
    }
    
    func GetHeaders(){
        
        headers = [String]()
        switch vm.filtering.filterObject{
        case .home:
            headers = Array(HomeObjectType.allCases.sorted(by: {$0.toInt() < $1.toInt()})).filter({self.propertiesDictionary.keys.contains($0.toPluralString())}).map({$0.toPluralString()})
        default:
            headers = Array(propertiesDictionary.keys.map({String($0)}).sorted(by: {$0 < $1}))
        }
    }
    
    func GetResultCount() -> Int{
        if GetShouldGroup(){
            return propertiesDictionary.values.compactMap({$0.count}).reduce(0, +)
        }
        else{
            return propertiesList.count
        }
    }
}

struct ContentViewStack_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewStack(isPresenting: .constant(false), modalType: .constant(.add), offset: .constant(.zero))
            .environmentObject(ViewModel())
    }
}
