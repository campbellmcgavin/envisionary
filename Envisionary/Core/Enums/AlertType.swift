//
//  AlertType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/18/23.
//


enum AlertType{
    case error
    case confirm
    case info
    case info_object
    case info_timeframe
    case info_content
    case warn
    
    func GetIcon() -> IconType {
        switch self {
        case .error:
            return .alert
        case .confirm:
            return .confirm_small
        case .info:
            return .info_nocircle
        case .warn:
            return .alert
        case .info_object:
            return .info_nocircle
        case .info_timeframe:
            return .info_nocircle
        case .info_content:
            return .info_nocircle
        }
    }
    
    func GetForegroundColor() -> CustomColor{
        switch self {
        case .error:
              return .red
        case .confirm:
            return .green
        case .info:
            return .blue
        case .warn:
            return .yellow
        case .info_object:
            return .blue
        case .info_timeframe:
            return .blue
        case .info_content:
            return .blue
        }
    }
}
