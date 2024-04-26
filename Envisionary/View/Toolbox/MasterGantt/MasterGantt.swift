//
//  GanttDateAndBar.swift
//  Visionary
//
//  Created by Campbell McGavin on 5/10/22.
//

import SwiftUI

struct MasterGanttView: View {

    @Binding var properties: [Properties]
    
    @State var focusGoal: UUID = UUID()
    var image: UIImage?
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
    @State var snapToToday: Bool = false
    
    typealias Key = CollectDict<UUID, Anchor<CGPoint>>
    private let coordinateSpaceName = UUID()
    
    var body: some View {
        ZStack(alignment:.topLeading){
            
            RoundedRectangle(cornerRadius:  (SizeType.medium.ToSize() + 10)/2)
                .fill(Color.specify(color: .grey15))
                .frame(maxWidth: .infinity)
                .frame(height: SizeType.medium.ToSize() + 10)
                .frame(alignment:.top)
                .offset(y:-17)
                .offset(y: offset.y > 200 ? offset.y - 200 : 0)
            
            ScrollViewReader{
                reader in
             
                ScrollView(.horizontal, showsIndicators: false){
                    ZStack(alignment:.topLeading){
                        
                        ScrollViewDirectionReader(axis: .horizontal, sensitivity: 2,  startingPoint: CGPoint(x: -200, y: 0), isPositive: $shouldShowPadding)
                                                
                        GanttMainDateColumns(dateValues: dateValues, columnWidth: columnWidth, timeframeType: timeframe)
                            .frame(maxWidth:.infinity)
                                                
                        LazyVStack(spacing:0){
                            ForEach(properties){
                                property in
                                HStack(spacing:0){
                                    
                                    let offset = GetOffset(localGoalId: property.id)
                                    GanttMainDiagram(parentGoalId: property.id, goalId: property.id, offset: offset, focusGoal: $focusGoal, filteredGoals: $filteredGoals, shouldShowAll: $shouldShowAll, value: { localGoalId in
                                        
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
            //                                .padding(.bottom,6)
                                    }, childCount: 0,  currentTimeframeType: $timeframe, shouldShowPadding: shouldShowPadding)
                                }
                                .offset(x: columnWidth/2 + 30, y:columnWidth * 3/4 + 17 + 50)
                            }
                        }
                        
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
                }
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
            
            LazyVStack(alignment:.leading, spacing:0){
                ForEach(properties){ property in
                    TreeView(parentGoalId: property.id, goalId: property.id, focusGoal: $focusGoal, filteredGoals: $filteredGoals, shouldShowAll: $shouldShowAll, leftPadding: 0, value: { goalId, leftPadding in
                        GanttCard(goalId: goalId, leftPadding: leftPadding, isMini: false, selectedGoalId: $focusGoal, shouldShowPadding: $shouldShowPadding)
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
                                            .offset(x: shouldShowPadding ? 0 : -9)
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
                                    }

                                     Spacer()
                                         .frame(height:10)
                                    

                                }
                                .frame(height:SizeType.small.ToSize()+6 + SizeType.small.ToSize() + 20)
                            })
                            
                        }, childCount: 0, isStatic: true, shouldScroll: false)
                        .offset(x:0, y:columnWidth * 3/4 + 50)
                }
            }

        HStack{
            TextIconButton(isPressed: $snapToToday, text: "Today", color: .purple, backgroundColor: .clear, fontSize: .caption, shouldFillWidth: false, addHeight: -3)
            
            Spacer()
            TextIconButton(isPressed: $shouldShowAll, text: shouldShowAll ? "Hide Completed" : "Show Completed", color: .purple, backgroundColor: .clear, fontSize: .caption, shouldFillWidth: false, addHeight: -3)
        }
        .frame(height:30)
        .offset(y: SizeType.medium.ToSize())
            
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
            RoundedRectangle(cornerRadius:  (SizeType.medium.ToSize() + 10)/2)
                .fill(Color.specify(color: .grey15))
                .frame(width:100, height: SizeType.medium.ToSize() + 10)
        )
        .offset(x:5, y:-12)
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
        .frame(height:columnWidth + CGFloat(objectCount) * 55)
        .onChange(of: shouldZoomIn){ _ in
            timeframe = timeframe.toChildTimeframe()
            GetDateValues()
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
        .onAppear(){
            GetDateValues()
            didFinishLoading = true
            GetTotalCount()
        }
    }
    
    func CalculateTodayOffset() -> CGFloat{
        let offset = startDate.GetDateDifferenceAsDecimal(to: Date.now, timeframeType: timeframe)
        return CGFloat(offset) * columnWidth + columnWidth - 5
    }
    
    func GetTotalCount(){
        var totalCount = 0
        
        properties.forEach({ property in
            totalCount += vm.ListAffectedGoals(id: property.id).count
        })
        
        objectCount = totalCount
    }
    
    @ViewBuilder
    func BuildInlineButtons(localGoalId: UUID) -> some View{
        if focusGoal == localGoalId{
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
                    let timeframe = timeframe == .decade ? .year : timeframe
                    var updateRequest = UpdateGoalRequest(goal: goal)
                    updateRequest.endDate = updateRequest.endDate.AdvanceDate(timeframe: timeframe, forward: true)
                    _ = vm.UpdateGoal(id: goal.id, request: updateRequest)
                }
            }
            .onChange(of:shouldRetract){ _ in
                if let goal = vm.GetGoal(id: localGoalId){
                    let timeframe = timeframe == .decade ? .year : timeframe
                    var updateRequest = UpdateGoalRequest(goal: goal)
                    updateRequest.endDate = updateRequest.endDate.AdvanceDate(timeframe: timeframe, forward: false)
                    _ = vm.UpdateGoal(id: goal.id, request: updateRequest)
                }
            }
            .onChange(of:shouldPushBack){ _ in
                let affectedGoals = vm.ListAffectedGoals(id: localGoalId)
    
                let timeframe = timeframe == .decade ? .year : timeframe
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
                let affectedGoals = vm.ListAffectedGoals(id: localGoalId)
    
                let timeframe = timeframe == .decade ? .year : timeframe
                var requestDictionary = [UUID:UpdateGoalRequest]()
                
                for affectedGoal in affectedGoals {
                    var updateRequest = UpdateGoalRequest(goal: affectedGoal)
                    updateRequest.startDate = updateRequest.startDate.AdvanceDate(timeframe: timeframe, forward: true)
                    updateRequest.endDate = updateRequest.endDate.AdvanceDate(timeframe: timeframe, forward: true)
                    requestDictionary[affectedGoal.id] = updateRequest
                }
                _ = vm.UpdateGoals(requestDictionary: requestDictionary)
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
        let units = localGoal.startDate.StartOfDay().GetDateDifferenceAsDecimal(to: localGoal.endDate, timeframeType: timeframe)
        let totalWidth = units * columnWidth
        return totalWidth
    }
    
    func GetOffset(localGoalId: UUID) -> CGFloat{
        let localGoal = vm.GetGoal(id: localGoalId) ?? Goal()
        
        let offset = startDate.GetDateDifferenceAsDecimal(to: localGoal.startDate, timeframeType: timeframe)
        return CGFloat(offset) * columnWidth
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
        let oldestDate = (oldestStartDate ?? Date()).AdvanceDate(timeframe: timeframe.toParentTimeframe(), forward: false)
        
        let latestEndDate = properties.map({$0.endDate ?? Date()}).max()
        let latestDate = (latestEndDate ?? Date()).AdvanceDate(timeframe: timeframe.toParentTimeframe(), forward: true)
        
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
