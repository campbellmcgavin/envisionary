//
//  ShapeType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/5/23.
//

import SwiftUI

enum ShapeType {
    case pin
    
    func toShapeString() -> String{
        switch self {
        case .pin:
            return "Shape_Pin"
        }
    }
}
