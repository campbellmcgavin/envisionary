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
    
    init(){
        dream = .title
        goal = .title
        session = .title
        task = .title
        habit = .title
        chapter = .title
        entry = .title
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
