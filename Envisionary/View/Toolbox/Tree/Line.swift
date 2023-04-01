//
//  Line.swift
//  Visionary
//
//  Created by Campbell McGavin on 2/4/22.
//

import SwiftUI


struct Line: Shape {
    var from: CGPoint
    var to: CGPoint

    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: self.from)
            p.addLine(to: self.to)
        }
    }
}

