//
//  AlertsData.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/26/23.
//

import SwiftUI

class AlertsService: ObservableObject {
    @Published var alerts: [Alert] = [Alert]()

    func UpdateObjectAlerts(object: ObjectType){
        alerts.removeAll(where: {$0.alertType == .info_object})
        alerts.append(Alert(alertType: .info_object, keyword: object.toPluralString(), description: object.toDescription(), timeAmount: 12, isPersistent: false))
    }

    func UpdateCalendarAlerts(object: ObjectType, timeframe: TimeframeType, date: Date){
        alerts.removeAll(where: {$0.alertType == .info_timeframe})
        alerts.append(Alert(alertType: .info_timeframe, keyword: "Showing", description: object.toFilterDescription(date: date, timeframe: timeframe), timeAmount: 12, isPersistent: false))
    }
    
    func UpdateContentAlerts(content: ContentViewType){
        alerts.removeAll(where: {$0.alertType == .info_content})
        alerts.append(Alert(alertType: .info_content, keyword: content.toString(), description: content.toDescription(), timeAmount: 12, isPersistent: false))
    }
}
