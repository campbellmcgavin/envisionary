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
    let proxy: ScrollViewProxy?
    
    @State var shouldExpandAll: Bool = true
    @StateObject var alerts = AlertsService()
    @State var isPresentingCalendar = false
    
    @State var headers = [String]()
    @State var propertiesDictionary: [String: [Properties]] = [String: [Properties]]()
    @State var propertiesList: [Properties] = [Properties]()
    
    @State var shouldUnlockObject: Bool = false
    
    
    @State var shouldShowArchivedOnly = false
    @State var shouldShowSuperOnly = false
    @State var shouldShowAspectOnly = ""
    @State var shouldShowPriorityOnly = ""
    @State var shouldShowProgressOnly = ""
    @State var shouldShowCalendar = false
    
    var body: some View {
        
        VStack{
            if !vm.unlockedObjects.fromObject(object: vm.filtering.filterObject){
                BuildUnlockCard()
            }
            else{
                VStack(alignment:.leading){                    
                    let objectType = vm.filtering.filterObject
                    
                    if vm.filtering.filterObject.hasFilter(){
                    HStack(alignment:.center){
                        FormFilterStack(objectType: vm.filtering.filterObject, date: $vm.filtering.filterIncludeCalendar, archived: $vm.filtering.filterArchived, subGoals: $vm.filtering.filterShowSubGoals, aspect: $vm.filtering.filterAspect, priority: $vm.filtering.filterPriority, progress: $vm.filtering.filterProgress, creed: $vm.filtering.filterCreed, entry: $vm.filtering.filterEntry)
                        }
                    .padding(.top, alerts.alerts.count > 0 ? 15 : 0)
                    .padding(.bottom, -10)

                    }
                        
                    if objectType == .value && vm.filtering.filterCreed{
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
                alerts.UpdateObjectAlerts(object: vm.filtering.filterObject, shouldShow: vm.helpPrompts.object)
            }
            UpdateData()
        }
        .onChange(of: vm.helpPrompts){ _ in
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
        .onChange(of: vm.filtering.filterObject){
            _ in
            withAnimation{
                alerts.UpdateObjectAlerts(object: vm.filtering.filterObject, shouldShow: vm.helpPrompts.object)
                vm.filtering.filterIncludeCalendar = .none
            }
        }
        .ignoresSafeArea(.keyboard,edges:.bottom)

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
                
                Text(vm.filtering.filterObject.toPluralString() + " " + vm.filtering.filterObject.toDescription())
                        .multilineTextAlignment(.leading)
                        .frame(alignment:.leading)
                        .font(.specify(style: .h5))
                        .foregroundColor(.specify(color: .grey9))
                        .frame(maxWidth:.infinity, alignment:.leading)
                        .padding()
                        .modifier(ModifierForm(color:.grey2))
                        .padding([.leading,.trailing], 8)
                
                let text = vm.filtering.filterObject == .goal ? "The goals here the ones you chose during setup. You can delete or modify anything you see." : "We've provided some " + vm.filtering.filterObject.toPluralString() + " to get you started. Everything can be changed or removed."
                    
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
                propertiesList = vm.ListCoreValues(criteria: vm.filtering.GetFilters()).map({Properties(value: $0)})
            case .creed:
                propertiesList = vm.ListCoreValues(criteria: vm.filtering.GetFilters()).map({Properties(value: $0)})
            case .goal:
                if vm.filtering.filterIncludeCalendar == DateFilterType.gantt{
                    propertiesList = vm.ListGoals(criteria: vm.filtering.GetFilters()).map({Properties(goal: $0)})
                }
                else{
                    propertiesDictionary = vm.GroupGoals(criteria: vm.filtering.GetFilters(), grouping: vm.grouping.goal).mapValues({$0.map({Properties(goal: $0)})})
                }
            case .journal:
                if vm.filtering.filterEntry {
                    propertiesDictionary = vm.GroupEntries(criteria: vm.filtering.GetFilters(), grouping: vm.grouping.entry).mapValues({$0.map({Properties(entry: $0)})})
                    propertiesList = vm.ListEntries(criteria: vm.filtering.GetFilters()).sorted(by: {$0.startDate > $1.startDate}).map({Properties(entry: $0)})
                }
                else{
                    propertiesDictionary = vm.GroupChapters(criteria: vm.filtering.GetFilters(), grouping: vm.grouping.chapter).mapValues({$0.map({Properties(chapter: $0)})})
                }
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
        criteria.superOnly = true
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
                else if properties.title != ValueType.Introduction.toString() && properties.title != ValueType.Conclusion.toString(){
                    PhotoCard(objectType: objectType, objectId: properties.id, properties: properties)
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
    
    func GetContentCaption() -> String{
        let count = GetResultCount()
        let shouldGroup = GetShouldGroup()
        let object = vm.filtering.filterObject
        let includeCalendar = vm.filtering.filterIncludeCalendar == .list
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
                if GetHasContent(){
                    if vm.filtering.filterIncludeCalendar == .gantt{
                        MasterGanttView(properties: $propertiesList, isLocal: false)
                            .padding(.top)
                            .padding(8)
                            .frame(alignment:.leading)
                            .modifier(ModifierForm(color:.grey05))
                            .frame(maxWidth:.infinity)
                            .padding(.top,20)
                    }
                    else{
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
                }
                else{
                    LabelAstronaut(opacity: 1.0)
                        .offset(y:110)
                        .frame(maxWidth:.infinity)
                }
                Spacer()
            }
    }
    
//    func GetOpacity() -> CGFloat{
//        let opacity = offset.y < 100 ? ((offset.y) * 0.7) / 100.0 : 0.7
//        return opacity
//    }
    
    @ViewBuilder
    func GroupBuilder() -> some View{
        
        let objectType = vm.filtering.filterObject
        
//        if shouldShowFlatStack{
//            VStack(spacing:0){
//                GroupBuilderHelper()
//            }
//        }
//        else{
            VStack(spacing:0){
                GroupBuilderHelper()
            }
//        }

    }
    
    @ViewBuilder
    func GroupBuilderHelper() -> some View{
        let objectType = vm.filtering.filterObject
//        let shouldShowFlatStack = objectType == .goal && vm.filtering.filterIncludeCalendar
        
        ForEach(headers, id:\.self){ header in
            VStack(alignment:.leading, spacing:0){
                HeaderWithContent(shouldExpand: $shouldExpandAll, headerColor: .grey10, header: header, isExpanded: shouldExpandAll, content: {

                    let shouldShowElements = !(vm.filtering.filterObject == ObjectType.goal) || ( vm.filtering.filterObject == .goal && !vm.filtering.filterShowSubGoals)
                    
                    VStack(alignment:.leading,spacing:0){
                    if let propertyList = propertiesDictionary[header]{
                            ForEach(propertyList){ properties in
                                VStack{
                                    if vm.filtering.filterShowSubGoals && vm.filtering.filterObject == .goal{
                                        CheckOff(goalId: properties.id, properties: properties, canEdit: false, proxy: proxy, isPresenting: $isPresenting, modalType: $modalType)
                                    }
                                    else{
                                        PhotoCard(objectType: objectType, objectId: properties.id, properties: properties)
                                    }
                                    
                                }
                                
                                if propertyList.last != properties && shouldShowElements{
                                    StackDivider()
                                }
                            }
                    }
                }
                .if(shouldShowElements){
                    view in
                    view.modifier(ModifierCard())
                }
                })
            }
        }
    }
    
    func GetShouldGroup() -> Bool{
        
        let object = vm.filtering.filterObject
        let calendarOn = vm.filtering.filterIncludeCalendar != .none
        
        switch object {
        case .value:
            return false
        case .creed:
            return false
        case .aspect:
            return false
        case .goal:
            return vm.filtering.filterIncludeCalendar != .gantt
        case .journal:
            return true
        case .entry:
            return calendarOn
        default:
            return false
        }
    }
    
    func GetHeaders(){
        headers = Array(propertiesDictionary.keys.map({String($0)}).sorted(by: {$0 < $1}))
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
        ContentViewStack(isPresenting: .constant(false), modalType: .constant(.add), proxy: nil)
            .environmentObject(ViewModel())
    }
}
