//
//  ObjectGrouping.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/11/23.
//

import SwiftUI

struct ObjectGrouping: Equatable {

    var dream: GroupingType
    var goal: GroupingType
    var session: GroupingType
    var task: GroupingType
    var habit: GroupingType
    var chapter: GroupingType
    var entry: GroupingType
//    var emotion: GroupingType
    
    init(){
        dream = GroupingType.fromString(from: UserDefaults.standard.string(forKey: SettingsKeyType.group_dream.toString()) ?? "")
        goal = GroupingType.fromString(from: UserDefaults.standard.string(forKey: SettingsKeyType.group_goal.toString()) ?? "")
        session = GroupingType.fromString(from: UserDefaults.standard.string(forKey: SettingsKeyType.group_session.toString()) ?? "")
        task = GroupingType.fromString(from: UserDefaults.standard.string(forKey: SettingsKeyType.group_task.toString()) ?? "")
        habit = GroupingType.fromString(from: UserDefaults.standard.string(forKey: SettingsKeyType.group_habit.toString()) ?? "")
        chapter = GroupingType.fromString(from: UserDefaults.standard.string(forKey: SettingsKeyType.group_chapter.toString()) ?? "")
        entry = GroupingType.fromString(from: UserDefaults.standard.string(forKey: SettingsKeyType.group_entry.toString()) ?? "")
//        emotion = GroupingType.fromString(from: UserDefaults.standard.string(forKey: SettingsKeyType.group_emotion.toString()) ?? "")
    }
    
    static func == (lhs: ObjectGrouping, rhs: ObjectGrouping) -> Bool {
        
        let isEqual =   lhs.dream == rhs.dream &&
                        lhs.goal == rhs.goal &&
                        lhs.session == rhs.session &&
                        lhs.task == rhs.task &&
                        lhs.habit == rhs.habit &&
                        lhs.chapter == rhs.chapter &&
                        lhs.entry == rhs.entry
        return isEqual
    }
}
