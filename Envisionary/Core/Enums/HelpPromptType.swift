//
//  HelpPromptType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/28/23.
//

import SwiftUI

enum HelpPromptType {
    case object
    case content
    
    func toString() -> String{
        switch self {
        case .object:
            return "Object"
        case .content:
            return "Content"
        }
    }
}
