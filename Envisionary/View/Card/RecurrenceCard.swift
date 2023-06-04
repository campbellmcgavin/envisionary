//
//  RecurrenceCard.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/22/23.
//

import SwiftUI

struct RecurrenceCard: View {
    let habitId: UUID
    @Binding var recurrenceId: UUID?
    var showPhotoCard: Bool = true
    @Binding var date: Date
    @State var recurrence: Recurrence = Recurrence()
    @State var habit: Habit = Habit()
    @State var shouldRecord = false
    @State var amount = 0
    @State var shouldDisable = false
    @State private var timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
        VStack{
            if showPhotoCard {
                PhotoCard(objectType: .habit, objectId: habit.id, properties: Properties(habit:habit), shouldHidePadding: true, imageSize: .mediumLarge)
                    .padding([.leading,.trailing],15)
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
                if !recurrence.isComplete{
                    if habit.schedule.shouldShowAmount(){
                        FormCounter(fieldValue: $amount, fieldName: "Amount", iconType: .amount, buttonSize: .small, unit: habit.unitOfMeasure, caption: GetCaption(), isSmall: true)
                    }
                    else{
                        FormLabel(fieldValue: "Progress", fieldName: "Check off", iconType: .amount, isSmall: true)
                    }
                    
                    if shouldRecord{
                        Spacer()
                    }
                        IconButton(isPressed: $shouldRecord, size: .medium, iconType: .confirm, iconColor: GetIconColor(), circleColor: GetButtonCircleColor())
                        .padding(.bottom,4)
                        .disabled(shouldDisable)
                }
                else{
                    FormLabel(fieldValue: "Completed", fieldName: "Status", iconType: .confirm, isSmall: true)
                }

                

//                    .padding(.trailing,8)
                    
//                TextButton(isPressed: $shouldRecord, text: "Record", color: .grey10, backgroundColor: .purple, style: .h4, shouldHaveBackground: true, iconType: .confirm, height:.largeMedium)
//                    .frame(width:140)
                
//                else{
//                    Spacer()
//                    TextButton(isPressed: .constant(true), text: "Recorded", color: .grey10, backgroundColor: .darkGreen, style: .h4, shouldHaveBackground: true, iconType: .confirm, height:.largeMedium)
//                        .frame(width:170)
//                }

            }
            .frame(alignment:.trailing)
            .padding(15)
  
        }
        .onAppear{
            SetupRecurrence()
            stopTimer()
        }
        .onChange(of: recurrenceId){
            _ in
            
            recurrence = vm.GetRecurrence(id: recurrenceId ?? UUID()) ?? Recurrence()
                        
            shouldRecord = false
            amount = 0
            shouldDisable = recurrenceId != nil ? (recurrence.isComplete) : false
        }
        .onChange(of: shouldRecord){
            _ in
            
            if shouldRecord {
                shouldDisable = true
                startTimer()
            }
        }
        .onReceive(timer, perform: { _ in
            stopTimer()
            withAnimation{
                CreateOrUpdateRecurrence()
            }
        })
    }
    
    func CreateOrUpdateRecurrence(){
        if shouldRecord{
//            if recurrence.scheduleType == .
            if let recurrenceId {
                _ = vm.UpdateRecurrence(id: recurrenceId, request: UpdateRecurrenceRequest(amount: amount + recurrence.amount, isComplete: GetIsCompleted()))
                recurrence = vm.GetRecurrence(id: recurrenceId) ?? recurrence
                shouldDisable = habit.amount ?? 0 <= recurrence.amount
                shouldRecord = false
                amount = 0
            }
            else{
                let request = CreateRecurrenceRequest(habitId: habitId, scheduleType: habit.schedule, timeOfDay: .notApplicable, startDate: date.StartOfDay(), endDate: date.EndOfDay())
                let id = vm.CreateRecurrence(request: request)
                
                shouldDisable = recurrenceId != nil ? (recurrence.isComplete) : false
                print(shouldRecord)
                let request2 = UpdateRecurrenceRequest(amount: amount, isComplete: GetIsCompleted())
                print(request2)
                _ = vm.UpdateRecurrence(id: id, request: request2)
                let update = vm.GetRecurrence(id: id) ?? Recurrence()
                print(update)
                recurrence = update
                shouldRecord = false
                amount = 0
            }
        }
    }
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    func startTimer() {
        self.timer = Timer.publish(every: showPhotoCard ? 2 : 0.05, on: .main, in: .common).autoconnect()
    }
    
    func GetCaption() -> String?{
        if recurrence.scheduleType.shouldShowAmount() {
            return "\(recurrence.amount) \(habit.unitOfMeasure.toStringShort()) recorded"
        }
        return nil
    }
    
    func GetButtonCircleColor() -> CustomColor {
        
        if shouldRecord {
            if shouldDisable{
                return .green
            }
            return .grey4
        }
        else{
            if shouldDisable{
                return .grey4
            }
            else{
                return .purple
            }
        }
    }
    
    func GetIconColor() -> CustomColor{
        return .grey10
    }
    
    func SetupRecurrence(){
        
        recurrence = vm.GetRecurrence(id: recurrenceId ?? UUID()) ?? Recurrence()
        amount = recurrence.amount
        
        habit = vm.GetHabit(id: habitId) ?? Habit()
        shouldRecord = recurrence.isComplete
    }
    
    func GetIsCompleted() -> Bool{
        if habit.schedule.shouldShowAmount(){
            return recurrenceId == nil ? true : amount + recurrence.amount >= habit.amount ?? 0
        }
        return shouldRecord
    }
}

struct RecurrenceCard_Previews: PreviewProvider {
    static var previews: some View {
        RecurrenceCard(habitId: UUID(), recurrenceId: .constant(UUID()), date: .constant(Date()))
            .modifier(ModifierCard())
            .environmentObject(ViewModel())
    }
}
