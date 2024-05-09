//
//  ModalGrouping.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/20/23.
//

import SwiftUI

struct ModalSettings: View {
    @Binding var isPresenting: Bool
//    @State var groupingGoal: String = GroupingType.title.toPluralString()
//    @State var groupingTask: String = GroupingType.progress.toPluralString()
//    @State var groupingHabit: String = GroupingType.schedule.toPluralString()
//    @State var groupingDream: String = GroupingType.title.toPluralString()
//    @State var groupingChapter: String = GroupingType.title.toPluralString()
//    @State var groupingEntry: String = GroupingType.chapter.toPluralString()
    
    @State var promptObject: Bool = false
    @State var promptContent: Bool = false
    @State var promptShowing: Bool = false
    @State var shouldExpandAll: Bool = true
    
    @State var reminderDigest: Bool = false
    @State var reminderEntry: Bool = false
    @State var reminderValue: Bool = false
    
    @EnvironmentObject var vm: ViewModel
    var body: some View {
        Modal(modalType: .settings, objectType: .na, isPresenting: $isPresenting, shouldConfirm: $isPresenting, isPresentingImageSheet: .constant(false), allowConfirm: true, modalContent: {
            
            VStack(spacing:0){
                ParentHeaderButton(shouldExpandAll: $shouldExpandAll, color: .purple, header: "Expand All", headerCollapsed: "Collapse All")
//                GetContent()
//                GetContentPrompts()
                GetNotificationsPrompt()
                Spacer()
            }
            .frame(minHeight:180)
            .padding(.top,8)
            
        }, headerContent:{EmptyView()}, bottomContent: {EmptyView()}, betweenContent: {EmptyView()})
        
            .onAppear{
                promptObject = vm.helpPrompts.object
                promptContent = vm.helpPrompts.content
                promptShowing = vm.helpPrompts.showing
                reminderEntry = vm.notifications.entry
                reminderDigest = vm.notifications.digest
                reminderValue = vm.notifications.valueAlignment
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
            .onChange(of: reminderEntry){
                _ in
                vm.notifications.entry = reminderEntry
                UserDefaults.standard.set(vm.notifications.entry, forKey: SettingsKeyType.notification_entry.toString())
            }
            .onChange(of: reminderValue){
                _ in
                vm.notifications.valueAlignment = reminderValue
                UserDefaults.standard.set(vm.notifications.valueAlignment, forKey: SettingsKeyType.notification_value_align.toString())
            }
            .onChange(of: reminderDigest){
                _ in
                vm.notifications.digest = reminderDigest
                UserDefaults.standard.set(vm.notifications.digest, forKey: SettingsKeyType.notification_digest.toString())
            }
            .onChange(of: vm.notifications){
                _ in
                _ = vm.CreateNotifications()
            }
    }
    
//    @ViewBuilder
//    func GetContentPrompts() -> some View {
//        HeaderWithContent(shouldExpand: $shouldExpandAll, headerColor: .grey10, header: "Help", content: {
//            VStack(spacing:10){
//                FormRadioButton(fieldValue: $promptContent, caption: "Help", fieldName: HelpPromptType.content.toString() + " Prompts", iconType: .help)
//                FormRadioButton(fieldValue: $promptObject, caption: "Help", fieldName: HelpPromptType.object.toString() + " Prompts", iconType: .help)
//            }
//            .padding([.leading,.trailing],8)
//            .padding([.top])
//        })
//    }
    
    @ViewBuilder
    func GetNotificationsPrompt() -> some View {
        HeaderWithContent(shouldExpand: $shouldExpandAll, headerColor: .grey10, header: "Notifications", content: {
            VStack(spacing:10){
                FormRadioButton(fieldValue: $reminderDigest, caption: "Mornings", fieldName: PromptType.digest.toString() + " Reminders", iconType: .notification)
                FormInlineDescription(description: PromptType.digest.toDescription())
                FormRadioButton(fieldValue: $reminderEntry, caption: "Evenings", fieldName: PromptType.entry.toString() + " Reminders", iconType: .notification)
                FormInlineDescription(description: PromptType.entry.toDescription())
                FormRadioButton(fieldValue: $reminderValue, caption: "Bi-Weekly", fieldName: PromptType.valueAlignment.toString() + " Reminders", iconType: .notification)
                FormInlineDescription(description: PromptType.valueAlignment.toDescription())
            }
            .padding([.leading,.trailing],8)
            .padding([.top])
        })
    }
    
//    @ViewBuilder
//    func GetContent() -> some View {
//
//        HeaderWithContent(shouldExpand: $shouldExpandAll, headerColor: .grey10, header: "Grouping", content: {
//            VStack(spacing:10){
//
//                FormStackPicker(fieldValue: $groupingDream, fieldName: "Group " + ObjectType.dream.toPluralString() + " by", options: .constant(GroupingType.allCases.filter({$0.hasObject(object: .dream)}).map({$0.toPluralString()})), iconType: .group)
//
//                FormStackPicker(fieldValue: $groupingGoal, fieldName: "Group " + ObjectType.goal.toPluralString() + " by", options: .constant(GroupingType.allCases.filter({$0.hasObject(object: .goal)}).map({$0.toPluralString()})), iconType: .group)
//
//                FormStackPicker(fieldValue: $groupingHabit, fieldName: "Group " + ObjectType.habit.toPluralString() + " by", options: .constant(GroupingType.allCases.filter({$0.hasObject(object: .habit)}).map({$0.toPluralString()})), iconType: .group)
//
//                //            FormStackPicker(fieldValue: $groupingTask, fieldName: "Group " + ObjectType.task.toPluralString() + " by", options: .constant(GroupingType.allCases.filter({$0.hasObject(object: .task)}).map({$0.toPluralString()})), iconType: .group)
//                //
//                FormStackPicker(fieldValue: $groupingChapter, fieldName: "Group " + ObjectType.journal.toPluralString() + " by", options: .constant(GroupingType.allCases.filter({$0.hasObject(object: .journal)}).map({$0.toPluralString()})), iconType: .group)
//
//                FormStackPicker(fieldValue: $groupingEntry, fieldName: "Group " + ObjectType.entry.toPluralString() + " by", options: .constant(GroupingType.allCases.filter({$0.hasObject(object: .entry)}).map({$0.toPluralString()})), iconType: .group)
//            }
//            .padding([.leading,.trailing],8)
//            .padding([.top,.bottom])
//        })
//
//    }
}

struct ModalGrouping_Previews: PreviewProvider {
    static var previews: some View {
        ModalSettings(isPresenting: .constant(true))
    }
}
