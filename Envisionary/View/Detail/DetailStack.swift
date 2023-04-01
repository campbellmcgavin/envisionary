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
    var properties: Properties
    let objectId: UUID
    let objectType: ObjectType
    
    @State var shouldExpandAll: Bool = true
    
    
    var body: some View {
        VStack(alignment:.leading, spacing:0){
            ParentHeaderButton(shouldExpandAll: $shouldExpandAll, color: .purple, header: "Expand All", headerCollapsed: "Collapse All")
            
            DetailProperties(shouldExpand: $shouldExpandAll, objectType: .goal, properties: properties)
                .frame(maxWidth:.infinity)
//                .padding(.bottom,15)
            
            DetailChildren(shouldExpand: $shouldExpandAll, objectId: objectId, objectType: objectType)

            DetailTree(shouldExpand: $shouldExpandAll, isPresentingModal: $isPresentingModal, modalType: $modalType, focusGoal: $focusObjectId, goalId: objectId)
        }
            .offset(y:offset.y < 150 ? -offset.y/1.5 : -100)
        .frame(alignment:.leading)
        .offset(y:100)
    }
}

struct DetailStack_Previews: PreviewProvider {
    static var previews: some View {
        DetailStack(offset: .constant(.zero), focusObjectId: .constant(UUID()), isPresentingModal: .constant(false) , modalType: .constant(.add)  , properties: Properties() , objectId: UUID() ,objectType: .goal)
            .environmentObject(GoalService())
    }
}
