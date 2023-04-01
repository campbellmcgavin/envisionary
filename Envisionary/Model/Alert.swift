//
//  Alert.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/18/23.
//

import SwiftUI

struct Alert: Identifiable, Equatable{
    var id = UUID()
    let alertType: AlertType
    var keyword: String
    var description: String
    let timeAmount: Int
    let isPersistent: Bool
    
    init(id: UUID = UUID(), alertType: AlertType, keyword: String, description: String, timeAmount: Int, isPersistent: Bool) {
        self.id = id
        self.alertType = alertType
        self.keyword = keyword
        self.description = description
        self.timeAmount = timeAmount
        self.isPersistent = isPersistent
    }
    
    init() {
        self.id = UUID()
        self.alertType = .info
        self.keyword = ObjectType.goal.toString()
        self.description = ObjectType.goal.toDescription()
        self.timeAmount = 10
        self.isPersistent = false
    }
}
