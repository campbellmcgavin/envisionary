//
//  ObjectType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/8/23.
//

import SwiftUI

enum EntityType: Int, Identifiable, CaseIterable, Codable{
    
    var id: Self {
        return self
    }
    
    case value
    case dream
    case aspect
    case goal
    case habit
    case session
    case journal
    case entry
    case prompt
    case recurrence
    case valueRating
    
    
}
