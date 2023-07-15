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
    @State var amount = 0
    @State var shouldDisable = false
    @State private var loadTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State var finishedLoad = false
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
        VStack{
            if showPhotoCard {
                PhotoCard(objectType: .habit, objectId: habit.id, properties: Properties(habit:habit), shouldHidePadding: true, imageSize: .mediumLarge)
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
            }

            HStack{
                FormCheckoff(fieldValue: $amount, finishedLoad: $finishedLoad, checkoffType: habit.schedule.shouldShowAmount() ? .amount : .checkoff, totalAmount: recurrence.scheduleType.shouldShowAmount() ? (habit.amount ?? 100) : 100, unitType: habit.unitOfMeasure)
            }
            .frame(alignment:.trailing)
            .padding(.leading,48)
            .padding(.top,-5)
        }
        .padding([.leading,.trailing,.bottom])
        .onAppear{
            finishedLoad = false
            SetupRecurrence()
            amount = GetAmount()
        }
        .onChange(of: finishedLoad){
            _ in
            startloadTimer()
        }
        .onChange(of: recurrenceId){
            _ in
            
            recurrence = vm.GetRecurrence(id: recurrenceId ?? UUID()) ?? Recurrence()
            amount = 0
            shouldDisable = recurrenceId != nil ? (recurrence.isComplete) : false
        }
        .onChange(of: amount){
            _ in
            
            if finishedLoad {
                CreateOrUpdateRecurrence()
            }
        }
        .onReceive(loadTimer, perform: { _ in
            withAnimation{
                finishedLoad = true
                stoploadTimer()
            }
        })
    }
    
    func GetAmount() -> Int{
        if recurrence.scheduleType.shouldShowAmount(){
            return recurrence.amount
        }
        else{
            return recurrence.isComplete ? 100 : 0
        }
    }
    
    func CreateOrUpdateRecurrence(){
        if let recurrenceId {
            _ = vm.UpdateRecurrence(id: recurrenceId, request: UpdateRecurrenceRequest(amount: amount, isComplete: GetIsCompleted()))
            recurrence = vm.GetRecurrence(id: recurrenceId) ?? recurrence
            shouldDisable = habit.amount ?? 0 <= recurrence.amount
        }
        else{
            let request = CreateRecurrenceRequest(habitId: habitId, scheduleType: habit.schedule, timeOfDay: .notApplicable, startDate: date.StartOfDay(), endDate: date.EndOfDay())
            let id = vm.CreateRecurrence(request: request)
            
            shouldDisable = recurrenceId != nil ? (recurrence.isComplete) : false
            let request2 = UpdateRecurrenceRequest(amount: amount, isComplete: GetIsCompleted())
            print(request2)
            _ = vm.UpdateRecurrence(id: id, request: request2)
            let update = vm.GetRecurrence(id: id) ?? Recurrence()
            print(update)
            recurrence = update
            amount = 0
        }
    }
    
    func stoploadTimer() {
        self.loadTimer.upstream.connect().cancel()
    }
    
    func startloadTimer() {
        self.loadTimer = Timer.publish(every: showPhotoCard ? 2 : 0.05, on: .main, in: .common).autoconnect()
    }
    
    func GetCaption() -> String?{
        if recurrence.scheduleType.shouldShowAmount() {
            return "\(recurrence.amount) \(habit.unitOfMeasure.toStringShort()) recorded"
        }
        return nil
    }
    
    func GetIconColor() -> CustomColor{
        return .grey10
    }
    
    func SetupRecurrence(){
        
        recurrence = vm.GetRecurrence(id: recurrenceId ?? UUID()) ?? Recurrence()
        amount = recurrence.amount == 0 ? 100 : recurrence.amount
        
        habit = vm.GetHabit(id: habitId) ?? Habit()
    }
    
    func GetIsCompleted() -> Bool{
        
        if let recurrenceId{
            return recurrence.scheduleType.shouldShowAmount() ? amount >= habit.amount ?? 0 : amount == 100
        }
        return true
    }
}

struct RecurrenceCard_Previews: PreviewProvider {
    static var previews: some View {
        RecurrenceCard(habitId: UUID(), recurrenceId: .constant(UUID()), date: .constant(Date()))
            .modifier(ModifierCard())
            .environmentObject(ViewModel())
    }
}
