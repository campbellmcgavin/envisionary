//
//  ObjectFiltering.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/11/23.
//

import SwiftUI

struct ObjectFiltering: Equatable {
    var filterTitle = ""
    var filterDescription = ""
    var filterAspect = ""
    var filterPriority: PriorityType?
    var filterChapter = ""
    var filterProgress: Int?
    var filterCoreValue = ""
    var filterCount = 0
    var filterDate = Date.now
    var filterTimeframe = TimeframeType.day
    var filterObject = ObjectType.home
    var filterContent = ContentViewType.execute
    var filterIncludeCalendar = false
    
    func GetFilters() -> Criteria {
        let criteria = Criteria(title: self.filterTitle, description: self.filterDescription, timeframe: self.filterTimeframe, date: self.filterDate, aspect: self.filterAspect, priority: self.filterPriority, progress: self.filterProgress, coreValue: self.filterCoreValue, parentId: nil, chapterId: nil, includeCalendar: self.filterIncludeCalendar)
        
        return criteria
    }
    
    func GetFilterCount() -> Int{
        
        var _filterCount = 0
        if !filterTitle.isEmpty && filterObject.hasProperty(property: .title) {
            _filterCount += 1
        }
        if !filterAspect.isEmpty && filterObject.hasProperty(property: .aspect) {
            _filterCount += 1
        }
        if !filterDescription.isEmpty && filterObject.hasProperty(property: .description) {
            _filterCount += 1
        }
        if filterProgress != nil && filterProgress != 0 && filterObject.hasProperty(property: .progress) {
            _filterCount += 1
        }
        return _filterCount
    }
    
    static func == (lhs: ObjectFiltering, rhs: ObjectFiltering) -> Bool {
        
        let isEqual =   lhs.filterCoreValue == rhs.filterCoreValue &&
                        lhs.filterTitle == rhs.filterTitle &&
                        lhs.filterDescription == rhs.filterDescription &&
                        lhs.filterAspect == rhs.filterAspect &&
                        lhs.filterPriority == rhs.filterPriority &&
                        lhs.filterChapter == rhs.filterChapter &&
                        lhs.filterProgress == rhs.filterProgress &&
                        lhs.filterDate == rhs.filterDate &&
                        lhs.filterTimeframe == rhs.filterTimeframe &&
                        lhs.filterObject == rhs.filterObject &&
                        lhs.filterContent == rhs.filterContent &&
                        lhs.filterIncludeCalendar == rhs.filterIncludeCalendar
        return isEqual
    }
}
