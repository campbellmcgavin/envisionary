//
//  Properties.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/15/23.
//

import Foundation

struct Properties: Identifiable, Equatable, Hashable, Codable{
    let id: UUID
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
    
    var start: String?
    var end: String?
    
    var valuesDictionary: [ValueType: Bool]?
    
    var scheduleType: ScheduleType?
    var amount: Int?
    var unitOfMeasure: UnitType?
    
    
    //sessions
    var date: Date?
    var dateCompleted: Date?
    var goalProperties: [Properties]?
    var evaluationDictionary: [UUID: EvaluationType]?
    var alignmentDictionary: [UUID: [ValueType:Bool]]?
    var childrenAddedDictionary: [UUID: [UUID]]?
    
    init(objectType: ObjectType){
        timeframe = .day
        startDate = Date()
        endDate = Date()
        aspect = AspectType.allCases.randomElement()!
        priority = PriorityType.allCases.randomElement()!
        title = "Learn Spanish"
        description = "I want to learn Spanish using duo lingo over a period of 12 months. I will spend 4 hours per day, 5 days per week. I will track my metrics using the app interface and then use people I can hold myself accountable to."
        parent = nil
        image = nil
        id = UUID()
    }
    
    init(){
        timeframe = nil
        startDate = nil
        endDate = nil
        aspect = nil
        priority = nil
        title = nil
        description = nil
        parent = nil
        image = nil
        images = nil
        id = UUID()
    }
    
    init(recurrence: Recurrence?){
        self.id = recurrence?.id ?? UUID()
        self.parent = recurrence?.habitId ?? UUID()
        self.scheduleType = recurrence?.scheduleType ?? .morning
        self.amount = recurrence?.amount ?? 0
    }
    
    init(goal: Goal?){
        self.id = goal?.id ?? UUID()
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
        self.id = dream?.id ?? UUID()
        self.title = dream?.title ?? "Empty Dream"
        self.description = dream?.description ?? "Empty Description"
        self.aspect = dream?.aspect
        self.image = dream?.image
    }
    
    init(value: CoreValue?){
        self.id = value?.id ?? UUID()
        self.title = value?.coreValue.toString() ?? "Empty Value"
        self.coreValue = value?.coreValue
        self.description = value?.description ?? "Empty Description"
    }
    
    init(aspect: Aspect?){
        self.id = aspect?.id ?? UUID()
        self.title = aspect?.aspect.toString() ?? "Empty Value"
        self.description = aspect?.description ?? "Empty Description"
    }
    
    init(task: Task?){
        self.id = task?.id ?? UUID()
        self.title = task?.title ?? "Empty Value"
        self.description = task?.description ?? "Empty Description"
        self.startDate = task?.startDate
        self.endDate = task?.endDate
        self.progress = task?.progress
    }
    
    init(creed: Bool, valueCount: Int){
        self.id = UUID()
        self.title = "Life's Creed"
        self.description = "Your personalized life's mission statement, with a total of " + String(valueCount - 2) + " values."
        self.start = "Birth"
        self.end = "Death"
    }
    
    init(chapter: Chapter?){
        self.id = chapter?.id ?? UUID()
        self.title = chapter?.title ?? "Empty Chapter"
        self.description = chapter?.description ?? "Empty Description"
        self.aspect = chapter?.aspect
        self.image = chapter?.image
    }
    init(entry: Entry?){
        self.id = entry?.id ?? UUID()
        self.title = entry?.title
        self.description = entry?.description
        self.images = entry?.images
        self.chapter = entry?.chapter
        self.startDate = entry?.startDate
        self.parent = entry?.parent
    }
    init(session: Session?){
        self.id = session?.id ?? UUID()
        self.title = session?.date.toString(timeframeType: session?.timeframe ?? .day)
        self.date = session?.date ?? Date()
        self.dateCompleted = session?.dateCompleted ?? Date()
        self.timeframe = session?.timeframe ?? .week
        self.goalProperties = session?.goalProperties
        self.evaluationDictionary = session?.evaluationDictionary
        self.alignmentDictionary = session?.alignmentDictionary
        self.childrenAddedDictionary = session?.childrenAddedDictionary
    }
    
    init(habit: Habit?){
        self.id = habit?.id ?? UUID()
        self.title = habit?.title ?? "Empty Goal"
        self.description = habit?.description ?? "Empty Description"
        self.timeframe = habit?.timeframe
        self.startDate = habit?.startDate
        self.endDate = habit?.endDate
        self.aspect = habit?.aspect
        self.priority = habit?.priority
        self.parent = habit?.goalId
        self.image = habit?.image
        self.amount = habit?.amount
        self.unitOfMeasure = habit?.unitOfMeasure
        self.scheduleType = habit?.schedule
    }
}
