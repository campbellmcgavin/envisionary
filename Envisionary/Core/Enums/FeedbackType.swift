//
//  FeedbackType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 8/2/23.
//

import SwiftUI

enum FeedbackType: CaseIterable {
    case bug
    case coolIdea
    case dontLike
    case doLike
    case doesntMakeSense
    
    func toString() -> String{
        switch self {
        case .bug:
            return "I found a bug"
        case .coolIdea:
            return "I have a cool idea"
        case .dontLike:
            return "I don't like something"
        case .doLike:
            return "I really like something"
        case .doesntMakeSense:
            return "Something doesn't make sense"
        }
    }
    
    func hasProperty(property: FeedbackPropertyType) -> Bool{
        switch self {
        case .bug:
            return true
        case .coolIdea:
            return property == .description
        case .dontLike:
            return property == .description
        case .doLike:
            return property == .description
        case .doesntMakeSense:
            return true
        }
    }
}

enum FeedbackPropertyType: CaseIterable{
    case category
    case mainScreen
    case object
    case description
}

enum FeedbackPropertyMainScreenType: CaseIterable{
    case contentView
    case detailView
    case modalView
    
    func toString() -> String{
        switch self {
        case .contentView:
            return "Content View"
        case .detailView:
            return "Detail View"
        case .modalView:
            return "Modal View"
        }
    }
    
    func toImageString() -> String{
        switch self {
        case .contentView:
            return "Shape_ContentView"
        case .detailView:
            return "Shape_DetailView"
        case .modalView:
            return "Shape_ModalView"
        }
    }
}

enum FeedbackPropertyBugType: CaseIterable{
    case data
    case userInterface
    case somethingElse
    
    func toString() -> String{
        switch self {
        case .data:
            return "Issues saving or retrieving my data"
        case .userInterface:
            return "The user interface is glitchy"
        case .somethingElse:
            return "Something else"
        }
    }
}
