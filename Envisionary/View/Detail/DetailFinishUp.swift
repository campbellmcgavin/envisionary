//
//  DetailFinishUp.swift
//  Envisionary
//
//  Created by Campbell McGavin on 7/2/23.
//

import SwiftUI

struct DetailFinishUp: View {
    let objectId: UUID
    @State var isPressed: Bool = false
    @State var progress: Int = 0
    @State var goal: Goal = Goal()
    @EnvironmentObject var vm: ViewModel
    @State var hasChildren: Bool = false
    
    var body: some View {
        HStack{
            VStack(alignment:.leading){
                Text(GetIsCompleted() ? "Completed" : "Finish up")
                    .font(.specify(style: .h3))
                    .foregroundColor(.specify(color: .grey10))
                    .padding(.leading,4)
                if hasChildren {
                    if !GetIsCompleted() {
                        Text("Completing will also complete all associated sub goals.")
                            .multilineTextAlignment(.leading)
                            .font(.specify(style: .caption))
                            .foregroundColor(.specify(color: .grey5))
                            .padding(.leading,4)
                    }
                }
            }
            Spacer()
            IconButton(isPressed: $isPressed, size: .medium, iconType: .confirm, iconColor: GetIsCompleted() ? .grey10 : .grey0, circleColor: GetIsCompleted() ? .green : .grey7, hasAnimation: true)
//                .disabled(GetIsCompleted())
        }
        .frame(maxWidth:.infinity)
        .padding()
        .modifier(ModifierCard())
        .onChange(of: isPressed){
            _ in
            if GetIsCompleted() {
                _ = vm.UpdateGoalProgress(id: objectId, progress: StatusType.notStarted.toInt())
            }
            else{
                _ = vm.UpdateGoalProgress(id: objectId, progress: StatusType.completed.toInt())
            }
        }
        .onAppear{
            goal = vm.GetGoal(id: objectId) ?? Goal()
            hasChildren = vm.ListChildGoals(id: objectId).count > 0
        }
        .onChange(of: vm.updates.goal){ _ in
            goal = vm.GetGoal(id: objectId) ?? Goal()
        }
    }
    
    func GetIsCompleted() -> Bool {
        return goal.progress >= StatusType.completed.toInt()
    }
}

struct DetailFinishUp_Previews: PreviewProvider {
    
    static var previews: some View {
        DetailFinishUp(objectId: UUID())
    }
}
