//
//  MasterGantt.swift
//  Envisionary
//
//  Created by Campbell McGavin on 8/7/23.
//

import SwiftUI

struct MasterGantt: View {
    
    @Binding var timeframe: TimeframeType
    @State var dateValues = [DateValue]()
    @State var goalIds = [UUID]()
    @State var expandedGoals = [UUID]()
    @State var focusGoal = UUID()
    @State var columnWidth = SizeType.ganttColumnWidth.ToSize()
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
        ScrollView(.horizontal){
            ZStack(alignment:.leading){
                GanttMainDateColumns(dateValues: dateValues, columnWidth: columnWidth, timeframeType: timeframe)

                VStack{
                    ForEach(goalIds){ goalId in
                        BuildGantt(id: goalId, objectType: .goal)
                        StackDivider()
                    }
                }
                .padding(.top,50)
            }
        }

        .modifier(ModifierCard(color:.grey1))
        .onAppear(){
            LoadGoals()
            GetDateValues()
        }
        .onChange(of: timeframe){
            _ in
            GetDateValues()
        }
    }
    
    func GetDateValues(){
        let startDate = vm.filtering.filterDate.StartOfTimeframe(timeframe: timeframe.toParentTimeframe())
        let endDate = vm.filtering.filterDate.EndOfTimeframe(timeframe: timeframe.toParentTimeframe())
        dateValues = startDate.GetDatesArray(endDate: endDate, timeframeType: timeframe)
    }
    
    func LoadGoals(){
        var criteria = Criteria()
        criteria.includeCalendar = false
        goalIds = vm.ListGoals(criteria: criteria).map({$0.id})
    }
    
    
    @ViewBuilder
    func BuildGantt(id: UUID, objectType: ObjectType) -> some View{
        ZStack(alignment:.topLeading){
            ScrollView(.horizontal, showsIndicators: false){
                ZStack(alignment:.leading){
                    VStack{
                        GanttMainDiagram(parentGoalId: id, goalId: id, focusGoal: $focusGoal, expandedGoals: $expandedGoals, value: { localGoalId in
                            
                            BubbleView(goalId: localGoalId, focusGoal: $focusGoal, width: GetWidth(localGoalId: localGoalId), offset: 0, shouldShowDetails: false)
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
                .foregroundColor(.specify(color: .grey1))
                .padding(.top,columnWidth/2-5)
            
            TreeView(goalId: id, focusGoal: $focusGoal, expandedGoals: $expandedGoals, value: { goalId in
                DotView(goalId: goalId, focusGoal: $focusGoal, shouldShowStatusLabel: true)
                
            }, childCount: 0, isStatic: true)
            .offset(x:10, y:columnWidth/2)
        }
    }
    
    func GetWidth(localGoalId: UUID) -> Double{
        let localGoal = vm.GetGoal(id: localGoalId) ?? Goal()
        let units = localGoal.startDate.StartOfDay().GetDateDifferenceAsDecimal(to: localGoal.endDate, timeframeType: timeframe)
        let totalWidth = units * columnWidth
        return totalWidth
    }
}

struct MasterGantt_Previews: PreviewProvider {
    static var previews: some View {
        MasterGantt(timeframe: .constant(.year))
    }
}
