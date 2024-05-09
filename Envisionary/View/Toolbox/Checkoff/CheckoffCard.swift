//
//  Checkoff.swift
//  Envisionary
//
//  Created by Campbell McGavin on 10/22/23.
//

import SwiftUI

struct CheckoffCard: View {
    let goalId: UUID?
    let superId: UUID
    let canEdit: Bool
    let leftPadding: CGFloat
    let outerPadding: CGFloat
    let proxy: ScrollViewProxy?
    let shouldDismissInteractively: Bool
    let isLocal: Bool
    var selectedColor: CustomColor = .grey10
    @Binding var selectedGoalId: UUID
    @Binding var isPresentingModal: Bool
    @Binding var modalType: ModalType
    @Binding var newGoalId: UUID?
    @Binding var dropFields: CheckOffDropDelegateField
    @State var goal: Goal = Goal(emptyTitle: true)
    @State var shouldProcessChange: Bool = false
    @State var amount = 0
    @State var shouldAdd = false
    @State var shouldGo = false
    @State var dropZoneValidityColor: CustomColor? = nil
    
    let totalAmount = 100
    @State var emphasisText = ""
    @State var isSelected: Int = 0

    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var keyInputSubject: KeyInputSubjectWrapper
    
    var body: some View {
        VStack(alignment:.leading, spacing:0){
            
//            if goalId != nil {
                
                VStack(alignment:.leading, spacing:0){
                    if !dropFields.isDragging{
                        BuildCard()
                    }
                    else{
                        BuildDraggingCard()
                    }
                    
                    StackDivider(shouldIndent: false, color: .grey35)
                        .offset(x: leftPadding + SizeType.mediumLarge.ToSize())
                }
                .onDrag{
                    withAnimation{
                        self.dropFields.currentItem = IdItem(id: (goalId ?? UUID()))
                        self.dropFields.isDragging = true
                    }
                    return NSItemProvider()
                }
                .id(goalId)
//            }
//            else{
//                    
//                    Button{
//                        shouldAdd.toggle()
//                    }
//                label:{
//                    HStack{
//                        IconLabel(size: .small, iconType: .add, iconColor: .grey1, circleColor: .grey10)
//                            .padding(.leading,5)
//                            .padding(.trailing, 4)
//                            .offset(y:-1)
//                        Text("Add new goal")
//                            .font(.specify(style: .body3))
//                            .foregroundColor(.specify(color: .grey6))
//                        Spacer()
//                    }
//                }
//                StackDivider(shouldIndent: false, color: .grey35)
//                    .offset(x: SizeType.mediumLarge.ToSize() + 4)
//            }


            
        }
        .onChange(of: dropFields.currentDropTarget){
            _ in
            DropZoneValidity()
        }
        .onChange(of: isSelected){ _ in
            
            if isSelected == 2 {
                if let proxy{
                    proxy.scrollTo(goalId, anchor: .center)
                }
            }
        }
            .frame(maxWidth:.infinity)
            .addButtonActions(leadingButtons: GetLeadingContentButtons(),
                              trailingButton:  GetTrailingContentButtons(), outerPadding: outerPadding, id: goalId, selectedId: $selectedGoalId, onClick: { button in
                                ExecuteButtonFunction(button: button)})
            .frame(alignment:.leading)
        .onAppear{
            if let goalId{
                goal = vm.GetGoal(id: goalId) ?? Goal(emptyTitle: true)
                amount = goal.progress
                
                if selectedGoalId == goalId{
                    isSelected = 1
                }
                
                GetEmphasisText()
            }
        }
        .onChange(of: selectedGoalId){ _ in
            if selectedGoalId != goalId{
                IsSelected()
            }
        }
        .onChange(of: shouldAdd){ _ in
            AddNewGoal()
        }
        .onChange(of: shouldProcessChange){
            _ in
            withAnimation{
                amount = GetIsComplete() ? 0 : totalAmount
                UpdateGoal()
            }
        }
        .onChange(of: vm.updates.goal){
            _ in
            if let goalId{
                goal = vm.GetGoal(id: goalId) ?? Goal(emptyTitle: true)
            }
            GetEmphasisText()
        }
    }
    
    func DropZoneValidity(){
        
        DispatchQueue.global(qos: .userInitiated).async {
            if dropFields.currentDropTarget != goalId{
                dropZoneValidityColor = nil
            }
            else if dropFields.currentItem == nil {
                dropZoneValidityColor = nil
            }
            else if dropFields.currentItem?.id == dropFields.currentDropTarget{
                dropZoneValidityColor = .red
            }
            else if let currentDropTarget = dropFields.currentDropTarget  {
                if  vm.ListParentGoals(id: currentDropTarget).contains(where: {$0.id == dropFields.currentItem?.id}){
                    dropZoneValidityColor = .red
                }
//                else if vm.GetGoal(id: currentDropTarget)?.isRecurring == true{
//                    dropZoneValidityColor = .red
//                }
            }
        }
    }
    
    func GetDropTargetOpacity(dropPlacement: PlacementType) -> CGFloat{
        if dropFields.currentDropPlacement != nil && dropFields.currentDropPlacement == dropPlacement && dropFields.currentDropTarget == goalId ?? UUID(){
            return 0.5
        }
        else{
            return 0.001
        }
    }
    
    func GetLeadingContentButtons() -> [CellButtonType]{
        var list = [CellButtonType]()
        if ShouldAllowButton(button: .indent){
            list.append(.indent)
        }
        if ShouldAllowButton(button: .add){
            list.append(.add)
        }
        return list
    }
    
    func GetTrailingContentButtons() -> [CellButtonType]{
        var list = [CellButtonType]()
        if ShouldAllowButton(button: .outdent){
            list.append(.outdent)
        }
        if ShouldAllowButton(button: .delete){
            list.append(.delete)
        }
        return list
    }
    
    func IsSelected(){
        isSelected = selectedGoalId == goalId ? 1 : 0
    }
    
    func ShouldShowDraggingBox(placement: PlacementType) -> Bool{
        if dropFields.currentDropPlacement == placement && dropFields.currentDropTarget == goalId {
            return true
        }
        return false
    }
    
    @ViewBuilder
    func BuildDraggingCard() -> some View{
        ZStack(alignment:.center){
            
            BuildCard()
                .if(ShouldShowDraggingBox(placement: .on), transform: {
                    view in
                    view.background(
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.specify(color: dropZoneValidityColor ?? .grey10))
                                .frame(maxHeight:.infinity)
                                .opacity(0.1)
                    )
                })
                .if(ShouldShowDraggingBox(placement: .above), transform: {
                    view in
                    view.overlay(
                        VStack{
                            RoundedRectangle(cornerRadius:1)
                                .fill(Color.specify(color: dropZoneValidityColor ?? .purple))
                                .frame(maxWidth:.infinity)
                                .frame(height:6)
                                .offset(x: leftPadding)
                                .frame(alignment:.top)
                            Spacer()
                        }
                    )
                })
                
            
            if goal.progress < 100 {
                VStack(spacing:0){
                    if let goalId{
                        DropZoneRectangle(placement: .above)
                            .onDrop(of: [.text],
                                    delegate:
                                        CheckOffDropDelegate(dropPlacement: .above, dropId: goalId, fields: $dropFields))
                        
                        DropZoneRectangle(placement: .on)
                            .onDrop(of: [.text],
                                    delegate:
                            CheckOffDropDelegate(dropPlacement: .on, dropId: goalId, fields: $dropFields))
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func BuildCard() -> some View{
        VStack{
            HStack(alignment:.center, spacing:0){
                
                IconButton(isPressed: $shouldProcessChange, size: .small, iconType: .confirm, iconColor: .grey10, circleColor: GetIsComplete() ? .green : .grey3, hasAnimation: false)
                    .padding(.trailing, outerPadding)
                    .offset(y:-1)
                    .opacity(goalId != nil ? 1.0 : 0.5)
                    .disabled(goalId == nil ? true : false)
                
                HStack(spacing:0){
                    VStack(alignment:.leading){
                        
                        if isSelected != 0 && !IsCompleted(){
                            CheckOffCardEditor(goalId: goalId, superId: superId, proxy: proxy, shouldDismissInteractively: shouldDismissInteractively, selectedGoalId: selectedGoalId, goal: $goal, newGoalId: $newGoalId, shouldAdd: $shouldAdd, isSelected: $isSelected)
                        }
                        else{
                            if goalId != nil {
                                Text(goal.title)
                                    .frame(maxWidth:.infinity, alignment: .topLeading)
                                    .font(.specify(style: .body3))
                                    .foregroundColor(.specify(color: IsCompleted() ? .grey5 : .grey10))
                                    .multilineTextAlignment(.leading)
                                    .frame(minHeight:17)
                                    .lineLimit(1)
                            }
                            else{
                                Text("Add a new goal")
                                    .frame(maxWidth:.infinity, alignment: .topLeading)
                                    .font(.specify(style: .body3))
                                    .foregroundColor(.specify(color: .grey5))
                                    .multilineTextAlignment(.leading)
                                    .frame(minHeight:17)
                            }
                        }
                        
                        if goalId != nil{
                            HStack{
                                if emphasisText.count > 0 {
                                    BuildEmphasisText()
                                }
                                BuildDateText()
                            }
                            .lineLimit(1)
                            .padding(.top,-6)
                        }
                    }
                    Spacer()
                }
                
                .frame(maxWidth:.infinity)
                .contentShape(Rectangle())
                
                HStack{
                    if isSelected != 0{
                        
                        if goalId != nil{
                            BuildEditMenu()
                        }
//                        else if goal.title.count > 0{
//                            IconButton(isPressed: $shouldAdd, size: .moderatelySmall, iconType: .confirm, iconColor: .grey5)
//                                .opacity(isSelected != 0 ? 1.0 : 0.0)
//                                .disabled(isSelected == 0)
//                                .padding(.leading,-5)
//                                .offset(y:-3)
//                                .padding(.trailing,-10)
//                        }
                    }
                    else{
                        if goal.progress > 0 && !IsCompleted() && isSelected == 0{
                            Text("\(goal.progress)%")
                                .font(.specify(style: .caption))
                                .foregroundColor(.specify(color: .grey3))
                        }
                    }
                }
                .padding(.trailing,outerPadding)
            }
            .padding(.leading,leftPadding)
            .padding([.top,.bottom],5)
            .contentShape(Rectangle())
            .onTapGesture{
                
                if isSelected == 1{
                    isSelected = 2
                }
                else{
                    if let goalId{
                        selectedGoalId = goalId
                    }
                    isSelected = 1
                }
            }
            .background( Color.specify(color: (goalId == selectedGoalId) || (goalId == nil && isSelected != 0) ? .grey10 : .clear).opacity(0.06).padding([.leading,.trailing], -2*outerPadding))
        }
    }
    
    func ShouldAllowButton(button: CellButtonType) -> Bool{
        switch button {
        case .indent:
            if goal.progress >= 100{
                return false
            }
            
            let siblingGoals = vm.ListChildGoals(id: goal.parentId ?? UUID())
            if let goalIndex = siblingGoals.filter({$0.progress < 100}).firstIndex(where: {$0.id == goalId}){
                if goalIndex != 0{
                    return true
                }
            }
            return false
        case .outdent:
            if goal.progress >= 100{
                return false
            }
            return goal.parentId != superId
        case .delete:
            if goal.progress >= 100{
                return false
            }
            
            return goal.id != superId
        case .add:
            if goal.progress >= 100{
                return false
            }
            
            return true
        case .edit:
            return true
        case .details:
            return true
        }
    }
    
    func ExecuteButtonFunction(button: CellButtonType)
    {
        switch button {
        case .add:
            shouldAdd.toggle()
        case .edit:
            modalType = .edit
            isPresentingModal = true
        case .details:
            // TODO: go to details
            let _ = "why"
        case .indent:
            if let dropFields = GetDropFields(isIndent: true){
                vm.UpdateGoalFromDragAndDrop(focusId: dropFields.currentItem?.id, selectedId: dropFields.currentDropTarget, selectedPlacement: dropFields.currentDropPlacement)
            }
        case .outdent:
            if let dropFields = GetDropFields(isIndent: false){
                vm.UpdateGoalFromDragAndDrop(focusId: dropFields.currentItem?.id, selectedId: dropFields.currentDropTarget, selectedPlacement: dropFields.currentDropPlacement, shouldOutdent: true)
            }
        case .delete:
            _ = vm.DeleteGoal(id: goalId ?? UUID())
        }
    }
    
    @ViewBuilder
    func BuildEditMenu() -> some View{
        Menu{
            VStack{
                ForEach(CellButtonType.allCases){ button in
                    if ShouldAllowButton(button: button)
                    {
                        if button == .delete{
                            Button("Delete", role: .destructive) {
                                ExecuteButtonFunction(button: button)
                            }
                        }
                        else if button == .details{
                            NavigationLink {
                                Detail(objectType: .goal, objectId: selectedGoalId)
                                    } label: {
                                        Text(button.toString())
                                        IconLabel(size: .medium, iconType: button.toIcon(), iconColor: .red)
                                    }
                        }
                        else{
                            Button(action:{
                                ExecuteButtonFunction(button: button)
                            })
                            {
                                Text(button.toString())
                                IconLabel(size: .medium, iconType: button.toIcon(), iconColor: .red)
                            }
                        }
                    }
                }
            }
        }
    label:{
        IconLabel(size: .moderatelySmall, iconType: .options, iconColor: .grey7)
            .opacity((isSelected != 0) ? 1.0 : 0.0)
            .disabled(isSelected == 0)
            .padding(.leading,-5)
            .padding(.trailing,-10)
        }
    }
    
    func GetDropFields(isIndent: Bool) -> CheckOffDropDelegateField?{
        var dropFields = CheckOffDropDelegateField()
        
        if let goalId{
            dropFields.currentItem = IdItem(id:goalId)
            
            if isIndent{
                dropFields.currentDropPlacement = .on
                
                let children = vm.ListChildGoals(id: goal.parentId ?? UUID()).filter({$0.progress < 100})
                
                if let index = children.firstIndex(where: {$0.id == goalId}){
                    
                    if index > 0 {
                        dropFields.currentDropTarget = children[index - 1].id
                        return dropFields
                    }
                }
            }
            else{
                dropFields.currentDropPlacement = .below
                
                if let parent = vm.GetGoal(id: goal.parentId ?? UUID())
                {
                    if let grandparent = vm.GetGoal(id: parent.parentId ?? UUID()){
                        let children = vm.ListChildGoals(id: grandparent.id)
                        
                        if let index = children.firstIndex(where: {$0.id == parent.id}){
                            dropFields.currentDropTarget = children[index].id
                            return dropFields
                        }
                    }
                }
            }
        }
        return nil
    }
    
    func GetEmphasisText(){
        DispatchQueue.global(qos: .userInteractive).async{

            if vm.filtering.filterObject == .goal && !isLocal{
                if let startDate = goal.startDate{
                    if let endDate = goal.endDate{
                        if startDate.isInSameDay(as: vm.filtering.filterDate) || endDate.isInSameDay(as: vm.filtering.filterDate) || vm.filtering.filterDate.isBetween(datePair: DatePair(date1: startDate, date2: endDate)) && vm.filtering.filterIncludeCalendar == .list{
                            
                            emphasisText = "Date Match"
                        }
                        else if endDate.isBefore(date: vm.filtering.filterDate) && !IsCompleted() && !(vm.filtering.filterIncludeCalendar == .list){
                            let daysBehind = endDate.GetDateDifferenceAsDecimal(to: Date(), timeframeType: .day)
                            emphasisText = "Late (\(Int(abs(daysBehind))) days)"
                        }
                        else{
                            emphasisText = ""
                        }
                    }
                }
                
                

            }
            else {
                
                if IsCompleted(){
                    emphasisText = "Completed"
                }
                else if let endDate = goal.endDate{
                    if endDate.isBefore(date: Date().StartOfDay()){
                        let daysBehind = endDate.GetDateDifferenceAsDecimal(to: Date(), timeframeType: .day)
                        emphasisText = "Late (\(Int(abs(daysBehind))) days)"
                    }
                    else if goal.startDate != nil && ((endDate.isInToday) || (endDate.isInToday) || (goal.startDate!.isInThePast && endDate.isInTheFuture)){
                        emphasisText = "Now"
                    }
                    else{
                        emphasisText = ""
                    }
                }
                else{
                    emphasisText = ""
                }
            }
        }
    }
    @ViewBuilder
    func BuildEmphasisText() -> some View{
        Text(emphasisText)
            .font(.specify(style: .subCaption))
            .foregroundColor(.specify(color: GetEmphasisTextColor()))
    }
    
    func GetEmphasisTextColor() -> CustomColor{
        
        if emphasisText == "" {
            return .clear
        }
        else if emphasisText.contains("Completed")
        {
            return .darkGreen
        }
        else if emphasisText.contains("Date Match") || emphasisText.contains("Now")
        {
            return .blue
        }
        else if emphasisText.contains("Late"){
            return .red
        }
        return .clear

    }
    
    func IsCompleted() -> Bool {
        return goal.progress >= 100
    }
    
    @ViewBuilder
    func DropZoneRectangle(placement: PlacementType) -> some View{
        
        if placement == .on || placement == .below{
            HStack{
                RoundedRectangle(cornerRadius: 3)
                .overlay(
                    Color.specify(color: .grey10)
                )
                .opacity(0.001)
            }
            .frame(maxHeight: .infinity)
            .frame(maxWidth:.infinity)
        }
        else{
            HStack{
                RoundedRectangle(cornerRadius: 3)
                .overlay(
                    Color.specify(color: .grey10)
                )
                .opacity(0.001)
            }
            .frame(height:13)
            .frame(maxWidth:.infinity)
        }
    }
    
    @ViewBuilder
    func BuildDateText() -> some View{
        
        if goal.startDate != nil && goal.endDate != nil{
            let text = goal.completedDate == nil ?
            "\(goal.startDate!.toString(timeframeType: .day)) - \(goal.endDate!.toString(timeframeType: .day))" :
            goal.completedDate!.toString(timeframeType: .day)
            
             Text(text)
                .font(.specify(style: .subCaption))
                .foregroundColor(.specify(color: IsCompleted() ? .grey3 : .grey4))
        }

    }
    
    func UpdateGoal(){
        if let goalId{
            _ = vm.UpdateGoalProgress(id: goalId, progress: amount)
        }
    }

    
    func GetIsComplete() -> Bool {
        return goal.progress >= totalAmount
    }
    
    func AddNewGoal(){
        
        if let goalId{
            if let parentId = goal.parentId{
                if let parentGoal = vm.GetGoal(id: parentId) {
                    
                    // add new goal
                    let request = CreateGoalRequest(title: "", description: "", priority: parentGoal.priority, startDate: nil, endDate: nil, percentComplete: 0, image: parentGoal.image, aspect: parentGoal.aspect, parent: parentGoal.id, previousGoalId: selectedGoalId, superId: parentGoal.superId)//, isRecurring: false, amount: nil, unitOfMeasure: nil, timeframe: nil, schedule: nil)
                    let createdId = vm.CreateGoal(request: request, silenceUpdates: true)
                    selectedGoalId = createdId
                    newGoalId = createdId
                    let childGoals = vm.ListChildGoals(id: goalId)
                    childGoals.forEach({
                        var props = Properties(goal: $0)
                        props.parentGoalId = createdId
                        _ = vm.UpdateGoal(id: props.id, request: UpdateGoalRequest(properties: props), notify: false)
                    })
                    vm.GoalsDidChange()
                }
            }
        }
        else{
            if let parentGoal = vm.GetGoal(id: superId){
                let request = CreateGoalRequest(title: goal.title, description: "", priority: parentGoal.priority, startDate: nil, endDate: nil, percentComplete: 0, image: parentGoal.image, aspect: parentGoal.aspect, parent: parentGoal.id, previousGoalId: selectedGoalId, superId: parentGoal.superId)//, isRecurring: false, amount: nil, unitOfMeasure: nil, timeframe: nil, schedule: nil)
                let createdId = vm.CreateGoal(request: request, silenceUpdates: true)
                selectedGoalId = createdId
                newGoalId = createdId
                vm.GoalsDidChange()
                goal.title = ""
            }
        }
    }

}


struct CheckOffCardEditor: View{
    let goalId: UUID?
    let superId: UUID
    let proxy: ScrollViewProxy?
    let shouldDismissInteractively: Bool
    var selectedGoalId: UUID
    @Binding var goal: Goal
    @Binding var newGoalId: UUID?
    @Binding var shouldAdd: Bool
    @Binding var isSelected: Int
    @FocusState var isFocused: Bool
    @State private var timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    @EnvironmentObject var vm: ViewModel
    
    var body: some View{
        
        TextField("", text: $goal.title, axis: .vertical)
            .focused($isFocused)
            .scrollDismissesKeyboard(.immediately)
            .submitLabel(.return)
            .frame(maxWidth:.infinity, alignment: .topLeading)
            .font(.specify(style: .body3))
            .foregroundColor(.specify(color: .grey10))
            .multilineTextAlignment(.leading)
            .frame(minHeight:17)
            .onTapGesture{
                isSelected = 2
                isFocused = true
            }
            .frame(maxWidth:.infinity)
            .onChange(of: goal.title){
                _ in
                
                if goal.title.count > 0{
                    TakeAction()
                }
            }
            .onAppear{
                
                if newGoalId == goal.id {
                    isFocused = true
                    isSelected = 2
                    newGoalId = nil
                }
                
                if goalId == nil {
                    isFocused = true
                }
                
                goal.title = goal.title.replacingOccurrences(of: "^\\s*", with: "", options: .regularExpression)
                timer.upstream.connect().cancel()
            }
    }
    
    func TakeAction(){

        if goalId == nil {
            shouldAdd.toggle()
            
        }
        else{
            timer.upstream.connect().cancel()
            let title = goal.title
            
            goal.title = goal.title.replacingOccurrences(of: "^\\s*", with: "", options: .regularExpression)
            goal.title = goal.title.replacingOccurrences(of: "\n", with: "", options: .regularExpression)
            _ = vm.UpdateGoal(id: goal.id, request: UpdateGoalRequest(goal: goal), notify: false)
            
            if(title.contains { $0.isNewline } || (goalId == nil)){
                shouldAdd.toggle()
            }
        }

    }
}

struct CheckOffDropDelegateField {
    var dropPerformed: Bool = false
    var currentItem: IdItem? = nil
    var currentDropTarget: UUID? = nil
    var currentDropPlacement: PlacementType? = nil
    var isDragging: Bool = false
}

struct CheckOffDropDelegate: DropDelegate {
    
    let dropPlacement: PlacementType
    let dropId: UUID
    @Binding var fields: CheckOffDropDelegateField
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        print("dropUpdated. " + (dropPlacement.toString()))
        return DropProposal(operation: .move)
    }
    
    func performDrop(info: DropInfo) -> Bool {
        if fields.currentItem?.id == fields.currentDropTarget{
            
            fields.isDragging = false
            fields.currentItem = nil
            fields.currentDropPlacement = nil
            fields.currentDropTarget = nil
        }
        else{
            print("performDrop. " + (dropPlacement.toString()))
            fields.dropPerformed.toggle()
            fields.isDragging = false
            return true
        }
        return false
    }
    
    func dropExited(info: DropInfo) {
        print("dropExited. " + (dropPlacement.toString()))
        fields.currentDropTarget = nil
        fields.currentDropPlacement = nil
    }
    
    func dropEntered(info: DropInfo) {
        fields.currentDropTarget = dropId
        fields.currentDropPlacement = dropPlacement
        fields.isDragging = true
        print("dropEntered. " + (dropPlacement.toString()))
    }
}
