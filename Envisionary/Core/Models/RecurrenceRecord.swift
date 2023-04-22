////
////  HabitRecord.swift
////  Visionary
////
////  Created by Campbell McGavin on 7/21/22.
////
//
//import SwiftUI
//
//struct RecurrenceRecord: Identifiable, Codable, Equatable, Hashable{
//    let id: UUID
//    var date: Date
//    var value: Int
//    var scheduleDictionary: [Int:Bool]
//
//    init(){
//        self.id = UUID()
//        self.date = Date()
//        self.value = 0
//        self.scheduleDictionary = [Int:Bool]()
//    }
//
//    init(date: Date){
//        self.id = UUID()
//        self.date = date
//        self.value = 0
//        self.scheduleDictionary = [Int:Bool]()
//    }
//    init(date: Date, recurrence: Recurrence){
//        self.id = UUID()
//        self.date = date
//        self.value = 0
//        self.scheduleDictionary = RecurrenceRecord.GetScheduleDictionary(recurrence: recurrence)
//    }
//
//    static func GetScheduleDictionary(recurrence:  Recurrence) ->  [Int:Bool] {
//
//        var scheduleDictionary = [Int:Bool]()
//
//        switch recurrence.customSchedule{
//        case .atATimeOfDay:
//            for timeOfDay in recurrence.customScheduleArray {
//                scheduleDictionary[timeOfDay]  = false
//            }
//        case .onCertainDays:
//            for onCertainDays in recurrence.customScheduleArray {
//                scheduleDictionary[onCertainDays]  = false
//            }
//        default:
//            let _ = "why"
//        }
//
//
//
//        return scheduleDictionary
//    }
//
//    func IsCompleted(recurrence: Recurrence) -> Bool{
//
//        switch recurrence.customSchedule {
//        case .onCertainDays:
//            if let isCompletedToday = self.scheduleDictionary[Calendar.current.component(.weekday, from: Date())] {
//                return isCompletedToday
//            }
//            return false
//        case .aCertainNumberOfTimes:
//            return self.value >= recurrence.customValue
//        case .atATimeOfDay:
//            return self.scheduleDictionary.values.filter({$0 == true}).count >= recurrence.customScheduleArray.count
//        case .forAnAmountOfTime:
//            return self.value >= recurrence.customValue
//        case .justOnce:
//            return self.value > 0
//        }
//    }
//}
