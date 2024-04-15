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
}
