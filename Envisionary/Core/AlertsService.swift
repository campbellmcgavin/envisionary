//
//  AlertsData.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/26/23.
//

import SwiftUI

class AlertsService: ObservableObject {
    @Published var alerts: [Alert] = [Alert]()

    func UpdateObjectAlerts(object: ObjectType, shouldShow: Bool){
        
        alerts.removeAll(where: {$0.alertType == .info_object})
        if shouldShow{
            alerts.append(Alert(alertType: .info_object, keyword: object.toPluralString(), description: object.toDescription(), timeAmount: 45, isPersistent: false))
        }
    }

    func UpdateCalendarAlerts(object: ObjectType, timeframe: TimeframeType, date: Date, shouldShow: Bool){
        alerts.removeAll(where: {$0.alertType == .info_timeframe})
        
        if shouldShow{
            alerts.append(Alert(alertType: .info_timeframe, keyword: "Showing", description: object.toFilterDescription(date: date, timeframe: timeframe), timeAmount: 45, isPersistent: false))
        }
    }
    
    func UpdateContentAlerts(content: ContentViewType, shouldShow: Bool){
        alerts.removeAll(where: {$0.alertType == .info_content})
        
        if shouldShow{
            alerts.append(Alert(alertType: .info_content, keyword: content.toString(), description: content.toDescription(), timeAmount: 45, isPersistent: false))
        }
    }
    
    func AddSetupUnlockAlert(object: ObjectType){
        alerts.removeAll(where: {$0.alertType == .confirm})
            var message = "has been unlocked!"
            
//            if object == .goal {
//                message.append(" Go to Plan to continue.")
//            }
//            if object == .home{
//                message.append(" Go to Execute to continue.")
//            }
//            if object == .chapter{
//                message.append(" Go to Journal to continue.")
//            }
            
            alerts.append(Alert(alertType: .confirm, keyword: object.toPluralString(), description: message, timeAmount: 45, isPersistent: false))
//        }
    }
}
