//
//  ContentViewStack.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/16/23.
//

import SwiftUI

struct ContentViewStack: View {
    @EnvironmentObject var vm: ViewModel
    @State var shouldExpandAll: Bool = true
    @State var valueList: [CoreValue] = [CoreValue]()
    @State var aspectList: [Aspect] = [Aspect]()
    @State var sessionList: [Session] = [Session]()
    @State var goalDictionary: [String:[Goal]] = [String:[Goal]]()
    @State var taskDictionary: [String:[Task]] = [String:[Task]]()
    @State var dreamDictionary: [String:[Dream]] = [String:[Dream]]()
    @State var chapterDictionary: [String:[Chapter]] = [String:[Chapter]]()
    @State var entriesDictionary: [String:[Entry]] = [String:[Entry]]()
    @State var favoriteList: [Prompt] = [Prompt]()
    @State var suggestionList: [Prompt] = [Prompt]()
    
    @State var todayTaskList: [Properties] = [Properties]()
    @State var todayGoalList: [Properties] = [Properties]()
//    @State var
    var body: some View {
        
        VStack{
            if !GetHasContent(){
                NoObjectsLabel(objectType: vm.filtering.filterObject)
            }
            else if vm.filtering.filterObject == .home{
                HomeBuilder()
            }
            else{
                if vm.filtering.filterObject == .value || vm.filtering.filterObject == .aspect || vm.filtering.filterObject == .creed || vm.filtering.filterObject == .session{
                    ListBuilder()
                }
                else if vm.filtering.filterObject == .goal || vm.filtering.filterObject == .task || vm.filtering.filterObject == .dream || vm.filtering.filterObject == .chapter || vm.filtering.filterObject == .entry {
                    GroupBuilder()
                }
            }
        }
        .onAppear(){
            UpdateData()
        }
        .onChange(of: vm.filtering){
            _ in
            UpdateData()
        }
        .onChange(of: vm.updates){
            _ in
            UpdateData()
        }
        .onChange(of: vm.filtering.filterContent){ _ in
            shouldExpandAll = true
        }
    }
    
    func UpdateData(){
        withAnimation{
            switch vm.filtering.filterObject {
            case .value:
                valueList = vm.ListCoreValues(criteria: vm.filtering.GetFilters()).sorted(by: {$0.coreValue.toString() < $1.coreValue.toString()})
                aspectList = [Aspect]()
                sessionList = [Session]()
                taskDictionary = [String:[Task]]()
                goalDictionary = [String:[Goal]]()
                dreamDictionary = [String:[Dream]]()
                chapterDictionary = [String:[Chapter]]()
                entriesDictionary = [String:[Entry]]()
                favoriteList = [Prompt]()
                suggestionList = [Prompt]()
                todayTaskList = [Properties]()
                todayGoalList = [Properties]()
            case .creed:
                valueList = vm.ListCoreValues(criteria: vm.filtering.GetFilters()).sorted(by: {$0.coreValue.toString() < $1.coreValue.toString()}).filter({$0.coreValue != .Introduction && $0.coreValue != .Conclusion})
                aspectList = [Aspect]()
                sessionList = [Session]()
                taskDictionary = [String:[Task]]()
                goalDictionary = [String:[Goal]]()
                dreamDictionary = [String:[Dream]]()
                chapterDictionary = [String:[Chapter]]()
                entriesDictionary = [String:[Entry]]()
                favoriteList = [Prompt]()
                suggestionList = [Prompt]()
                todayTaskList = [Properties]()
                todayGoalList = [Properties]()
            case .dream:
                dreamDictionary = vm.GroupDreams(criteria: vm.filtering.GetFilters(), grouping: vm.grouping.dream)
                valueList = [CoreValue]()
                aspectList = [Aspect]()
                sessionList = [Session]()
                taskDictionary = [String:[Task]]()
                goalDictionary = [String:[Goal]]()
                chapterDictionary = [String:[Chapter]]()
                entriesDictionary = [String:[Entry]]()
                favoriteList = [Prompt]()
                suggestionList = [Prompt]()
                todayTaskList = [Properties]()
                todayGoalList = [Properties]()
            case .aspect:
                aspectList = vm.ListAspects(criteria: vm.filtering.GetFilters()).sorted(by: {$0.aspect.toString() < $1.aspect.toString()})
                valueList = [CoreValue]()
                sessionList = [Session]()
                taskDictionary = [String:[Task]]()
                goalDictionary = [String:[Goal]]()
                dreamDictionary = [String:[Dream]]()
                chapterDictionary = [String:[Chapter]]()
                entriesDictionary = [String:[Entry]]()
                favoriteList = [Prompt]()
                suggestionList = [Prompt]()
                todayTaskList = [Properties]()
                todayGoalList = [Properties]()
            case .goal:
                goalDictionary = vm.GroupGoals(criteria: vm.filtering.GetFilters(), grouping: vm.grouping.goal)
                valueList = [CoreValue]()
                aspectList = [Aspect]()
                sessionList = [Session]()
                taskDictionary = [String:[Task]]()
                dreamDictionary = [String:[Dream]]()
                chapterDictionary = [String:[Chapter]]()
                entriesDictionary = [String:[Entry]]()
                favoriteList = [Prompt]()
                suggestionList = [Prompt]()
                todayTaskList = [Properties]()
                todayGoalList = [Properties]()
            case .task:
                taskDictionary = vm.GroupTasks(criteria: vm.filtering.GetFilters(), grouping: vm.grouping.task)
                valueList = [CoreValue]()
                aspectList = [Aspect]()
                sessionList = [Session]()
                goalDictionary = [String:[Goal]]()
                dreamDictionary = [String:[Dream]]()
                chapterDictionary = [String:[Chapter]]()
                entriesDictionary = [String:[Entry]]()
                favoriteList = [Prompt]()
                suggestionList = [Prompt]()
                todayTaskList = [Properties]()
                todayGoalList = [Properties]()
            case .chapter:
                chapterDictionary = vm.GroupChapters(criteria: vm.filtering.GetFilters(), grouping: vm.grouping.chapter)
                taskDictionary = [String:[Task]]()
                valueList = [CoreValue]()
                sessionList = [Session]()
                aspectList = [Aspect]()
                goalDictionary = [String:[Goal]]()
                dreamDictionary = [String:[Dream]]()
                entriesDictionary = [String:[Entry]]()
                favoriteList = [Prompt]()
                suggestionList = [Prompt]()
                todayTaskList = [Properties]()
                todayGoalList = [Properties]()
            case .entry:
                chapterDictionary = [String:[Chapter]]()
                taskDictionary = [String:[Task]]()
                valueList = [CoreValue]()
                aspectList = [Aspect]()
                sessionList = [Session]()
                goalDictionary = [String:[Goal]]()
                dreamDictionary = [String:[Dream]]()
                favoriteList = [Prompt]()
                entriesDictionary = vm.GroupEntries(criteria: vm.filtering.GetFilters(), grouping: vm.grouping.entry)
                suggestionList = [Prompt]()
                todayTaskList = [Properties]()
                todayGoalList = [Properties]()
            case .session:
                chapterDictionary = [String:[Chapter]]()
                taskDictionary = [String:[Task]]()
                valueList = [CoreValue]()
                aspectList = [Aspect]()
                sessionList = [Session]()
                goalDictionary = [String:[Goal]]()
                dreamDictionary = [String:[Dream]]()
                entriesDictionary = [String:[Entry]]()
                sessionList = vm.ListSessions(criteria: vm.filtering.GetFilters())
                favoriteList = [Prompt]()
                suggestionList = [Prompt]()
                todayTaskList = [Properties]()
                todayGoalList = [Properties]()
            case .home:
                chapterDictionary = [String:[Chapter]]()
                taskDictionary = [String:[Task]]()
                valueList = [CoreValue]()
                aspectList = [Aspect]()
                sessionList = [Session]()
                goalDictionary = [String:[Goal]]()
                dreamDictionary = [String:[Dream]]()
                entriesDictionary = [String:[Entry]]()
                sessionList = vm.ListSessions(criteria: vm.filtering.GetFilters())
                favoriteList = vm.ListPrompts(criteria: Criteria(type: .favorite))
                suggestionList = vm.ListPrompts(criteria: Criteria(type: .suggestion))
                todayTaskList = vm.ListTasks(criteria: GetTaskCriteria()).sorted(by: {$0.progress < $1.progress}).map({Properties(task: $0)})
                todayGoalList = vm.ListGoals(criteria: GetTaskCriteria()).sorted(by: {$0.startDate < $1.startDate}).map({Properties(goal: $0)})
            default:
                let _ = "why"
            }
        }

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
            
            HeaderWithContent(shouldExpand: $shouldExpandAll, headerColor: .grey10, header: "Tasks", content: {
                
                if todayTaskList.count > 0{
                    CollapsingListCard(propertiesList: $todayTaskList, objectType: .task)
                }
                else {
                    NoObjectsLabel(objectType: .task)
                }
            })

            HeaderWithContent(shouldExpand: $shouldExpandAll, headerColor: .grey10, header: "Goals", content: {
                if todayGoalList.count > 0 {
                    CollapsingListCard(propertiesList: $todayGoalList, objectType: .goal)
                }
                else{
                    NoObjectsLabel(objectType: .goal)
                }
            })
            
            if suggestionList.count > 0 {
                HeaderWithContent(shouldExpand: $shouldExpandAll, headerColor: .grey10, header: PromptType.suggestion.toPluralString(), content: {
                    VStack(spacing:0){
                        ForEach(suggestionList){
                            prompt in
                            PromptCard(prompt: prompt)
                        }
                    }
                })
            }
            
            HeaderWithContent(shouldExpand: $shouldExpandAll, headerColor: .grey10, header: PromptType.favorite.toPluralString(), content: {
                VStack(spacing:0){
                    ForEach(favoriteList){
                        prompt in
                        PromptCard(prompt: prompt)
                    }
                    if favoriteList.count == 0{
                        NoObjectsLabel(objectType: .prompt)
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
                    if coreValue.coreValue != .Introduction && coreValue.coreValue != .Conclusion{
                        PhotoCard(objectType: .value, objectId: coreValue.id, properties: Properties(value: coreValue), header: coreValue.coreValue.toString(), subheader: coreValue.description)
                    }
                    if valueList.last != coreValue{
                        StackDivider()
                    }
                }
            case .aspect:
                ForEach(aspectList){ aspect in
                    
                    PhotoCard(objectType: .aspect, objectId: aspect.id, properties: Properties(aspect: aspect), header: aspect.aspect.toString(), subheader: aspect.description)
                    
                    if aspectList.last != aspect{
                        StackDivider()
                    }
                }
            case .session:
                ForEach(sessionList){ session in
                    PhotoCard(objectType: .session, objectId: session.id, properties: Properties(session: session), header: session.date.toString(timeframeType: session.timeframe), subheader: "Completed on " + session.dateCompleted.toString(timeframeType: session.timeframe))
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
            case .task:
                return taskDictionary.keys.count > 0
            case .chapter:
                return chapterDictionary.keys.count > 0
            case .entry:
                return entriesDictionary.keys.count > 0
            case .session:
                return sessionList.count > 0
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
            default:
                return false
            }
        }
    
    @ViewBuilder
    func GroupBuilder() -> some View{
        
        VStack(spacing:0){
            ParentHeaderButton(shouldExpandAll: $shouldExpandAll, color: .purple, header: "Expand All", headerCollapsed: "Collapse All")
            
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
                                                PhotoCard(objectType: .dream, objectId: dream.id, properties: Properties(dream:dream), header: dream.title, subheader: dream.description, caption: dream.aspect.toString())
                                                
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
                                                PhotoCard(objectType: .goal, objectId: goal.id, properties: Properties(goal:goal), header: goal.title, subheader: goal.description, caption: goal.startDate.toString(timeframeType: goal.timeframe, isStartDate: goal.timeframe == .week ? true : nil) + " - " + goal.endDate.toString(timeframeType: goal.timeframe, isStartDate: goal.timeframe == .week ? false : nil))
                                                
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
                    case .task:
                        ForEach(headers, id:\.self){ header in
                            VStack(spacing:0){
                                HeaderWithContent(shouldExpand: $shouldExpandAll, headerColor: .grey10, header: header, isExpanded: shouldExpandAll, content: {
                                    VStack(spacing:0){
                                            
                                        if let tasks = taskDictionary[header]{
                                            ForEach(tasks){ task in
                                                TaskCard(taskId: task.id, properties: Properties(task: task))
//                                                PhotoCard(objectType: .task, objectId: task.id, properties: Properties(task:task), header: task.title, subheader: task.description)
                                                
                                                if tasks.last != task{
                                                    StackDivider()
                                                }
                                            }
                                        }
                                    }
                                    .padding([.top,.bottom],3)
                                    .modifier(ModifierCard())
                                })
                            }
                        }
                    case .chapter:
                        ForEach(headers, id:\.self){ header in
                            VStack(spacing:0){
                                HeaderWithContent(shouldExpand: $shouldExpandAll, headerColor: .grey10, header: header, isExpanded: shouldExpandAll, content: {
                                    VStack(spacing:0){
                                            
                                        if let chapters = chapterDictionary[header]{
                                            ForEach(chapters){ chapter in
                                                PhotoCard(objectType: .chapter, objectId: chapter.id, properties: Properties(chapter:chapter), header: chapter.title, subheader: chapter.description, caption: chapter.aspect.toString())
                                                
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
                                                PhotoCard(objectType: .entry, objectId: entry.id, properties: Properties(entry:entry), header: entry.title, subheader: entry.description, caption: entry.startDate.toString(timeframeType: .day))
                                                
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
                    default:
                        let _ = "why"
//                    case .habit:
//                        <#code#>

//                    case .emotion:
//                        <#code#>
                    }
                }
        }
    }
    
    func GetHeaders() -> [String]{
        switch vm.filtering.filterObject{
        case .task:
            return Array(taskDictionary.keys.map({String($0)}).sorted(by: {$0 < $1}))
        case .goal:
            return Array(goalDictionary.keys.map({String($0)}).sorted(by: {$0 < $1}))
        case .dream:
            return Array(dreamDictionary.keys.map({String($0)}).sorted(by: {$0 < $1}))
        case .chapter:
            return Array(chapterDictionary.keys.map({String($0)}).sorted(by: {$0 < $1}))
        case .entry:
            return Array(entriesDictionary.keys.map({String($0)}).sorted(by: {$0 < $1}))
        default:
           return [String]()
        }
    }
}

struct ContentViewStack_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewStack(shouldExpandAll: true)
    }
}
