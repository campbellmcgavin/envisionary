//
//  CheckoffView.swift
//  Envisionary
//
//  Created by Campbell McGavin on 10/22/23.
//

import SwiftUI

struct CheckoffView<Value: Identifiable, V: View>: View where Value: Equatable {
    @Binding var shouldShowAll: Bool
    @Binding var focusGoal: UUID
    let parentGoalId: UUID
    let goalId: UUID
    let leftPadding: CGFloat
    let outerPadding: CGFloat
    let canEdit: Bool
    let proxy: ScrollViewProxy?
    let shouldDismissInteractively: Bool
    let value: (Value, CGFloat, CGFloat) -> V
    @State var goals = [Goal]()
    @State var shouldAdd = false
    @State var shouldSave = false
    @State var customOrder = true
    @State var affectedGoals = [Goal]()
    @State var visibleChildGoals = 0
    @State var visibleAffectedGoals = 0
    @State var allGoalsCompleted: Bool = false
    
//    private typealias AreInIncreasingOrder = (Goal, Goal) -> Bool
//    private let predicates: [AreInIncreasingOrder] = [
//        {($0.progress >= 100 ? 1 : 0) < (($1.progress >= 100) ? 1 : 0)},
//        {(($0.endDate < Date() && $0.progress < 100) ? 1 : 0) > (($1.endDate < Date() && $1.progress < 100) ? 1 : 0)},
//        {(Date.isHappeningNow(start: $0.startDate, end: $0.endDate) ? 1 : 0) > ((Date.isHappeningNow(start: $1.startDate, end: $1.endDate)) ? 1 : 0)},
//        {$0.startDate < $1.startDate}
//    ]
//
//    private let predicatesOrderBased: [AreInIncreasingOrder] = [
//        {($0.progress >= 100 ? 1 : 0) < (($1.progress >= 100) ? 1 : 0)},
//        {
//            ($0.completedDate != nil && $1.completedDate != nil) ?
//            ($0.completedDate! < $1.completedDate!) :
//            ($0.position) < ($1.position)
//        }
//    ]
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        if canEdit{
            BuildView()
        }
        else{
            ScrollView{
                BuildView()
            }
        }
    }
    
    @ViewBuilder
    func BuildView() -> some View{
        VStack(alignment: .leading, spacing:0) {
            
            if parentGoalId != goalId{
                value(goalId as! Value, leftPadding, outerPadding)
            }

                if parentGoalId == goalId{
                    
                    VStack{
                        HStack{
                            Text("Filtering \(affectedGoals.count - visibleAffectedGoals)")
                                .foregroundColor(.specify(color: .grey4))
                                .font(.specify(style: .caption))
                                .padding(.leading,leftPadding + 30)
                            Spacer()
                            TextIconButton(isPressed: $shouldShowAll, text: shouldShowAll ? "Hide Completed" : "Show Completed", color: .purple, backgroundColor: .clear, fontSize: .caption, shouldFillWidth: false, addHeight: -3)
                        }
                        .padding(5)
                        .padding(.leading,10)
                        .padding(.trailing,10)
                        .padding(.top,4)
                        .frame(height:35 )
                        
                        StackDivider(shouldIndent: false, color: .grey3)
                        
                        // can't see any goals
                        // or all goals completed
                        if visibleChildGoals == 0 || allGoalsCompleted {
                            CheckoffCard(goalId: nil, superId: parentGoalId, canEdit: true, leftPadding: leftPadding + 30 + 8, outerPadding: outerPadding, proxy: proxy, shouldDismissInteractively: shouldDismissInteractively, selectedGoalId: $focusGoal, isPresentingModal: .constant(false), modalType: .constant(.add),  newGoalId: .constant(nil), dropFields: .constant(CheckOffDropDelegateField()))
                                .padding(.top,-9)
                        }
                    }
                    
                }
            
            ForEach(goals, content: { child in
                    if (ShouldShow(goal: child)){
                        CheckoffView(shouldShowAll: $shouldShowAll, focusGoal: $focusGoal, parentGoalId: parentGoalId, goalId: child.id, leftPadding: leftPadding + 30, outerPadding: outerPadding, canEdit: canEdit, proxy: proxy, shouldDismissInteractively: shouldDismissInteractively, value: self.value)
                    }
                })
            
            if parentGoalId == goalId{
                if visibleChildGoals != 0 && goals.last?.progress ?? 100 < 100 {
                    CheckoffCard(goalId: nil, superId: parentGoalId, canEdit: true, leftPadding: leftPadding + 30 + 8, outerPadding: outerPadding, proxy: proxy, shouldDismissInteractively: shouldDismissInteractively, selectedGoalId: $focusGoal, isPresentingModal: .constant(false), modalType: .constant(.add),  newGoalId: .constant(nil), dropFields: .constant(CheckOffDropDelegateField()))
                        .offset(x:-2)
                }
                
                Spacer()
            }
        }
        .onChange(of: vm.updates.goal){
            _ in
                UpdateGoals()
        }
        .onChange(of: shouldShowAll){ _ in
            if parentGoalId == goalId{
                UpdateGoals()
            }
        }
        .onAppear(){
            UpdateGoals()
        }
    }
    
    func UpdateGoals(){
            withAnimation{
                goals = Goal.ComplexSort(predicates: Goal.predicatesOrderBased, goals: vm.ListChildGoals(id: goalId))

            }
            if parentGoalId == goalId{
                affectedGoals = vm.ListAffectedGoals(id: parentGoalId)
                visibleChildGoals = goals.map({ShouldShow(goal: $0) ? 1 : 0}).reduce(0,+)
                visibleAffectedGoals = affectedGoals.map({ShouldShow(goal: $0) ? 1 : 0}).reduce(0,+)
                allGoalsCompleted = visibleAffectedGoals == 0 && (goals.map({$0.progress < 100}).filter({$0}).count == 0)
            }
    }
    
    func ShouldShow(goal: Goal) -> Bool{
        
        if shouldShowAll {
            return true
        }
        let objectViewType = vm.filtering.filterObject
        
        if goal.progress < 100 {
            return true
        }
//        if objectViewType == .home && ( (Date.isHappeningNow(start: goal.startDate, end: goal.endDate) && goal.progress < 100) || (goal.endDate.isInThePast && goal.progress < 100)){
//            return true
//        }
//        else if objectViewType == .goal {
//            if goal.progress < 100 || vm.filtering.filterProgress == 100 {
//                if !vm.filtering.filterIncludeCalendar {
//                    return true
//                }
//                else if vm.filtering.filterDate.isBetween(datePair: DatePair(date1: goal.startDate, date2: goal.endDate)){
//                    return true
//                }
//            }
//
//        }
        
        return false
    }
    
//    func SortGoals(predicate: [AreInIncreasingOrder], goals: [Goal]) -> [Goal]{
//
//        if customOrder{
//            return goals.sorted {
//                (lhs, rhs) in
//
//                    for predicate in predicatesOrderBased {
//                        if !predicate(lhs,rhs) && !predicate(rhs,lhs) {
//                            continue
//                        }
//                        return predicate(lhs,rhs)
//                    }
//                    return false
//            }
//        }
//        else{
//            return goals.sorted {
//                (lhs, rhs) in
//
//                    for predicate in predicates {
//                        if !predicate(lhs,rhs) && !predicate(rhs,lhs) {
//                            continue
//                        }
//                        return predicate(lhs,rhs)
//                    }
//                    return false
//            }
//        }
//    }
}



