//
//  ObjectGrouping.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/11/23.
//

import SwiftUI

struct ObjectGrouping {

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
}
