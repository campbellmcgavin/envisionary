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
    @State var shouldShowSuperOnly = false
    @State var shouldShowAspectOnly = ""
    @State var shouldShowPriorityOnly = ""
    @State var shouldShowProgressOnly = ""
    
    @EnvironmentObject var vm: ViewModel
    var body: some View {
        
        Modal(modalType: .search, objectType: objectType, isPresenting: $isPresenting, shouldConfirm: .constant(false), isPresentingImageSheet: .constant(false), allowConfirm: true, modalContent: { GetContent() }, headerContent: { EmptyView() }, bottomContent: {EmptyView()},
              betweenContent: {
            HStack{
                
                FormFilterStack(objectType: objectType, archived: $shouldShowArchivedOnly, superGoal: $shouldShowSuperOnly, aspect: $shouldShowAspectOnly, priority: $shouldShowPriorityOnly, progress: $shouldShowProgressOnly)
                
//                TextIconButton(isPressed: $shouldShowArchivedOnly, text: "Archived", color: .grey10, backgroundColor: shouldShowArchivedOnly ? .purple : .grey3, fontSize: .caption, shouldFillWidth: false, iconType: .archived_filled)
//
//                if objectType == .goal{
//                    TextIconButton(isPressed: $shouldShowSuperOnly, text: "Super goals", color: .grey10, backgroundColor: shouldShowSuperOnly ? .purple : .grey3, fontSize: .caption, shouldFillWidth: false, iconType: .maximize)
//                }
//
//                Spacer()
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
        .onChange(of: shouldShowProgressOnly){
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
        .onChange(of: shouldShowSuperOnly){
            _ in
            GetFullList()
        }
        .onAppear{
            GetFullList()
        }
    }
    
    func GetFullList(){
        var criteria = Criteria()
        
        criteria.archived = shouldShowArchivedOnly
        criteria.includeCalendar = !shouldShowSuperOnly
        criteria.progress = shouldShowProgressOnly.count > 0 ? StatusType.fromString(from: shouldShowProgressOnly).toInt() : nil
        criteria.priority = shouldShowPriorityOnly.count > 0 ? PriorityType.fromString(input: shouldShowPriorityOnly) : nil
        criteria.aspect = shouldShowAspectOnly.count > 0 ? shouldShowAspectOnly : nil
        
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
        case .chapter:
            objectsFiltered = vm.ListChapters(criteria: criteria).map({Properties(chapter: $0)})
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
                    PhotoCard(objectType: objectType, objectId: properties.id, properties: properties)
                }
            }
            
            if objectsFiltered.count == 0 {
                LabelAstronaut(opacity: 1.0)
                    .padding(.top,80)
                    .padding(.bottom,80)
            }
        }
    }
}

struct ModalSearch_Previews: PreviewProvider {
    static var previews: some View {
        ModalSearch(isPresenting: .constant(true), objectType: .goal)
            .environmentObject(ViewModel())
    }
}
