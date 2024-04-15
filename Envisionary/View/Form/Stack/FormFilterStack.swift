//
//  FormFilterStack.swift
//  Envisionary
//
//  Created by Campbell McGavin on 8/6/23.
//

import SwiftUI

struct FormFilterStack: View {
    let objectType: ObjectType
    @Binding var date: DateFilterType
    @Binding var archived: Bool
    @Binding var subGoals: Bool
    @Binding var aspect: String
    @Binding var priority: String
    @Binding var progress: StatusType
    @Binding var creed: Bool
    @Binding var entry: Bool
    var isSearch = false
    
    @State var dateFilter: String = ""
    @State var filters: [FilterType: Bool] = [FilterType:Bool]()
    @State var filterShouldChange: [FilterType: Int] = [FilterType:Int]()
    @State var aspects: [String] = [String]()
    @State var statuses: [String] = StatusType.allCases.map({$0.toString()})
    @State var dateFilters: [String] = [DateFilterType.list.toString(), DateFilterType.gantt.toString()]
    @State var priorities: [String] = PriorityType.allCases.map({$0.toString()})
    @State var shouldClearAll: Bool = false
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false){
            HStack(alignment:.top){
                let _ = Self._printChanges()
                let hasFilters = filters.values.filter({$0}).count > 0
                
                TextIconButton(isPressed: $shouldClearAll, text: "Clear all", color: hasFilters ? .grey10 : .grey3, backgroundColor: hasFilters ? .red : .grey1, fontSize: .subCaption, shouldFillWidth: false, iconType: .cancel)
                    .disabled(!hasFilters)
                
                ForEach(filters.sorted{
                    if $0.value == $1.value {
                        return $0.key.toInt() < $1.key.toInt()
                    }
                    return $0.value && !$1.value
                }.map({$0.key}), id:\.self){ filter in
                    
                    if objectType.hasFilter(filter: filter) && ShouldDisplay(filter: filter){
                        BuildButton(filter: filter)
                    }
                }
            }
        }
        .animation(.easeInOut)
        .onAppear{
            FilterType.allCases.forEach({filters[$0] = false})
            aspects = vm.ListAspects().map({$0.title})
            filters[.archived] = archived
            filters[.subGoals] = subGoals
            filters[.aspect] = aspect.count > 0
            filters[.priority] = priority.count > 0
            filters[.progress] = progress != .none
            filters[.creed] = creed
            filters[.entry] = entry
            
            filterShouldChange[.archived] = archived ? 2 : 0
            filterShouldChange[.subGoals] = subGoals ? 2 : 0
            filterShouldChange[.aspect] = aspect.count > 0 ? 2 : 0
            filterShouldChange[.priority] = priority.count > 0 ? 2 : 0
            filterShouldChange[.progress] = progress != .none ? 2 : 0
            filterShouldChange[.creed] = creed ? 2 : 0
            filterShouldChange[.entry] = entry ? 2 : 0
        }
        .onChange(of: shouldClearAll){ _ in
            FilterType.allCases.forEach({
                filters[$0] = false
                filterShouldChange[$0] = 0
            })
            archived = false
            subGoals = false
            aspect = ""
            priority = ""
            progress = .none
            dateFilter = ""
            entry = false
            creed = false
        }
        .onChange(of: dateFilter){ _ in
            date = DateFilterType.fromString(from: dateFilter)
        }
    }
    
    func ShouldDisplay(filter: FilterType) -> Bool{
        switch filter {
        case .creed:
            return !isSearch
        case .entry:
            return true
        case .date:
            return !isSearch
        case .subGoals:
            return date != .gantt
        case .aspect:
            return objectType != .journal || !entry
        case .priority:
            return true
        case .progress:
            return true
        case .archived:
            return true
        }
    }
    
    @ViewBuilder
    func BuildButton(filter: FilterType) -> some View{
        
        HStack(alignment:.center){
            let pressedState = filterShouldChange[filter] ?? 0
            
            
            Button{
                withAnimation{
                    if pressedState == 0 {
                        if filter.hasDropDown(){
                            filterShouldChange[filter] = 1
                        }
                        else{
                            filterShouldChange[filter] = 2
                            filters[filter] = true
                            
                            if filter == .subGoals{
                                subGoals = true
                            }
                            
                            if filter == .archived{
                                archived = true
                            }
                            
                            if filter == .creed{
                                creed = true
                            }
                            
                            if filter == .entry{
                                entry = true
                            }
                        }
                        
                    }
                    else{
                        filterShouldChange[filter] = 0
                        filters[filter] = false
                        
                        switch filter{
                        case .aspect: aspect = ""
                        case .priority: priority = ""
                        case .progress: progress = .none
                        case .subGoals: subGoals = false
                        case .archived: archived = false
                        case .date: dateFilter = ""
                        case .creed: creed = false
                        case .entry: entry = false
                        }
                    }
                }
            }
        label:{
            TextIconLabel(text: GetText(filter: filter), color: .grey10, backgroundColor: pressedState != 0 ? .purple : .grey2, fontSize: .subCaption, shouldFillWidth: false, iconType: filter.toIcon())
        }
            

            if pressedState == 1 {
                BuildSubMenu(filter: filter)
            }
        }
    }
    
    func GetText(filter: FilterType) -> String{
        switch filter {
        case .archived:
            return filter.toString()
        case .subGoals:
            return filter.toString()
        case .aspect:
            return filter.toString() + (aspect.count > 0 ? ": " + aspect : "")
        case .priority:
            return filter.toString() + (priority.count > 0 ? ": " + priority : "")
        case .progress:
            return filter.toString() + (progress != .none ? ": " + progress.toString() : "")
        case .date:
            return filter.toString() + (dateFilter.count > 0 ? ": " + dateFilter : "")
        case .creed:
            return filter.toString()
        case .entry:
            return filter.toString()
        }
    }
    
    @ViewBuilder
    func BuildSubMenu(filter: FilterType) -> some View{
        if filter == .aspect {
                ForEach(Array(aspects), id:\.self){ aspect in
                    Button{
                        withAnimation{
                            self.aspect = aspect
                            filters[filter] = true
                            filterShouldChange[filter] = 2
                        }
    
                        
                    }
                label:{
                    TextIconLabel(text: aspect, color: .grey6, backgroundColor: .darkPurple, fontSize: .caption, shouldFillWidth: false)
                        .opacity(0.7)
                }
                }
        }
        
        if filter == .priority {
            
                ForEach(Array(priorities), id:\.self){ priority in
                    Button{
                        withAnimation{
                            self.priority = priority
                            filters[filter] = true
                            filterShouldChange[filter] = 2
                        }
                    }
                label:{
                    TextIconLabel(text: priority, color: .grey6, backgroundColor: .darkPurple, fontSize: .caption, shouldFillWidth: false)
                        .opacity(0.7)
                }
                }
        }
        
        if filter == .date{
            ForEach(Array(dateFilters), id:\.self){ dateFilter in
                Button{
                    withAnimation{
                        self.dateFilter = dateFilter
                        filters[filter] = true
                        filterShouldChange[filter] = 2
                    }
                }
            label:{
                TextIconLabel(text: dateFilter, color: .grey6, backgroundColor: .darkPurple, fontSize: .caption, shouldFillWidth: false)
                    .opacity(0.7)
            }
            }
        }
        
        if filter == .progress{
            ForEach(Array(arrayLiteral: StatusType.notStarted,StatusType.inProgress,StatusType.completed), id:\.self){ status in
                Button{
                    withAnimation{
                        self.progress = status
                        filters[filter] = true
                        filterShouldChange[filter] = 2
                    }
                }
            label:{
                TextIconLabel(text: status.toString(), color: .grey6, backgroundColor: .darkPurple, fontSize: .caption, shouldFillWidth: false)
                    .opacity(0.7)
            }
            }
        }
    }
    
    func BindingFilter(for key: FilterType) -> Binding<Int>{
        return Binding(get: {
            return self.filterShouldChange[key] ?? 0},
                       set: {
                self.filterShouldChange[key] = $0
        })
    }
}

struct FormFilterStack_Previews: PreviewProvider {
    static var previews: some View {
        FormFilterStack(objectType: .goal, date: .constant(.none), archived: .constant(false), subGoals: .constant(true), aspect: .constant(""), priority: .constant(""), progress: .constant(.none), creed: .constant(false), entry: .constant(false))
    }
}
