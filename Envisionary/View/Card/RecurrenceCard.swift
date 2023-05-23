//
//  RecurrenceCard.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/22/23.
//

import SwiftUI

struct RecurrenceCard: View {
    let recurrenceId: UUID
    
    @State var recurrence: Recurrence = Recurrence()
    @State var habit: Habit = Habit()
    @State var shouldRecord = false
    @State var amount = 0
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        VStack{
            PhotoCard(objectType: .habit, objectId: habit.id, properties: Properties(habit:habit), header: habit.title, subheader: habit.schedule.toString(),imageSize: .mediumLarge)
                .padding([.leading,.top],-4)
            HStack{
                
                if !shouldRecord{
                    if habit.schedule.shouldShowAmount(){
                        FormCounter(fieldValue: $amount, fieldName: "Amount", buttonSize: .medium)
                    }
                    else{
                        FormLabel(fieldValue: "Progress", fieldName: "Check off")
                    }
                }
                
                if !shouldRecord{
                    TextButton(isPressed: $shouldRecord, text: "Record", color: .grey10, backgroundColor: .purple, style: .h4, shouldHaveBackground: true, iconType: .confirm, height:.largeMedium)
                        .frame(width:140)
                }
                else{
                    Spacer()
                    TextButton(isPressed: .constant(true), text: "Recorded", color: .grey10, backgroundColor: .darkGreen, style: .h4, shouldHaveBackground: true, iconType: .confirm, height:.largeMedium)
                        .frame(width:170)
                }

            }
            .padding(8)
        }
        .onAppear{
            recurrence = vm.GetRecurrence(id: recurrenceId) ?? Recurrence()
            habit = vm.GetHabit(id: recurrence.habitId) ?? Habit()
            shouldRecord = recurrence.isComplete
        }
        .onChange(of: shouldRecord){
            _ in
            
            if shouldRecord{
                vm.UpdateRecurrence(id: recurrenceId, request: UpdateRecurrenceRequest(amount: amount, isComplete: GetIsCompleted()))
            }
        }
    }
    
    func GetIsCompleted() -> Bool{
        if habit.schedule.shouldShowAmount(){
            return amount >= habit.amount ?? 0
        }
        return shouldRecord
    }
}

struct RecurrenceCard_Previews: PreviewProvider {
    static var previews: some View {
        RecurrenceCard(recurrenceId: UUID())
            .modifier(ModifierCard())
            .environmentObject(ViewModel())
    }
}
