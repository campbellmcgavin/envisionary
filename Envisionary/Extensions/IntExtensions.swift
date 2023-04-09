//
//  IntExtensions.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/3/23.
//

import SwiftUI

extension Int {
    
    func toStatusType() -> StatusType {
        if self < 2 {
            return .notStarted
        }
        else if self >= 2 && self < 99 {
            return .inProgress
        }
        else {
            return .completed
        }
    }
    func updateProgress(isForward: Bool) -> Int{
        
        if isForward{
            switch self.toStatusType(){
            case .notStarted:
                return 50
            case .inProgress:
                return 100
            case .completed:
                return 100
            }
        }
        else{
            switch self.toStatusType(){
            case .notStarted:
                return 0
            case .inProgress:
                return 0
            case .completed:
                return 50
            }
        }
    }
}
