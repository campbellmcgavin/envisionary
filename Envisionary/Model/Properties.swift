//
//  Properties.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/15/23.
//

import Foundation

struct Properties{
    var title: String?
    var description: String?
    var timeframe: TimeframeType?
    var startDate: Date?
    var endDate: Date?
    var aspect: AspectType?
    var priority: PriorityType?
    var progress: Int?
    var parent: UUID?
    var children: [UUID]?
    var image: UUID?
    var edited: Int?
    var leftAsIs: Int?
    var pushedOff: Int?
    var deleted: Int?
    var coreValue: ValueType?
    var start: String?
    var end: String?
    
    init(objectType: ObjectType){
        timeframe = .day
        startDate = Date()
        endDate = Date()
        aspect = AspectType.allCases.randomElement()!
        priority = PriorityType.allCases.randomElement()!
        edited = 1
        leftAsIs = 2
        pushedOff = 3
        deleted = 4
        title = "Learn Spanish"
        description = "I want to learn Spanish using duo lingo over a period of 12 months. I will spend 4 hours per day, 5 days per week. I will track my metrics using the app interface and then use people I can hold myself accountable to."
        parent = nil
        children = nil
        image = nil
    }
    
    init(){
        timeframe = nil
        startDate = nil
        endDate = nil
        aspect = nil
        priority = nil
        edited = nil
        leftAsIs = nil
        pushedOff = nil
        deleted = nil
        title = nil
        description = nil
        parent = nil
        children = nil
        image = nil
    }
    
    init(goal: Goal?){
        self.title = goal?.title ?? "Empty Goal"
        self.description = goal?.description ?? "Empty Description"
        self.timeframe = goal?.timeframe
        self.startDate = goal?.startDate
        self.endDate = goal?.endDate
        self.aspect = goal?.aspect
        self.priority = goal?.priority
        self.progress = goal?.progress
        self.parent = goal?.parent
        self.children = goal?.children
        self.image = goal?.image
    }
    
    init(dream: Dream?){
        self.title = dream?.title ?? "Empty Goal"
        self.description = dream?.description ?? "Empty Description"
        self.aspect = dream?.aspect
        self.image = dream?.image
    }
    
    init(value: CoreValue?){
        self.title = value?.coreValue.toString() ?? "Empty Value"
        self.coreValue = value?.coreValue
        self.description = value?.description ?? "Empty Description"
    }
    
    init(aspect: Aspect?){
        self.title = aspect?.aspect.toString() ?? "Empty Value"
        self.description = aspect?.description ?? "Empty Description"
    }
    
    init(creed: Bool, valueCount: Int){
        self.title = "Life's Creed"
        self.description = "Your personalized life's mission statement, with a total of " + String(valueCount - 2) + " values."
        self.start = "Birth"
        self.end = "Death"
    }
}
