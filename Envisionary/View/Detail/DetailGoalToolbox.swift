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
    var goalId: UUID
    let isStatic = false
    @State var image: UIImage? = nil
    @State var expandedGoals = [UUID]()
    @State var isExpanded: Bool = true
    @State var currentTimeframe: TimeframeType = .year
    @State var viewType: ViewType = .tree
    @State var shouldSelectTree = false
    @State var shouldSelectGantt = false
    @State var shouldSelectKanban = false
    @State var didEditPrimaryGoal = false
    @State var goal: Goal = Goal()
    @State var selectedView = ViewType.tree.toString()
    @State var viewOptions: [String] = [String]()
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        DetailView(viewType: viewType, objectId: goalId, selectedObjectId: $focusGoal, selectedObjectType: .constant(.goal), shouldExpandAll: $shouldExpand, expandedObjects: $expandedGoals, isPresentingModal: $isPresentingModal, modalType: $modalType, isPresentingSourceType: $isPresentingSourceType, didEditPrimaryGoal: $didEditPrimaryGoal, currentTimeframe: currentTimeframe, alternativeTitle: "Toolbox", content: {
            
            VStack{
                switch viewType {
                case .tree:
                    TreeView(goalId: goalId, focusGoal: $focusGoal, expandedGoals: $expandedGoals, value: { goalId in
                        BubbleView(goalId: goalId, focusGoal: $focusGoal, shouldShowStatusLabel: true)
                    }, childCount: 0)
                case .gantt:
                    GanttView(goalId: goalId, focusGoal: $focusGoal, expandedGoals: $expandedGoals, timeframe: $currentTimeframe, didEditPrimaryGoal: $didEditPrimaryGoal)
                        .padding(.top)
                case .kanban:
                    KanbanView(isPresentingModal: $isPresentingModal, modalType: $modalType, focusGoal: $focusGoal, goalId: goalId)
                        .disabled(goal.archived)
                case .goalValueAlignment:
                    if goal.parentId == nil{
                        GoalValueAlignmentView(goalId: goalId)
                            .disabled(goal.archived)
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
                viewOptions.removeAll()
                
                if goal.parentId == nil{
                    viewOptions.append(ViewType.goalValueAlignment.toString())
                }
                viewOptions.append(ViewType.tree.toString())
                viewOptions.append(ViewType.gantt.toString())
                viewOptions.append(ViewType.kanban.toString())
                selectedView = viewOptions.first!
            }
            .onChange(of: vm.updates.goal){
                _ in
                goal = vm.GetGoal(id: goalId) ?? Goal()
            }
        }, aboveContent: {
            SelectableHStack(fieldValue: $selectedView, options: $viewOptions, fontSize: .h6)
                .padding(8)
                .modifier(ModifierCard(color:.grey1))
        })
    }
}
