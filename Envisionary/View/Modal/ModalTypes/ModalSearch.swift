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
    @State var tasksFiltered = [Task]()
    @State var valuesFiltered = [CoreValue]()
    @State var dreamsFiltered = [Dream]()
    @State var aspectsFiltered = [Aspect]()
    @State var goalsFiltered = [Goal]()
    
    @State var shouldShowObject = false
    @EnvironmentObject var vm: ViewModel
    var body: some View {
        
        Modal(modalType: .search, objectType: objectType, isPresenting: $isPresenting, shouldConfirm: .constant(false), isPresentingImageSheet: .constant(false), modalContent: {
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
                valuesFiltered = vm.ListCoreValues(criteria: Criteria())
            }
            else{
                valuesFiltered = vm.ListCoreValues(criteria: Criteria(title: searchString))
            }
        case .dream:
            if searchString.count == 0 {
                dreamsFiltered = vm.ListDreams(criteria: Criteria())
            }
            else{
                dreamsFiltered = vm.ListDreams(criteria: Criteria(title: searchString))
            }
        case .aspect:
            if searchString.count == 0 {
                aspectsFiltered = vm.ListAspects(criteria: Criteria())
            }
            else{
                var criteria = Criteria()
                criteria.aspect = searchString
                aspectsFiltered = vm.ListAspects(criteria: Criteria(title: searchString))
            }
        case .goal:
            if searchString.count == 0 {
                goalsFiltered = vm.ListGoals(criteria: Criteria())
            }
            else{
                goalsFiltered = vm.ListGoals(criteria: Criteria(title: searchString))
            }
        case .task:
            if searchString.count == 0 {
                tasksFiltered = vm.ListTasks(criteria: Criteria())
            }
            else{
                tasksFiltered = vm.ListTasks(criteria: Criteria(title: searchString))
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
            
            
            switch objectType {
            case .value:
                ScrollView(.vertical){
                    ForEach(valuesFiltered){
                        value in
                        PhotoCard(objectType: .value, objectId: value.id, properties: Properties(value: value), header: value.coreValue.toString(), subheader: value.description)
                    }
                }
            case .dream:
                ScrollView(.vertical){
                    ForEach(dreamsFiltered){
                        dream in
                        PhotoCard(objectType: .dream, objectId: dream.id, properties: Properties(dream: dream), header: dream.title, subheader: dream.description)
                    }
                }
            case .aspect:
                ScrollView(.vertical){
                    ForEach(aspectsFiltered){
                        aspect in
                        PhotoCard(objectType: .aspect, objectId: aspect.id, properties: Properties(aspect: aspect), header: aspect.aspect.toString(), subheader: aspect.description)
                    }
                }
            case .goal:
                ScrollView(.vertical){
                    ForEach(goalsFiltered){
                        goal in
                        PhotoCard(objectType: .goal, objectId: goal.id, properties: Properties(goal: goal), header: goal.title, subheader: goal.description)
                    }
                }
            case .task:
                ScrollView(.vertical){
                    ForEach(tasksFiltered){
                        task in
                        PhotoCard(objectType: .task, objectId: task.id, properties: Properties(task: task), header: task.title, subheader: task.description)
                    }
                }
            default:
                EmptyView()
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
