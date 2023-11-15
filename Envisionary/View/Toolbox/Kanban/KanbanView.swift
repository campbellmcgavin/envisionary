//
//  DetailKanban.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/2/23.
//

import SwiftUI

struct KanbanView: View {
    
    @Binding var isPresentingModal: Bool
    @Binding var modalType: ModalType
    @Binding var focusGoal: UUID
    var goalId: UUID
    
    @State var isExpanded: Bool = true
    @EnvironmentObject var vm: ViewModel
    
    @State var draggingObject: IdItem? = nil
    @State var shouldUpdateGoal = false
    @State var currentPlaceToDrop: StatusType? = nil
    @State var shouldHideElements = false
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top) {
                ForEach(StatusType.allCases, id:\.self) { status in
                    
                    BoardListView(statusType: status, objectId: goalId, selectedObjectId: $focusGoal, isPresentingModal: $isPresentingModal, modalType: $modalType, draggingObject: $draggingObject, shouldUpdateGoal: $shouldUpdateGoal, shouldHideElements: $shouldHideElements, currentPlaceToDrop: $currentPlaceToDrop)
                        .onDrop(of: [.text],
                                delegate:
                                    DropViewDelegate(destinationItem: status, currentPlaceToDrop: $currentPlaceToDrop, draggingObject: $draggingObject, shouldUpdateGoal: $shouldUpdateGoal, shouldHideElements: $shouldHideElements))
                        .onChange(of: shouldUpdateGoal){
                            _ in
                            if let draggingObject = self.draggingObject {
                                if let goal = vm.GetGoal(id: draggingObject.id){
                                    
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
                                        _ = vm.UpdateGoalProgress(id: goal.id, progress: request.progress)
                                    }
                                }
                            }
                        }
                }
            }
        }
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
            }
            
        }
        
        func dropEntered(info: DropInfo) {
            shouldHideElements = true
            currentPlaceToDrop = destinationItem
            shouldUpdateGoal.toggle()
        }
    }
}

struct IdItem: Identifiable, Codable, Transferable {
    var id: UUID
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(for: IdItem.self, contentType: .text)
    }
}
