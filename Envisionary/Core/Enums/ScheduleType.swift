//
//  ScheduleType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/21/23.
//

import SwiftUI

enum ScheduleType: CaseIterable, Codable, Equatable, Hashable {
    case aCertainAmountOverTime
    
    case aCertainAmountPerDay
    case oncePerDay
//    case morning
//    case evening
//    case morningAndEvening
    
    case aCertainAmountPerWeek
    case oncePerWeek
    case weekends
    case weekdays
    
    func toString() -> String{
        switch self {
        case .aCertainAmountOverTime:
            return "A certain amount over time"
        case .aCertainAmountPerDay:
            return "A certain amount per day"
//        case .morningAndEvening:
//            return "Morning and Evening"
//        case .morning:
//            return "Morning"
//        case .evening:
//            return "Evening"
        case .oncePerDay:
            return "Once per day"
        case .aCertainAmountPerWeek:
            return "A certain amount per week"
        case .oncePerWeek:
            return "Once per week"
        case .weekends:
            return "Weekends"
        case .weekdays:
            return "Weekdays"
        }
    }
    
    static func fromString(input: String) -> Self{
        return Self.allCases.first(where: {$0.toString() == input}) ?? .oncePerDay
    }
    
    func shouldShow(timeframe: TimeframeType) -> Bool{
        switch self {
        case .aCertainAmountOverTime:
            return true
        case .aCertainAmountPerDay:
            return timeframe == .day
        case .oncePerDay:
            return timeframe == .day
//        case .morning:
//            return timeframe == .day
//        case .evening:
//            return timeframe == .day
//        case .morningAndEvening:
//            return timeframe == .day
            
        case .aCertainAmountPerWeek:
            return timeframe == .week
        case .oncePerWeek:
            return timeframe == .week
        case .weekends:
            return timeframe == .week
        case .weekdays:
            return timeframe == .week
        }
    }
    
    func shouldShowAmount() -> Bool {
        switch self {
        case .aCertainAmountOverTime:
            return true
        case .aCertainAmountPerDay:
            return true
        case .aCertainAmountPerWeek:
            return true
        default:
            return false
        }
    }
}
