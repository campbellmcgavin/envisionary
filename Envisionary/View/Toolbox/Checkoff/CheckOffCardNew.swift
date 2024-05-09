//
//  CheckOffCardNew.swift
//  Envisionary
//
//  Created by Campbell McGavin on 10/23/23.
//

import SwiftUI

struct CheckOffCardNew: View {
    let requireSelect: Bool
    let shouldIndent: Bool
    @Binding var selectedGoalId: UUID
    @Binding var shouldAdd: Bool
    @State var shouldSave: Bool = false
    @EnvironmentObject var vm: ViewModel
    @State var isSelected: Bool = false
    @State var goalName: String = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack{
            IconLabel(size: .small, iconType: .confirm, iconColor: .grey10, circleColor: .grey10)
                .opacity(0.1)
                .padding(.trailing,-8)
            
            ZStack(alignment:.leading){
                if goalName.count == 0 {
                    Text("New goal")
                        .foregroundColor(.specify(color: .grey5))
                        .padding(.leading, isActive() ? 11 : 5)
                        .font(.specify(style: .body3))
                        .allowsHitTesting(true)
                }
                TextField("", text: $goalName, axis: .horizontal)
                    .focused($isFocused)
                    .scrollDismissesKeyboard(.interactively)
                    .submitLabel(.done)
                    .frame(height: 30)
                    .frame(maxWidth:.infinity)
                    .font(.specify(style: .body3))
                    .foregroundColor(.specify(color: .grey10))
            }

            if isActive() {
                IconButton(isPressed: $shouldAdd, size: .small, iconType: .cancel, iconColor: .grey5)
                    .padding(.trailing,-6)
                    .padding(.leading,-7)
                IconButton(isPressed: $shouldSave, size: .small, iconType: .confirm, iconColor: .grey5)
                    .padding(.leading,-5)
                    .padding(.trailing,7)
            }
        }
        .onTapGesture {
            isSelected = true
            isFocused = true
        }
        .modifier(ModifierCard(color: isActive() ? .darkPurple : .clear, padding:1))
        .padding(.trailing,8)
        .padding(.top,-5)
        .padding(.leading, shouldIndent ? 30 : 0)
        .onChange(of: shouldSave){
            _ in
            SaveNewGoal()
        }
        .onChange(of: shouldAdd){
            _ in
            goalName = ""
            isFocused = false
            
            if requireSelect {
                isSelected = false
            }
        }
    }
    
    func isActive() -> Bool{
        return !requireSelect || isSelected
    }
    
    func SaveNewGoal(){
        if goalName.count > 2{
            
            if let goal = vm.GetGoal(id: selectedGoalId) {
//                let request = CreateGoalRequest(title: goalName, description: "", priority: goal.priority, startDate: goal.startDate, endDate: goal.endDate, percentComplete: 0, image: goal.image, aspect: goal.aspect, parent: goal.id)
//
//                let newGoalId = vm.CreateGoal(request: request)
//
//                goalName = ""
//                shouldAdd = false
//                selectedGoalId = newGoalId
            }

        }
    }
}
