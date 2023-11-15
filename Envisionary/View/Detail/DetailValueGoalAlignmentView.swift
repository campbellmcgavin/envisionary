//
//  DetailValueGoalAlignmentView.swift
//  Envisionary
//
//  Created by Campbell McGavin on 8/11/23.
//

import SwiftUI

struct DetailValueGoalAlignmentView: View {
    @Binding var shouldExpand: Bool
    let valueId: UUID
    
    var body: some View {
        
        DetailView(viewType: .valueGoalAlignment, objectId: valueId, selectedObjectId: .constant(UUID()), selectedObjectType: .constant(.valueRating), shouldExpandAll: $shouldExpand, expandedObjects: .constant([UUID]()), isPresentingModal: .constant(false), modalType: .constant(.add), isPresentingSourceType: .constant(false), didEditPrimaryGoal: .constant(false), currentTimeframe: .day, content: { ValueGoalAlignmentView(valueId: valueId)}, aboveContent: {EmptyView()})
    }
}

struct DetailGoalValueAlignmentView: View {
    @Binding var shouldExpand: Bool
    let goalId: UUID
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
       DetailView(viewType: .goalValueAlignment, objectId: goalId, selectedObjectId: .constant(UUID()), selectedObjectType: .constant(.valueRating), shouldExpandAll: $shouldExpand, expandedObjects: .constant([UUID]()), isPresentingModal: .constant(false), modalType: .constant(.add), isPresentingSourceType: .constant(false), didEditPrimaryGoal: .constant(false), currentTimeframe: .day, shouldShowText: false, content: {
           GoalValueAlignmentView(goalId: goalId)
            
        }, aboveContent: {EmptyView()})
    }
}
