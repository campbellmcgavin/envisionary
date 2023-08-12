//
//  DetailStackType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 8/11/23.
//

import SwiftUI

enum DetailStackType: CaseIterable, Identifiable {
    
    var id: Self {
        return self
    }
    
    case superCard
    case finishUp
    case archived
    case convertToGoal
    case parentHeader
    case properties
    case creed
    case valueGoalAlignment
    case images
    case children
    case toolbox
    case affectedGoals
    case habitProgress
    
}
