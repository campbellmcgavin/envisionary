//
//  DetailStack.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/17/23.
//

import SwiftUI

struct DetailStack: View {
    @Binding var offset: CGPoint
    @Binding var focusObjectId: UUID
    @Binding var isPresentingModal: Bool
    @Binding var modalType: ModalType
    @Binding var statusToAdd: StatusType
    @Binding var isPresentingSourceType: Bool
    var properties: Properties
    let objectId: UUID
    let objectType: ObjectType
    
    @State var shouldExpandAll: Bool = true
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        VStack(alignment:.leading, spacing:0){
            ParentHeaderButton(shouldExpandAll: $shouldExpandAll, color: .purple, header: "Expand All", headerCollapsed: "Collapse All")
            
            DetailProperties(shouldExpand: $shouldExpandAll, objectType: objectType, properties: properties)
                .frame(maxWidth:.infinity)
            
            if objectType == .creed{
                DetailCreed(shouldExpand: $shouldExpandAll, isPresentingModal: $isPresentingModal, modalType: $modalType, focusValue: $focusObjectId)
            }
            
            if objectType == .entry {
                DetailImages(shouldExpand: $shouldExpandAll, objectId: objectId, objectType: objectType)
            }
//            DetailChildren(shouldExpand: $shouldExpandAll, objectId: objectId, objectType: objectType)
//                .environmentObject(gs)

            if objectType == .goal{
                DetailTree(shouldExpand: $shouldExpandAll, isPresentingModal: $isPresentingModal, isPresentingSourceType: $isPresentingSourceType, modalType: $modalType, focusGoal: $focusObjectId, goalId: objectId)
                DetailGantt(shouldExpand: $shouldExpandAll, isPresentingModal: $isPresentingModal, modalType: $modalType, focusGoal: $focusObjectId, goalId: objectId)
                DetailKanban(shouldExpand: $shouldExpandAll, isPresentingModal: $isPresentingModal, modalType: $modalType, focusGoal: $focusObjectId, statusToAdd: $statusToAdd, goalId: objectId)
            }


        }
            .offset(y:offset.y < 150 ? -offset.y/1.5 : -100)
        .frame(alignment:.leading)
        .offset(y:100)
    }
}

struct DetailStack_Previews: PreviewProvider {
    static var previews: some View {
        DetailStack(offset: .constant(.zero), focusObjectId: .constant(UUID()), isPresentingModal: .constant(false) , modalType: .constant(.add), statusToAdd: .constant(.notStarted), isPresentingSourceType: .constant(false) , properties: Properties() , objectId: UUID() ,objectType: .goal)
            .environmentObject(ViewModel())
    }
}
