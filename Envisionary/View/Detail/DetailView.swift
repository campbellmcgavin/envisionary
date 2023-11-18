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
                        .modifier(ModifierForm(color:.grey1))
                        .padding(8)

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
            .onChange(of:shouldPushBack){ _ in
                if selectedObjectId == objectId {
                    didEditPrimaryGoal = true
                }
                let affectedGoals = vm.ListAffectedGoals(id: selectedObjectId)
    
                let timeframe = currentTimeframe == .decade ? .year : currentTimeframe
                var requestDictionary = [UUID:UpdateGoalRequest]()
                
                for affectedGoal in affectedGoals {
                    var updateRequest = UpdateGoalRequest(goal: affectedGoal)
                    updateRequest.startDate = updateRequest.startDate.AdvanceDate(timeframe: timeframe, forward: false)
                    updateRequest.endDate = updateRequest.endDate.AdvanceDate(timeframe: timeframe, forward: false)
                    requestDictionary[affectedGoal.id] = updateRequest
                }
                
                _ = vm.UpdateGoals(requestDictionary: requestDictionary)
                
            }
            .onChange(of:shouldPushForward){ _ in
                if selectedObjectId == objectId {
                    didEditPrimaryGoal = true
                }
                let affectedGoals = vm.ListAffectedGoals(id: selectedObjectId)
    
                let timeframe = currentTimeframe == .decade ? .year : currentTimeframe
                var requestDictionary = [UUID:UpdateGoalRequest]()
                
                for affectedGoal in affectedGoals {
                    var updateRequest = UpdateGoalRequest(goal: affectedGoal)
                    updateRequest.startDate = updateRequest.startDate.AdvanceDate(timeframe: timeframe, forward: true)
                    updateRequest.endDate = updateRequest.endDate.AdvanceDate(timeframe: timeframe, forward: true)
                    requestDictionary[affectedGoal.id] = updateRequest
                }
                _ = vm.UpdateGoals(requestDictionary: requestDictionary)
            }
            .onChange(of:shouldAddTime){ _ in
                if let goal = vm.GetGoal(id: selectedObjectId){
                    if selectedObjectId == objectId {
                        didEditPrimaryGoal = true
                    }
                    let timeframe = currentTimeframe == .decade ? .year : currentTimeframe
                    var updateRequest = UpdateGoalRequest(goal: goal)
                    updateRequest.endDate = updateRequest.endDate.AdvanceDate(timeframe: timeframe, forward: true)
                    _ = vm.UpdateGoal(id: goal.id, request: updateRequest)
                }
            }
            .onChange(of:shouldSubtractTime){ _ in
                if let goal = vm.GetGoal(id: selectedObjectId){
                    if selectedObjectId == objectId {
                        didEditPrimaryGoal = true
                    }
                    let timeframe = currentTimeframe == .decade ? .year : currentTimeframe
                    var updateRequest = UpdateGoalRequest(goal: goal)
                    updateRequest.endDate = updateRequest.endDate.AdvanceDate(timeframe: timeframe, forward: false)
                    _ = vm.UpdateGoal(id: goal.id, request: updateRequest)
                }
            }
            .onChange(of:shouldPushBack){ _ in
                if selectedObjectId == objectId {
                    didEditPrimaryGoal = true
                }
                let affectedGoals = vm.ListAffectedGoals(id: selectedObjectId)
    
                let timeframe = currentTimeframe == .decade ? .year : currentTimeframe
                var requestDictionary = [UUID:UpdateGoalRequest]()
                
                for affectedGoal in affectedGoals {
                    var updateRequest = UpdateGoalRequest(goal: affectedGoal)
                    updateRequest.startDate = updateRequest.startDate.AdvanceDate(timeframe: timeframe, forward: false)
                    updateRequest.endDate = updateRequest.endDate.AdvanceDate(timeframe: timeframe, forward: false)
                    requestDictionary[affectedGoal.id] = updateRequest
                }
                
                _ = vm.UpdateGoals(requestDictionary: requestDictionary)
                
            }
            .onChange(of:shouldPushForward){ _ in
                if selectedObjectId == objectId {
                    didEditPrimaryGoal = true
                }
                let affectedGoals = vm.ListAffectedGoals(id: selectedObjectId)
    
                let timeframe = currentTimeframe == .decade ? .year : currentTimeframe
                var requestDictionary = [UUID:UpdateGoalRequest]()
                
                for affectedGoal in affectedGoals {
                    var updateRequest = UpdateGoalRequest(goal: affectedGoal)
                    updateRequest.startDate = updateRequest.startDate.AdvanceDate(timeframe: timeframe, forward: true)
                    updateRequest.endDate = updateRequest.endDate.AdvanceDate(timeframe: timeframe, forward: true)
                    requestDictionary[affectedGoal.id] = updateRequest
                }
                _ = vm.UpdateGoals(requestDictionary: requestDictionary)
            }
        })
    }
    
    func ShouldHaveButton(button: ViewMenuButtonType) -> Bool{
        switch button {
        case .delete:
            return viewType.shouldHaveButton(button: .delete) && selectedObjectId != objectId && selectedGoal?.archived == false
        case .expand_all:
            return viewType.shouldHaveButton(button: .expand_all) && vm.ListChildGoals(id: objectId).count > 0
        case .expand:
            return viewType.shouldHaveButton(button: .expand) && vm.ListChildGoals(id: selectedGoal?.id ?? UUID()).count > 0
        case .forward:
            return viewType.shouldHaveButton(button: .forward) && selectedObjectId != objectId && vm.GetGoal(id: selectedObjectId)?.progress ?? 100 < 99 && selectedGoal?.archived == false
        case .backward:
            return viewType.shouldHaveButton(button: .backward) && selectedObjectId != objectId && vm.GetGoal(id: selectedObjectId)?.progress ?? 0 > 1 && selectedGoal?.archived == false
        case .timeBack:
            return viewType.shouldHaveButton(button: .timeBack) && selectedGoal?.archived == false
        case .timeForward:
            return viewType.shouldHaveButton(button: .timeForward) && selectedGoal?.archived == false
        case .timeAdd:
            return viewType.shouldHaveButton(button: .timeAdd) && selectedGoal?.archived == false
        case .timeSubtract:
            return viewType.shouldHaveButton(button: .timeSubtract) && selectedGoal?.archived == false
        case .photo:
            return viewType.shouldHaveButton(button: .photo) && selectedGoal?.archived == false
        case .edit:
            return viewType.shouldHaveButton(button: .edit) && selectedGoal?.archived == false
        case .add:
            return viewType.shouldHaveButton(button: .add) && viewType != .kanban && selectedGoal?.archived == false
        case .goTo:
            return selectedObjectId != objectId && (ShouldShowGoTo())
        }
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
    
    @ViewBuilder
    func BuildButton(button: ViewMenuButtonType) -> some View{
        switch button {
        case .delete:
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
        case .expand_all:
            if isExpanded{
                IconButton(isPressed: $shouldMinimizeAllObjects, size: .medium, iconType: .minimize_all, iconColor: .grey9, circleColor: .grey2)
            }
            else{
                IconButton(isPressed: $shouldExpandAllObjects, size: .medium, iconType: .maximize_all, iconColor: .grey9, circleColor: .grey2)
            }
        case .expand:
            if expandedObjects.contains(selectedObjectId){
                IconButton(isPressed: $shouldExpand, size: .medium, iconType: .minimize, iconColor: .grey9, circleColor: .grey2)
            }
            else{
                IconButton(isPressed: $shouldExpand, size: .medium, iconType: .maximize, iconColor: .grey9, circleColor: .grey2)
            }
        case .forward:
            IconButton(isPressed: $shouldMoveForward, size: .medium, iconType: .arrow_right, iconColor: .grey9, circleColor: .grey2)
        case .backward:
            IconButton(isPressed: $shouldMoveBackward, size: .medium, iconType: .arrow_left, iconColor: .grey9, circleColor: .grey2)
        case .timeBack:
            IconButton(isPressed: $shouldPushBack, size: .medium, iconType: .timeBack, iconColor: .grey9, circleColor: .grey2)
        case .timeForward:
            IconButton(isPressed: $shouldPushForward, size: .medium, iconType: .timeForward, iconColor: .grey9, circleColor: .grey2)
        case .timeAdd:
            IconButton(isPressed: $shouldAddTime, size: .medium, iconType: .time_add, iconColor: .grey9, circleColor: .grey2)
        case .timeSubtract:
            IconButton(isPressed: $shouldSubtractTime, size: .medium, iconType: .time_subtract, iconColor: .grey9, circleColor: .grey2)
        case .photo:
            IconButton(isPressed: $isPresentingSourceType, size: .medium, iconType: .photo, iconColor: .grey9, circleColor: .grey2)
        case .edit:
            IconButton(isPressed: $shouldEdit, size: .medium, iconType: .edit, iconColor: .grey9, circleColor: .grey2)
        case .add:
            IconButton(isPressed: $shouldAdd, size: .medium, iconType: .add, iconColor: .grey9, circleColor: .grey2)
        case .goTo:
            BuildNavButton()
        }
    }
    
    @ViewBuilder
    func BuildMenu() -> some View{
        
        VStack{
            ZStack{
                HStack{
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing:0){
                            ForEach(ViewMenuButtonType.allCases, id:\.self){
                                button in
                                if ShouldHaveButton(button: button) && button != .goTo{
                                    VStack{
                                        BuildButton(button: button)
                                        
                                        if button == .expand{
                                            
                                            if expandedObjects.contains(selectedObjectId){
                                                Text("Collapse")
                                                    .font(.specify(style: .subCaption))
                                                    .foregroundColor(.specify(color: .grey4))
                                                    .frame(width:45)
                                                    .padding(.top,-8)
                                            }
                                            else{
                                                Text("Expand")
                                                    .font(.specify(style: .subCaption))
                                                    .foregroundColor(.specify(color: .grey4))
                                                    .frame(width:45)
                                                    .padding(.top,-8)
                                            }
                                        }
                                        else{
                                            Text(button.toString())
                                                .font(.specify(style: .subCaption))
                                                .foregroundColor(.specify(color: .grey4))
                                                .frame(width:45)
                                                .padding(.top,-8)
                                        }
                                    }
                                    .padding(.bottom,6)
                                }
                            }
                        }
                        .padding(.trailing,80)
                    }
                    Spacer()
                }
                HStack{
                    Spacer()
                        VStack{
                            BuildNavButton()
                            Text(ViewMenuButtonType.goTo.toString())
                                .font(.specify(style: .subCaption))
                                .foregroundColor(.specify(color: .grey4))
                                .frame(width:45)
                                .padding(.top,-8)
                        }
                        .background(
                            ZStack{
                                Circle()
                                    .frame(width:SizeType.medium.ToSize() + 10, height:SizeType.medium.ToSize() + 10)
                                    .foregroundColor(.specify(color:.grey1))
                                Rectangle()
                                    .frame(width:SizeType.medium.ToSize() + 8, height:SizeType.medium.ToSize() + 8)
                                    .foregroundColor(.specify(color:.grey1))
                                    .offset(x:SizeType.medium.ToSize()/2)
                            }
                                .offset(y:-5)
                        )

                }
                .padding(.bottom,6)
            }

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
        .onChange(of: shouldExpandAllObjects){ _ in
            withAnimation{
                expandedObjects = vm.ListAffectedGoals(id: objectId).map({$0.id})
                isExpanded = true
            }
        }
        .onChange(of: shouldMinimizeAllObjects){ _ in
            withAnimation{
                expandedObjects.removeAll()
                isExpanded = false
            }
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
            Detail(objectType: selectedObjectType, objectId: selectedObjectId), label: {IconButton(isPressed: $shouldGoTo, size: .medium, iconType: .right, iconColor: .grey9, circleColor: .grey2).disabled(true)})
            .id(UUID())
        }
    }
    
    @ViewBuilder
    func BuildNavTextIconButton() -> some View{
        
        if viewType != .kanban || (viewType == .kanban && selectedObjectId != objectId){
            NavigationLink(destination:
            Detail(objectType: selectedObjectType, objectId: selectedObjectId), label: {TextIconLabel(text: ViewMenuButtonType.goTo.toString(), color: .grey7, backgroundColor: .grey2, fontSize: .caption, shouldFillWidth: true, iconType: .arrow_right)})
            .id(UUID())
        }
    }
    
    func ShouldEnable() -> Bool {
        
        switch viewType {
        case .tree:
            return selectedGoal != nil
        case .gantt:
            return selectedGoal != nil
        case .kanban:
            return selectedGoal != nil
        case .creed:
            return vm.GetCoreValue(id: selectedObjectId) != nil
        case .goalValueAlignment:
            return vm.GetGoal(id: selectedObjectId) != nil
        case .valueGoalAlignment:
            return true
        case .checkOff:
            return true
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(viewType: .gantt, selectedObjectId: .constant(UUID()), selectedObjectType: .constant(.goal), shouldExpandAll: .constant(false), expandedObjects: <#Binding<[UUID]>#>, content: {DetailTree(shouldExpand: .constant(false), goalId: UUID(), focusGoal: .constant(UUID()))})
//    }
//}
