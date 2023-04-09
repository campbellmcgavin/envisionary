//
//  DataModel.swift
//  Visionary
//
//  Created by Campbell McGavin on 1/12/22.
//

import Foundation
import SwiftUI

class DataModel: ObservableObject
{
    // OBJECT TYPES
    @Published var objectType = ObjectType.home
    @Published var contentType = ContentViewType.execute
    @Published var timeframeType = TimeframeType.day
    
    
    // DATES
    @Published var date = Date.now
    @Published var pushToToday = false
    
    // FILTERS
    @Published var filterTitle = ""
    @Published var filterDescription = ""
    @Published var filterAspect: AspectType?
    @Published var filterTimeframe: TimeframeType?
    @Published var filterPriority: PriorityType?
    @Published var filterChapter = ""
    @Published var filterProgress: Int?
    @Published var filterCoreValue: ValueType?
    @Published var filterCount = 0

    
    func GetFilterCriteria() -> Criteria {
        return Criteria(title: self.filterTitle, description: self.filterDescription, timeframe: self.timeframeType, date: self.date, aspect: self.filterAspect, priority: self.filterPriority, progress: self.filterProgress, coreValue: self.filterCoreValue)
    }
}

extension DataModel {

    
    static func BindingOptionalToNonOptional<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
        Binding(
            get: { lhs.wrappedValue ?? rhs },
            set: { lhs.wrappedValue = $0 }
        )
    }
    
    static func BindingNonOptionalToOptional<T>(lhs: Binding<T>) -> Binding<Optional<T>> {
        Binding(
            get: { lhs.wrappedValue },
            set: { lhs.wrappedValue = $0! }
        )
    }

}

