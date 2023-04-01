//
//  UUIDExtensions.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/30/23.
//

import SwiftUI

extension UUID: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return self.hashValue
    }
}
