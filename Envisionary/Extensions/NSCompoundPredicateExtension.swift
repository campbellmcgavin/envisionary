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
        
        if criteria.title != nil && criteria.title!.count > 0 && object.hasProperty(property: .title){
            predicates.append(NSPredicate(format: "title CONTAINS %@", criteria.title!))
        }
        
        if criteria.description != nil && criteria.description!.count > 0 && object.hasProperty(property: .description){
            predicates.append(NSPredicate(format: "desc CONTAINS %@", criteria.description!))
        }
        
        if criteria.timeframe != nil && object.hasProperty(property: .timeframe){
            predicates.append(NSPredicate(format: "timeframe == %@", criteria.timeframe!.toString()))
        }
        
        if criteria.aspect != nil && criteria.aspect!.count > 0 && object.hasProperty(property: .aspect){
            predicates.append(NSPredicate(format: "aspect == %@", criteria.aspect!))
        }
        
        if criteria.coreValue != nil && criteria.coreValue!.count > 0 && object.hasProperty(property: .coreValue){
            predicates.append(NSPredicate(format: "coreValue == %@", criteria.coreValue!))
        }
        
        if criteria.parentId != nil && object.hasProperty(property: .parentId){
            predicates.append(NSPredicate(format: "parentId == %@", criteria.parentId! as CVarArg))
        }
        
        if criteria.date != nil && object.hasProperty(property: .startDate) && !object.hasProperty(property: .endDate){
            
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
        
        else if criteria.date != nil && object.hasProperty(property: .startDate) && object.hasProperty(property: .endDate){
            
            if let timeframe = criteria.timeframe {
                
                var datesArray = [Date]()
                switch timeframe {
                case .decade:
                    datesArray = [
                        criteria.date!.StartOfYear(),
                        criteria.date!.EndOfYear(),
                        criteria.date!.StartOfYear(),
                        criteria.date!.EndOfYear()
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
        
        if criteria.priority != nil && object.hasProperty(property: .priority){
            predicates.append(NSPredicate(format: "priority == %@", criteria.priority!.toString()))
        }
        
        if criteria.progress != nil && object.hasProperty(property: .progress){
            predicates.append(NSPredicate(format: "progress >= %i", criteria.progress!))
        }
        
        if criteria.promptType != nil && object.hasProperty(property: .promptType){
            predicates.append(NSPredicate(format: "type == %@", criteria.promptType!.toString()))
        }
        
        return NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
    }
}
