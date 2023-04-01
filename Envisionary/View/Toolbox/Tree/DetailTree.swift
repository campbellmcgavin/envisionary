//
//  TreeView.swift
//  Visionary
//
//  Created by Campbell McGavin on 2/4/22.
//
import SwiftUI

struct DetailTree: View {
    @Binding var shouldExpand: Bool
    @Binding var isPresentingModal: Bool
    @Binding var modalType: ModalType
    @Binding var focusGoal: UUID
    @State var expandedGoals = [UUID]()
    var goalId: UUID
    @State var isExpanded: Bool = true

    @EnvironmentObject  var dm: DataModel
    @EnvironmentObject var gs: GoalService
    @Environment(\.colorScheme) var colorScheme
    
    
    var body: some View {

        DetailView(viewType: .tree, selectedObjectId: $focusGoal, selectedObjectType: .constant(.goal), shouldExpandAll: $shouldExpand, expandedObjects: $expandedGoals, isPresentingModal: $isPresentingModal, modalType: $modalType, content: {

            
                ScrollView([.horizontal],showsIndicators: true){
                    VStack(alignment:.leading, spacing:0){
                        TreeDiagramView(goalId: goalId, focusGoal: $focusGoal, expandedGoals: $expandedGoals, value: { goal in
                            BubbleView(goalId: goal, focusGoal: $focusGoal)
                        }, childCount: 0)
                        .padding(.top,5)
                        .padding(.bottom)
                }
                .frame(alignment:.leading)
                .onAppear{
    //                focusGoal = goalId
                    expandedGoals.append(goalId)
                    //            for child in goal.children
    //                expandedGoals.append(contentsOf: gs.ListsChildGoalsByParentId(id: goalId))
                }
                .onChange(of: expandedGoals){
                    _ in
                    print(String(expandedGoals.count) + " goals in expanded goals")
                }
            }
                .frame(alignment:.leading)
        })
    }
                   
}

