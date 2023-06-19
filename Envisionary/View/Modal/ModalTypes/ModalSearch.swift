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
    
    
    @State var searchString = ""
    @State var objectType: ObjectType
    @State var objectsFiltered = [Properties]()
    
    @State var shouldShowObject = false
    @EnvironmentObject var vm: ViewModel
    var body: some View {
        
        Modal(modalType: .search, objectType: objectType, isPresenting: $isPresenting, shouldConfirm: .constant(false), isPresentingImageSheet: .constant(false), allowConfirm: .constant(true), modalContent: {
            GetContent()

        }, headerContent: {
            let timer = Timer.publish(every: 0.6, on: .main, in: .common).autoconnect()
            
            VStack{
                if(shouldShowObject){
                    ScrollPickerObject(objectType: $objectType, isSearch: true)
                        .frame(maxWidth:.infinity).padding([.leading,.trailing])
                        .offset(y:60)
                }
            }
            .onAppear{
                objectType = vm.filtering.filterObject
                shouldShowObject = false

            }
            .onChange(of: objectType){
                _ in
                GetFullList()
            }
            .onReceive(timer){ _ in
                withAnimation{
                    shouldShowObject = true
                    timer.upstream.connect().cancel()
                }
            }
        }, bottomContent: {EmptyView()}, betweenContent: {EmptyView()})
        .onChange(of:searchString){ _ in
            GetFullList()
        }
    }
    
    func GetFullList(){
        switch objectType {
        case .value:
            if searchString.count == 0 {
                objectsFiltered = vm.ListCoreValues(criteria: Criteria()).map({Properties(value: $0)})
            }
            else{
                objectsFiltered = vm.ListCoreValues(criteria: Criteria(title: searchString)).map({Properties(value: $0)})
            }
        case .dream:
            if searchString.count == 0 {
                objectsFiltered = vm.ListDreams(criteria: Criteria()).map({Properties(dream: $0)})
            }
            else{
                objectsFiltered = vm.ListDreams(criteria: Criteria(title: searchString)).map({Properties(dream: $0)})
            }
        case .aspect:
            if searchString.count == 0 {
                objectsFiltered = vm.ListAspects(criteria: Criteria()).map({Properties(aspect: $0)})
            }
            else{
                var criteria = Criteria()
                criteria.aspect = searchString
                objectsFiltered = vm.ListAspects(criteria: Criteria(title: searchString)).map({Properties(aspect: $0)})
            }
        case .goal:
            if searchString.count == 0 {
                objectsFiltered = vm.ListGoals(criteria: Criteria()).map({Properties(goal: $0)})
            }
            else{
                objectsFiltered = vm.ListGoals(criteria: Criteria(title: searchString)).map({Properties(goal: $0)})
            }
        case .habit:
            if searchString.count == 0 {
                objectsFiltered = vm.ListHabits().map({Properties(habit: $0)})
            }
            else{
                objectsFiltered = vm.ListHabits(criteria: Criteria(title: searchString)).map({Properties(habit: $0)})
            }
//        case .task:
//            if searchString.count == 0 {
//                objectsFiltered = vm.ListTasks(criteria: Criteria()).map({Properties(task: $0)})
//            }
//            else{
//                objectsFiltered = vm.ListTasks(criteria: Criteria(title: searchString)).map({Properties(task: $0)})
//            }
        case .chapter:
            if searchString.count == 0 {
                objectsFiltered = vm.ListChapters().map({Properties(chapter: $0)})
            }
            else{
                objectsFiltered = vm.ListChapters(criteria: Criteria(title: searchString)).map({Properties(chapter: $0)})
            }
        case .entry:
            if searchString.count == 0 {
                objectsFiltered = vm.ListEntries().map({Properties(entry: $0)})
            }
            else{
                objectsFiltered = vm.ListEntries(criteria: Criteria(title: searchString)).map({Properties(entry: $0)})
            }
        default:
            let _ = "why"
        }
    }
    
    @ViewBuilder
    func GetContent() -> some View {
        LazyVStack(spacing:10){
            
            FormText(fieldValue: $searchString, fieldName: "Search", axis: .horizontal, iconType: .search)
                .padding(8)
            
            ScrollView(.vertical){
                ForEach(objectsFiltered){
                    properties in
                    PhotoCard(objectType: objectType, objectId: properties.id, properties: properties)
                }
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
