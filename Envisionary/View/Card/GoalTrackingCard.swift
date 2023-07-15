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
    @State var finishedLoad = false
    @State private var timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    @State var amount = 0
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        VStack{
            PhotoCard(objectType: .goal, objectId: goalId, properties: Properties(goal:goal), shouldHidePadding: true, imageSize: .mediumLarge)
                .padding([.leading,.trailing],15)

            FormCheckoff(fieldValue: $amount, finishedLoad: $finishedLoad, checkoffType: .checkoff, totalAmount: 100)
                .frame(alignment:.trailing)
                .padding(.leading,65)
                .padding(.top,-5)
                .padding([.bottom,.trailing])
  
        }
        .onAppear{
            finishedLoad = false
            goal = vm.GetGoal(id: goalId) ?? Goal()
            amount = goal.progress
            startTimer()
        }
        .onChange(of: amount){
            _ in
            
            if finishedLoad {
                UpdateGoal()
            }
        }
        .onReceive(timer, perform: { _ in
            stopTimer()
            withAnimation{
                finishedLoad = true
            }
        })
        .onChange(of: vm.updates.goal){
            _ in
            goal = vm.GetGoal(id: goalId) ?? Goal()
        }
    }
    
    func UpdateGoal(){
        _ = vm.UpdateGoalProgress(id: goalId, progress: amount)
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
