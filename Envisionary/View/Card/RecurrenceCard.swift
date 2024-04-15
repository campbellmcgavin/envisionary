//
//  RecurrenceCard.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/22/23.
//

import SwiftUI

struct RecurrenceCard: View {
    let goalId: UUID
    @Binding var recurrenceId: UUID?
    var showPhotoCard: Bool = true
    @Binding var date: Date
    @State var recurrence: Recurrence = Recurrence()
    @State var habit: Habit = Habit()
    @State var amount = 0
    @State var shouldProcessChange = false
    @State private var loadTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
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
                FormCheckoff(fieldValue: $amount, shouldProcessChange: $shouldProcessChange, checkoffType: habit.schedule.shouldShowAmount() ? .amount : .checkoff, totalAmount: recurrence.scheduleType.shouldShowAmount() ? (habit.amount ?? 100) : 100, unitType: habit.unitOfMeasure)
            }
            .frame(alignment:.trailing)
            .padding(.leading,48)
            .padding(.top,-5)
        }
        .padding(.leading)
        .padding([.trailing,.bottom],10)
        .onAppear{
            SetupRecurrence()
            amount = GetAmount()
        }
//        .onChange(of: finishedLoad){
//            _ in
//            if finishedLoad == false{
//                startloadTimer()
//            }
//        }
        .onChange(of: recurrenceId){
            _ in
            recurrence = vm.GetRecurrence(id: recurrenceId ?? UUID()) ?? Recurrence()
            amount = recurrence.amount
        }
        .onChange(of: vm.updates.recurrence){
            _ in
            recurrence = vm.GetRecurrence(id: recurrenceId ?? UUID()) ?? Recurrence()
            amount = recurrence.amount
        }
        .onChange(of: shouldProcessChange){
            _ in
            CreateOrUpdateRecurrence()
        }
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
            _ = vm.UpdateRecurrence(id: recurrenceId, request: UpdateRecurrenceRequest(amount: amount, isComplete: GetIsCompleted(), archived: recurrence.archived))
            recurrence = vm.GetRecurrence(id: recurrenceId) ?? recurrence
        }
//        else{
//            let request = CreateRecurrenceRequest(goalId: goalId, scheduleType: habit.schedule, timeOfDay: .notApplicable, startDate: date.StartOfDay(), endDate: date.EndOfDay())
//            let id = vm.CreateRecurrence(request: request)
//            let request2 = UpdateRecurrenceRequest(amount: amount, isComplete: GetIsCompleted())
//            print(request2)
//            _ = vm.UpdateRecurrence(id: id, request: request2)
//            let update = vm.GetRecurrence(id: id) ?? Recurrence()
//            print(update)
//            recurrence = update
//            amount = 0
//        }
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
        habit = vm.GetHabit(id: goalId) ?? Habit()
    }
    
    func GetIsCompleted() -> Bool{
        
        if recurrenceId != nil{
            return recurrence.scheduleType.shouldShowAmount() ? amount >= habit.amount ?? 0 : amount == 100
        }
        return true
    }
}

struct RecurrenceCard_Previews: PreviewProvider {
    static var previews: some View {
        RecurrenceCard(goalId: UUID(), recurrenceId: .constant(UUID()), date: .constant(Date()))
            .modifier(ModifierCard())
            .environmentObject(ViewModel())
    }
}
