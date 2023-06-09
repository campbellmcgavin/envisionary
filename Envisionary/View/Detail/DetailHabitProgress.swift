//
//  DetailHabitProgress.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/23/23.
//

import SwiftUI

struct DetailHabitProgress: View {
    @Binding var shouldExpand: Bool
    let habitId: UUID

    @State var isExpanded: Bool = true
    @EnvironmentObject var vm: ViewModel
    @State var recurrences: [Recurrence] = [Recurrence]()
    @State var dateStatuses: [DateValue] = [DateValue]()
    
    @State var date: Date = Date()
    @State var recurrenceId: UUID? = nil
    var body: some View {
        
        VStack(spacing:0){
            HeaderButton(isExpanded: $isExpanded, color: .grey10, header: "Progress")
            
            if isExpanded {
                
                VStack{
                    
                    CalendarPicker(date: $date, timeframeType: .constant(.day), dateStatuses: $dateStatuses, localized: true)
                        .padding()
                        .modifier(ModifierCard())
                    
                    if recurrenceId == nil {
                        Text("The selected date has no associated records to track. You can add a record below.")
                            .font(.specify(style:.h6))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.specify(color: .grey3))
                            .padding(30)
                    }
                    RecurrenceCard(habitId: habitId, recurrenceId: $recurrenceId, showPhotoCard: false, date: $date)
                        .modifier(ModifierCard())
                }
                .frame(maxWidth:.infinity)
                .frame(alignment:.leading)


            }
        }
        .onChange(of:shouldExpand){
            _ in
            withAnimation{
                if shouldExpand{
                    isExpanded = true
                }
                else{
                    isExpanded = false
                }
            }
        }
        .onChange(of: date){ _ in
            UpdateRecurrence()
        }
        .onChange(of: vm.updates.recurrence){
            _ in
            LoadRecurrences()
            UpdateRecurrence()
        }
        .onAppear{
            LoadRecurrences()
        }
    }
    
    func LoadRecurrences(){
        withAnimation{
            var criteria = Criteria()
            criteria.habitId = habitId
            recurrences = vm.ListRecurrences(criteria: criteria, limit:360)
            let datesStatuses1 = recurrences.map({DateValue(day: GetDateStatus(recurrence: $0), date: $0.startDate)})
            dateStatuses = datesStatuses1
        }
    }
    
    // 0 = grey (always available to add time to, never late)
    // 1 = grey or red if late (always available to add time to, will be marked as late)
    // 2 = green (completed, cannot add more)
    // 3 = purple (partially completed, can add more)
    
    func GetDateStatus(recurrence: Recurrence) -> Int {
//        let schedule = Recurrence().scheduleType
        
        switch recurrence.scheduleType {
        case .aCertainAmountOverTime:
            return recurrence.amount > 0 ? 3 : 0
        case .aCertainAmountPerDay:
            return recurrence.isComplete ? 2 : 1
        case .oncePerDay:
            return recurrence.isComplete ? 2 : 1
//        case .morning:
//            return recurrence.isComplete ? 2 : 1
//        case .evening:
//            return recurrence.isComplete ? 2 : 1
//        case .morningAndEvening:
//            return recurrence.isComplete ? 2 : 1
        case .aCertainAmountPerWeek:
            return recurrence.amount > 0 ? 3 : 0
        case .oncePerWeek:
            return recurrence.isComplete ? 2 : 1
        case .weekends:
            return recurrence.isComplete ? 2 : 1
        case .weekdays:
            return recurrence.isComplete ? 2 : 1
        }
    }
    
    func UpdateRecurrence(){
        recurrenceId = recurrences.first(where: {$0.startDate.isInSameDay(as: date)})?.id
    }
}

struct DetailHabitProgress_Previews: PreviewProvider {
    static var previews: some View {
        DetailHabitProgress(shouldExpand: .constant(true), habitId: UUID())
    }
}
