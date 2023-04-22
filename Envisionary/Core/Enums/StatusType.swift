//
//  StatusType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/2/23.
//

import Foundation

enum StatusType: Int, CaseIterable {
    
    case notStarted = 0
    case inProgress = 50
    case completed = 100
    
    func toString() -> String{
        
        switch self {
        case .notStarted:
            return "Not Started"
        case .inProgress:
            return "In Progress"
        case .completed:
            return "Completed"
        }
    }
    
    func toInt() -> Int {
        switch self {
        case .notStarted:
            return 0
        case .inProgress:
            return 50
        case .completed:
            return 100
        }
    }
    
    func hasObject(progress: Int) -> Bool {
        switch self {
        case .notStarted:
            return progress >= 0 && progress <= 1
        case .inProgress:
            return progress > 1 && progress <= 99
        case .completed:
            return progress > 99
        }
    }
    
    static func getStatusFromProgress(progress: Int) -> StatusType{
        if progress <= 1 {
            return .notStarted
        }
        else if progress > 1 && progress <= 99 {
            return .inProgress
        }
        else {
            return .completed
        }
    }
    

}
