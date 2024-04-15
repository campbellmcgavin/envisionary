//
//  ModalSearch.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/20/23.
//

import SwiftUI

struct ModalSearch: View {
    @Binding var isPresenting: Bool
//    let objectType: ObjectType
    
    @State var objectType: ObjectType
    @State var searchString = ""
    @State var objectsFiltered = [Properties]()
    @State var shouldShowArchivedOnly = false
    @State var shouldShowSubgoals = false
    @State var shouldShowAspectOnly = ""
    @State var shouldShowPriorityOnly = ""
    @State var shouldShowStatusOnly = StatusType.none
    @State var shouldShowCalendar: DateFilterType = .none
    @State var shouldShowEntries: Bool = false
    @EnvironmentObject var vm: ViewModel
    var body: some View {
        
        Modal(modalType: .search, objectType: objectType, isPresenting: $isPresenting, shouldConfirm: .constant(false), isPresentingImageSheet: .constant(false), allowConfirm: true, modalContent: { GetContent() }, headerContent: { EmptyView() }, bottomContent: {EmptyView()},
              betweenContent: {
            HStack{
                
                FormFilterStack(objectType: objectType, date: $shouldShowCalendar, archived: $shouldShowArchivedOnly, subGoals: $shouldShowSubgoals, aspect: $shouldShowAspectOnly, priority: $shouldShowPriorityOnly, progress: $shouldShowStatusOnly, creed: .constant(false), entry: $shouldShowEntries, isSearch: true)
            }
        })
        .onChange(of:searchString){ _ in
            GetFullList()
        }
        .onChange(of: shouldShowArchivedOnly){
            _ in
            GetFullList()
        }
        .onChange(of: shouldShowAspectOnly){
            _ in
            GetFullList()
        }
        .onChange(of: shouldShowStatusOnly){
            _ in
            GetFullList()
        }
        .onChange(of: shouldShowPriorityOnly){
            _ in
            GetFullList()
        }
        .onChange(of: vm.filtering.filterObject){
            _ in
            objectType = vm.filtering.filterObject
            GetFullList()
        }
        .onChange(of: shouldShowSubgoals){
            _ in
            GetFullList()
        }
        .onChange(of: shouldShowEntries){ _ in
            GetFullList()
        }
        .onAppear{
            GetFullList()
        }
    }
    
    func GetFullList(){
        var criteria = Criteria()        
        criteria.archived = shouldShowArchivedOnly
        criteria.progress = shouldShowStatusOnly
        criteria.priority = shouldShowPriorityOnly.count > 0 ? shouldShowPriorityOnly : nil
        criteria.aspect = shouldShowAspectOnly.count > 0 ? shouldShowAspectOnly : nil
        criteria.superOnly = !shouldShowSubgoals
        
        if searchString.count > 0{
            criteria.title = searchString
        }
        
        switch objectType {
        case .dream:
            objectsFiltered = vm.ListDreams(criteria: criteria).map({Properties(dream: $0)})
        case .goal:
            objectsFiltered = vm.ListGoals(criteria: criteria).map({Properties(goal: $0)})
        case .habit:
            objectsFiltered = vm.ListHabits(criteria: criteria).map({Properties(habit: $0)})
        case .journal:
            if shouldShowEntries {
                objectsFiltered = vm.ListEntries(criteria: criteria).map({Properties(entry: $0)})
            }
            else{
                objectsFiltered = vm.ListChapters(criteria: criteria).map({Properties(chapter: $0)})
            }
        case .entry:
            objectsFiltered = vm.ListEntries(criteria: criteria).map({Properties(entry: $0)})
        default:
            let _ = "why"
        }
    }
    
    @ViewBuilder
    func GetContent() -> some View {
        LazyVStack(spacing:10){
            
            FormText(fieldValue: $searchString, fieldName: "Search", axis: .horizontal, iconType: .search)
                .padding([.top,.leading,.trailing],8)
                .padding(.bottom, objectsFiltered.count > 0 ? 15 : 0)
            
            ScrollView(.vertical){
                ForEach(objectsFiltered){
                    properties in
                    PhotoCard(objectType: GetObjectType(), objectId: properties.id, properties: properties)
                }
            }
            
            if objectsFiltered.count == 0 {
                LabelAstronaut(opacity: 1.0)
                    .padding(.top,80)
                    .padding(.bottom,80)
            }
        }
    }
    
    func GetObjectType() -> ObjectType {
        if objectType == .journal {
            return shouldShowEntries ? .entry : .journal
        }
        return objectType
    }
}

struct ModalSearch_Previews: PreviewProvider {
    static var previews: some View {
        ModalSearch(isPresenting: .constant(true), objectType: .goal)
            .environmentObject(ViewModel())
    }
}
