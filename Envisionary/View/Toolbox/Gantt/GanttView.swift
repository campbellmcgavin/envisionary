//
//  GanttDateAndBar.swift
//  Visionary
//
//  Created by Campbell McGavin on 5/10/22.
//

import SwiftUI

struct GanttView: View {
    
    var goalId: UUID
    @Binding var focusGoal: UUID
    @Binding var timeframe: TimeframeType
    @Binding var didEditPrimaryGoal: Bool
    var image: UIImage? 
    @State var dateValues: [DateValue] = [DateValue]()
    @State var offsetX: CGFloat = 0
    @State var goal: Goal = Goal()
    let columnWidth: CGFloat = SizeType.ganttColumnWidth.ToSize()
    var isPreview: Bool = true
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
    
    typealias Key = CollectDict<UUID, Anchor<CGPoint>>
    
    var body: some View {
        ZStack(alignment:.topLeading){
            
            RoundedRectangle(cornerRadius:  (SizeType.medium.ToSize() + 10)/2)
                .fill(Color.specify(color: .grey15))
                .frame(maxWidth: .infinity)
                .frame(height: SizeType.medium.ToSize() + 10)
                .frame(alignment:.top)
                .offset(y:-17)
            
            ScrollView(.horizontal, showsIndicators: false){
                ZStack(alignment:.topLeading){
                    ScrollViewDirectionReader(axis: .horizontal, sensitivity: 2,  startingPoint: CGPoint(x: -200, y: 0), isPositive: $shouldShowPadding)
                    
                    GanttMainDateColumns(dateValues: dateValues, columnWidth: columnWidth, timeframeType: timeframe)
                    HStack(spacing:0){
                        
                        let offset = GetOffset(localGoalId: goalId)
                        GanttMainDiagram(parentGoalId: goalId, goalId: goalId, offset: offset, focusGoal: $focusGoal, filteredGoals: $filteredGoals, shouldShowAll: $shouldShowAll, value: { localGoalId in
                            
                            BubbleView(goalId: localGoalId, focusGoal: $focusGoal, width: GetWidth(localGoalId: localGoalId), height: SizeType.small.ToSize(), offset: 0, shouldShowDetails: false, ignoreImageLoad: true, ignoreImageRefresh: true)
                                .frame(height:SizeType.small.ToSize()+6)
                                .offset(x:GetOffset(localGoalId: localGoalId))
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
                .padding(.leading, 240)
                .padding(.bottom, 2*columnWidth)
            }
            .offset(y:-17)
            
            
            TreeView(parentGoalId: goalId, goalId: goalId, focusGoal: $focusGoal, filteredGoals: $filteredGoals, shouldShowAll: $shouldShowAll, leftPadding: 0, value: { goalId, leftPadding in
                GanttCard(goalId: goalId, leftPadding: leftPadding, selectedGoalId: $focusGoal, shouldShowPadding: $shouldShowPadding)
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
                            BuildInlineButtons(localGoalId: goalId)
                                 .offset(x: GetInlineButtonPadding(padding: leftPadding))
                                 .frame(height:SizeType.small.ToSize())
                             Spacer()
                                 .frame(height:10)

                        }
                        .frame(height:SizeType.small.ToSize()+6 + SizeType.small.ToSize() + 20)
                    })
                    
                }, childCount: 0, isStatic: true, shouldScroll: false)
                .offset(x:0, y:columnWidth * 3/4 + 50)
           
        HStack{
            Text("Filtering \(filteredGoals)")
                .foregroundColor(.specify(color: .grey4))
                .font(.specify(style: .caption))
                .padding(.leading,5)
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
        .frame(minHeight:300)
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
        .onChange(of: vm.updates.goal){
            _ in
            
            goal = vm.GetGoal(id: goalId) ?? Goal()
            
            if didEditPrimaryGoal{
//                DispatchQueue.global(qos: .userInteractive).async{
                        GetDateValues()
//                }
            }
            didEditPrimaryGoal = false
        }
        .onAppear(){
            goal = vm.GetGoal(id: goalId) ?? Goal()
            timeframe = Date.toBestTimeframe(start: goal.startDate, end: goal.endDate)
            GetDateValues()
            didFinishLoading = true
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
                    if localGoalId == goalId {
                        didEditPrimaryGoal = true
                    }
                    let timeframe = timeframe == .decade ? .year : timeframe
                    var updateRequest = UpdateGoalRequest(goal: goal)
                    updateRequest.endDate = updateRequest.endDate.AdvanceDate(timeframe: timeframe, forward: true)
                    _ = vm.UpdateGoal(id: goal.id, request: updateRequest)
                }
            }
            .onChange(of:shouldRetract){ _ in
                if let goal = vm.GetGoal(id: localGoalId){
                    if localGoalId == goalId {
                        didEditPrimaryGoal = true
                    }
                    let timeframe = timeframe == .decade ? .year : timeframe
                    var updateRequest = UpdateGoalRequest(goal: goal)
                    updateRequest.endDate = updateRequest.endDate.AdvanceDate(timeframe: timeframe, forward: false)
                    _ = vm.UpdateGoal(id: goal.id, request: updateRequest)
                }
            }
            .onChange(of:shouldPushBack){ _ in
                if localGoalId == goalId {
                    didEditPrimaryGoal = true
                }
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
                if localGoalId == goalId {
                    didEditPrimaryGoal = true
                }
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
    
    func GetWidth(localGoalId: UUID) -> Double{
        let localGoal = vm.GetGoal(id: localGoalId) ?? Goal()
        let units = localGoal.startDate.StartOfDay().GetDateDifferenceAsDecimal(to: localGoal.endDate, timeframeType: timeframe)
        let totalWidth = units * columnWidth
        return totalWidth
    }
    
    func GetOffset(localGoalId: UUID) -> CGFloat{
        let localGoal = vm.GetGoal(id: localGoalId) ?? Goal()
        let startDate = self.goal.startDate
        let endDate = localGoal.startDate
//        let timeframe = self.goal.timeframe
        let offset = startDate.GetDateDifferenceAsDecimal(to: endDate, timeframeType: timeframe)
        return CGFloat(offset) * columnWidth
    }
    
    func GetDateValues(){
            dateValues = goal.startDate.GetDatesArray(endDate: goal.endDate, timeframeType: timeframe)
    }
    

}

//struct GanttDateAndBar_Previews: PreviewProvider {
//    static var previews: some View {
//        GanttMain(goal: .constant(Goal.sampleGoals[0]), propertyTypeMenu: .constant([Bool](repeating: true, count:PropertyType.allCases.count)), focusGoal: .constant(UUID()), expandedGoals: .constant([UUID]()), isPreview: true)
//    }
//}
