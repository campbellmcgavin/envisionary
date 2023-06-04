//
//  HabitHelper.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/22/23.
//

import SwiftUI

struct HabitHelper {
    
    func CreateRecurrences(habit: Habit) -> [CreateRecurrenceRequest]{
        
        var recurrences = [CreateRecurrenceRequest]()
        let calendar = Calendar.current
        let formatter = DateFormatter()
        
        switch habit.schedule {
        case .aCertainAmountOverTime:
            var date = habit.startDate
            while date < habit.endDate {
                var request = CreateRecurrenceRequest(habitId: habit.id, scheduleType: habit.schedule, timeOfDay: .notApplicable, startDate: date.StartOfDay(), endDate: date.EndOfDay())
                recurrences.append(request)
                date = date.AdvanceDate(timeframe: .day, forward: true)
            }
        case .aCertainAmountPerDay:
            var date = habit.startDate
            
            while date < habit.endDate {
                var request = CreateRecurrenceRequest(habitId: habit.id, scheduleType: habit.schedule, timeOfDay: .notApplicable, startDate: date.StartOfDay(), endDate: date.EndOfDay())
                recurrences.append(request)
                date = date.AdvanceDate(timeframe: .day, forward: true)
            }
            
        case .oncePerDay:
            var date = habit.startDate
            
            while date < habit.endDate {
                var request = CreateRecurrenceRequest(habitId: habit.id, scheduleType: habit.schedule, timeOfDay: .notApplicable, startDate: date.StartOfDay(), endDate: date.EndOfDay())
                recurrences.append(request)
                date = date.AdvanceDate(timeframe: .day, forward: true)
            }
//        case .morning:
//            var date = habit.startDate
//
//            while date < habit.endDate {
//                var request = CreateRecurrenceRequest(habitId: habit.id, scheduleType: habit.schedule, timeOfDay: .morning, startDate: date.StartOfDay(), endDate: date.EndOfDay())
//                recurrences.append(request)
//                date = date.AdvanceDate(timeframe: .day, forward: true)
//            }
//        case .evening:
//            var date = habit.startDate
//
//            while date < habit.endDate {
//                var request = CreateRecurrenceRequest(habitId: habit.id, scheduleType: habit.schedule, timeOfDay: .evening, startDate: date.StartOfDay(), endDate: date.EndOfDay())
//                recurrences.append(request)
//                date = date.AdvanceDate(timeframe: .day, forward: true)
//            }
//        case .morningAndEvening:
//            var date = habit.startDate
//
//            while date < habit.endDate {
//                var request1 = CreateRecurrenceRequest(habitId: habit.id, scheduleType: habit.schedule, timeOfDay: .morning, startDate: date.StartOfDay(), endDate: date.EndOfDay())
//                recurrences.append(request1)
//                var request2 = CreateRecurrenceRequest(habitId: habit.id, scheduleType: habit.schedule, timeOfDay: .evening, startDate: date.StartOfDay(), endDate: date.EndOfDay())
//                recurrences.append(request2)
//                date = date.AdvanceDate(timeframe: .day, forward: true)
//            }
        case .aCertainAmountPerWeek:
//            var date = habit.startDate
//
//            while date < habit.endDate {
//                var request = CreateRecurrenceRequest(habitId: habit.id, scheduleType: habit.schedule, timeOfDay: .evening, startDate: date.StartOfDay(), endDate: date.EndOfDay())
//                recurrences.append(request)
//                date = date.AdvanceDate(timeframe: .week, forward: true)
//            }
            var date = habit.startDate
            
            while date < habit.endDate {
                var request = CreateRecurrenceRequest(habitId: habit.id, scheduleType: habit.schedule, timeOfDay: .notApplicable, startDate: date.StartOfDay(), endDate: date.EndOfDay())
                recurrences.append(request)
                date = date.AdvanceDate(timeframe: .day, forward: true)
            }
        case .oncePerWeek:
            var date = habit.startDate
            
            while date < habit.endDate {
                var request = CreateRecurrenceRequest(habitId: habit.id, scheduleType: habit.schedule, timeOfDay: .evening, startDate: date.StartOfDay(), endDate: date.EndOfDay())
                recurrences.append(request)
                date = date.AdvanceDate(timeframe: .week, forward: true)
            }
        case .weekends:
            var date = habit.startDate
            
            while date < habit.endDate {
            

                let weekday = formatter.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
                if weekday == "Saturday" || weekday == "Sunday" {
                    var request = CreateRecurrenceRequest(habitId: habit.id, scheduleType: habit.schedule, timeOfDay: .notApplicable, startDate: date.StartOfDay(), endDate: date.EndOfDay())
                    recurrences.append(request)
                }
                date = date.AdvanceDate(timeframe: .day, forward: true)
            }
        case .weekdays:
            var date = habit.startDate
            
            while date < habit.endDate {
                let weekday = formatter.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
                if weekday != "Saturday" && weekday != "Sunday" {
                    var request = CreateRecurrenceRequest(habitId: habit.id, scheduleType: habit.schedule, timeOfDay: .notApplicable, startDate: date.StartOfDay(), endDate: date.EndOfDay())
                    recurrences.append(request)
                }
                date = date.AdvanceDate(timeframe: .day, forward: true)
            }
        }
        
        return recurrences
    }
}
