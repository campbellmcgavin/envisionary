//
//  SetupHabit.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/7/23.
//

import SwiftUI

struct SetupHabit: View {
    @Binding var canProceed: Bool
    @Binding var shouldAct: Bool
    @State var Habits: [String:Bool] = [String:Bool]()
    @State var isExpressSetup = false
    @State var options = [String]()
    let expressOptions: [String] = [HabitType.brushTeeth, HabitType.goToBe10pm, HabitType.dailyExercise].map({$0.toString()})
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
        VStack{
            ExpressSetupButton(isExpressSetup: $isExpressSetup)
            WrappingHStack(fieldValue: .constant(""), fieldValues: $Habits, options: $options, isMultiSelector: true)
                .padding(.top,22)
                .disabled(isExpressSetup)
                .opacity(isExpressSetup ? 0.87 : 1.0)
        }
            .padding(8)
            .onChange(of: Habits, perform: { _ in
                let count = Habits.values.filter({$0}).count
                canProceed = count > 2 && count < 6
            })
            .onChange(of: shouldAct){
                _ in
                let currentlySavedHabits = vm.ListHabits()
                
                for savedHabit in currentlySavedHabits{
                    _ = vm.DeleteHabit(id: savedHabit.id)
                }
                
                for HabitString in Habits.filter({$0.value}).keys{
                    let request = HabitType.fromString(from: HabitString).toRequest()
//                    let request = CreateHabitRequest(title: Habit.toString(), description: "", aspect: Habit.toAspect())
                    _ = vm.CreateHabit(request: request)
                }
            }
            .onAppear{
                SetupHabits()
            }
            .onChange(of: isExpressSetup){
                _ in
                SetupHabits()
            }
    }
    
    func SetupHabits(){
        if isExpressSetup{
            Habits = [String:Bool]()
            options = expressOptions.sorted()
            options.forEach { Habits[$0] = true}
        }
        else{
            Habits = [String:Bool]()
            options = HabitType.allCases.map({$0.toString()})
            options.forEach { Habits[$0] = false }
        }
    }
}

struct SetupHabit_Previews: PreviewProvider {
    static var previews: some View {
        SetupHabit(canProceed: .constant(false), shouldAct: .constant(false))
    }
}
