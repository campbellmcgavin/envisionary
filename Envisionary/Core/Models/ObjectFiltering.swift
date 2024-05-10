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
    var filterPriority = ""
    var filterChapter = ""

    var filterCoreValue = ""
    var filterCount = 0
    var filterDate = Date()
    var filterTimeframe = TimeframeType.day
    var filterObject = ObjectType.goal
    var filterContent = ContentViewType.goals
    var filterIncludeCalendar: Bool = false
    var filterView: ViewFilterType = .none
    var filterArchived = false
    var filterShowSubGoals = false
    var filterCreed = false
    var filterEntry = false
    var filterProgress: StatusType = .none
    
    func GetFilters() -> Criteria {
        let criteria = Criteria(title: self.filterTitle, description: self.filterDescription, timeframe: self.filterTimeframe, date: self.filterDate, aspect: self.filterAspect, priority: self.filterPriority, progress: self.filterProgress, coreValue: self.filterCoreValue, parentId: nil, chapterId: nil, includeCalendar: self.filterIncludeCalendar, archived: self.filterArchived, superOnly: true, superId: nil)
        
        return criteria
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
                        lhs.filterIncludeCalendar == rhs.filterIncludeCalendar &&
                        lhs.filterView == rhs.filterView &&
                        lhs.filterArchived == rhs.filterArchived &&
                        lhs.filterCreed == rhs.filterCreed &&
                        lhs.filterEntry == rhs.filterEntry
        return isEqual
    }
}
