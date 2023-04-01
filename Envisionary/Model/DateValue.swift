//
//  DateValue.swift
//  Visionary
//
//  Created by Campbell McGavin on 3/11/22.
//

import SwiftUI

struct DateValue: Identifiable, Equatable{
    var id = UUID().uuidString
    var day: Int
    var date: Date
    var hasContent: Bool?
}
