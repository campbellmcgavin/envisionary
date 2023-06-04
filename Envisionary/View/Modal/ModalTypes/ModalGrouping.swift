//
//  ModalGrouping.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/20/23.
//

import SwiftUI

struct ModalGrouping: View {
    @Binding var isPresenting: Bool
    @State var groupingGoal: String = GroupingType.title.toPluralString()
    @State var groupingTask: String = GroupingType.progress.toPluralString()
    @State var groupingHabit: String = GroupingType.schedule.toPluralString()
    @State var groupingDream: String = GroupingType.title.toPluralString()
    @State var groupingChapter: String = GroupingType.title.toPluralString()
    @State var groupingEntry: String = GroupingType.chapter.toPluralString()
    
    @EnvironmentObject var vm: ViewModel
    var body: some View {
        Modal(modalType: .group, objectType: .home, isPresenting: $isPresenting, shouldConfirm: $isPresenting, isPresentingImageSheet: .constant(false), allowConfirm: .constant(true), modalContent: {GetContent()}, headerContent:{EmptyView()}, bottomContent: {EmptyView()}, betweenContent: {EmptyView()})
            .onAppear{
                groupingDream = vm.grouping.dream.toPluralString()
                groupingGoal = vm.grouping.goal.toPluralString()
                groupingTask = vm.grouping.task.toPluralString()
                groupingHabit = vm.grouping.habit.toPluralString()
                groupingChapter = vm.grouping.chapter.toPluralString()
                groupingEntry = vm.grouping.entry.toPluralString()
            }
            .onChange(of: groupingDream){
                _ in
                vm.grouping.dream = GroupingType.allCases.first(where:{$0.toPluralString() == groupingDream}) ?? .title
            }
            .onChange(of: groupingGoal){
                _ in
                vm.grouping.goal = GroupingType.allCases.first(where:{$0.toPluralString() == groupingGoal}) ?? .title
            }
            .onChange(of: groupingTask){
                _ in
                vm.grouping.task = GroupingType.allCases.first(where:{$0.toPluralString() == groupingTask}) ?? .title
            }
            .onChange(of: groupingHabit){
                _ in
                vm.grouping.habit = GroupingType.allCases.first(where:{$0.toPluralString() == groupingHabit}) ?? .title
            }
            .onChange(of: groupingChapter){
                _ in
                vm.grouping.chapter = GroupingType.allCases.first(where:{$0.toPluralString() == groupingChapter}) ?? .title
            }
            .onChange(of: groupingEntry){
                _ in
                vm.grouping.entry = GroupingType.allCases.first(where:{$0.toPluralString() == groupingEntry}) ?? .title
            }
        
    }
    
    @ViewBuilder
    func GetContent() -> some View {
        VStack(spacing:10){
            
            FormStackPicker(fieldValue: $groupingDream, fieldName: "Group " + ObjectType.dream.toPluralString() + " by", options: .constant(GroupingType.allCases.filter({$0.hasObject(object: .dream)}).map({$0.toPluralString()})), iconType: .group)
            
            FormStackPicker(fieldValue: $groupingGoal, fieldName: "Group " + ObjectType.goal.toPluralString() + " by", options: .constant(GroupingType.allCases.filter({$0.hasObject(object: .goal)}).map({$0.toPluralString()})), iconType: .group)
            
            FormStackPicker(fieldValue: $groupingHabit, fieldName: "Group " + ObjectType.habit.toPluralString() + " by", options: .constant(GroupingType.allCases.filter({$0.hasObject(object: .habit)}).map({$0.toPluralString()})), iconType: .group)
            
            FormStackPicker(fieldValue: $groupingTask, fieldName: "Group " + ObjectType.task.toPluralString() + " by", options: .constant(GroupingType.allCases.filter({$0.hasObject(object: .task)}).map({$0.toPluralString()})), iconType: .group)
            
            FormStackPicker(fieldValue: $groupingChapter, fieldName: "Group " + ObjectType.chapter.toPluralString() + " by", options: .constant(GroupingType.allCases.filter({$0.hasObject(object: .chapter)}).map({$0.toPluralString()})), iconType: .group)
            
            FormStackPicker(fieldValue: $groupingEntry, fieldName: "Group " + ObjectType.entry.toPluralString() + " by", options: .constant(GroupingType.allCases.filter({$0.hasObject(object: .entry)}).map({$0.toPluralString()})), iconType: .group)
            
        }
        .padding(8)
    }    
}

struct ModalGrouping_Previews: PreviewProvider {
    static var previews: some View {
        ModalGrouping(isPresenting: .constant(true))
    }
}
