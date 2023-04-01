////
////  Journal.swift
////  Visionary
////
////  Created by Campbell McGavin on 4/25/22.
////
//
//import Foundation
//import SwiftUI
//
//struct JournalEntry: Identifiable, Codable, Equatable, Hashable {
//    let id: UUID
//    var title: String
//    var entry: String
//    var date: Date
//    var journal: UUID
//    var aspect: UUID
//    var goalId: UUID?
//    
//    
//    init(id: UUID = UUID(), title: String, entry: String, journal: UUID, date: Date, aspect: UUID, goalId: UUID?) {
//        self.id = id
//        self.title = title
//        self.entry = entry
//        self.journal = journal
//        self.date = date
//        self.aspect = aspect
//        self.goalId = goalId
//    }
//}
//
//extension JournalEntry {
//    
//    
//    struct EditableData {
//        let id: UUID = UUID()
//        var title: String = ""
//        var entry: String = ""
//        var journal: UUID = UUID()
//        var date: Date = Date()
//        var aspect: UUID  = UUID()
//        var goalId: UUID? = nil
//    }
//
//    var editableData: EditableData {
//        EditableData(title: title, entry: entry, journal: journal, date: date, aspect: aspect, goalId: goalId)
//    }
//    
//    mutating func update(from editableData: EditableData) {
//        title = editableData.title
//        entry = editableData.entry
//        journal = editableData.journal
//        date = editableData.date
//        aspect = editableData.aspect
//        goalId = editableData.goalId
//    }
//
//    init(editableData: EditableData) {
//        id = UUID()
//        title = editableData.title
//        entry = editableData.entry
//        journal = editableData.journal
//        date = editableData.date
//        aspect = editableData.aspect
//        goalId = editableData.goalId
//    }
//    
//}
//
//extension JournalEntry {
//    static let sampleJournals: [JournalEntry] =
//    [
//        JournalEntry(title:"", entry:"", journal: UUID(), date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!, aspect: Generic.aspects[5].id, goalId: nil),
//        JournalEntry(title: "I really want to go to Harvard", entry: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", journal: Generic.journals[0].id, date: Date(), aspect: Generic.aspects[5].id, goalId: nil),
//        JournalEntry(title: "I want to start up a company.", entry: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", journal: Generic.journals[1].id, date: Date(), aspect: Generic.aspects[4].id, goalId: nil),
//        JournalEntry(title: "I want to start up a charitable venture.", entry: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", journal: Generic.journals[2].id, date: Date(), aspect: Generic.aspects[3].id, goalId: nil),
//        JournalEntry(title: "I want to become Governor of Utah.", entry: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", journal: Generic.journals[3].id, date: Date(), aspect: Generic.aspects[2].id, goalId: nil),
//        JournalEntry(title: "I need to do the spring cleaning.", entry: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", journal: Generic.journals[1].id, date: Date(), aspect: Generic.aspects[1].id, goalId: nil)
//
//    ]
//}
//
//extension DataModel {
//    
//    func GetPropertyImage(journalEntry: JournalEntry, propertyType: PropertyType) -> String{
//
//        switch propertyType{
//        case .title:
//            return "propertyType.title"
//        case .aspect:
//            return (aspectsList.first(where:{journalEntry.aspect == $0.id}) ?? Generic.aspects[0]).imageString
//        case .dates:
//            return "🕙"
//        case .parent:
//            return (journalList.first(where:{journalEntry.journal == $0.id}) ?? Generic.journals[0]).imageString
//        case .description:
//            return "💬"
//        default:
//            return ""
//        }
//    }
//    
//    func GetPropertyTitle(journalEntry: JournalEntry, propertyType: PropertyType, journalName: String = "") -> String{
//
//        switch propertyType{
//        case .title:
//            return journalEntry.title
//        case .aspect:
//            return ((aspectsList.first(where:{journalEntry.aspect == $0.id}) ?? Generic.aspects[0])).title + " Aspect"
//        case .dates:
//            return journalEntry.date.toString(timeframeType: .day)
//        case .parent:
//            return (journalList.first(where:{journalEntry.journal == $0.id}) ?? Generic.journals[0]).title
//        case .description:
//            return journalEntry.entry
//        default:
//            return ""
//        }
//    }
//    
//    func GetPropertyTitleShort(journalEntry: JournalEntry, propertyType: PropertyType, journalName: String = "") -> String{
//
//        switch propertyType{
//        case .title:
//            return journalEntry.title
//        case .aspect:
//            return ((aspectsList.first(where:{journalEntry.aspect == $0.id}) ?? Generic.aspects[0])).title
//        case .dates:
//            return journalEntry.date.toString(timeframeType: .day)
//        case .parent:
//            return (journalList.first(where:{journalEntry.journal == $0.id}) ?? Generic.journals[0]).title
//        case .description:
//            return journalEntry.entry
//        default:
//            return ""
//        }
//    }
//    
//    func GetPropertyDescription(journalEntry: JournalEntry, propertyType: PropertyType) -> String{
//
//        switch propertyType{
//        case .title:
//            return "The title of this journal entry"
//        case .aspect:
//            return (aspectsList.first(where:{journalEntry.aspect == $0.id}) ?? Generic.aspects[0]).description
//        case .dates:
//            return "The day this journal entry was recorded on."
//        case .parent:
//            return (journalList.first(where:{journalEntry.journal == $0.id}) ?? Generic.journals[0]).description
//        case .description:
//            return "The body of this journal entry."
//        default:
//            return ""
//        }
//    }
//
//}
