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
    
    let isStatic = false
    @State var isExpanded: Bool = true
    
    var body: some View {

        DetailView(viewType: .tree, objectId: goalId, selectedObjectId: $focusGoal, selectedObjectType: .constant(.goal), shouldExpandAll: $shouldExpand, expandedObjects: $expandedGoals, isPresentingModal: $isPresentingModal, modalType: $modalType, content: {

            
                ScrollView([.horizontal],showsIndicators: true){
                    VStack(alignment:.leading, spacing:0){
                        TreeDiagramView(goalId: goalId, focusGoal: $focusGoal, expandedGoals: $expandedGoals, value: { goalId in
                            BubbleView(goalId: goalId, focusGoal: $focusGoal)
                        }, childCount: 0)
                        .padding(.top,5)
                        .padding(.bottom)
                }
                .frame(alignment:.leading)
                .onAppear{
                    expandedGoals.append(goalId)
                }
            }
                .disabled(isStatic)
                .frame(alignment:.leading)
        })
    }
                   
}

