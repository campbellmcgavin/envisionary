//
//  UIImageExtensions.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/17/23.
//

import SwiftUI

extension UIImage {
    static func == (lhs: UIImage, rhs: UIImage) -> Bool {
        lhs === rhs || lhs.pngData() == rhs.pngData()
    }
}
