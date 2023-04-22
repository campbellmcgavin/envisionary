//
//  MissionStatement.swift
//  Visionary
//
//  Created by Campbell McGavin on 8/3/22.
//

import SwiftUI

struct MissionStatement: Identifiable, Equatable, Hashable  {
    let id: UUID
    var introduction: String
    var conclusion: String
    
    init(){
        id = UUID()
        introduction = "My mission statement is"
        conclusion = "As I live by these principles, I will become the best version of myself I possibly can be."
    }
}
