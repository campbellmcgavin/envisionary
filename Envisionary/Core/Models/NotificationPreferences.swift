//
//  NotificationPreferences.swift
//  Envisionary
//
//  Created by Campbell McGavin on 8/14/23.
//

import SwiftUI

struct NotificationPreferences: Equatable {
    var digest: Bool
    var entry: Bool
    var valueAlignment: Bool
    
    init(){
        digest = UserDefaults.standard.bool(forKey: SettingsKeyType.notification_digest.toString())
        entry = UserDefaults.standard.bool(forKey: SettingsKeyType.notification_entry.toString())
        valueAlignment = UserDefaults.standard.bool(forKey: SettingsKeyType.notification_value_align.toString())
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        
        let isEqual =   lhs.digest == rhs.digest &&
                        lhs.entry == rhs.entry &&
                        lhs.valueAlignment == rhs.valueAlignment
        return isEqual
    }
}
