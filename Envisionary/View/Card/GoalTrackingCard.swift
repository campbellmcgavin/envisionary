//
//  GoalTrackingCard.swift
//  Envisionary
//
//  Created by Campbell McGavin on 7/13/23.
//

import SwiftUI

struct GoalTrackingCard: View {
    let goalId: UUID
    @State var goal: Goal = Goal()
    @State private var timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    @State var amount = 0
    @State var shouldProcessChange = false
    @State var isVisible = false
    let totalAmount = 100
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        VStack{
            PhotoCard(objectType: .goal, objectId: goalId, properties: Properties(goal:goal), shouldHidePadding: true, imageSize: .mediumLarge)
                .padding([.leading,.trailing],15)

            HStack(spacing:6){
                GoalDependencyStack(isVisible: $isVisible, objectId: goalId, tapToShow: true)
                IconButton(isPressed: $shouldProcessChange, size: .medium, iconType: .confirm, iconColor: .grey10, circleColor: GetIsComplete() ? .green : .grey3)
                    .padding(.trailing,8)
            }
            .modifier(ModifierForm(color:.grey15))
            .padding(8)
            .padding(.bottom,5)
            .padding(.leading, isVisible ? 0 : 59)
            .padding(.top,-10)
  
        }
        .onAppear{
            goal = vm.GetGoal(id: goalId) ?? Goal()
            amount = goal.progress
        }
        .onChange(of: shouldProcessChange){
            _ in
            amount = GetIsComplete() ? 0 : totalAmount
            UpdateGoal()
        }
        .onChange(of: vm.updates.goal){
            _ in
            goal = vm.GetGoal(id: goalId) ?? Goal()
        }
    }
    
    func UpdateGoal(){
        _ = vm.UpdateGoalProgress(id: goalId, progress: amount)
    }
    
    func GetIsComplete() -> Bool {
        return goal.progress >= totalAmount
    }
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }

    func startTimer() {
        self.timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
    }
}

struct GoalTrackingCard_Previews: PreviewProvider {
    static var previews: some View {
        GoalTrackingCard(goalId: UUID())
    }
}
