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
    
    @State var superGoal: Goal = Goal()
    @State var shouldExpandAll: Bool = true
    let navLinkId = UUID()
    @EnvironmentObject var vm: ViewModel
    

    var body: some View {
        VStack(alignment:.leading, spacing:0){
            
            if objectType == .goal && properties.parentGoalId != nil {
                BuildSuperCard()
                
//                DetailSuperGoal(shouldExpand: $shouldExpandAll, objectId: superGoal.id, properties: Properties(goal: superGoal))
            }
            
            ParentHeaderButton(shouldExpandAll: $shouldExpandAll, color: .purple, header: "Expand All", headerCollapsed: "Collapse All")
            
            DetailProperties(shouldExpand: $shouldExpandAll, objectType: objectType, properties: properties)
                .frame(maxWidth:.infinity)
            
            if objectType == .creed{
                DetailCreed(shouldExpand: $shouldExpandAll, isPresentingModal: $isPresentingModal, modalType: $modalType, focusValue: $focusObjectId)
            }
            
            if objectType == .entry {
                DetailImages(shouldExpand: $shouldExpandAll, objectId: objectId, objectType: objectType)
            }

            if objectType == .goal && properties.timeframe != .day{
                DetailTree(shouldExpand: $shouldExpandAll, isPresentingModal: $isPresentingModal, isPresentingSourceType: $isPresentingSourceType, modalType: $modalType, focusGoal: $focusObjectId, goalId: objectId)
                DetailGantt(shouldExpand: $shouldExpandAll, isPresentingModal: $isPresentingModal, modalType: $modalType, focusGoal: $focusObjectId, goalId: objectId)
                DetailKanban(shouldExpand: $shouldExpandAll, isPresentingModal: $isPresentingModal, modalType: $modalType, focusGoal: $focusObjectId, statusToAdd: $statusToAdd, goalId: objectId)
            }
            
            if objectType == .session{
                DetailAffectedGoals(shouldExpand: $shouldExpandAll, sessionProperties: properties)
            }
            
            if objectType == .habit{
                DetailHabitProgress(shouldExpand: $shouldExpandAll, habitId: objectId)
            }


        }
        .offset(y:offset.y < 150 ? -offset.y/1.5 : -100)
        .frame(alignment:.leading)
        .offset(y:100)
        .onAppear(){
            if objectType == .goal {
                if let goal = vm.GetGoal(id: objectId){
                    superGoal = GetSuperGoal(superGoal: goal)
                    superGoal.description = "Super Goal"
                    superGoal.image = nil
                }
            }
        }
    }
    
    func GetSuperGoal(superGoal: Goal) -> Goal{
        if(superGoal.parentId == nil){
            return superGoal
        }
        else{
            if let candidateGoal = vm.GetGoal(id: superGoal.parentId!){
                return GetSuperGoal(superGoal: candidateGoal)
            }
        }
        return superGoal
    }
    
    @ViewBuilder
    func BuildSuperCard() -> some View{

        NavigationLink(
            destination:
                Detail(objectType: .goal, objectId: superGoal.id),
                       label: {
                           PhotoCard(objectType: .goal, objectId: objectId, properties: Properties(goal: superGoal), shouldHaveLink: false)
                               .frame(maxWidth:.infinity)
                               .modifier(ModifierCard())
                               .padding([.top,.bottom])
        })
        .id(navLinkId)
    }
}

struct DetailStack_Previews: PreviewProvider {
    static var previews: some View {
        DetailStack(offset: .constant(.zero), focusObjectId: .constant(UUID()), isPresentingModal: .constant(false) , modalType: .constant(.add), statusToAdd: .constant(.notStarted), isPresentingSourceType: .constant(false) , properties: Properties() , objectId: UUID() ,objectType: .goal)
            .environmentObject(ViewModel())
    }
}
