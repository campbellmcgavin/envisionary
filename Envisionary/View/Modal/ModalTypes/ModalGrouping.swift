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
    @State var groupingSession: String = GroupingType.date.toPluralString()
    @State var groupingChapter: String = GroupingType.title.toPluralString()
    @State var groupingEntry: String = GroupingType.chapter.toPluralString()
    
    @EnvironmentObject var vm: ViewModel
    var body: some View {
        Modal(modalType: .group, objectType: .home, isPresenting: $isPresenting, shouldConfirm: $isPresenting, isPresentingImageSheet: .constant(false), modalContent: {GetContent()}, headerContent:{EmptyView()})
            .onAppear{
                groupingGoal = vm.grouping.goal.toPluralString()
                groupingDream = vm.grouping.dream.toPluralString()
            }
            .onChange(of: groupingGoal){
                _ in
                vm.grouping.goal = GroupingType.allCases.first(where:{$0.toPluralString() == groupingGoal}) ?? .title
            }
            .onChange(of: groupingDream){
                _ in
                vm.grouping.dream = GroupingType.allCases.first(where:{$0.toPluralString() == groupingDream}) ?? .title
            }
    }
    
    @ViewBuilder
    func GetContent() -> some View {
        VStack(spacing:10){
            
            FormStackPicker(fieldValue: $groupingGoal, fieldName: "Group " + ObjectType.goal.toPluralString() + " by", options: GroupingType.allCases.filter({$0.hasObject(object: .goal)}).map({$0.toPluralString()}))
            FormStackPicker(fieldValue: $groupingTask, fieldName: "Group " + ObjectType.task.toPluralString() + " by", options: GroupingType.allCases.filter({$0.hasObject(object: .task)}).map({$0.toPluralString()}))
            FormStackPicker(fieldValue: $groupingHabit, fieldName: "Group " + ObjectType.habit.toPluralString() + " by", options: GroupingType.allCases.filter({$0.hasObject(object: .habit)}).map({$0.toPluralString()}))
            FormStackPicker(fieldValue: $groupingDream, fieldName: "Group " + ObjectType.dream.toPluralString() + " by", options: GroupingType.allCases.filter({$0.hasObject(object: .dream)}).map({$0.toPluralString()}))
            FormStackPicker(fieldValue: $groupingSession, fieldName: "Group " + ObjectType.session.toPluralString() + " by", options: GroupingType.allCases.filter({$0.hasObject(object: .session)}).map({$0.toPluralString()}))
            FormStackPicker(fieldValue: $groupingChapter, fieldName: "Group " + ObjectType.chapter.toPluralString() + " by", options: GroupingType.allCases.filter({$0.hasObject(object: .chapter)}).map({$0.toPluralString()}))
            FormStackPicker(fieldValue: $groupingEntry, fieldName: "Group " + ObjectType.entry.toPluralString() + " by", options: GroupingType.allCases.filter({$0.hasObject(object: .entry)}).map({$0.toPluralString()}))
            
        }
        .padding(8)
    }    
}

struct ModalGrouping_Previews: PreviewProvider {
    static var previews: some View {
        ModalGrouping(isPresenting: .constant(true))
    }
}
