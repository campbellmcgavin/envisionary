//
//  GanttDateAndBar.swift
//  Visionary
//
//  Created by Campbell McGavin on 5/10/22.
//

import SwiftUI

struct GanttMain: View {
    @EnvironmentObject var dataModel: DataModel
    @Binding var goal: Goal
    @Binding var propertyTypeMenu: [Bool]
    @Binding var focusGoal: UUID
    @Binding var expandedGoals: [UUID]
    @State var dateValues: [DateValue] = [DateValue]()
    @State var offsetX: CGFloat = 0
    @State var currentTimeframeType = TimeframeType.day
    let columnWidth: CGFloat = 100
    var isPreview: Bool = true
//    let maxTimeframeValue: Int
    var body: some View {
        
        ScrollView(isPreview ? [.horizontal] : [.horizontal,.vertical], showsIndicators: true){
    
            ZStack(alignment:.leading){
                GanttMainDateColumns(dateValues: $dateValues, columnWidth: columnWidth, timeframeType: goal.timeframe)
                VStack{
                    HStack{
                        Spacer()
                            .frame(width: columnWidth)
                        
                        GanttMainDiagram(goal: $goal, propertyTypeMenu: $propertyTypeMenu, focusGoal: $focusGoal, expandedGoals: $expandedGoals, value: { goal in
                            
                            GanttMainBar(focusGoal: $focusGoal, width: GetWidth(goal: goal), offsetX: GetOffset(goal: goal), goal: goal)
                    

                        }, isPreview: isPreview, childCount: 0,  currentTimeframeType: currentTimeframeType)
                    }
                        .offset(y:50)
                    
                    Spacer()
                        .frame(height:50)
                }

                
                
                
            }
            .frame(alignment:.leading)
        }

        .onAppear(){
            GetDateValues()
            expandedGoals.append(goal.id)
            currentTimeframeType = goal.timeframe
            
            if !isPreview {
                focusGoal = goal.id
            }
        }
        .onChange(of: goal){
            _ in
            GetDateValues()
        }
 
    }
    
    func GetWidth(goal: Goal) -> Double{
        let units = ControllerCalendar.GetDateDifferenceAsDecimal(startDate: goal.startDate, endDate: goal.endDate, timeframeType: GetFocusTimeframe(), dateValues: dateValues)
        let totalWidth = units * columnWidth
        return totalWidth
    }
    
    func GetOffset(goal: Goal) -> CGFloat{

        let offset = ControllerCalendar.GetDateDifferenceAsDecimal(startDate: self.goal.startDate, endDate: goal.startDate, timeframeType: self.goal.timeframe, dateValues: dateValues)
//        let offset = dateValues.firstIndex(where: { $0.date.isInSameTimeframe(as: goal.startDate, timeframeType: timeframeType)}) ?? 0
        return CGFloat(offset) * columnWidth
    }
    
    
    func GetDateValues(){
        dateValues = ControllerCalendar.GetDatesArray(startDate: goal.startDate, endDate: goal.endDate, timeframeType: GetFocusTimeframe())
    }
    
    
    func GetFocusTimeframe() -> TimeframeType{
        switch goal.timeframe{
        case .decade:
            return .decade
        case .year:
            return .year
        case .month:
            return .month
        case .week:
            return .week
        case .day:
            return .day
        }
    }
    

}

struct GanttDateAndBar_Previews: PreviewProvider {
    static var previews: some View {
        GanttMain(goal: .constant(Goal.sampleGoals[0]), propertyTypeMenu: .constant([Bool](repeating: true, count:PropertyType.allCases.count)), focusGoal: .constant(UUID()), expandedGoals: .constant([UUID]()), isPreview: true)
    }
}
