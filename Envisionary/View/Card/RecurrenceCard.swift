//
//  RecurrenceCard.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/22/23.
//

import SwiftUI

struct RecurrenceCard: View {
    let habitId: UUID
    var recurrenceId: UUID?
    var showPhotoCard: Bool = true
    @Binding var date: Date
    @State var recurrence: Recurrence = Recurrence()
    @State var habit: Habit = Habit()
    @State var shouldRecord = false
    @State var amount = 0
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
        
        VStack{
            if showPhotoCard {
                PhotoCard(objectType: .habit, objectId: habit.id, properties: Properties(habit:habit), header: habit.title, subheader: habit.schedule.toString(),imageSize: .mediumLarge)
                    .padding([.leading,.top],-4)
            }
            else{
                HStack{
                    VStack(alignment:.leading){
                        Text("Track progress")
                            .font(.specify(style: .h4))
                            .foregroundColor(.specify(color: .grey10))
                        
                        Text(date.toString(timeframeType: .day))
                            .font(.specify(style:.caption))
                            .foregroundColor(.specify(color: .grey7))
                    }
                    Spacer()
                }
                .padding()
            }

            HStack{
                
                if !shouldRecord{
                    if habit.schedule.shouldShowAmount(){
                        FormCounter(fieldValue: $amount, fieldName: "Amount", buttonSize: .medium)
                    }
                    else{
                        FormLabel(fieldValue: "Progress", fieldName: "Check off")
                    }
                    
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
            SetupRecurrence()
        }
        .onChange(of: shouldRecord){
            _ in
            
            if shouldRecord {
                
                if let recurrenceId {
                    _ = vm.UpdateRecurrence(id: recurrenceId, request: UpdateRecurrenceRequest(amount: amount, isComplete: GetIsCompleted()))
                }
                else{
                    let request = CreateRecurrenceRequest(habitId: habitId, scheduleType: habit.schedule, timeOfDay: .notApplicable, startDate: date.StartOfDay(), endDate: date.EndOfDay())
                    let id = vm.CreateRecurrence(request: request)
                    let request2 = UpdateRecurrenceRequest(amount: amount, isComplete: GetIsCompleted())
                    _ = vm.UpdateRecurrence(id: id, request: request2)
                }
            }
        }
        .onChange(of: recurrenceId){
            _ in
            SetupRecurrence()
        }
    }
    
    func SetupRecurrence(){
        recurrence = vm.GetRecurrence(id: recurrenceId ?? UUID()) ?? Recurrence()
        amount = recurrence.amount
        
        habit = vm.GetHabit(id: habitId) ?? Habit()
        shouldRecord = recurrence.isComplete
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
        RecurrenceCard(habitId: UUID(), recurrenceId: UUID(), date: .constant(Date()))
            .modifier(ModifierCard())
            .environmentObject(ViewModel())
    }
}
