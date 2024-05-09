//
//  DetailGoalToolbox.swift
//  Envisionary
//
//  Created by Campbell McGavin on 8/9/23.
//

import SwiftUI

struct DetailGoalToolbox: View {
    @Binding var shouldExpand: Bool
    @Binding var isPresentingModal: Bool
    @Binding var isPresentingSourceType: Bool
    @Binding var modalType: ModalType
    @Binding var focusGoal: UUID
    @State var viewType: ViewType = .checkOff
    var goalId: UUID
    let proxy: ScrollViewProxy
    let isStatic = false
    @State var newGoalId: UUID? = nil
    @State var image: UIImage? = nil
    @State var expandedGoals = [UUID]()
    @State var isExpanded: Bool = true
    @State var currentTimeframe: TimeframeType = .year
    @State var shouldSelectTree = false
    @State var shouldSelectGantt = false
    @State var shouldSelectKanban = false
    @State var didEditPrimaryGoal = false
    @State var goal: Goal = Goal()
    @State var selectedView = ViewType.tree.toString()
    @State var shouldShowAllCheckOff = false
    @State var viewOptions: [String] = [String]()
    @State var dropFields: CheckOffDropDelegateField = CheckOffDropDelegateField()
    @State var properties: [Properties] = [Properties]()
    
    @EnvironmentObject var vm: ViewModel
    
    
    var body: some View {
        DetailView(viewType: viewType, objectId: goalId, selectedObjectId: $focusGoal, selectedObjectType: .constant(.goal), shouldExpandAll: $shouldExpand, expandedObjects: $expandedGoals, isPresentingModal: $isPresentingModal, modalType: $modalType, isPresentingSourceType: $isPresentingSourceType, didEditPrimaryGoal: $didEditPrimaryGoal, currentTimeframe: currentTimeframe, alternativeTitle: "Toolbox", content: {
            
            VStack{
                switch viewType {
                case .gantt:
                    MasterGanttView(properties: $properties, isLocal: true)
                        .padding(.top)
                case .progress:                    
                    ProgressView(id: goalId, objectType: .goal)
                case .checkOff:
                    CheckoffView(shouldShowAll: $shouldShowAllCheckOff, focusGoal: $focusGoal, newGoalId: $newGoalId, parentGoalId: goalId, goalId: goalId, leftPadding: -27, outerPadding: 17, canEdit: true, proxy: proxy, shouldDismissInteractively: true, isLocal: true, value: {
                        goalId, leftPadding, outerPadding in
                        CheckoffCard(goalId: goalId, superId: self.goalId, canEdit: true, leftPadding: leftPadding, outerPadding: outerPadding, proxy: proxy, shouldDismissInteractively: true, isLocal: true, selectedGoalId: $focusGoal, isPresentingModal: $isPresentingModal, modalType: $modalType, newGoalId: $newGoalId, dropFields: $dropFields)
                    })
                    .padding(.top,4)
                    .onChange(of: dropFields.dropPerformed){
                        _ in
                        vm.UpdateGoalFromDragAndDrop(focusId: dropFields.currentItem?.id, selectedId: dropFields.currentDropTarget, selectedPlacement: dropFields.currentDropPlacement)
                        
                        dropFields.currentDropPlacement = nil
                        dropFields.currentDropTarget = nil
                        dropFields.currentItem = nil
                    }
                default:
                    EmptyView()
                }
            }
            .onChange(of: selectedView){
                _ in
                viewType = ViewType.fromString(from: selectedView)
            }
            .onAppear(){
                if !expandedGoals.contains(goalId){
                    expandedGoals.append(goalId)
                }
                if let goal = vm.GetGoal(id: goalId){
                    if let image = goal.image{
                        self.image = vm.GetImage(id: image)
                    }
                }
                goal = vm.GetGoal(id: goalId) ?? Goal()
                properties.removeAll()
                properties.append(Properties(goal: goal))
                
                viewOptions.removeAll()
                
                viewOptions.append(ViewType.checkOff.toString())
                viewOptions.append(ViewType.gantt.toString())
//                viewOptions.append(ViewType.kanban.toString())
                viewOptions.append(ViewType.progress.toString())
                
                selectedView = viewType.toString()
            }
            .onChange(of: vm.updates.goal){
                _ in
                goal = vm.GetGoal(id: goalId) ?? Goal()
                
                if properties.first != nil {
                    properties = [Properties(goal: goal)]
                }
                
            }
        }, aboveContent: {
            SelectableHStack(fieldValue: $selectedView, options: $viewOptions, fontSize: .h6)
                .padding(8)
                .modifier(ModifierCard(color:.grey1))
        })
    }
}
