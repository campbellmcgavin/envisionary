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
    @State var recurrence: Recurrence? = nil
    var body: some View {
        
        VStack(spacing:0){
            HeaderButton(isExpanded: $isExpanded, color: .grey10, header: "Progress")
            
            if isExpanded {
                
                VStack{
                    
                    CalendarPicker(date: $date, timeframeType: .constant(.day), dateStatuses: $dateStatuses, localized: true)
                        .padding()
                        .modifier(ModifierCard())
                    
                    if recurrence == nil {
                        Text("The selected date has no associated records to track. You can add a record below.")
                            .font(.specify(style:.h6))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.specify(color: .grey3))
                            .padding(30)
                    }
                    
                    RecurrenceCard(habitId: habitId, recurrenceId: recurrence?.id, showPhotoCard: false, date: $date)
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
            let datesStatuses1 = recurrences.map({DateValue(day: $0.isComplete ? 1 : 0, date: $0.startDate)})
            dateStatuses = datesStatuses1
        }
    }
    
    func UpdateRecurrence(){
        recurrence = recurrences.first(where: {$0.startDate.isInSameDay(as: date)})
    }
}

struct DetailHabitProgress_Previews: PreviewProvider {
    static var previews: some View {
        DetailHabitProgress(shouldExpand: .constant(true), habitId: UUID())
    }
}
