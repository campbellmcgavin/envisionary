//
//  ObjectUpdates.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/11/23.
//

import SwiftUI

struct ObjectUpdates: Equatable {
    var value: Bool
    var creed: Bool
    var aspect: Bool
    var dream: Bool
    var goal: Bool
    var session: Bool
    var habit: Bool
    var task: Bool
    var image: Bool
    var chapter: Bool
    var entry: Bool
    var prompt: Bool
    var recurrence: Bool
    var emotion: Bool
    var activity: Bool
    
    init(){
        image = false
        value = false
        creed = false
        aspect = false
        goal = false
        session = false
        habit = false
        task = false
        dream = false
        chapter = false
        entry = false
        session = false
        prompt = false
        recurrence = false
        emotion = false
        activity = false
    }
    
    static func == (lhs: ObjectUpdates, rhs: ObjectUpdates) -> Bool {
        
        let isEqual = lhs.value == rhs.value &&
        lhs.creed == rhs.creed &&
        lhs.aspect == rhs.aspect &&
        lhs.dream == rhs.dream &&
        lhs.goal == rhs.goal &&
        lhs.session == rhs.session &&
        lhs.habit == rhs.habit &&
        lhs.task == rhs.task &&
        lhs.chapter == rhs.chapter &&
        lhs.image == rhs.image &&
        lhs.entry == rhs.entry &&
        lhs.prompt == rhs.prompt &&
        lhs.recurrence == rhs.recurrence &&
        lhs.emotion == rhs.emotion &&
        lhs.activity == rhs.activity
        
        return isEqual
    }
}
