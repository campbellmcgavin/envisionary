//
//  DetailView.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/30/23.
//

import SwiftUI

struct DetailView<Content: View, AboveContent: View>: View {
    var viewType: ViewType
    let objectId: UUID
    @Binding var selectedObjectId: UUID
    @Binding var selectedObjectType: ObjectType
    @Binding var shouldExpandAll: Bool
    @Binding var expandedObjects: [UUID]
    @Binding var isPresentingModal: Bool
    @Binding var modalType: ModalType
    @Binding var isPresentingSourceType: Bool
    @Binding var didEditPrimaryGoal: Bool
    var currentTimeframe: TimeframeType
    var alternativeTitle: String?
    var shouldShowText: Bool = true
    @ViewBuilder var content: Content
    @ViewBuilder var aboveContent: AboveContent
    
    @State var shouldDelete: Bool = false
    @State var shouldMoveForward: Bool = false
    @State var shouldMoveBackward: Bool = false
    @State var shouldPushBack: Bool = false
    @State var shouldPushForward: Bool = false
    @State var shouldExpand: Bool = false
    @State var shouldExpandAllObjects: Bool = false
    @State var shouldMinimize: Bool = false
    @State var shouldMinimizeAllObjects: Bool = false
    @State var shouldChangePhoto: Bool = false
    @State var shouldEdit: Bool = false
    @State var shouldAdd: Bool = false
    @State var shouldGoTo: Bool = false
    @State var shouldAddTime: Bool = false
    @State var shouldSubtractTime: Bool = false
    @State var isVerbose: Bool = true
    @State var isExpanded: Bool = false
    @State var selectedGoal: Goal? = nil
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        HeaderWithContent(shouldExpand: $shouldExpandAll, headerColor: .grey10, header: alternativeTitle ?? viewType.toString(), content: {
            VStack{
                aboveContent
                
                VStack(alignment:.leading){
                    
                    
                    if shouldShowText{
                        VStack(alignment:.leading, spacing:0){
                            Text(viewType.toDescription())
                                .font(.specify(style: .h5))
                                .foregroundColor(.specify(color: .grey10))
                            
                            if let subsdescription = viewType.toSubDescription(){
                                Text(subsdescription)
                                    .font(.specify(style: .h6))
                                    .foregroundColor(.specify(color: .grey5))
                                    .padding(.bottom)
                                    .padding(.top,4)
                                    .multilineTextAlignment(.leading)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            else{
                                Text("Select a " + selectedObjectType.toString() + " to get started.")
                                    .font(.specify(style: .h6))
                                    .foregroundColor(.specify(color: .grey5))
                                    .padding(.bottom)
                                    .padding(.top,4)
                            }
                            
                            
                            //                            if viewType != .valueGoalAlignment && viewType != .goalValueAlignment{
                            //                                BuildMenu()
                            //                            }
                        }
                        .padding([.leading,.trailing,.top])
                    }
                    
                    
                    content
                        .padding(8)
                        .frame(alignment:.leading)
                        .if(viewType != .goalValueAlignment && viewType != .valueGoalAlignment){
                            view in
                            view
                                .modifier(ModifierForm(color:.grey1))
                                .padding(8)
                        }
                        
                        
                    
                }
                .modifier(ModifierCard(color:.grey05))
            }
            .padding(.top,5)
            .onAppear{
                selectedGoal = vm.GetGoal(id: selectedObjectId)
            }
            .onChange(of: selectedObjectId){
                _ in
                selectedGoal = vm.GetGoal(id: selectedObjectId)
            }
            .onChange(of: vm.updates.goal){
                _ in
                selectedGoal = vm.GetGoal(id: selectedObjectId)
            }
//            .onChange(of:shouldPushBack){ _ in
//                if selectedObjectId == objectId {
//                    didEditPrimaryGoal = true
//                }
//                let affectedGoals = vm.ListAffectedGoals(id: selectedObjectId)
//                
//                let timeframe = currentTimeframe == .decade ? .year : currentTimeframe
//                var requestDictionary = [UUID:UpdateGoalRequest]()
//                
//                for affectedGoal in affectedGoals {
//                    var updateRequest = UpdateGoalRequest(goal: affectedGoal)
//                    updateRequest.startDate = updateRequest.startDate.AdvanceDate(timeframe: timeframe, forward: false)
//                    updateRequest.endDate = updateRequest.endDate.AdvanceDate(timeframe: timeframe, forward: false)
//                    requestDictionary[affectedGoal.id] = updateRequest
//                }
//                
//                _ = vm.UpdateGoals(requestDictionary: requestDictionary)
//                
//            }
//            .onChange(of:shouldPushForward){ _ in
//                if selectedObjectId == objectId {
//                    didEditPrimaryGoal = true
//                }
//                let affectedGoals = vm.ListAffectedGoals(id: selectedObjectId)
//                
//                let timeframe = currentTimeframe == .decade ? .year : currentTimeframe
//                var requestDictionary = [UUID:UpdateGoalRequest]()
//                
//                for affectedGoal in affectedGoals {
//                    var updateRequest = UpdateGoalRequest(goal: affectedGoal)
//                    updateRequest.startDate = updateRequest.startDate.AdvanceDate(timeframe: timeframe, forward: true)
//                    updateRequest.endDate = updateRequest.endDate.AdvanceDate(timeframe: timeframe, forward: true)
//                    requestDictionary[affectedGoal.id] = updateRequest
//                }
//                _ = vm.UpdateGoals(requestDictionary: requestDictionary)
//            }
//            .onChange(of:shouldAddTime){ _ in
//                if let goal = vm.GetGoal(id: selectedObjectId){
//                    if selectedObjectId == objectId {
//                        didEditPrimaryGoal = true
//                    }
//                    let timeframe = currentTimeframe == .decade ? .year : currentTimeframe
//                    var updateRequest = UpdateGoalRequest(goal: goal)
//                    updateRequest.endDate = updateRequest.endDate.AdvanceDate(timeframe: timeframe, forward: true)
//                    _ = vm.UpdateGoal(id: goal.id, request: updateRequest)
//                }
//            }
//            .onChange(of:shouldSubtractTime){ _ in
//                if let goal = vm.GetGoal(id: selectedObjectId){
//                    if selectedObjectId == objectId {
//                        didEditPrimaryGoal = true
//                    }
//                    let timeframe = currentTimeframe == .decade ? .year : currentTimeframe
//                    var updateRequest = UpdateGoalRequest(goal: goal)
//                    updateRequest.endDate = updateRequest.endDate.AdvanceDate(timeframe: timeframe, forward: false)
//                    _ = vm.UpdateGoal(id: goal.id, request: updateRequest)
//                }
//            }
//            .onChange(of:shouldPushBack){ _ in
//                if selectedObjectId == objectId {
//                    didEditPrimaryGoal = true
//                }
//                let affectedGoals = vm.ListAffectedGoals(id: selectedObjectId)
//                
//                let timeframe = currentTimeframe == .decade ? .year : currentTimeframe
//                var requestDictionary = [UUID:UpdateGoalRequest]()
//                
//                for affectedGoal in affectedGoals {
//                    var updateRequest = UpdateGoalRequest(goal: affectedGoal)
//                    updateRequest.startDate = updateRequest.startDate.AdvanceDate(timeframe: timeframe, forward: false)
//                    updateRequest.endDate = updateRequest.endDate.AdvanceDate(timeframe: timeframe, forward: false)
//                    requestDictionary[affectedGoal.id] = updateRequest
//                }
//                
//                _ = vm.UpdateGoals(requestDictionary: requestDictionary)
//                
//            }
//            .onChange(of:shouldPushForward){ _ in
//                if selectedObjectId == objectId {
//                    didEditPrimaryGoal = true
//                }
//                let affectedGoals = vm.ListAffectedGoals(id: selectedObjectId)
//                
//                let timeframe = currentTimeframe == .decade ? .year : currentTimeframe
//                var requestDictionary = [UUID:UpdateGoalRequest]()
//                
//                for affectedGoal in affectedGoals {
//                    var updateRequest = UpdateGoalRequest(goal: affectedGoal)
//                    updateRequest.startDate = updateRequest.startDate.AdvanceDate(timeframe: timeframe, forward: true)
//                    updateRequest.endDate = updateRequest.endDate.AdvanceDate(timeframe: timeframe, forward: true)
//                    requestDictionary[affectedGoal.id] = updateRequest
//                }
//                _ = vm.UpdateGoals(requestDictionary: requestDictionary)
//            }
        })
    }
    
    func ShouldShowGoTo() -> Bool{
        if viewType == .kanban{
            if selectedGoal == nil {
                return false
            }
            else if selectedGoal!.archived {
                return false
            }
        }
        return true
    }
    
}
