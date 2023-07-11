//
//  GanttDateAndBar.swift
//  Visionary
//
//  Created by Campbell McGavin on 5/10/22.
//

import SwiftUI

struct GanttMain: View {
    
    var goalId: UUID
    @Binding var focusGoal: UUID
    @Binding var expandedGoals: [UUID]
    @Binding var timeframe: TimeframeType
    @State var dateValues: [DateValue] = [DateValue]()
    @State var offsetX: CGFloat = 0
    @State var goal: Goal = Goal()
    let columnWidth: CGFloat = SizeType.ganttColumnWidth.ToSize()
    var isPreview: Bool = true
    @EnvironmentObject var vm: ViewModel
    @State var shouldZoomOut = false
    @State var shouldZoomIn = false
    
    var body: some View {
        
        
        ZStack(alignment:.topLeading){

            ScrollView(isPreview ? [.horizontal] : [.horizontal,.vertical], showsIndicators: true){
                ZStack(alignment:.leading){
                    GanttMainDateColumns(dateValues: dateValues, columnWidth: columnWidth, timeframeType: timeframe)
                    HStack{
                        
                        GanttMainDiagram(parentGoalId: goalId, goalId: goalId, focusGoal: $focusGoal, expandedGoals: $expandedGoals, value: { localGoalId in
                            
                            BubbleView(goalId: localGoalId, focusGoal: $focusGoal, width: GetWidth(localGoalId: localGoalId), offset: GetOffset(localGoalId: localGoalId), shouldShowDetails: false)
                        }, childCount: 0,  currentTimeframeType: $timeframe)
                    }
                
                    .offset(x: columnWidth/2 + 30, y:columnWidth/2)
                    .padding(.bottom,columnWidth/2)
                }
                .offset(x:columnWidth + 28)
            }
            Rectangle()
                .frame(width:34)
                .frame(maxHeight:.infinity)
                .foregroundColor(.specify(color: .grey15))
                .padding(.top,columnWidth/2-5)
            TreeDiagramView(goalId: goalId, focusGoal: $focusGoal, expandedGoals: $expandedGoals, value: { goalId in
                DotView(goalId: goalId, focusGoal: $focusGoal, shouldShowStatusLabel: true)
                
            }, childCount: 0, isStatic: true)
            .offset(x:10, y:columnWidth/2)
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    IconButton(isPressed: $shouldZoomOut, size: .medium, iconType: .zoomOut, iconColor: .grey9, circleColor: .grey2)
                        .disabled(timeframe == .decade)
                        .opacity(timeframe == .decade ? 0.3 : 1.0)
                    IconButton(isPressed: $shouldZoomIn, size: .medium, iconType: .zoomIn, iconColor: .grey9, circleColor: .grey2)
                        .disabled(timeframe == .day)
                        .opacity(timeframe == .day ? 0.3 : 1.0)
                }
            }

        }
        .onChange(of: shouldZoomIn){ _ in
            timeframe = timeframe.toChildTimeframe()
            GetDateValues()
        }
        .onChange(of: shouldZoomOut){
            _ in
            timeframe = timeframe.toParentTimeframe()
            GetDateValues()
        }
        .onChange(of: vm.updates.goal){
            _ in
            goal = vm.GetGoal(id: goalId) ?? Goal()
            
            DispatchQueue.global(qos: .userInteractive).async{
                    GetDateValues()
            }
        }
        .onAppear(){
            goal = vm.GetGoal(id: goalId) ?? Goal()
            timeframe = goal.timeframe
            GetDateValues()
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
