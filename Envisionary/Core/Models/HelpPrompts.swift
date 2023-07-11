//
//  HelpPrompts.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/28/23.
//

import SwiftUI

struct HelpPrompts: Equatable {
    
    var object: Bool
    var content: Bool
    var showing: Bool
    
    init(){
        object = UserDefaults.standard.bool(forKey: SettingsKeyType.help_prompts_object.toString())
        content = UserDefaults.standard.bool(forKey: SettingsKeyType.help_prompts_content.toString())
        showing = UserDefaults.standard.bool(forKey: SettingsKeyType.help_prompts_showing.toString())
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        
        let isEqual =   lhs.object == rhs.object &&
                        lhs.content == rhs.content &&
                        lhs.showing == rhs.showing
        return isEqual
    }
}
