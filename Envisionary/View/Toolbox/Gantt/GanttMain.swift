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
    @State var dateValues: [DateValue] = [DateValue]()
    @State var offsetX: CGFloat = 0
    @State var goal: Goal = Goal()
    let columnWidth: CGFloat = SizeType.ganttColumnWidth.ToSize()
    var isPreview: Bool = true
    @EnvironmentObject var vm: ViewModel
    var body: some View {
        
        
        ZStack(alignment:.topLeading){

            ScrollView(isPreview ? [.horizontal] : [.horizontal,.vertical], showsIndicators: true){
                ZStack(alignment:.leading){
                    GanttMainDateColumns(dateValues: dateValues, columnWidth: columnWidth, timeframeType: goal.timeframe)
                    HStack{
                        
                        GanttMainDiagram(parentGoalId: goalId, goalId: goalId, focusGoal: $focusGoal, expandedGoals: $expandedGoals, value: { localGoalId in
                            
                            BubbleView(goalId: localGoalId, focusGoal: $focusGoal, width: GetWidth(localGoalId: localGoalId), offset: GetOffset(localGoalId: localGoalId), shouldShowDetails: false)
                        }, childCount: 0,  currentTimeframeType: goal.timeframe)
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
                DotView(goalId: goalId, focusGoal: $focusGoal)
                
            }, childCount: 0, isStatic: true)
            .offset(x:10, y:columnWidth/2)
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
            GetDateValues()
        }
    }
    
    func GetWidth(localGoalId: UUID) -> Double{
        let localGoal = vm.GetGoal(id: localGoalId) ?? Goal()
        let units = localGoal.startDate.StartOfDay().GetDateDifferenceAsDecimal(to: localGoal.endDate, timeframeType: self.goal.timeframe)
        let totalWidth = units * columnWidth
        return totalWidth
    }
    
    func GetOffset(localGoalId: UUID) -> CGFloat{
        let localGoal = vm.GetGoal(id: localGoalId) ?? Goal()
        let startDate = self.goal.startDate
        let endDate = localGoal.startDate
        let timeframe = self.goal.timeframe
        let offset = startDate.GetDateDifferenceAsDecimal(to: endDate, timeframeType: timeframe)
//        let offset = dateValues.firstIndex(where: { $0.date.isInSameTimeframe(as: goal.startDate, timeframeType: timeframeType)}) ?? 0
        return CGFloat(offset) * columnWidth
    }
    
    
    func GetDateValues(){
            dateValues = goal.startDate.GetDatesArray(endDate: goal.endDate, timeframeType: goal.timeframe)
    }
    

}

//struct GanttDateAndBar_Previews: PreviewProvider {
//    static var previews: some View {
//        GanttMain(goal: .constant(Goal.sampleGoals[0]), propertyTypeMenu: .constant([Bool](repeating: true, count:PropertyType.allCases.count)), focusGoal: .constant(UUID()), expandedGoals: .constant([UUID]()), isPreview: true)
//    }
//}
