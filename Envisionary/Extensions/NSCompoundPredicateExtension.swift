//
//  NSCompoundPredicateExtension.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/11/23.
//

import SwiftUI
import CoreData

extension NSCompoundPredicate {
    
    static func PredicateBuilder(criteria: Criteria, object: ObjectType) -> NSCompoundPredicate{
        
        var predicates = [NSPredicate]()
        var includeCalendarValues = true
        
        if criteria.title != nil && criteria.title!.count > 0 && object.hasProperty(property: .title){
            predicates.append(NSPredicate(format: "title CONTAINS %@", criteria.title!))
        }
        
        if criteria.description != nil && criteria.description!.count > 0 && object.hasProperty(property: .description){
            predicates.append(NSPredicate(format: "desc CONTAINS %@", criteria.description!))
        }
        
        if criteria.valueId != nil && object.hasProperty(property: .valueId){
            predicates.append(NSPredicate(format: "coreValueId == %@", criteria.valueId! as CVarArg))
        }
        
        if criteria.aspect != nil && criteria.aspect!.count > 0 && object.hasProperty(property: .aspect){
            predicates.append(NSPredicate(format: "aspect == %@", criteria.aspect!))
        }
        
        // if there's a parent id then look for it
        if criteria.parentId != nil && object.hasProperty(property: .parentId){
            predicates.append(NSPredicate(format: "parentId == %@", criteria.parentId! as CVarArg))
        }
        
        else if criteria.superOnly != nil && criteria.superOnly!{
            if object == .goal{
                let pred = NSPredicate(format: "parentId = nil")
                predicates.append(pred)
            }
        }
        
        if criteria.superId != nil && object.hasProperty(property: .superId){
            predicates.append(NSPredicate(format: "superId == %@", criteria.superId! as CVarArg))
        }
        
        // else if you shouldn't include calendar
        if criteria.includeCalendar != nil && !criteria.includeCalendar!{
            includeCalendarValues = false

        }
        
        if criteria.archived != nil && object.hasProperty(property: .archived){
            predicates.append(NSPredicate(format: "archived == %@ || archived == nil || archived == false", NSNumber(value: criteria.archived!)))
        }
        
        if criteria.chapterId != nil && object.hasProperty(property: .chapter){
            predicates.append(NSPredicate(format: "chapterId == %@", criteria.chapterId! as CVarArg))
        }
        
        if includeCalendarValues && criteria.date != nil && object.hasProperty(property: .startDate) && !object.hasProperty(property: .endDate){
            
            if let timeframe = criteria.timeframe {
                
                var datesArray = [Date]()
                switch timeframe {
                case .decade:
                    datesArray = [
                        criteria.date!.StartOfDecade(),
                        criteria.date!.EndOfDecade()
                    ]
                case .year:
                    datesArray = [
                        criteria.date!.StartOfYear(),
                        criteria.date!.EndOfYear()
                    ]
                case .month:
                    datesArray = [
                        criteria.date!.StartOfMonth(),
                        criteria.date!.EndOfMonth()
                    ]
                case .week:
                    datesArray = [
                        criteria.date!.StartOfWeek(),
                        criteria.date!.EndOfWeek()
                    ]
                case .day:
                    datesArray = [
                        criteria.date!.StartOfDay(),
                        criteria.date!.EndOfDay()
                    ]
                }
                
                let predicate = NSPredicate(format: "(startDate >= %@ && startDate <= %@)", argumentArray: datesArray)
                print(predicate)
                
                predicates.append(predicate)
            }
        }
        
        else if includeCalendarValues && criteria.date != nil && object.hasProperty(property: .startDate) && object.hasProperty(property: .endDate){
            
            if let timeframe = criteria.timeframe {
                
                var datesArray = [Date]()
                switch timeframe {
                case .decade:
                    datesArray = [
                        criteria.date!.StartOfDecade(),
                        criteria.date!.EndOfDecade(),
                        criteria.date!.StartOfDecade(),
                        criteria.date!.EndOfDecade()
                    ]
                case .year:
                    datesArray = [
                        criteria.date!.StartOfYear(),
                        criteria.date!.EndOfYear(),
                        criteria.date!.StartOfYear(),
                        criteria.date!.EndOfYear()
                    ]
                case .month:
                    datesArray = [
                        criteria.date!.StartOfMonth(),
                        criteria.date!.EndOfMonth(),
                        criteria.date!.StartOfMonth(),
                        criteria.date!.EndOfMonth()
                    ]
                case .week:
                    datesArray = [
                        criteria.date!.StartOfWeek(),
                        criteria.date!.EndOfWeek(),
                        criteria.date!.StartOfWeek(),
                        criteria.date!.EndOfWeek()
                    ]
                case .day:
                    datesArray = [
                        criteria.date!.StartOfDay(),
                        criteria.date!.EndOfDay(),
                        criteria.date!.StartOfDay(),
                        criteria.date!.EndOfDay()
                    ]
                }
                
                datesArray.append(criteria.date!)
                datesArray.append(criteria.date!)
                
                
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yy"

                let predicate = NSPredicate(format: "(startDate >= %@ && startDate <= %@) || (endDate >= %@ && endDate <= %@) || (startDate < %@ && endDate > %@)", argumentArray: datesArray)
                print(predicate)
                
                predicates.append(predicate)
        }
    }
        
        if criteria.priority?.count ?? 0 > 0 && object.hasProperty(property: .priority){
            predicates.append(NSPredicate(format: "priority == %@", criteria.priority!))
        }
        
        if criteria.progress != nil && object.hasProperty(property: .progress){
            
            switch criteria.progress! {
            case .none:
                let _ = "nothing"
            case .notStarted:
                predicates.append(NSPredicate(format: "progress <= 1"))
            case .inProgress:
                predicates.append(NSPredicate(format: "progress > 0 && progress < 100"))
            case .completed:
                predicates.append(NSPredicate(format: "progress > 99"))
            }
            
        }
        
        if criteria.promptType != nil && object.hasProperty(property: .promptType){
            predicates.append(NSPredicate(format: "type == %@", criteria.promptType!.toString()))
        }
        
        if criteria.scheduleType != nil && object.hasProperty(property: .scheduleType){
            predicates.append(NSPredicate(format: "scheduleType == %@", criteria.scheduleType!.toString()))
        }
        
        if criteria.isComplete != nil && object.hasProperty(property: .isComplete){
            predicates.append(NSPredicate(format: "isComplete == %@", criteria.isComplete!))
        }
        
        if criteria.amount != nil && object.hasProperty(property: .amount){
            predicates.append(NSPredicate(format: "amount >= %@", criteria.amount!))
        }
        
        if criteria.habitId != nil && object.hasProperty(property: .habitId){
            predicates.append(NSPredicate(format: "habitId == %@", criteria.habitId! as CVarArg))
        }
        print(predicates)
        
        return NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
    }
}
