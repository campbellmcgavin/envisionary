//
//  ModalGrouping.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/20/23.
//

import SwiftUI

struct ModalSettings: View {
    @Binding var isPresenting: Bool
    @State var groupingGoal: String = GroupingType.title.toPluralString()
    @State var groupingTask: String = GroupingType.progress.toPluralString()
    @State var groupingHabit: String = GroupingType.schedule.toPluralString()
    @State var groupingDream: String = GroupingType.title.toPluralString()
    @State var groupingChapter: String = GroupingType.title.toPluralString()
    @State var groupingEntry: String = GroupingType.chapter.toPluralString()
    
    @State var promptObject: Bool = false
    @State var promptContent: Bool = false
    @State var promptShowing: Bool = false
    @State var shouldExpandAll: Bool = true
//    @State var groupingEmotion: String = GroupingType.title.toPluralString()
    
    @EnvironmentObject var vm: ViewModel
    var body: some View {
        Modal(modalType: .group, objectType: .home, isPresenting: $isPresenting, shouldConfirm: $isPresenting, isPresentingImageSheet: .constant(false), allowConfirm: true, modalContent: {
            
            VStack(spacing:0){
                ParentHeaderButton(shouldExpandAll: $shouldExpandAll, color: .purple, header: "Expand All", headerCollapsed: "Collapse All")
                GetContent()
                GetContentPrompts()
                Spacer()
            }
            .frame(minHeight:180)
            .padding(.top,8)
            
        }, headerContent:{EmptyView()}, bottomContent: {EmptyView()}, betweenContent: {EmptyView()})
        
            .onAppear{
//                groupingDream = vm.grouping.dream.toPluralString()
//                groupingGoal = vm.grouping.goal.toPluralString()
//                groupingTask = vm.grouping.task.toPluralString()
//                groupingHabit = vm.grouping.habit.toPluralString()
//                groupingChapter = vm.grouping.chapter.toPluralString()
//                groupingEntry = vm.grouping.entry.toPluralString()
//                promptObject = vm.helpPrompts.object
//                promptContent = vm.helpPrompts.content
//                promptShowing = vm.helpPrompts.showing
            }
            .onChange(of: groupingDream){
                _ in
                vm.grouping.dream = GroupingType.allCases.first(where:{$0.toPluralString() == groupingDream}) ?? .title
                UserDefaults.standard.set(groupingDream, forKey: SettingsKeyType.group_dream.toString())
            }
            .onChange(of: groupingGoal){
                _ in
                vm.grouping.goal = GroupingType.allCases.first(where:{$0.toPluralString() == groupingGoal}) ?? .title
                UserDefaults.standard.set(groupingGoal, forKey: SettingsKeyType.group_goal.toString())
            }
            .onChange(of: groupingTask){
                _ in
                vm.grouping.task = GroupingType.allCases.first(where:{$0.toPluralString() == groupingTask}) ?? .title
                UserDefaults.standard.set(groupingTask, forKey: SettingsKeyType.group_task.toString())
            }
            .onChange(of: groupingHabit){
                _ in
                vm.grouping.habit = GroupingType.allCases.first(where:{$0.toPluralString() == groupingHabit}) ?? .title
                UserDefaults.standard.set(groupingHabit, forKey: SettingsKeyType.group_habit.toString())
            }
            .onChange(of: groupingChapter){
                _ in
                vm.grouping.chapter = GroupingType.allCases.first(where:{$0.toPluralString() == groupingChapter}) ?? .title
                UserDefaults.standard.set(groupingChapter, forKey: SettingsKeyType.group_chapter.toString())
            }
            .onChange(of: groupingEntry){
                _ in
                vm.grouping.entry = GroupingType.allCases.first(where:{$0.toPluralString() == groupingEntry}) ?? .title
                UserDefaults.standard.set(groupingEntry, forKey: SettingsKeyType.group_entry.toString())
            }
            .onChange(of: promptObject){
                _ in
                vm.helpPrompts.object = promptObject
                UserDefaults.standard.set(vm.helpPrompts.object, forKey: SettingsKeyType.help_prompts_object.toString())
            }
            .onChange(of: promptContent){
                _ in
                vm.helpPrompts.content = promptContent
                UserDefaults.standard.set(vm.helpPrompts.content, forKey: SettingsKeyType.help_prompts_content.toString())
            }
            .onChange(of: promptShowing){
                _ in
                vm.helpPrompts.showing = promptShowing
                UserDefaults.standard.set(vm.helpPrompts.showing, forKey: SettingsKeyType.help_prompts_showing.toString())
            }
        
    }
    
    @ViewBuilder
    func GetContentPrompts() -> some View {
        HeaderWithContent(shouldExpand: $shouldExpandAll, headerColor: .grey10, header: "Help Prompts", content: {
            VStack(spacing:10){
                FormRadioButton(fieldValue: $promptContent, caption: "Prompt", fieldName: HelpPromptType.content.toString(), iconType: .help)
                FormRadioButton(fieldValue: $promptObject, caption: "Prompt", fieldName: HelpPromptType.object.toString(), iconType: .help)
                FormRadioButton(fieldValue: $promptShowing, caption: "Prompt", fieldName: HelpPromptType.showing.toString(), iconType: .help)
            }
            .padding([.leading,.trailing],8)
            .padding([.top])
        })
    }
    
    @ViewBuilder
    func GetContent() -> some View {
        
        HeaderWithContent(shouldExpand: $shouldExpandAll, headerColor: .grey10, header: "Grouping", content: {
            VStack(spacing:10){
                
                FormStackPicker(fieldValue: $groupingDream, fieldName: "Group " + ObjectType.dream.toPluralString() + " by", options: .constant(GroupingType.allCases.filter({$0.hasObject(object: .dream)}).map({$0.toPluralString()})), iconType: .group)
                
                FormStackPicker(fieldValue: $groupingGoal, fieldName: "Group " + ObjectType.goal.toPluralString() + " by", options: .constant(GroupingType.allCases.filter({$0.hasObject(object: .goal)}).map({$0.toPluralString()})), iconType: .group)
                
                FormStackPicker(fieldValue: $groupingHabit, fieldName: "Group " + ObjectType.habit.toPluralString() + " by", options: .constant(GroupingType.allCases.filter({$0.hasObject(object: .habit)}).map({$0.toPluralString()})), iconType: .group)
                
                //            FormStackPicker(fieldValue: $groupingTask, fieldName: "Group " + ObjectType.task.toPluralString() + " by", options: .constant(GroupingType.allCases.filter({$0.hasObject(object: .task)}).map({$0.toPluralString()})), iconType: .group)
                //
                FormStackPicker(fieldValue: $groupingChapter, fieldName: "Group " + ObjectType.chapter.toPluralString() + " by", options: .constant(GroupingType.allCases.filter({$0.hasObject(object: .chapter)}).map({$0.toPluralString()})), iconType: .group)
                
                FormStackPicker(fieldValue: $groupingEntry, fieldName: "Group " + ObjectType.entry.toPluralString() + " by", options: .constant(GroupingType.allCases.filter({$0.hasObject(object: .entry)}).map({$0.toPluralString()})), iconType: .group)
                
            }
            .padding([.leading,.trailing],8)
            .padding([.top])
        })
        
    }    
}

struct ModalGrouping_Previews: PreviewProvider {
    static var previews: some View {
        ModalSettings(isPresenting: .constant(true))
    }
}
