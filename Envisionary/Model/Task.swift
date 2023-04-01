////
////  Task.swift
////  Visionary
////
////  Created by Campbell McGavin on 3/10/22.
////
//import SwiftUI
//import Foundation
//
//struct Task: Identifiable, Codable, Equatable, Hashable {
//    var id: UUID
//    var parentId: UUID?
//    var isAllDay: Bool
//    var isScratchpad: Bool
//    var startDateTime: Date
//    var endDateTime: Date
//    var title: String
//    var description: String
//    var taskStatus: TaskStatusType
//    var isRecurring: Bool
//    var recurrence: Recurrence?
//
//    init(title: String, description: String) {
//        self.id = UUID()
//        self.title = title
//        self.description = description
//        self.startDateTime = Date()
//        self.endDateTime = Date()
//        self.isAllDay = true
//        self.isScratchpad = false
//        self.taskStatus = .notStarted
//        self.isRecurring = false
//        self.recurrence = Recurrence()
//    }
//    init(title: String, description: String, taskStatus: TaskStatusType) {
//        self.id = UUID()
//        self.title = title
//        self.description = description
//        self.taskStatus = taskStatus
//        self.startDateTime = Date()
//        self.endDateTime = Date()
//        self.isAllDay = true
//        self.isScratchpad = false
//        self.isRecurring = false
//        self.recurrence = Recurrence()
//    }
//    init(title: String, description: String, taskStatus: TaskStatusType, startDateTime: Date) {
//        self.id = UUID()
//        self.title = title
//        self.description = description
//        self.taskStatus = taskStatus
//        self.startDateTime = startDateTime
//        self.endDateTime = startDateTime
//        self.isAllDay = true
//        self.isScratchpad = false
//        self.isRecurring = false
//        self.recurrence = Recurrence()
//    }
//    init(title: String, description: String, taskStatus: TaskStatusType, startDateTime: Date, endDateTime: Date) {
//        self.id = UUID()
//        self.title = title
//        self.description = description
//        self.taskStatus = taskStatus
//        self.startDateTime = startDateTime
//        self.endDateTime = endDateTime
//        self.isAllDay = false
//        self.isScratchpad = false
//        self.isRecurring = false
//        self.recurrence = Recurrence()
//    }
//
//    init(){
//        self.id = UUID()
//        self.title = ""
//        self.description = ""
//        self.taskStatus = .notStarted
//        self.startDateTime = Date()
//        self.endDateTime = Date()
//        self.isAllDay = false
//        self.isScratchpad = false
//        self.isRecurring = false
//        self.recurrence = Recurrence()
//    }
//    init(isScratchpad: Bool){
//        self.id = UUID()
//        self.title = ""
//        self.description = ""
//        self.taskStatus = .notStarted
//        self.startDateTime = Date()
//        self.endDateTime = Date()
//        self.isAllDay = false
//        self.isScratchpad = isScratchpad
//        self.isRecurring = false
//        self.recurrence = Recurrence()
//    }
//
//    struct EditableData {
//        let id: UUID = UUID()
//        var title: String = ""
//        var description: String = ""
//        var parentId: UUID?
//        var startDateTime: Date = Date()
//        var endDateTime: Date = Date()
//        var taskStatus: TaskStatusType = .notStarted
//        var isAllDay: Bool = false
//        var isScratchpad: Bool = false
//        var isRecurring: Bool = false
//        var recurrence: Recurrence? = Recurrence()
//    }
//
//    var editableData: EditableData {
//        EditableData(title: title, description: description, parentId: parentId, startDateTime: startDateTime, endDateTime: endDateTime, taskStatus: taskStatus, isScratchpad: isScratchpad, isRecurring: isRecurring, recurrence: recurrence)
//    }
//
//    mutating func update(from editableData: EditableData) {
//        title = editableData.title
//        description = editableData.description
//        parentId = editableData.parentId
//        startDateTime = editableData.startDateTime
//        endDateTime = editableData.endDateTime
//        taskStatus = editableData.taskStatus
//        isScratchpad  = editableData.isScratchpad
//        isRecurring = editableData.isRecurring
//        recurrence  = editableData.recurrence
//    }
//
//    mutating func GetDatesScheduled(){
//
//        if recurrence != nil {
//
//            var recurrenceRecords = [RecurrenceRecord]()
//
//            var currentDate = startDateTime
//
//            while currentDate < endDateTime{
//                if recurrence!.timeframeType  == .week {
//                    let tuesday = Calendar.current.date(byAdding: .day, value: 3, to: currentDate.StartOfWeek())!
//
//                    recurrenceRecords.append(RecurrenceRecord(date:tuesday,  recurrence: recurrence!))
////                    switch recurrence!.customSchedule{
////                    case .onCertainDays:
////                        for weekday in recurrence!.customScheduleArray {
////                            recurrenceRecords.append(RecurrenceRecord(date:Calendar.current.date(byAdding: .day, value: (WeekdayType.allCases.first(where:{$0.ToInt() == weekday}) ?? .monday).ToInt(), to: startOfWeek)!,  recurrence: recurrence!))
////                        }
////
////                    case .atATimeOfDay:
////                        for timeOfDay in recurrence!.customScheduleArray {
////                            recurrenceRecords.append(RecurrenceRecord(date:Calendar.current.date(byAdding: .day, value: (WeekdayType.allCases.first(where:{$0.ToInt() == timeOfDay}) ?? .monday).ToInt(), to: startOfWeek)!,  recurrence: recurrence!))
////                        }
////                    default:
////                        recurrenceRecords.append(RecurrenceRecord(date: startOfWeek))
////                    }
//
//                    currentDate = (Calendar.current.date(byAdding: .day, value: 7 * recurrence!.customFrequency, to: currentDate)!)
//                }
//                else{
//                    let startOfDay = currentDate.StartOfDay()
//                    recurrenceRecords.append(RecurrenceRecord(date: startOfDay, recurrence: recurrence!))
////                    switch recurrence!.customSchedule{
////                    case .onCertainDays:
////                        let _ = "why"
////                    default:
////                        recurrenceRecords.append(RecurrenceRecord(date: startOfDay))
////                    }
//                    currentDate = Calendar.current.date(byAdding: .day, value: 1 * recurrence!.customFrequency, to: currentDate)!
//                }
//            }
//            recurrence!.recurrenceRecords = recurrenceRecords
//        }
//
//    }
//
//    init(editableData: EditableData) {
//        id = UUID()
//        title = editableData.title
//        description = editableData.description
//        parentId = editableData.parentId
//        startDateTime = editableData.startDateTime
//        endDateTime = editableData.endDateTime
//        taskStatus = editableData.taskStatus
//        isAllDay = editableData.isAllDay
//        isScratchpad = editableData.isScratchpad
//        isRecurring = editableData.isRecurring
//        recurrence = editableData.recurrence
//    }
//
//}
//
//extension Task {
//
//
//    static let sampleTasks: [Task] =
//    [
//        Task(),
//        Task(title: "Comb the dog", description: "But do it emphatically so you they know who's boss."),
//        Task(title: "Wash the dog", description: "Like it's swimming in a lake."),
//        Task(title: "Dry the dog", description: "Without getting wet yourself."),
//        Task(title: "Cut the dog's hair", description: "But not it's skin or eyeballs."),
//        Task(title: "Hug the dog", description: "Yes yes yesyesyeysyesyeyseyes. Eyes."),
//        Task(title: "Tell the dog they're a good boy", description: "Such a good boy!!!!!!!!!!!!")
//    ]
//}
//
//
//extension DataModel {
//
//    func GetPropertyImage(task: Task, propertyType: PropertyType) -> String{
//
//        switch propertyType{
//        case .title:
//            return "propertyType.title"
//        case .parent:
//            return "propertyType.parent"
//        case .description:
//            return "💬"
//        case .taskStatus:
//            return "propertyType.percent"
//        case .startTime:
//            return "🟢"
//        case .endTime:
//            return "🔴"
//        case .isAllDay:
//            return "☀️"
//        case .recurrenceRecord:
//            return "☑️"
//
//        case .frequency:
//            if task.recurrence != nil {
//                switch task.recurrence!.timeframeType{
//                case .day: return "timeframe.day"
//                case .week: return "timeframe.week"
//                default: return ""
//                }
//            }
//            else {
//                return ""
//            }
//
//        case .weekdays:
//            return "☀️"
//        case .schedule:
//            return "🗓"
//        case .timeOfDay:
//            return "🌙"
//        case .numberOfTimes:
//            return "#️⃣"
//        case .monthDays:
//            return "🗓"
//        case .timeAmount:
//            return "⏳"
//        default:
//            return ""
//        }
//    }
//
//    func GetPropertyTitle(task: Task, propertyType: PropertyType, parentGoalName: String = "") -> String{
//
//        switch propertyType{
//        case .title:
//            return task.title
//        case .description:
//            return task.description.count > 0 ? task.description : "No description"
//        case .taskStatus:
//            return String(task.taskStatus.rawValue)
//        case .startTime:
//            return task.startDateTime.toString(timeframeType: .day)
//        case .endTime:
//            return task.endDateTime.toString(timeframeType: .day)
//        case .isAllDay:
//            return task.isAllDay ==  true ? "All day task" : "Not all day task"
//        case .recurrenceRecord:
//            return  task.recurrence != nil ? String(Int(ControllerStats.GetCompletedDates(task: task))) + " / " +  String(Int(ControllerStats.GetScheduledDates(task: task))) : ""
//        case .frequency:
//            let string1 = "Scheduled for every "
//            var string2 = ""
//            if let recurrence = task.recurrence {
//                switch recurrence.customFrequency {
//                case 0: string2 = "never"
//                case 1: string2 = ""
//                case 2: string2 = "other "
//                case 3: string2 = "third "
//                case 4: string2 = "fourth "
//                case 5: string2 = "fifth "
//                case 6: string2 = "sixth "
//                case 7: string2 = "seventh "
//                default: string2 = String(recurrence.customFrequency) + " "
//                }
//                return string1 + string2 + recurrence.timeframeType.toTitle().lowercased()  + String(recurrence.customFrequency > 7 ? "s." : ".")
//            }
//            return ""
//        case .weekdays:
//
//            if let recurrence = task.recurrence {
//                var isFirst = true
//                var weekdayString = ""
//                for weekdayInt in recurrence.customScheduleArray {
//                    if !isFirst {
//                        weekdayString.append(contentsOf: ", " + WeekdayType.ToString(int: weekdayInt))
//                    }
//                    else{
//                        isFirst =  false
//                        weekdayString.append(contentsOf: WeekdayType.ToString(int: weekdayInt))
//                    }
//                }
//                return weekdayString
//            }
//            return ""
//
//        case .schedule:
//
//            if let recurrence = task.recurrence {
//                return recurrence.customSchedule.rawValue
//            }
//            else{
//                return ""
//            }
//        case .timeOfDay:
//            if let recurrence = task.recurrence {
//                var isFirst = true
//                var returnString = "Occurs in the "
//                for dayScheduleInt in recurrence.customScheduleArray {
//                    if !isFirst {
//                        returnString.append(contentsOf: ", " + TimeOfDayType.ToString(int: dayScheduleInt))
//                    }
//                    else{
//                        isFirst =  false
//                        returnString.append(contentsOf: TimeOfDayType.ToString(int: dayScheduleInt))
//                    }
//                }
//                return returnString
//            }
//            else{
//                return ""
//            }
//        case .numberOfTimes:
//            if let recurrence = task.recurrence {
//                return String(recurrence.customValue) + String(recurrence.customValue > 1 ? " times" : " time")
//            }
//            else{
//                return ""
//            }
//        case .monthDays:
//            return ""
//        case .timeAmount:
//            if let recurrence = task.recurrence {
//                return String(recurrence.customValue) + " " + recurrence.customTimeUnit.rawValue  + String(recurrence.customValue > 1 ? "s" : "")
//            }
//            else{
//                return ""
//            }
//        default:
//            return ""
//        }
//    }
//
//    func GetPropertyDescription(task: Task, propertyType: PropertyType) -> String{
//
//
//        switch propertyType{
//        case .title:
//            return "The title for this task"
//        case .description:
//            return "The description for this task"
//        case .taskStatus:
//            return "The status for this task"
//        case .startTime:
//            return "The start time of this task"
//        case .endTime:
//            return "The end time of this task"
//        case .isAllDay:
//            return "Whether or not the task is scheduled for all-day"
//        case .recurrenceRecord:
//            return "The number of times completed."
//        case .frequency:
//            return "The frequency of recurrence."
//        case .weekdays:
//            return "The days scheduled to complete this habit."
//        case .schedule:
//            return "The type of schedule, based on the frequency."
//        case .timeOfDay:
//            return "The time of day scheduled to complete this habit."
//        case .numberOfTimes:
//            return "The number of times scheduled per timeframe to complete."
//        case .monthDays:
//            return  "The days of the month this habit is scheduled for."
//        case .timeAmount:
//            return "The amount of time that should be taken to complete this habit, each timeframe."
//        default:
//            return ""
//        }
//
//    }
//
//
//    func GetPropertyTitleShort(task: Task, propertyType: PropertyType, parentString: String = "") -> String{
//
//        switch propertyType{
//        case .title:
//            return task.title
//        case .parent:
//            return parentString
//        case .taskStatus:
//            return task.taskStatus.ToString()
//        case .startTime:
//            return task.startDateTime.toString(timeframeType: .day)
//        case .endTime:
//            return task.endDateTime.toString(timeframeType: .day)
//        case .isAllDay:
//            return task.isAllDay ? "All-day" : "Not all-day"
//        case .recurrenceRecord:
//            return   task.recurrence != nil ? String(Int(ControllerStats.GetCompletedDates(task: task))) + " / " +  String(Int(ControllerStats.GetScheduledDates(task: task))) : ""
//        case .frequency:
//            return GetPropertyTitle(task: task, propertyType: propertyType)
//        case .weekdays:
//
//
//            if let recurrence = task.recurrence {
//                if recurrence.customSchedule == .onCertainDays {
//                    var weekdayString = ""
//                    for weekdayInt in recurrence.customScheduleArray{
//                        weekdayString.append(String(WeekdayType.ToString(int: weekdayInt).first ?? Character("")))
//                    }
//                    return weekdayString
//                }
//
//            }
//            return ""
//
//        case .schedule:
//            if let recurrence = task.recurrence {
//                return recurrence.customSchedule.rawValue
//            }
//            return ""
//        case .timeOfDay:
//            if let recurrence = task.recurrence {
//                if recurrence.customSchedule == .atATimeOfDay {
//                    var timeOfDayString = ""
//                    for timeOfDayInt in recurrence.customScheduleArray{
//                        timeOfDayString.append(String(TimeOfDayType.ToString(int: timeOfDayInt) + ", "))
//                    }
//                    return timeOfDayString
//                }
//
//            }
//            return ""
//        case .numberOfTimes:
//            return GetPropertyTitle(task: task, propertyType: propertyType)
//        case .monthDays:
//            return GetPropertyTitle(task: task, propertyType: propertyType)
//        case .timeAmount:
//            return GetPropertyTitle(task: task, propertyType: propertyType)
//        default:
//            return ""
//        }
//    }
//
//}
