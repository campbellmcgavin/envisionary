//
//  Criteria.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/26/23.
//

import Foundation

struct Criteria {
    
    var title: String?
    var description: String?
    var timeframe: TimeframeType?
    var date: Date?
    var aspect: String?
    var priority: PriorityType?
    var progress: Int?
    var coreValue: String?
    var parentId: UUID?
    
    init(title: String? = nil, description: String?, timeframe: TimeframeType?, date: Date?, aspect: String?, priority: PriorityType?, progress: Int?, coreValue: String?, parentId: UUID?) {
        self.title = title
        self.description = description
        self.timeframe = timeframe
        self.date = date
        self.aspect = aspect
        self.priority = priority
        self.progress = progress
        self.coreValue = coreValue
        self.parentId = parentId
    }
    init(){
        self.title = nil
        self.description = nil
        self.timeframe = nil
        self.date = nil
        self.aspect = nil
        self.priority = nil
        self.progress = nil
        self.coreValue = nil
        self.parentId = nil
    }
    init(title: String) {
        self.title = title
        self.description = nil
        self.timeframe = nil
        self.date = nil
        self.aspect = nil
        self.priority = nil
        self.progress = nil
        self.coreValue = nil
        self.parentId = nil
    }
}
