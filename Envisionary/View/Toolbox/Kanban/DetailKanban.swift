//
//  DetailKanban.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/2/23.
//

import SwiftUI

struct DetailKanban: View {
    
    @Binding var shouldExpand: Bool
    @Binding var isPresentingModal: Bool
    @Binding var modalType: ModalType
    @Binding var focusGoal: UUID
    @Binding var statusToAdd: StatusType
    var goalId: UUID
    @State var expandedGoals = [UUID]()
    
    let isStatic = false
    @State var isExpanded: Bool = true
    @EnvironmentObject var gs: GoalService
    
    @State var draggingObject: IdItem? = nil
    @State var shouldUpdateGoal = false
    @State var currentPlaceToDrop: StatusType? = nil
    @State var shouldHideElements = false
    
    var body: some View {
        DetailView(viewType: .kanban, objectId: goalId, selectedObjectId: $focusGoal, selectedObjectType: .constant(.goal), shouldExpandAll: $shouldExpand, expandedObjects: $expandedGoals, isPresentingModal: $isPresentingModal, modalType: $modalType, content: {

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(StatusType.allCases, id:\.self) { status in
                        BoardListView(statusType: status, objectId: goalId, selectedObjectId: $focusGoal, isPresentingModal: $isPresentingModal, modalType: $modalType, statusToAdd: $statusToAdd, draggingObject: $draggingObject, shouldUpdateGoal: $shouldUpdateGoal, shouldHideElements: $shouldHideElements, currentPlaceToDrop: $currentPlaceToDrop)
                            .onDrop(of: [.text],
                                    delegate:
                                        DropViewDelegate(destinationItem: status, currentPlaceToDrop: $currentPlaceToDrop, draggingObject: $draggingObject, shouldUpdateGoal: $shouldUpdateGoal, shouldHideElements: $shouldHideElements))
                            .onChange(of: shouldUpdateGoal){
                                _ in
                                if let draggingObject = self.draggingObject {
                                    if let goal = gs.GetGoal(id: draggingObject.id){
                                        
                                        var request = UpdateGoalRequest(goal: goal)
                                        
                                        switch currentPlaceToDrop {
                                        case .notStarted:
                                            request.progress = 0
                                        case .inProgress:
                                            request.progress = 50
                                        case .completed:
                                            request.progress = 100
                                        default:
                                            let _ = ""
                                            
                                        }
                                        withAnimation{
                                            _ = gs.UpdateGoal(id: goal.id, request: request)
                                        }
                                    }
                                }
                            }
                    }
                }
            }
            .onChange(of:statusToAdd){
                _ in
                print(statusToAdd)
            }
            .padding(.top,-29)
                .disabled(isStatic)
                .frame(alignment:.topLeading)
        })
    }
    

    
    struct DropViewDelegate: DropDelegate {
        
        let destinationItem: StatusType
        @Binding var currentPlaceToDrop: StatusType?
        @Binding var draggingObject: IdItem?
        @Binding var shouldUpdateGoal: Bool
        @Binding var shouldHideElements: Bool
        
        func dropUpdated(info: DropInfo) -> DropProposal? {
            return DropProposal(operation: .move)
        }
        
        func performDrop(info: DropInfo) -> Bool {
            draggingObject = nil
            withAnimation{
                shouldHideElements = false
            }

            return true
        }
        
        func dropExited(info: DropInfo) {
            withAnimation{
//                shouldHideElements = false
            }
            
        }
        
        func dropEntered(info: DropInfo) {
            shouldHideElements = true
            currentPlaceToDrop = destinationItem
            shouldUpdateGoal.toggle()
            
            // Swap Items
            
        }
    }
}

struct IdItem: Identifiable, Codable, Transferable {
    var id: UUID
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(for: IdItem.self, contentType: .text)
    }
}
