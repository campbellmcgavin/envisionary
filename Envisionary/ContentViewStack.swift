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
    
    @State var goalDictionary: [String:[Goal]] = [String:[Goal]]()
    @State var dreamDictionary: [String:[Dream]] = [String:[Dream]]()
    @State var emotionDictionary: [String:[Emotion]] = [String:[Emotion]]()
    @State var chapterDictionary: [String:[Chapter]] = [String:[Chapter]]()
    @State var entriesDictionary: [String:[Entry]] = [String:[Entry]]()
    @State var habitDictionary: [String:[Habit]] = [String:[Habit]]()
    
    @State var valueList: [CoreValue] = [CoreValue]()
    @State var aspectList: [Aspect] = [Aspect]()
    @State var sessionList: [Session] = [Session]()
    
    @State var todayGoalList: [Properties] = [Properties]()
    @State var todayRecurrenceList: [Properties] = [Properties]()
    @State var todaySuggestionList: [Prompt] = [Prompt]()
    @State var todayFavoriteList: [Prompt] = [Prompt]()
    
    @State var shouldUnlockObject: Bool = false
    
    
    var body: some View {
        
        VStack{
            if !vm.unlockedObjects.fromObject(object: vm.filtering.filterObject){
                BuildUnlockCard()
            }
            else{
                    
                    VStack{
                        AlertsBuilder()
                        
                        ZStack{
                            if !GetHasContent(){
                                NoObjectsLabel(objectType: vm.filtering.filterObject, labelType: .page)
                            }
                            else if vm.filtering.filterObject == .home{
                                HomeBuilder()
                            }
                            else if vm.filtering.filterObject == .value || vm.filtering.filterObject == .aspect || vm.filtering.filterObject == .creed || vm.filtering.filterObject == .session{
                                    ListBuilder()
                                }
                            else if vm.filtering.filterObject == .goal ||  vm.filtering.filterObject == .dream || vm.filtering.filterObject == .chapter || vm.filtering.filterObject == .entry || vm.filtering.filterObject == .habit || vm.filtering.filterObject == .emotion { //vm.filtering.filterObject == .task ||{
                                
                                GroupBuilder()
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
            
//            if vm.filtering.filterObject == .goal{
////                let criteria = Criteria(title: "Envisionary University")
//                let goals = vm.ListGoals(criteria: Criteria())
//                let goal = goals.first(where: {$0.title == ExampleGoalEnum.decide.toTitle()}) ?? Goal()
//                let fakeId = UUID()
//                TreeDiagramView(goalId: goal.id, focusGoal: .constant(fakeId), expandedGoals: .constant(goals.map({$0.id})), value: { goalId in
//                    BubbleView(goalId: goalId, focusGoal: .constant(fakeId))
//                }, childCount: 0)
//                .padding(.top,5)
//                .padding(.bottom)
//                .frame(maxWidth:.infinity)
//                .frame(alignment:.leading)
//            }
            
            if vm.filtering.filterObject != .session && vm.filtering.filterObject != .home && vm.filtering.filterObject != .entry && vm.filtering.filterObject != .goal{
                
                let text = vm.filtering.filterObject == .creed ? "We built out your " + vm.filtering.filterObject.toPluralString().lowercased() + " based on the values for your archetype, The " + vm.archetype.toString() : "We built out your " + vm.filtering.filterObject.toPluralString() + " based on your archetype, The " + vm.archetype.toString()
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
                valueList = vm.ListCoreValues(criteria: vm.filtering.GetFilters()).sorted(by: {$0.title < $1.title})
                aspectList = [Aspect]()
                sessionList = [Session]()
                emotionDictionary = [String:[Emotion]]()
//                taskDictionary = [String:[Task]]()
                goalDictionary = [String:[Goal]]()
                dreamDictionary = [String:[Dream]]()
                chapterDictionary = [String:[Chapter]]()
                entriesDictionary = [String:[Entry]]()
                todayFavoriteList = [Prompt]()
                todaySuggestionList = [Prompt]()
//                todayTaskList = [Properties]()
                todayGoalList = [Properties]()
                habitDictionary = [String:[Habit]]()
            case .creed:
                valueList = vm.ListCoreValues(criteria: vm.filtering.GetFilters()).sorted(by: {$0.title < $1.title}).filter({$0.title != ValueType.Introduction.toString() && $0.title != ValueType.Conclusion.toString()})
                aspectList = [Aspect]()
                sessionList = [Session]()
//                taskDictionary = [String:[Task]]()
                goalDictionary = [String:[Goal]]()
                dreamDictionary = [String:[Dream]]()
                chapterDictionary = [String:[Chapter]]()
                entriesDictionary = [String:[Entry]]()
                todayFavoriteList = [Prompt]()
                todaySuggestionList = [Prompt]()
//                todayTaskList = [Properties]()
                todayGoalList = [Properties]()
                emotionDictionary = [String:[Emotion]]()
                habitDictionary = [String:[Habit]]()
            case .dream:
                emotionDictionary = [String:[Emotion]]()
                dreamDictionary = vm.GroupDreams(criteria: vm.filtering.GetFilters(), grouping: vm.grouping.dream)
                valueList = [CoreValue]()
                aspectList = [Aspect]()
                sessionList = [Session]()
//                taskDictionary = [String:[Task]]()
                goalDictionary = [String:[Goal]]()
                chapterDictionary = [String:[Chapter]]()
                entriesDictionary = [String:[Entry]]()
                todayFavoriteList = [Prompt]()
                todaySuggestionList = [Prompt]()
//                todayTaskList = [Properties]()
                todayGoalList = [Properties]()
                habitDictionary = [String:[Habit]]()
            case .aspect:
                emotionDictionary = [String:[Emotion]]()
                aspectList = vm.ListAspects(criteria: vm.filtering.GetFilters()).sorted(by: {$0.title < $1.title})
                valueList = [CoreValue]()
                sessionList = [Session]()
//                taskDictionary = [String:[Task]]()
                goalDictionary = [String:[Goal]]()
                dreamDictionary = [String:[Dream]]()
                chapterDictionary = [String:[Chapter]]()
                entriesDictionary = [String:[Entry]]()
                todayFavoriteList = [Prompt]()
                todaySuggestionList = [Prompt]()
//                todayTaskList = [Properties]()
                todayGoalList = [Properties]()
                habitDictionary = [String:[Habit]]()
            case .goal:
                emotionDictionary = [String:[Emotion]]()
                goalDictionary = vm.GroupGoals(criteria: vm.filtering.GetFilters(), grouping: vm.grouping.goal)
                valueList = [CoreValue]()
                aspectList = [Aspect]()
                sessionList = [Session]()
//                taskDictionary = [String:[Task]]()
                dreamDictionary = [String:[Dream]]()
                chapterDictionary = [String:[Chapter]]()
                entriesDictionary = [String:[Entry]]()
                todayFavoriteList = [Prompt]()
                todaySuggestionList = [Prompt]()
//                todayTaskList = [Properties]()
                todayGoalList = [Properties]()
                habitDictionary = [String:[Habit]]()
//            case .task:
////                taskDictionary = vm.GroupTasks(criteria: vm.filtering.GetFilters(), grouping: vm.grouping.task)
//                valueList = [CoreValue]()
//                aspectList = [Aspect]()
//                sessionList = [Session]()
//                goalDictionary = [String:[Goal]]()
//                dreamDictionary = [String:[Dream]]()
//                chapterDictionary = [String:[Chapter]]()
//                entriesDictionary = [String:[Entry]]()
//                todayFavoriteList = [Prompt]()
//                todaySuggestionList = [Prompt]()
////                todayTaskList = [Properties]()
//                todayGoalList = [Properties]()
//                habitDictionary = [String:[Habit]]()
            case .chapter:
                emotionDictionary = [String:[Emotion]]()
                chapterDictionary = vm.GroupChapters(criteria: vm.filtering.GetFilters(), grouping: vm.grouping.chapter)
//                taskDictionary = [String:[Task]]()
                valueList = [CoreValue]()
                sessionList = [Session]()
                aspectList = [Aspect]()
                goalDictionary = [String:[Goal]]()
                dreamDictionary = [String:[Dream]]()
                entriesDictionary = [String:[Entry]]()
                todayFavoriteList = [Prompt]()
                todaySuggestionList = [Prompt]()
//                todayTaskList = [Properties]()
                todayGoalList = [Properties]()
                habitDictionary = [String:[Habit]]()
            case .entry:
                emotionDictionary = [String:[Emotion]]()
                chapterDictionary = [String:[Chapter]]()
//                taskDictionary = [String:[Task]]()
                valueList = [CoreValue]()
                aspectList = [Aspect]()
                sessionList = [Session]()
                goalDictionary = [String:[Goal]]()
                dreamDictionary = [String:[Dream]]()
                todayFavoriteList = [Prompt]()
                entriesDictionary = vm.GroupEntries(criteria: vm.filtering.GetFilters(), grouping: vm.grouping.entry)
                todaySuggestionList = [Prompt]()
//                todayTaskList = [Properties]()
                todayGoalList = [Properties]()
                habitDictionary = [String:[Habit]]()
            case .session:
                emotionDictionary = [String:[Emotion]]()
                chapterDictionary = [String:[Chapter]]()
//                taskDictionary = [String:[Task]]()
                valueList = [CoreValue]()
                aspectList = [Aspect]()
                sessionList = [Session]()
                goalDictionary = [String:[Goal]]()
                dreamDictionary = [String:[Dream]]()
                entriesDictionary = [String:[Entry]]()
                sessionList = vm.ListSessions(criteria: vm.filtering.GetFilters())
                todayFavoriteList = [Prompt]()
                todaySuggestionList = [Prompt]()
//                todayTaskList = [Properties]()
                todayGoalList = [Properties]()
                habitDictionary = [String:[Habit]]()
            case .home:
                emotionDictionary = [String:[Emotion]]()
                chapterDictionary = [String:[Chapter]]()
//                taskDictionary = [String:[Task]]()
                valueList = [CoreValue]()
                aspectList = [Aspect]()
                sessionList = [Session]()
                goalDictionary = [String:[Goal]]()
                dreamDictionary = [String:[Dream]]()
                entriesDictionary = [String:[Entry]]()
                sessionList = vm.ListSessions(criteria: vm.filtering.GetFilters())
                todayFavoriteList = vm.ListPrompts(criteria: Criteria(type: .favorite))
                todaySuggestionList = vm.ListPrompts(criteria: Criteria(type: .suggestion))
//                todayTaskList = vm.ListTasks(criteria: GetTaskCriteria()).sorted(by: {$0.progress < $1.progress}).map({Properties(task: $0)})
                todayGoalList = vm.ListGoals(criteria: GetTaskCriteria()).sorted(by: {$0.startDate < $1.startDate}).map({Properties(goal: $0)})
                habitDictionary = [String:[Habit]]()
                todayRecurrenceList = vm.ListRecurrences(criteria: GetHabitCriteria()).sorted(by: {!$0.isComplete && $1.isComplete}).map({Properties(recurrence: $0)})
            case .habit:
                emotionDictionary = [String:[Emotion]]()
                chapterDictionary = [String:[Chapter]]()
//                taskDictionary = [String:[Task]]()
                valueList = [CoreValue]()
                aspectList = [Aspect]()
                sessionList = [Session]()
                goalDictionary = [String:[Goal]]()
                dreamDictionary = [String:[Dream]]()
                entriesDictionary = [String:[Entry]]()
                sessionList = [Session]()
                todayFavoriteList = [Prompt]()
                todaySuggestionList = [Prompt]()
//                todayTaskList = [Properties]()
                todayGoalList = [Properties]()
                habitDictionary = vm.GroupHabits(criteria: vm.filtering.GetFilters(), grouping: vm.grouping.habit)
            case .emotion:
                emotionDictionary = vm.GroupEmotions(criteria: vm.filtering.GetFilters())
                chapterDictionary = [String:[Chapter]]()
//                taskDictionary = [String:[Task]]()
                valueList = [CoreValue]()
                aspectList = [Aspect]()
                sessionList = [Session]()
                goalDictionary = [String:[Goal]]()
                dreamDictionary = [String:[Dream]]()
                entriesDictionary = [String:[Entry]]()
                sessionList = [Session]()
                todayFavoriteList = [Prompt]()
                todaySuggestionList = [Prompt]()
//                todayTaskList = [Properties]()
                todayGoalList = [Properties]()
                habitDictionary = [String:[Habit]]()
            default:
                let _ = "why"
            }
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
    func HomeBuilder() -> some View {
        VStack(alignment:.leading, spacing:0){
            
            
            ParentHeaderButton(shouldExpandAll: $shouldExpandAll, color: .purple, header: "Expand All", headerCollapsed:  "Collapse All")
            
//            HeaderWithContent(shouldExpand: $shouldExpandAll, headerColor: .grey10, header: "Tasks", content: {
//
//                if todayTaskList.count > 0{
//                    CollapsingListCard(propertiesList: $todayTaskList, objectType: .task)
//                }
//                else {
//                    NoObjectsLabel(objectType: .task, labelType: .home)
//                }
//            })
            
            HeaderWithContent(shouldExpand: $shouldExpandAll, headerColor: .grey10, header: "Habits", content: {
                if todayRecurrenceList.count > 0 {
                    CollapsingListCard(propertiesList: $todayRecurrenceList, objectType: .recurrence)
                }
                else{
                    NoObjectsLabel(objectType: .habit, labelType: .home)
                }
            })

            HeaderWithContent(shouldExpand: $shouldExpandAll, headerColor: .grey10, header: "Goals", content: {
                if todayGoalList.count > 0 {
                    CollapsingListCard(propertiesList: $todayGoalList, objectType: .goal)
                }
                else{
                    NoObjectsLabel(objectType: .goal, labelType: .home)
                }
            })
            
            if todaySuggestionList.count > 0 {
                HeaderWithContent(shouldExpand: $shouldExpandAll, headerColor: .grey10, header: PromptType.suggestion.toPluralString(), content: {
                    VStack(spacing:0){
                        ForEach(todaySuggestionList){
                            prompt in
                            PromptCard(prompt: prompt)
                        }
                    }
                })
            }
            
            HeaderWithContent(shouldExpand: $shouldExpandAll, headerColor: .grey10, header: PromptType.favorite.toPluralString(), content: {
                VStack(spacing:0){
                    ForEach(todayFavoriteList){
                        prompt in
                        PromptCard(prompt: prompt)
                    }
                    if todayFavoriteList.count == 0{
                        NoObjectsLabel(objectType: .prompt, labelType: .home)
                    }
                }
            })
        }

    }
    
    @ViewBuilder
    func ListBuilder() -> some View{
        
        VStack(spacing:0){
            switch vm.filtering.filterObject {
            case .value:
                ForEach(valueList){ coreValue in
                    if coreValue.title != ValueType.Introduction.toString() && coreValue.title != ValueType.Conclusion.toString(){
                        PhotoCard(objectType: .value, objectId: coreValue.id, properties: Properties(value: coreValue))
                    }
                    if valueList.last != coreValue{
                        StackDivider()
                    }
                }
            case .aspect:
                ForEach(aspectList){ aspect in
                    
                    PhotoCard(objectType: .aspect, objectId: aspect.id, properties: Properties(aspect: aspect))
                    
                    if aspectList.last != aspect{
                        StackDivider()
                    }
                }
            case .session:
                ForEach(sessionList){ session in
                    PhotoCard(objectType: .session, objectId: session.id, properties: Properties(session: session))
                }
            case .creed:
                CreedCard()
            default:
                let _ = "why"
                
            }
        }
        .modifier(ModifierCard())
        .padding(.top)
    }
        
        func GetHasContent() -> Bool{
            switch vm.filtering.filterObject {
            case .value:
                return valueList.count > 0
            case .creed:
                return valueList.count > 0
            case .dream:
                return dreamDictionary.keys.count > 0
            case .aspect:
                return aspectList.count > 0
            case .goal:
                return goalDictionary.keys.count > 0
                //        case .session:
                //            return
//            case .task:
//                return taskDictionary.keys.count > 0
            case .chapter:
                return chapterDictionary.keys.count > 0
            case .entry:
                return entriesDictionary.keys.count > 0
            case .session:
                return sessionList.count > 0
            case .habit:
                return habitDictionary.keys.count > 0
            case .home:
                return true
                //        case .habit:
                //            <#code#>
                //        case .home:
                //            <#code#>
                //        case .chapter:
                //            <#code#>
                //        case .entry:
                //            <#code#>
                //        case .emotion:
                //            <#code#>
                //        case .stats:
                //            <#code#>
            case .recurrence:
                return todayRecurrenceList.count > 0
            case .emotion:
                return emotionDictionary.keys.count > 0
            default:
                return false
            }
        }
    
    @ViewBuilder
    func GroupBuilder() -> some View{
        ZStack{
            
            VStack(spacing:0){
                HStack{
                    
                    let count = GetResultCount()
                    Text("Showing " + String(count) + (count == 1 ? " result, grouped by " : " results, grouped by ") + vm.grouping.fromObject(object: vm.filtering.filterObject).toPluralString().lowercased())
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
                
                let headers = GetHeaders()
                    LazyVStack(spacing:0){
                        
                        switch vm.filtering.filterObject {
                        case .dream:
                            ForEach(headers, id:\.self){ header in
                                VStack(spacing:0){
                                    HeaderWithContent(shouldExpand: $shouldExpandAll, headerColor: .grey10, header: header, isExpanded: shouldExpandAll, content: {
                                        VStack(spacing:0){
                                                
                                            if let dreams = dreamDictionary[header]{
                                                ForEach(dreams){ dream in
                                                    PhotoCard(objectType: .dream, objectId: dream.id, properties: Properties(dream:dream))
                                                    
                                                    if dreams.last != dream{
                                                        StackDivider()
                                                    }
                                                }
                                            }
                                        }
                                        .modifier(ModifierCard())
                                    })
                                }
                            }
                        case .goal:
                            ForEach(headers, id:\.self){ header in
                                VStack(spacing:0){
                                    HeaderWithContent(shouldExpand: $shouldExpandAll, headerColor: .grey10, header: header, isExpanded: shouldExpandAll, content: {
                                        VStack(spacing:0){
                                                
                                            if let goals = goalDictionary[header]{
                                                ForEach(goals){ goal in
                                                    PhotoCard(objectType: .goal, objectId: goal.id, properties: Properties(goal:goal))
                                                    
                                                    if goals.last != goal{
                                                        StackDivider()
                                                    }
                                                }
                                            }
                                        }
                                        .modifier(ModifierCard())
                                    })
                                }
                            }
    //                    case .task:
    //                        ForEach(headers, id:\.self){ header in
    //                            VStack(spacing:0){
    //                                HeaderWithContent(shouldExpand: $shouldExpandAll, headerColor: .grey10, header: header, isExpanded: shouldExpandAll, content: {
    //                                    VStack(spacing:0){
    //
    //                                        if let tasks = taskDictionary[header]{
    //                                            ForEach(tasks){ task in
    //                                                TaskCard(taskId: task.id, properties: Properties(task: task))
    ////                                                PhotoCard(objectType: .task, objectId: task.id, properties: Properties(task:task), header: task.title, subheader: task.description)
    //
    //                                                if tasks.last != task{
    //                                                    StackDivider()
    //                                                }
    //                                            }
    //                                        }
    //                                    }
    //                                    .padding([.top,.bottom],3)
    //                                    .modifier(ModifierCard())
    //                                })
    //                            }
    //                        }
                        case .chapter:
                            ForEach(headers, id:\.self){ header in
                                VStack(spacing:0){
                                    HeaderWithContent(shouldExpand: $shouldExpandAll, headerColor: .grey10, header: header, isExpanded: shouldExpandAll, content: {
                                        VStack(spacing:0){
                                                
                                            if let chapters = chapterDictionary[header]{
                                                ForEach(chapters){ chapter in
                                                    PhotoCard(objectType: .chapter, objectId: chapter.id, properties: Properties(chapter:chapter))
                                                    
                                                    if chapters.last != chapter{
                                                        StackDivider()
                                                    }
                                                }
                                            }
                                        }
                                        .modifier(ModifierCard())
                                    })
                                }
                            }
                        case .entry:
                            ForEach(headers, id:\.self){ header in
                                VStack(spacing:0){
                                    HeaderWithContent(shouldExpand: $shouldExpandAll, headerColor: .grey10, header: header, isExpanded: shouldExpandAll, content: {
                                        VStack(spacing:0){
                                                
                                            if let entries = entriesDictionary[header]{
                                                ForEach(entries){ entry in
                                                    PhotoCard(objectType: .entry, objectId: entry.id, properties: Properties(entry:entry))
                                                    
                                                    if entries.last != entry{
                                                        StackDivider()
                                                    }
                                                }
                                            }
                                        }
                                        .modifier(ModifierCard())
                                    })
                                }
                            }
                        case .habit:
                            ForEach(headers, id:\.self){ header in
                                VStack(spacing:0){
                                    HeaderWithContent(shouldExpand: $shouldExpandAll, headerColor: .grey10, header: header, isExpanded: shouldExpandAll, content: {
                                        VStack(spacing:0){
                                                
                                            if let habits = habitDictionary[header]{
                                                ForEach(habits){ habit in
                                                    
                                                    PhotoCard(objectType: .habit, objectId: habit.id, properties: Properties(habit:habit))
                                                    
                                                    if habits.last != habit{
                                                        StackDivider()
                                                    }
                                                }
                                            }
                                        }
                                        .modifier(ModifierCard())
                                    })
                                }
                            }
                        case .emotion:
                            ForEach(headers, id:\.self){ header in
                                VStack(spacing:0){
                                    HeaderWithContent(shouldExpand: $shouldExpandAll, headerColor: .grey10, header: header, isExpanded: shouldExpandAll, content: {
                                        VStack(spacing:0){
                                                
                                            if let emotions = emotionDictionary[header]{
                                                ForEach(emotions){ emotion in
                                                    PhotoCard(objectType: .emotion, objectId: emotion.id, properties: Properties(emotion:emotion))
                                                    
                                                    if emotions.last != emotion{
                                                        StackDivider()
                                                    }
                                                }
                                            }
                                        }
                                        .modifier(ModifierCard())
                                    })
                                }
                            }
                        default:
                            let _ = "why"
                        }
                    }
            }
        }

    }
    
    func GetHeaders() -> [String]{
        switch vm.filtering.filterObject{
//        case .task:
//            return Array(taskDictionary.keys.map({String($0)}).sorted(by: {$0 < $1}))
        case .goal:
            return Array(goalDictionary.keys.map({String($0)}).sorted(by: {$0 < $1}))
        case .dream:
            return Array(dreamDictionary.keys.map({String($0)}).sorted(by: {$0 < $1}))
        case .chapter:
            return Array(chapterDictionary.keys.map({String($0)}).sorted(by: {$0 < $1}))
        case .entry:
            return Array(entriesDictionary.keys.map({String($0)}).sorted(by: {$0 < $1}))
        case .habit:
            return Array(habitDictionary.keys.map({String($0)}).sorted(by: {$0 < $1}))
        case .emotion:
            return Array(emotionDictionary.keys.map({String($0)}).sorted(by: {$0 < $1}))
        default:
           return [String]()
        }
    }
    
    func GetResultCount() -> Int{
        switch vm.filtering.filterObject{
//        case .task:
//            return Array(taskDictionary.keys.map({String($0)}).sorted(by: {$0 < $1}))
        case .goal:
            return goalDictionary.values.compactMap({$0.count}).reduce(0, +)
        case .dream:
            return dreamDictionary.values.compactMap({$0.count}).reduce(0, +)
        case .chapter:
            return chapterDictionary.values.compactMap({$0.count}).reduce(0, +)
        case .entry:
            return entriesDictionary.values.compactMap({$0.count}).reduce(0, +)
        case .habit:
            return habitDictionary.values.compactMap({$0.count}).reduce(0, +)
        case .emotion:
            return emotionDictionary.values.compactMap({$0.count}).reduce(0, +)
        default:
           return 0
        }
    }
}

struct ContentViewStack_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewStack(isPresenting: .constant(false), modalType: .constant(.add))
            .environmentObject(ViewModel())
    }
}
