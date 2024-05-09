//
//  ImageType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/30/24.
//

import SwiftUI

enum ExampleImages: Hashable {

    case harvard
    case humanRights
    case travel
    case olympics
    case company
    case dreamHome
    case executive
    case influencer
    case artist
    case philanthropist
    case politician
    case student
    
    func toImageString() -> String{
        switch self {
        case .harvard:
            return "sample_harvard"
        case .humanRights:
            return "sample_rights"
        case .travel:
            return "sample_travel"
        case .olympics:
            return "sample_gymnast"
        case .company:
            return "sample_business"
        case .dreamHome:
            return "sample_home"
        case .executive:
            return "sample_exec"
        case .influencer:
            return "sample_influencer"
        case .artist:
            return "sample_artsy"
        case .philanthropist:
            return "sample_spiritual"
        case .politician:
            return "sample_politician"
        case .student:
            return "sample_hs"
        }
    }
}
