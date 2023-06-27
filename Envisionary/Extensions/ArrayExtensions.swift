//
//  ArrayExtensions.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/20/23.
//

import SwiftUI

extension [UUID] {
    func toCsvString() -> String{
        var str = ""
        if self.count > 0{
            for index in 0...self.count-1{
                str += self[index].uuidString
                
                if index < self.count-1{
                    str += ", "
                }
            }
        }
        return str
    }
}

extension [String] {
    func toCsvString() -> String{
        var str = ""
        if self.count > 0{
            for index in 0...self.count-1{
                str += self[index]
                
                if index < self.count-1{
                    str += ", "
                }
            }
        }
        return str
    }
}
