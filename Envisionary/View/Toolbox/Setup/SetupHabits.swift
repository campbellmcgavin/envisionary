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
    let options = HabitType.allCases.map({$0.toString()})
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        WrappingHStack(fieldValue: .constant(""), fieldValues: $Habits, options: .constant(options), isMultiSelector: true)
            .padding(8)
            .onChange(of: Habits, perform: { _ in
                let count = Habits.values.filter({$0}).count
                canProceed = count > 3 && count < 11
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
                options.forEach { Habits[$0] = false }
            }
    }
}

struct SetupHabit_Previews: PreviewProvider {
    static var previews: some View {
        SetupHabit(canProceed: .constant(false), shouldAct: .constant(false))
    }
}
