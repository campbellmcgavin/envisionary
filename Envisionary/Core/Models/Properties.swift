//
//  Properties.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/15/23.
//

import Foundation

struct Properties{
    var title: String?
    var coreValue: ValueType?
    var aspect: AspectType?
    var chapter: UUID?
    var description: String?
    var timeframe: TimeframeType?
    var startDate: Date?
    var endDate: Date?
    var priority: PriorityType?
    var progress: Int?
    var parent: UUID?
    var parentObject: ObjectType?
    var image: UUID?
    var images: [UUID]?
    var edited: Int?
    var leftAsIs: Int?
    var pushedOff: Int?
    var deleted: Int?
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
        image = nil
        images = nil
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
        self.parent = goal?.parentId
        self.image = goal?.image
    }
    
    init(dream: Dream?){
        self.title = dream?.title ?? "Empty Dream"
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
    
    init(task: Task?){
        self.title = task?.title ?? "Empty Value"
        self.description = task?.description ?? "Empty Description"
        self.startDate = task?.startDate
        self.endDate = task?.endDate
        self.progress = task?.progress
    }
    
    init(creed: Bool, valueCount: Int){
        self.title = "Life's Creed"
        self.description = "Your personalized life's mission statement, with a total of " + String(valueCount - 2) + " values."
        self.start = "Birth"
        self.end = "Death"
    }
    
    init(chapter: Chapter?){
        self.title = chapter?.title ?? "Empty Chapter"
        self.description = chapter?.description ?? "Empty Description"
        self.aspect = chapter?.aspect
        self.image = chapter?.image
    }
    init(entry: Entry?){
        self.title = entry?.title
        self.description = entry?.description
        self.images = entry?.images
        self.chapter = entry?.chapter
        self.startDate = entry?.startDate
        self.parent = entry?.parent
        
    }
}
