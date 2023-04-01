//
//  CollectDict.swift
//  Visionary
//
//  Created by Campbell McGavin on 2/4/22.
//

import SwiftUI


struct CollectDict<Key: Hashable, Value>: PreferenceKey {
    static var defaultValue: [Key:Value] { [:] }
    static func reduce(value: inout [Key:Value], nextValue: () -> [Key:Value]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}



