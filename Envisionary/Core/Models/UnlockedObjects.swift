//
//  SetupSteps.swift
//  Envisionary
//
//  Created by Campbell McGavin on 7/8/23.
//

import SwiftUI

struct UnlockedObjects: Equatable {
    
    var unlock_value: Bool
    var unlock_creed: Bool
    var unlock_dream: Bool
    var unlock_aspect: Bool
    var unlock_goal: Bool
    var unlock_habit: Bool
    var unlock_session: Bool
    var unlock_home: Bool
    var unlock_chapter: Bool
    var unlock_entry: Bool
    var unlock_favorite: Bool
    
    init(){
        unlock_value = UserDefaults.standard.bool(forKey: SettingsKeyType.unlock_value.toString())
        unlock_creed = UserDefaults.standard.bool(forKey: SettingsKeyType.unlock_creed.toString())
        unlock_dream = UserDefaults.standard.bool(forKey: SettingsKeyType.unlock_dream.toString())
        unlock_aspect = UserDefaults.standard.bool(forKey: SettingsKeyType.unlock_aspect.toString())
        unlock_goal = UserDefaults.standard.bool(forKey: SettingsKeyType.unlock_goal.toString())
        unlock_habit = UserDefaults.standard.bool(forKey: SettingsKeyType.unlock_habit.toString())
        unlock_session = UserDefaults.standard.bool(forKey: SettingsKeyType.unlock_session.toString())
        unlock_home = UserDefaults.standard.bool(forKey: SettingsKeyType.unlock_home.toString())
        unlock_chapter = UserDefaults.standard.bool(forKey: SettingsKeyType.unlock_chapter.toString())
        unlock_entry = UserDefaults.standard.bool(forKey: SettingsKeyType.unlock_entry.toString())
        unlock_favorite = UserDefaults.standard.bool(forKey: SettingsKeyType.unlock_favorite.toString())
    }
    
    static func == (lhs: UnlockedObjects, rhs: UnlockedObjects) -> Bool {
        
        let isEqual =   lhs.unlock_value == rhs.unlock_value &&
                        lhs.unlock_creed == rhs.unlock_creed &&
                        lhs.unlock_dream == rhs.unlock_dream &&
                        lhs.unlock_aspect == rhs.unlock_aspect &&
                        lhs.unlock_goal == rhs.unlock_goal &&
                        lhs.unlock_habit == rhs.unlock_habit &&
                        lhs.unlock_session == rhs.unlock_session &&
                        lhs.unlock_home == rhs.unlock_home &&
                        lhs.unlock_chapter == rhs.unlock_chapter &&
                        lhs.unlock_entry == rhs.unlock_entry &&
                        lhs.unlock_favorite == rhs.unlock_favorite
        return isEqual
    }
    
    func fromObject(object: ObjectType) -> Bool{
        switch object {
        case .value:
            return unlock_value
        case .creed:
            return unlock_creed
        case .dream:
            return unlock_dream
        case .aspect:
            return unlock_aspect
        case .goal:
            return unlock_goal
        case .habit:
            return unlock_habit
        case .session:
            return unlock_session
        case .home:
            return unlock_home
        case .journal:
            return unlock_chapter
        case .entry:
            return unlock_entry
        case .favorite:
            return unlock_favorite
        default:
            return false
        }
    }
    
    mutating func unlockObject(object: ObjectType){
        switch object {
        case .value:
            unlock_value = true
            UserDefaults.standard.set(true, forKey: SettingsKeyType.unlock_value.toString())
        case .creed:
            unlock_creed = true
            UserDefaults.standard.set(true, forKey: SettingsKeyType.unlock_creed.toString())
        case .dream:
            unlock_dream = true
            UserDefaults.standard.set(true, forKey: SettingsKeyType.unlock_dream.toString())
        case .aspect:
            unlock_aspect = true
            UserDefaults.standard.set(true, forKey: SettingsKeyType.unlock_aspect.toString())
        case .goal:
            unlock_goal = true
            UserDefaults.standard.set(true, forKey: SettingsKeyType.unlock_goal.toString())
        case .habit:
            unlock_habit = true
            UserDefaults.standard.set(true, forKey: SettingsKeyType.unlock_habit.toString())
        case .session:
            unlock_session = true
            UserDefaults.standard.set(true, forKey: SettingsKeyType.unlock_session.toString())
        case .home:
            unlock_home = true
            UserDefaults.standard.set(true, forKey: SettingsKeyType.unlock_home.toString())
        case .journal:
            unlock_chapter = true
            UserDefaults.standard.set(true, forKey: SettingsKeyType.unlock_chapter.toString())
        case .entry:
            unlock_entry = true
            UserDefaults.standard.set(true, forKey: SettingsKeyType.unlock_entry.toString())
        case .favorite:
            unlock_favorite = true
            UserDefaults.standard.set(true, forKey: SettingsKeyType.unlock_favorite.toString())
        default:
            let _ = "why"
        }
    }
}
