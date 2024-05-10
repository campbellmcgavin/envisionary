//
//  CheckOff.swift
//  Envisionary
//
//  Created by Campbell McGavin on 10/22/23.
//

import SwiftUI

struct CheckOff: View {
    let goalId: UUID
    let properties: Properties
    let canEdit: Bool
    let proxy: ScrollViewProxy?
    @Binding var isPresenting: Bool
    @Binding var modalType: ModalType
    @State var focusGoal: UUID = UUID()
    @State var shouldShowAll = false
    @State var dropFields: CheckOffDropDelegateField = CheckOffDropDelegateField()
    @State var newGoalId: UUID? = nil
    
    @EnvironmentObject var vm: ViewModel
    @State var goal: Goal = Goal()
    
    var body: some View {
        VStack(spacing:0){
            PhotoCard(objectType: .goal, objectId: goalId, properties: properties, shouldHidePadding: true, imageSize: .mediumLarge)
                .padding([.leading,.trailing],15)
                .modifier(ModifierCard(color:.grey15))
            
            CheckoffView(shouldShowAll: $shouldShowAll, focusGoal: $focusGoal, newGoalId: $newGoalId, parentGoalId: properties.id, goalId: properties.id, leftPadding: -21, outerPadding: 8, canEdit: canEdit, proxy: proxy, shouldDismissInteractively: true, isLocal: false, value: { goalId, leftPadding, outerPadding  in
                CheckoffCard(goalId: goalId, superId: self.goalId, canEdit: canEdit, leftPadding: leftPadding, outerPadding: outerPadding, proxy: proxy, shouldDismissInteractively: true, isLocal: false, selectedGoalId: $focusGoal, isPresentingModal: $isPresenting, modalType: $modalType,  newGoalId: $newGoalId, dropFields: $dropFields)
                    .contentShape(Rectangle())
            })
            .shouldDisable(disable: goal.archived)
            .onChange(of: dropFields.dropPerformed){
                _ in
                vm.UpdateGoalFromDragAndDrop(focusId: dropFields.currentItem?.id, selectedId: dropFields.currentDropTarget, selectedPlacement: dropFields.currentDropPlacement)
                dropFields.currentDropPlacement = nil
                dropFields.currentDropTarget = nil
                dropFields.currentItem = nil
            }
            .onAppear{
                goal = vm.GetGoal(id: goalId) ?? Goal()
            }
            
        }.padding(.top,-4)
            .frame(alignment:.top)
            .frame(height:300)
            .modifier(ModifierCard(color:.grey05))
    }
}

struct ProgressCard: View {
    let goalId: UUID
    let properties: Properties
    let canEdit: Bool
    let proxy: ScrollViewProxy?
    @Binding var isPresenting: Bool
    @Binding var modalType: ModalType
    @State var focusGoal: UUID = UUID()
    @State var shouldShowAll = false
    @State var dropFields: CheckOffDropDelegateField = CheckOffDropDelegateField()
    @State var newGoalId: UUID? = nil
    
    @EnvironmentObject var vm: ViewModel
    @State var goal: Goal = Goal()
    
    var body: some View {
        VStack(alignment:.leading, spacing:0){
            PhotoCard(objectType: .goal, objectId: goalId, properties: properties, shouldHidePadding: true, imageSize: .mediumLarge)
                .padding([.leading,.trailing],15)
                .modifier(ModifierCard(color:.grey15))
            
            
            ProgressView(id: goalId, objectType: .goal, isCompact: true)
                .frame(maxWidth:UIScreen.screenWidth - 8)
            .onAppear{
                goal = vm.GetGoal(id: goalId) ?? Goal()
            }
            
        }.padding(.top,-4)
            .frame(alignment:.top)
            .frame(height:300)
            .modifier(ModifierCard(color:.grey05))
    }
}
