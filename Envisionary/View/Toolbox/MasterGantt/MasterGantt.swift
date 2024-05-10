//
//  GanttDateAndBar.swift
//  Visionary
//
//  Created by Campbell McGavin on 5/10/22.
//

import SwiftUI

struct MasterGanttView: View {
    
    @Binding var properties: [Properties]
    let isLocal: Bool
    
    @State var focusGoal: UUID = UUID()
    @State var dateValues: [DateValue] = [DateValue]()
    @State var offsetX: CGFloat = 0
    
    let columnWidth: CGFloat = SizeType.ganttColumnWidth.ToSize()
    @EnvironmentObject var vm: ViewModel
    
    @State var shouldZoomOut = false
    @State var shouldZoomIn = false
    @State var shouldShowPadding = true
    @State var shouldPushBack = false
    @State var shouldPushForward = false
    @State var shouldExtend = false
    @State var shouldRetract = false
    @State var shouldShowAll = false
    @State var shouldAddDates = false
    @State var filteredGoals = 0
    @State var affectedGoals = 0
    @State var isUpdatingDateValues: Bool = false
    @State var didFinishLoading: Bool = false
    @State var date: Date = Date()
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    @State var timeframe: TimeframeType = .month
    @State var closestId: String = ""
    @State var offset: CGPoint = .zero
    @State var objectCount: Int = 0
    @State var allObjects: [Properties] = [Properties]()
    @State var snapToToday: Bool = false
    @State var expandedObjects = [UUID]()

    
    typealias Key = CollectDict<UUID, Anchor<CGPoint>>
    
    var body: some View {
        ZStack(alignment:.topLeading){
            
            ScrollViewReader{
                reader in
                
                ScrollView(.horizontal, showsIndicators: false){
                    ZStack(alignment:.topLeading){
                        
                        BuildMainDiagram()
                        
                        GanttMainDateColumns(shouldShowPadding: $shouldShowPadding, dateValues: dateValues, columnWidth: columnWidth, timeframeType: timeframe)
                        
                        
                        ZStack{
                            VStack{
                                Circle()
                                    .frame(width:8,height:8)
                                    .foregroundColor(Color.specify(color: .blue))
                                Spacer()
                            }
                            Divider()
                                .frame(maxHeight:.infinity)
                                .frame(width:2)
                                .overlay(Color.specify(color: .blue))
                        }
                        .offset(x:CalculateTodayOffset(), y: 20)
                    }
                    .padding(.leading, 240)
                    .padding(.bottom,60)
                }
                .cornerRadius(SizeType.cornerRadiusForm.ToSize())
                .offset(y:-17)
                .onChange(of: dateValues){
                    _ in
                    reader.scrollTo(closestId, anchor:.top)
                }
                .onChange(of: snapToToday){
                    _ in
                    reader.scrollTo(closestId, anchor:.top)
                }
            }
            
            BuildTree()
            
            BuildTodayCompletedButtons()
            
            BuildZoomButtons()
        }
        .backgroundPreferenceValue(Key.self, { (centers: [UUID: Anchor<CGPoint>]) in
            
            GeometryReader { proxy in
                
                if centers[focusGoal] != nil {
                    
                    let point1: CGPoint = proxy[centers[focusGoal]!]
                    
                    Color.specify(color: .purple)
                        .opacity(0.05)
                        .frame(height: SizeType.small.ToSize()+6 + SizeType.small.ToSize() + 20)
                        .frame(maxWidth:.infinity)
                        .padding(.leading,-UIScreen.screenHeight)
                        .position(x: point1.x, y: point1.y)
                }
            }
        })
        .onChange(of: shouldZoomIn){ _ in
            timeframe = timeframe.toChildTimeframe()
            GetDateValues()
        }
        .onChange(of: vm.updates.goal){
            _ in
            GetAllObjects()
        }
        .onChange(of: dateValues){ _ in
            isUpdatingDateValues = true
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
                withAnimation{
                    self.isUpdatingDateValues = false
                }
            }
        }
        .onChange(of: shouldZoomOut){
            _ in
            timeframe = timeframe.toParentTimeframe()
            GetDateValues()
        }
        .onChange(of: shouldShowAll){ _ in
            CalculateObjectCount()
            snapToToday.toggle()
        }
        .onAppear(){
            GetDateValues()
            GetAllObjects()
            CalculateObjectCount()
            didFinishLoading = true
        }
    }
    
    @ViewBuilder
    func BuildImage(property: Properties) -> some View{
        if !isLocal{
            let image = vm.GetImage(id: property.image ?? UUID())
            ImageCircle(imageSize: SizeType.small.ToSize(), image: image)
                .padding(.leading,4)
        }
    }
    
    func CalculateTodayOffset() -> CGFloat{
        
        let offset = startDate.GetDateDifferenceAsDecimal(to: Date.now, timeframeType: timeframe)
        return CGFloat(offset) * columnWidth + columnWidth - 5
        
    }
    
    @ViewBuilder
    func BuildMainDiagram() -> some View{
        LazyVStack(alignment:.leading, spacing:0){
            ForEach(properties){
                property in
                
                let offset = GetOffset(localGoalId: property.id)
                
                GanttMainDiagram(parentGoalId: property.id, goalId: property.id, offset: offset, focusGoal: $focusGoal, filteredGoals: $filteredGoals, shouldShowAll: $shouldShowAll, expandedGoals: $expandedObjects, shouldShowExpand: !isLocal, value: { localGoalId in
                    
                    BubbleView(goalId: localGoalId, focusGoal: $focusGoal, width: GetWidth(localGoalId: localGoalId), height: SizeType.small.ToSize(), offset: 0, shouldShowDetails: false, ignoreImageLoad: true, ignoreImageRefresh: true)
                        .frame(height:SizeType.small.ToSize()+6)
                        .offset(x: GetOffset(localGoalId: localGoalId))
                        .if(localGoalId == focusGoal, transform: { view in
                            VStack(alignment:.leading, spacing:0){
                                Spacer()
                                    .frame(height:10)
                                view
                                
                                Spacer()
                                    .frame(height:SizeType.small.ToSize())
                                
                                Spacer()
                                    .frame(height:10)
                            }
                            .frame(height:SizeType.small.ToSize()+6 + SizeType.small.ToSize() + 20)
                            
                        })
                }, childCount: 0,  currentTimeframeType: $timeframe, shouldShowPadding: shouldShowPadding)
            }
        }
        .offset(x: columnWidth/2 + 30, y:columnWidth * 3/4 + 17 + 50)
        .padding(.bottom,60)
    }
    
    @ViewBuilder
    func BuildZoomButtons() -> some View{
        HStack{
            IconButton(isPressed: $shouldZoomOut, size: .medium, iconType: .zoomOut, iconColor: .grey9, circleColor: .grey25)
                .disabled(timeframe == .decade)
                .opacity(timeframe == .decade ? 0.3 : 1.0)
            IconButton(isPressed: $shouldZoomIn, size: .medium, iconType: .zoomIn, iconColor: .grey9, circleColor: .grey25)
                .disabled(timeframe == .day)
                .opacity(timeframe == .day ? 0.3 : 1.0)
            if isUpdatingDateValues && didFinishLoading{
                TextIconLabel(text: "Dates Updated", color: .grey10, backgroundColor: .blue, fontSize: .caption, shouldFillWidth: false)
            }
        }
        .frame(alignment:.topLeading)
        .background(
            RoundedRectangle(cornerRadius:  SizeType.cornerRadiusForm.ToSize())
                .fill(Color.specify(color: .grey15))
                .frame(width:96, height: SizeType.medium.ToSize() + 10)
        )
        .offset(x:5, y:-12)
    }
    
    @ViewBuilder
    func BuildTree() -> some View{
        LazyVStack(alignment:.leading, spacing:0){
            ForEach(properties){ property in
                TreeView(parentGoalId: property.id, goalId: property.id, focusGoal: $focusGoal, filteredGoals: $filteredGoals, shouldShowAll: $shouldShowAll, expandedObjects: $expandedObjects, shouldShowExpand: !isLocal, leftPadding: 0, value: { goalId, leftPadding in
                    GanttCard(parentGoalId: property.id, goalId: goalId, leftPadding: leftPadding, isMini: false, selectedGoalId: $focusGoal, shouldShowPadding: $shouldShowPadding)
                        .id(goalId)
                        .anchorPreference(key: Key.self, value: .leading, transform: {
                            [goalId: $0]
                        })
                        .if(goalId == focusGoal, transform: { view in
                            VStack(alignment:.leading, spacing:0){
                                Spacer()
                                    .frame(height:10)
                                
                                HStack{
                                    
                                    view
                                        .offset(x: shouldShowPadding || property.id == goalId ? 0 : -9)
                                    Spacer()
                                }
                                HStack{
                                    BuildInlineButtons(localGoalId: goalId)
                                        .offset(x: GetInlineButtonPadding(padding: leftPadding))
                                        .frame(height:SizeType.small.ToSize())
                                    Spacer()
                                    NavigationLink {
                                        Detail(objectType: .goal, objectId: focusGoal, properties: property)
                                    } label: {
                                        IconLabel(size: .extraSmall, iconType: .right, iconColor: .grey10)
                                            .background(Capsule().fill(Color.specify(color: .grey25)).frame(height:SizeType.small.ToSize() - 6))
                                    }
                                    .frame(height:SizeType.small.ToSize())
                                }
                                
                                Spacer()
                                    .frame(height:10)
                                
                                
                            }
                            .frame(height:SizeType.small.ToSize()+6 + SizeType.small.ToSize() + 20)
                        })
                    
                }, childCount: 0, isStatic: true, shouldScroll: false)
            }
        }
        .offset(x:0, y:columnWidth * 3/4 + 50)
        .padding(.bottom,60)
        .background(
            HStack{
                Color.specify(color: .grey1)
                    .frame(width:230)
                    .frame(maxHeight:.infinity)
                    .padding(.top,65)
                    .padding(.bottom,-70)
                    .blur(radius: 25)
                    .offset(x:-70)
                Spacer()
            }

        )
    }
    
    @ViewBuilder
    func BuildTodayCompletedButtons() -> some View{
        HStack{
            TextIconButton(isPressed: $snapToToday, text: "Today", color: .purple, backgroundColor: .clear, fontSize: .caption, shouldFillWidth: false, addHeight: -3)
            
            Spacer()
            TextIconButton(isPressed: $shouldShowAll, text: shouldShowAll ? "Hide Completed" : "Show Completed", color: .purple, backgroundColor: .clear, fontSize: .caption, shouldFillWidth: false, addHeight: -3)
        }
        .frame(height:30)
        .offset(y: SizeType.medium.ToSize())
    }
    
    @ViewBuilder
    func BuildInlineButtons(localGoalId: UUID) -> some View{
        if focusGoal == localGoalId{
            if let localGoal = vm.GetGoal(id: localGoalId){
                
                if localGoal.hasDates(){
                    HStack(spacing:5){
                        HStack(spacing:-5){
                            IconButton(isPressed: $shouldPushBack, size: .extraSmall, iconType: .arrow_left, iconColor: .grey10)
                            IconButton(isPressed: $shouldPushForward, size: .extraSmall, iconType: .arrow_right, iconColor: .grey10)
                        }
                        .background(Capsule().fill(Color.specify(color: .grey25)).frame(height:SizeType.small.ToSize() - 6))
                        
                        HStack(spacing:-5){
                            IconButton(isPressed: $shouldRetract, size: .extraSmall, iconType: .subtract, iconColor: .grey10)
                            IconButton(isPressed: $shouldExtend, size: .extraSmall, iconType: .add, iconColor: .grey10)
                            
                        }
                        .background(Capsule().fill(Color.specify(color: .grey25)).frame(height:SizeType.small.ToSize() - 6))
                        
                    }
                    .frame(height:SizeType.small.ToSize())
                    .onChange(of:shouldExtend){ _ in
                        if let goal = vm.GetGoal(id: localGoalId){
                            if let startDate = goal.startDate{
                                if let endDate = goal.endDate{
                                    let timeframe = timeframe == .decade ? .year : timeframe
                                    var updateRequest = UpdateGoalRequest(goal: goal)
                                    updateRequest.endDate = endDate.AdvanceDate(timeframe: timeframe, forward: true)
                                    _ = vm.UpdateGoal(id: goal.id, request: updateRequest)
                                }
                            }
                            
                        }
                    }
                    .onChange(of:shouldRetract){ _ in
                        if let goal = vm.GetGoal(id: localGoalId){
                            let timeframe = timeframe == .decade ? .year : timeframe
                            
                            if let endDate = goal.endDate{
                                if let startDate = goal.startDate{
                                    let calculatedEndDate = endDate.AdvanceDate(timeframe: timeframe, forward: false)
                                    
                                    if calculatedEndDate > startDate {
                                        let affectedGoals = vm.ListAffectedGoals(id: localGoalId).filter({$0.startDate != nil && $0.endDate != nil}).filter({$0.endDate! > calculatedEndDate})
                                        var requestDictionary = [UUID:UpdateGoalRequest]()
                                        
                                        for affectedGoal in affectedGoals {
                                            var updateRequest = UpdateGoalRequest(goal: affectedGoal)
                                            
                                            if updateRequest.startDate != nil && updateRequest.startDate! > calculatedEndDate{
                                                updateRequest.startDate = affectedGoal.startDate!.AdvanceDate(timeframe: timeframe, forward: false)
                                            }
                                            updateRequest.endDate = calculatedEndDate
                                            _ = vm.UpdateGoal(id: affectedGoal.id, request: updateRequest)
                                        }
                                    }
                                }
                                
                            }
                            
                        }
                    }
                    .onChange(of:shouldPushBack){ _ in
                        let affectedGoals = vm.ListAffectedGoals(id: localGoalId)
                        
                        let timeframe = timeframe == .decade ? .year : timeframe
                        var requestDictionary = [UUID:UpdateGoalRequest]()
                        
                        for affectedGoal in affectedGoals {
                            var updateRequest = UpdateGoalRequest(goal: affectedGoal)
                            
                            if let startDate = updateRequest.startDate{
                                if let endDate = updateRequest.endDate{
                                    updateRequest.startDate = startDate.AdvanceDate(timeframe: timeframe, forward: false)
                                    updateRequest.endDate = endDate.AdvanceDate(timeframe: timeframe, forward: false)
                                    _ = vm.UpdateGoal(id: affectedGoal.id, request: updateRequest)
                                }
                            }
                            
                        }
                    }
                    .onChange(of:shouldPushForward){ _ in
                        let affectedGoals = vm.ListAffectedGoals(id: localGoalId)
                        
                        let timeframe = timeframe == .decade ? .year : timeframe
                        var requestDictionary = [UUID:UpdateGoalRequest]()
                        
                        for affectedGoal in affectedGoals {
                            var updateRequest = UpdateGoalRequest(goal: affectedGoal)
                            
                            if let startDate = updateRequest.startDate{
                                if let endDate = updateRequest.endDate{
                                    updateRequest.startDate = startDate.AdvanceDate(timeframe: timeframe, forward: true)
                                    updateRequest.endDate = endDate.AdvanceDate(timeframe: timeframe, forward: true)
                                    requestDictionary[affectedGoal.id] = updateRequest
                                    _ = vm.UpdateGoal(id: affectedGoal.id, request: updateRequest)
                                }
                            }
                            
                        }
                    }
                }
                else{
                    
                    TextIconButton(isPressed: $shouldAddDates, text: "Add Dates", color: .grey10, backgroundColor: .grey25, fontSize: .caption, shouldFillWidth: false)
                        .frame(height:SizeType.small.ToSize() - 6)
                        .onChange(of: shouldAddDates){
                            _ in
                            
                            if let localGoal = vm.GetGoal(id: localGoalId) {
                                
                                
                                let parentGoals = vm.ListParentGoals(id: localGoalId)
                                
                                if parentGoals.count > 0 {
                                    var currentIndex = 0
                                    
                                    var currentGoal = localGoal
                                    
                                    for indexGoal in parentGoals{
                                        if indexGoal.hasDates(){
                                            currentGoal = indexGoal
                                            break
                                        }
                                        continue
                                    }
                                    
                                    if currentGoal != localGoal {
                                        
                                        var startDateForUpdates = currentGoal.startDate!
                                        var endDateForUpdates = currentGoal.startDate! + (currentGoal.endDate! - currentGoal.startDate!)/2
                                        
                                        for goalToUpdate in parentGoals{
                                            
                                            if goalToUpdate == currentGoal{
                                                break
                                            }
                                            
                                            var updateGoalRequest = UpdateGoalRequest(goal: goalToUpdate)
                                            updateGoalRequest.startDate = startDateForUpdates
                                            updateGoalRequest.endDate = endDateForUpdates
                                            
                                            _ = vm.UpdateGoal(id: goalToUpdate.id, request: updateGoalRequest, notify: false)
                                        }
                                        
                                        vm.updates.goal.toggle()
                                    }
                                }
                            }

                            
                        }
                }
                
            }
            
        }
    }
    
    func GetInlineButtonPadding(padding: CGFloat) -> CGFloat {
        if shouldShowPadding {
            if padding > UIScreen.screenWidth - 260 {
                return UIScreen.screenWidth - 260 + 10 + SizeType.small.ToSize()
            }
            else{
                return padding + 10 + SizeType.small.ToSize()
            }
        }
        else{
            return 9
        }
    }
    
    func GetWidth(localGoalId: UUID) -> Double{
        let localGoal = vm.GetGoal(id: localGoalId) ?? Goal()
        if let localStartDate = localGoal.startDate{
            if let localEndDate = localGoal.endDate{
                let units = localStartDate.StartOfDay().GetDateDifferenceAsDecimal(to: localEndDate, timeframeType: timeframe)
                let totalWidth = units * columnWidth
                return totalWidth
            }
        }
        return 0
    }
    
    func CalculateObjectCount(){
        
        objectCount = allObjects.filter({shouldShowAll ? true : $0.progress ?? 0 < 100}).count
    }
    
    func GetAllObjects(){
        var affectedGoals: [Goal] = [Goal]()
        
        properties.forEach({
            property in
            
            affectedGoals.append(contentsOf: vm.ListAffectedGoals(id: property.id))
        })
        
        allObjects = affectedGoals.map({Properties(goal: $0)})
    }
    
    func GetOffset(localGoalId: UUID) -> CGFloat{
        let localGoal = vm.GetGoal(id: localGoalId) ?? Goal()
        
        if let localStartDate = localGoal.startDate{
            let offset = startDate.GetDateDifferenceAsDecimal(to: localStartDate, timeframeType: timeframe)
            return CGFloat(offset) * columnWidth
        }
        
        return 0
    }
    
    func GetDateValues(){
        
        ComputeDates()
        dateValues = startDate.StartOfTimeframe(timeframe: timeframe).GetDatesArray(endDate: endDate.EndOfTimeframe(timeframe: timeframe), timeframeType: timeframe)
        
        
        
        if dateValues.count > 0{
            closestId = (dateValues.sorted(by: {($0.date.timeIntervalSince(date)).magnitude < ($1.date.timeIntervalSince(date)).magnitude}).first)?.id ?? dateValues[0].id
        }
    }
    
    func ComputeDates(){
        let oldestStartDate = properties.map({$0.startDate ?? Date()}).min()
        let oldestDate = (oldestStartDate ?? Date()).AdvanceDate(timeframe: timeframe.toParentTimeframe(), forward: false, count: 2)
        
        let latestEndDate = properties.map({$0.endDate ?? Date()}).max()
        let latestDate = (latestEndDate ?? Date()).AdvanceDate(timeframe: timeframe.toParentTimeframe(), forward: true, count: 2)
        
        startDate = oldestDate.StartOfTimeframe(timeframe: timeframe)
        endDate = latestDate.EndOfTimeframe(timeframe: timeframe)
    }
    
    func bind<T>(optional: Binding<Optional<T>>, defaultValue: T) -> Binding<T> {
        Binding(
            get: { optional.wrappedValue ?? defaultValue },
            set: { optional.wrappedValue = $0 }
        )
    }
}

//struct GanttDateAndBar_Previews: PreviewProvider {
//    static var previews: some View {
//        GanttMain(goal: .constant(Goal.sampleGoals[0]), propertyTypeMenu: .constant([Bool](repeating: true, count:PropertyType.allCases.count)), focusGoal: .constant(UUID()), expandedGoals: .constant([UUID]()), isPreview: true)
//    }
//}
