//
//  GanttMainDiagram.swift
//  Visionary
//
//  Created by Campbell McGavin on 5/13/22.
//

import SwiftUI

struct GanttMainDiagram<Value: Identifiable, V: View>: View where Value: Equatable {
    var parentGoalId: UUID
    var goalId: UUID
    @Binding var focusGoal: UUID
    @Binding var filteredGoals: Int
    @Binding var shouldShowAll: Bool
    var value: (Value) -> V
    let childCount: Int
    @Binding var currentTimeframeType: TimeframeType
    @State var shouldMoveBackward = false
    @State var shouldMoveForward = false
    @State var childGoals = [Goal]()
    @State var goals: [Goal] = [Goal]()
    @EnvironmentObject var vm: ViewModel
    
    typealias Key = CollectDict<UUID, Anchor<CGPoint>>

    var body: some View {
        
        return ZStack{
        LazyVStack(alignment: .leading, spacing: 0) {
            
            value(goalId as! Value)
                .anchorPreference(key: Key.self, value: .leading, transform: {
                   [goalId: $0]
               })
                .padding([.top,.bottom],5)

                ForEach(childGoals, content: { child in
                    
                    if ShouldShow(goal: child){
                        GanttMainDiagram(parentGoalId: parentGoalId, goalId: child.id, focusGoal: $focusGoal, filteredGoals: .constant(0), shouldShowAll: $shouldShowAll, value: self.value,  childCount: childCount + 1, currentTimeframeType: $currentTimeframeType)
                    }
                })

        }
        .onAppear{
            UpdateGoals()
        }
        .onChange(of: vm.updates.goal){
            _ in
            UpdateGoals()
        }
        .onChange(of: shouldShowAll){
            _ in
            UpdateGoals()
        }
//        .backgroundPreferenceValue(Key.self, { (leadingEdge: [UUID: Anchor<CGPoint>]) in
//
//                GeometryReader { proxy in
//                    ForEach(childGoals, content: { child in
//
//                        if leadingEdge[goalId] != nil && leadingEdge[child.id] != nil {
//
//                            let point1: CGPoint = proxy[leadingEdge[self.goalId]!]
////                            let offset1 = goal.startDate.GetDateDifferenceAsDecimal(to: vm.GetGoal(id: child)?.startDate ?? Date(), timeframeType: currentTimeframeType) * 100
//                            let offset = GetOffset()
//
//                            let point1Offset = CGPoint(x: point1.x + offset + 30, y: point1.y)
//                            let goal = vm.GetGoal(id: self.goalId) ?? Goal()
//
//                            let offset2 = goal.startDate.GetDateDifferenceAsDecimal(to: vm.GetGoal(id: child.id)?.startDate ?? Date(), timeframeType: currentTimeframeType) * SizeType.ganttColumnWidth.ToSize()
//
//                            let point2: CGPoint = proxy[leadingEdge[child.id]!]
//                            let point2Offset = CGPoint(x:point2.x + (offset2 + offset + 30), y: point2.y)
//
//
//                            Path { path in
//                                path.move(to: point1Offset)
//                                path.addCurve(
//                                    to: point2Offset,
//                                    control1: CGPoint(x: point1Offset.x + 10, y: point2Offset.y - 10),
//                                    control2: CGPoint(x: point1Offset.x + 10, y: point2Offset.y - 10))
//                            }
//                            .stroke(lineWidth: 1)
//                            .foregroundColor(.specify(color:.grey5))
//                        }
//                    })
//                }
//
//
//                })
        }
        }
    
    func UpdateGoals(){
        childGoals = Goal.ComplexSort(predicates: Goal.predicatesOrderBased, goals: vm.ListChildGoals(id: goalId))
        
        if parentGoalId == goalId{
            let affectedGoals = vm.ListAffectedGoals(id: goalId)
            let visibleAffectedGoals = affectedGoals.map({ShouldShow(goal: $0) ? 1 : 0}).reduce(0,+)
            filteredGoals = affectedGoals.count - visibleAffectedGoals
        }
    }
    
    func ShouldShow(goal: Goal) -> Bool{
        
        if shouldShowAll {
            return true
        }
        
        if goal.progress < 100 {
            return true
        }
        
        return false
    }
    
    func GetOffset() -> CGFloat{
        let localGoal = vm.GetGoal(id: goalId) ?? Goal()
        let parentGoal = vm.GetGoal(id: parentGoalId) ?? Goal()
        let startDate = parentGoal.startDate
        let endDate = localGoal.startDate
        
        let timeframe = currentTimeframeType
        let offset = startDate.GetDateDifferenceAsDecimal(to: endDate, timeframeType: timeframe)
//        let offset = dateValues.firstIndex(where: { $0.date.isInSameTimeframe(as: goal.startDate, timeframeType: timeframeType)}) ?? 0
        return offset * SizeType.ganttColumnWidth.ToSize()
    }
}
