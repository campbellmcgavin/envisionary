//
//  SetupSteps.swift
//  Envisionary
//
//  Created by Campbell McGavin on 7/8/23.
//

import SwiftUI

struct UnlockedObjects: Equatable {
    
    var unlock_value: Bool
    var unlock_goal: Bool
    var unlock_chapter: Bool
    var unlock_entry: Bool
    
    init(){
        unlock_value = UserDefaults.standard.bool(forKey: SettingsKeyType.unlock_value.toString())
        unlock_goal = UserDefaults.standard.bool(forKey: SettingsKeyType.unlock_goal.toString())
        unlock_chapter = UserDefaults.standard.bool(forKey: SettingsKeyType.unlock_chapter.toString())
        unlock_entry = UserDefaults.standard.bool(forKey: SettingsKeyType.unlock_entry.toString())
    }
    
    static func == (lhs: UnlockedObjects, rhs: UnlockedObjects) -> Bool {
        
        let isEqual =   lhs.unlock_value == rhs.unlock_value &&
                        lhs.unlock_goal == rhs.unlock_goal &&
                        lhs.unlock_chapter == rhs.unlock_chapter &&
                        lhs.unlock_entry == rhs.unlock_entry
        return isEqual
    }
    
    func fromObject(object: ObjectType) -> Bool{
        switch object {
        case .value:
            return unlock_value
        case .goal:
            return unlock_goal
        case .journal:
            return unlock_chapter
        case .entry:
            return unlock_entry
        default:
            return false
        }
    }
    
    mutating func unlockObject(object: ObjectType){
        switch object {
        case .value:
            unlock_value = true
            UserDefaults.standard.set(true, forKey: SettingsKeyType.unlock_value.toString())
        case .goal:
            unlock_goal = true
            UserDefaults.standard.set(true, forKey: SettingsKeyType.unlock_goal.toString())
        case .journal:
            unlock_chapter = true
            UserDefaults.standard.set(true, forKey: SettingsKeyType.unlock_chapter.toString())
        case .entry:
            unlock_entry = true
            UserDefaults.standard.set(true, forKey: SettingsKeyType.unlock_entry.toString())
        default:
            let _ = "why"
        }
    }
}
