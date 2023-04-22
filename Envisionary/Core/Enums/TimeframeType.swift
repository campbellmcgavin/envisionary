//
//  TimeframeType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/9/23.
//

enum TimeframeType: Int, CaseIterable, Codable{
    case decade = 0
    case year = 1
    case month = 2
    case week = 3
    case day = 4
    
    func toImage() -> String{
        switch self {
        case .decade:
            return "timeframe.decade"
        case .year:
            return "timeframe.year"
        case .month:
            return "timeframe.month"
        case .week:
            return "timeframe.week"
        case .day:
            return "timeframe.day"
        }
    }
    
    func toString() -> String{
        switch self {
        case .decade:
            return "Decade"
        case .year:
            return "Year"
        case .month:
            return "Month"
        case .week:
            return "Week"
        case .day:
            return "Day"
        }
    }
    
    func toChildTimeframe()  -> TimeframeType {
        switch self {
        case .decade:
            return .year
        case .year:
            return .month
        case .month:
            return .week
        case .week:
            return .day
        case .day:
            return .day
        }
    }
}
