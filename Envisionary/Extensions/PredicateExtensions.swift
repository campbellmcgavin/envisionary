//
//  PredicateExtensions.swift
//  Envisionary
//
//  Created by Campbell McGavin on 11/16/23.
//
import SwiftUI


extension Goal{
    static let predicatesOrderBased: [AreInIncreasingOrder] = [
        
        {($0.progress >= 100 ? 1 : 0) < (($1.progress >= 100) ? 1 : 0)},
        {
            ($0.completedDate != nil && $1.completedDate != nil) ?
            ($0.completedDate! < $1.completedDate!) :
            ($0.position) < ($1.position)
        }
    ]
    
    public typealias AreInIncreasingOrder = (Goal, Goal) -> Bool
    
    static func ComplexSort(predicates: [AreInIncreasingOrder], goals: [Goal])  -> [Goal]{

        return goals.sorted {
            (lhs, rhs) in

                for predicate in predicates {
                    if !predicate(lhs,rhs) && !predicate(rhs,lhs) {
                        continue
                    }
                    return predicate(lhs,rhs)
                }
                return false
        }
    }
}
