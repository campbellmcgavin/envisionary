////
////  RecurrenceSchedule.swift
////  Visionary
////
////  Created by Campbell McGavin on 7/15/22.
////
//
//import SwiftUI
//
//struct Recurrence: Identifiable, Codable, Equatable, Hashable {
//    let id: UUID
//    var recurrenceRecords: [RecurrenceRecord]
//    var timeframeType: TimeframeType
//    var customFrequency: Int
//    var customSchedule: ScheduleType
//    var customScheduleArray: [Int]
//    var customValue: Int
//    var customTimeUnit: TimeUnit
//
//
//
//    init(recurrenceRecords: [RecurrenceRecord], timeframeType: TimeframeType, customFrequency: Int, customSchedule: ScheduleType, customScheduleArray: [Int], customValue: Int, customTimeUnit: TimeUnit) {
//        self.id = UUID()
//        self.recurrenceRecords = recurrenceRecords
//        self.timeframeType = timeframeType
//        self.customFrequency = customFrequency
//        self.customSchedule = customSchedule
//        self.customScheduleArray = customScheduleArray
//        self.customValue = customValue
//        self.customTimeUnit =  customTimeUnit
//    }
//
//    init(){
//        self.id = UUID()
//        self.recurrenceRecords = [RecurrenceRecord]()
//        self.timeframeType = .day
//        self.customFrequency = 1
//        self.customSchedule = .justOnce
//        self.customValue = 0
//        self.customScheduleArray = [Int]()
//        self.customTimeUnit = .minute
//    }
//
//
//    struct EditableData {
//        let id = UUID()
//        var recurrenceRecords = [RecurrenceRecord]()
//        var timeframeType = TimeframeType.day
//        var customFrequency = 1
//        var customSchedule = ScheduleType.justOnce
//        var customScheduleArray = [Int]()
//        var customValue = 0
//        var customTimeUnit =  TimeUnit.minute
//    }
//
//    var editableData: EditableData {
//
//        EditableData(recurrenceRecords: recurrenceRecords, timeframeType: timeframeType, customFrequency: customFrequency, customSchedule: customSchedule, customScheduleArray: customScheduleArray, customValue: customValue, customTimeUnit: customTimeUnit)
//    }
//
//
//
//    mutating func update(from editableData: EditableData) {
//
//        recurrenceRecords = editableData.recurrenceRecords
//        timeframeType = editableData.timeframeType
//        customFrequency = editableData.customFrequency
//        customSchedule = editableData.customSchedule
//        customValue = editableData.customValue
//        customTimeUnit  = editableData.customTimeUnit
//    }
//
//    init(editableData: EditableData) {
//        id = UUID()
//        recurrenceRecords = editableData.recurrenceRecords
//        timeframeType = editableData.timeframeType
//        customFrequency = editableData.customFrequency
//        customSchedule = editableData.customSchedule
//        customScheduleArray = editableData.customScheduleArray
//        customValue = editableData.customValue
//        customTimeUnit = editableData.customTimeUnit
//    }
//
//}
//
//extension DataModel{
////    func GetPropertyImage(recurrence: Recurrence, propertyType: PropertyType) -> String{
////
////        switch propertyType {
////        case .recurrenceRecord:
////            return "☑️"
////        case .frequency:
////            switch recurrence.timeframeType{
////            case .day: return "timeframe.day"
////            case .week: return "timeframe.week"
////            default: return ""
////            }
////        case .weekdays:
////            return "☀️"
////        case .schedule:
////            return "🗓"
////        case .timeOfDay:
////            return "🌙"
////        case .numberOfTimes:
////            return "#️⃣"
////        case .monthDays:
////            return "🗓"
////        case .timeAmount:
////            return "⏳"
////        }
////    }
////
////    func GetPropertyTitle(task: Task, propertyType: PropertyType) -> String{
////
////        if task.recurrence != nil {
////            let recurrence = task.recurrence!
////
////            switch propertyType {
////            case .recurrenceRecord:
////                return String(Int(ControllerStats.GetCompletedDates(task: task))) + " / " +  String(Int(ControllerStats.GetScheduledDates(task: task)))
////            case .frequency:
////                let string1 = "Scheduled for every "
////                var string2 = ""
////
////                switch recurrence.customFrequency {
////                case 0: string2 = "never"
////                case 1: string2 = ""
////                case 2: string2 = "other "
////                case 3: string2 = "third "
////                case 4: string2 = "fourth "
////                case 5: string2 = "fifth "
////                case 6: string2 = "sixth "
////                case 7: string2 = "seventh "
////                default: string2 = String(recurrence.customFrequency) + " "
////                }
////                return string1 + string2 + Generic.timeframes.first(where:{$0.timeframeType! == recurrence.timeframeType})!.title.lowercased()  + String(recurrence.customFrequency > 7 ? "s." : ".")
////            case .weekdays:
////                var isFirst = true
////                var weekdayString = ""
////                for weekdayInt in recurrence.customScheduleArray {
////                    if !isFirst {
////                        weekdayString.append(contentsOf: ", " + WeekdayType.ToString(int: weekdayInt))
////                    }
////                    else{
////                        isFirst =  false
////                        weekdayString.append(contentsOf: WeekdayType.ToString(int: weekdayInt))
////                    }
////                }
////                return weekdayString
////
////            case .schedule:
////                return recurrence.customSchedule.rawValue
////            case .timeOfDay:
////                var isFirst = true
////                var returnString = "Occurs in the "
////                for dayScheduleInt in recurrence.customScheduleArray {
////                    if !isFirst {
////                        returnString.append(contentsOf: ", " + TimeOfDayType.ToString(int: dayScheduleInt))
////                    }
////                    else{
////                        isFirst =  false
////                        returnString.append(contentsOf: TimeOfDayType.ToString(int: dayScheduleInt))
////                    }
////                }
////                return returnString
////            case .numberOfTimes:
////                return String(recurrence.customValue) + String(recurrence.customValue > 1 ? " times" : " time")
////            case .monthDays:
////                return ""
////            case .timeAmount:
////                return String(recurrence.customValue) + " " + recurrence.customTimeUnit.rawValue  + String(recurrence.customValue > 1 ? "s" : "")
////            }
////        }
////        return ""
////    }
////
////        func GetPropertyDescription(recurrence: Recurrence, propertyType: PropertyType) -> String{
////
////            switch propertyType {
////            case .recurrenceRecord:
////                return "The number of times completed."
////            case .frequency:
////                return "The frequency of recurrence."
////            case .weekdays:
////                return "The days scheduled to complete this habit."
////            case .schedule:
////                return "The type of schedule, based on the frequency."
////            case .timeOfDay:
////                return "The time of day scheduled to complete this habit."
////            case .numberOfTimes:
////                return "The number of times scheduled per timeframe to complete."
////            case .monthDays:
////                return  "The days of the month this habit is scheduled for."
////            case .timeAmount:
////                return "The amount of time that should be taken to complete this habit, each timeframe."
////            }
////        }
//
//}
