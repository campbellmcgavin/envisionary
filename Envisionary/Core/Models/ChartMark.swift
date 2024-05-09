//
//  ChartMark.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/1/24.
//

import SwiftUI

struct ChartMark: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var count: Int
    var color: CustomColor
}
