//
//  DetailView.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/30/23.
//

import SwiftUI

struct DetailView<Content: View>: View {
    let viewType: ViewType
    let objectId: UUID
    @Binding var selectedObjectId: UUID
    @Binding var selectedObjectType: ObjectType
    @Binding var shouldExpandAll: Bool
    @Binding var expandedObjects: [UUID]
    @Binding var isPresentingModal: Bool
    @Binding var modalType: ModalType
    @Binding var isPresentingSourceType: Bool
    
    @ViewBuilder var content: Content
    
    @State var shouldDelete: Bool = false
    @State var shouldMoveForward: Bool = false
    @State var shouldMoveBackward: Bool = false
    @State var shouldPushBack: Bool = false
    @State var shouldPushForward: Bool = false
    
    @State var shouldExpand: Bool = false
    @State var shouldMinimize: Bool = false
    @State var shouldChangePhoto: Bool = false
    @State var shouldEdit: Bool = false
    @State var shouldAdd: Bool = false
    @State var shouldGoTo: Bool = false
    
    @State var selectedGoal: Goal? = Goal()
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        HeaderWithContent(shouldExpand: $shouldExpandAll, headerColor: .grey10, header: viewType.toString(), content: {
            VStack(alignment:.leading){
                
                VStack(alignment:.leading, spacing:0){
                    Text(viewType.toDescription())
                        .font(.specify(style: .h5))
                        .foregroundColor(.specify(color: .grey8))
                    
                    Text("Select a " + selectedObjectType.toString() + " to get started.")
                        .font(.specify(style: .caption))
                        .foregroundColor(.specify(color: .grey4))
                        .padding(.bottom)
                    
                    BuildMenu()
                    
                }
                .padding([.leading,.trailing,.top])
                
                
                content
                    .padding(.top, 25)
                    .padding(8)
                    .frame(alignment:.leading)
                    .modifier(ModifierCard(color:.grey15, radius: SizeType.cornerRadiusLarge.ToSize() - 8))
                    .padding([.leading,.trailing,.bottom],8)
                    .padding(.bottom,-4)

            }
            .padding(.top,5)
            .onAppear{
                selectedGoal = vm.GetGoal(id: selectedObjectId)
            }
            .onChange(of: selectedObjectId){
                _ in
                withAnimation{
                    selectedGoal = vm.GetGoal(id: selectedObjectId)
                }
            }
            .onChange(of: vm.updates){
                _ in
                selectedGoal = vm.GetGoal(id: selectedObjectId)
            }
            .modifier(ModifierCard())
            .onChange(of:shouldPushBack){ _ in
                let affectedGoals = vm.ListAffectedGoals(id: selectedObjectId)
                let affectedParentGoal = vm.GetGoal(id: selectedObjectId) ?? Goal()
    
                for affectedGoal in affectedGoals {
                    var updateRequest = UpdateGoalRequest(goal: affectedGoal)
                    updateRequest.startDate = updateRequest.startDate.AdvanceDate(timeframe: affectedParentGoal.timeframe, forward: false)
                    updateRequest.endDate = updateRequest.endDate.AdvanceDate(timeframe: affectedParentGoal.timeframe, forward: false)
                    withAnimation{
                        _ = vm.UpdateGoal(id: affectedGoal.id, request: updateRequest)
                    }
                }
            }
            .onChange(of:shouldPushForward){ _ in
                let affectedGoals = vm.ListAffectedGoals(id: selectedObjectId)
                let affectedParentGoal = vm.GetGoal(id: selectedObjectId) ?? Goal()
    
                for affectedGoal in affectedGoals {
                    var updateRequest = UpdateGoalRequest(goal: affectedGoal)
                    updateRequest.startDate = updateRequest.startDate.AdvanceDate(timeframe: affectedParentGoal.timeframe, forward: true)
                    updateRequest.endDate = updateRequest.endDate.AdvanceDate(timeframe: affectedParentGoal.timeframe, forward: true)
                    withAnimation{
                        _ = vm.UpdateGoal(id: affectedGoal.id, request: updateRequest)
                    }
                }
            }
            .onChange(of: shouldMoveForward){
                _ in
                if let affectedGoal = vm.GetGoal(id: selectedObjectId){
                    var updateRequest = UpdateGoalRequest(goal: affectedGoal)
                    updateRequest.progress = updateRequest.progress.updateProgress(isForward: true)
                    withAnimation{
                        _ = vm.UpdateGoal(id: affectedGoal.id, request: updateRequest)
                    }
                }
            }
            .onChange(of: shouldMoveBackward){
                _ in
                if let affectedGoal = vm.GetGoal(id: selectedObjectId){
                    var updateRequest = UpdateGoalRequest(goal: affectedGoal)
                    updateRequest.progress = updateRequest.progress.updateProgress(isForward: false)
                    withAnimation{
                        _ = vm.UpdateGoal(id: affectedGoal.id, request: updateRequest)
                    }
                }
            }
        })
    }
    
    @ViewBuilder
    func BuildMenu() -> some View{
        HStack{
            
            if viewType.shouldHaveButton(button: .delete) && selectedObjectId != objectId {
                
                if selectedObjectType != .value{
                    IconButton(isPressed: $shouldDelete, size: .medium, iconType: .delete, iconColor: .red, circleColor: .grey2)
                }
                else if selectedObjectType == .value {
                    if let coreValue = vm.GetCoreValue(id: selectedObjectId){
                        if coreValue.title != ValueType.Conclusion.toString() && coreValue.title != ValueType.Introduction.toString() {
                            IconButton(isPressed: $shouldDelete, size: .medium, iconType: .delete, iconColor: .red, circleColor: .grey2)
                        }
                    }
                }
            }
            
            Spacer()
            
            if viewType.shouldHaveButton(button: .forward) && selectedObjectId != objectId{
                if let goal = vm.GetGoal(id: selectedObjectId){
                    if goal.progress > 1 {
                        IconButton(isPressed: $shouldMoveBackward, size: .medium, iconType: .undo, iconColor: .grey9, circleColor: .grey2)
                    }
                    if goal.progress < 99 {
                        IconButton(isPressed: $shouldMoveForward, size: .medium, iconType: .redo, iconColor: .grey9, circleColor: .grey2)
                    }
                }
            }
            
            if viewType.shouldHaveButton(button: .timeBack){
                IconButton(isPressed: $shouldPushBack, size: .medium, iconType: .timeBack, iconColor: .grey9, circleColor: .grey2)
                IconButton(isPressed: $shouldPushForward, size: .medium, iconType: .timeForward, iconColor: .grey9, circleColor: .grey2)
            }
            if viewType.shouldHaveButton(button: .expand) && selectedGoal?.timeframe != .day && vm.ListChildGoals(id: selectedGoal?.id ?? UUID()).count > 0 {
                if expandedObjects.contains(selectedObjectId){
                    IconButton(isPressed: $shouldExpand, size: .medium, iconType: .minimize, iconColor: .grey9, circleColor: .grey2)
                }
                else{
                    IconButton(isPressed: $shouldExpand, size: .medium, iconType: .maximize, iconColor: .grey9, circleColor: .grey2)
                }
            }
            if viewType.shouldHaveButton(button: .photo){
                IconButton(isPressed: $isPresentingSourceType, size: .medium, iconType: .photo, iconColor: .grey9, circleColor: .grey2)
            }
            
            if viewType != .kanban || (viewType == .kanban && selectedObjectId != objectId){
                IconButton(isPressed: $shouldEdit, size: .medium, iconType: .edit, iconColor: .grey9, circleColor: .grey2)
            }
            
            if viewType.shouldHaveButton(button: .add) && selectedGoal?.timeframe != .day && viewType != .kanban {
                IconButton(isPressed: $shouldAdd, size: .medium, iconType: .add, iconColor: .grey9, circleColor: .grey2)
            }
            
            BuildNavButton()
        }
        .opacity(ShouldEnable() ? 1.0 : 0.4)
        .disabled(!ShouldEnable())
        .onChange(of: shouldExpand){
            _ in
            withAnimation{
                if expandedObjects.contains(selectedObjectId){
                    expandedObjects.removeAll(where: {$0 == selectedObjectId})
                }
                else{
                    expandedObjects.append(selectedObjectId)
                }
            }
        }
        .onChange(of: shouldDelete){ _ in
            modalType = .delete
            isPresentingModal.toggle()
        }
        .onChange(of: shouldAdd){ _ in
            modalType = .add
            isPresentingModal.toggle()
        }
        .onChange(of: shouldEdit){ _ in
            modalType = .edit
            isPresentingModal.toggle()
        }
        .onChange(of: shouldGoTo){ _ in
            modalType = .delete
            isPresentingModal.toggle()
        }
    }
    
    func PrintObjectType() {
        print(selectedObjectType)
    }
    @ViewBuilder
    func BuildNavButton() -> some View{
        
        if viewType != .kanban || (viewType == .kanban && selectedObjectId != objectId){
            NavigationLink(destination:
            Detail(objectType: selectedObjectType, objectId: selectedObjectId), label: {IconButton(isPressed: $shouldGoTo, size: .medium, iconType: .arrow_right, iconColor: .grey9, circleColor: .grey2).disabled(true)})
            .id(UUID())
        }
    }
    
    func ShouldEnable() -> Bool {
        
        switch viewType {
        case .tree:
            return vm.GetGoal(id: selectedObjectId) != nil
        case .gantt:
            return vm.GetGoal(id: selectedObjectId) != nil
        case .kanban:
            return vm.GetGoal(id: selectedObjectId) != nil
        case .creed:
            return vm.GetCoreValue(id: selectedObjectId) != nil
        }
        
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(viewType: .gantt, selectedObjectId: .constant(UUID()), selectedObjectType: .constant(.goal), shouldExpandAll: .constant(false), expandedObjects: <#Binding<[UUID]>#>, content: {DetailTree(shouldExpand: .constant(false), goalId: UUID(), focusGoal: .constant(UUID()))})
//    }
//}
