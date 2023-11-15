//
//  FormFilterStack.swift
//  Envisionary
//
//  Created by Campbell McGavin on 8/6/23.
//

import SwiftUI

struct FormFilterStack: View {
    let objectType: ObjectType
    @Binding var date: Bool
    @Binding var archived: Bool
    @Binding var subGoals: Bool
    @Binding var aspect: String
    @Binding var priority: String
    @Binding var progress: Int
    
    @State var filters: [FilterType: Bool] = [FilterType:Bool]()
    @State var filterShouldChange: [FilterType: Int] = [FilterType:Int]()
    @State var aspects: [String] = [String]()
    @State var statuses: [String] = StatusType.allCases.map({$0.toString()})
    @State var priorities: [String] = PriorityType.allCases.map({$0.toString()})
    @State var shouldClearAll: Bool = false
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false){
            HStack(alignment:.top){
                
                let hasFilters = filters.values.filter({$0}).count > 0
                
                TextIconButton(isPressed: $shouldClearAll, text: "Clear all", color: hasFilters ? .grey10 : .grey3, backgroundColor: hasFilters ? .red : .grey1, fontSize: .subCaption, shouldFillWidth: false, iconType: .cancel)
                    .disabled(!hasFilters)
                
                ForEach(filters.sorted{
                    if $0.value == $1.value {
                        return $0.key.toInt() < $1.key.toInt()
                    }
                    return $0.value && !$1.value
                }.map({$0.key}), id:\.self){ filter in
                    
                    if objectType.hasFilter(filter: filter){
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
            filters[.completed] = progress == 100
            
            filterShouldChange[.archived] = archived ? 2 : 0
            filterShouldChange[.subGoals] = subGoals ? 2 : 0
            filterShouldChange[.aspect] = aspect.count > 0 ? 2 : 0
            filterShouldChange[.priority] = priority.count > 0 ? 2 : 0
            filterShouldChange[.completed] = progress == 100 ? 2 : 0
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
            progress = 0
            date = false
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
                            
                            if filter == .completed {
                                progress = 100
                            }
                            if filter == .subGoals{
                                subGoals = true
                            }
                            
                            if filter == .archived{
                                archived = true
                            }
                            
                            if filter == .date{
                                date = true
                            }
                        }
                        
                    }
                    else{
                        filterShouldChange[filter] = 0
                        filters[filter] = false
                        
                        
                        switch filter{
                        case .aspect: aspect = ""
                        case .priority: priority = ""
                        case .completed: progress = 99
                        case .subGoals: subGoals = false
                        case .archived: archived = false
                        case .date: date = false
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
        case .completed:
            return filter.toString()
        case .date:
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
        FormFilterStack(objectType: .goal, date: .constant(true), archived: .constant(false), subGoals: .constant(true), aspect: .constant(""), priority: .constant(""), progress: .constant(0))
    }
}
