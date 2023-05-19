//
//  Aspect.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/11/23.
//

enum AspectType: CaseIterable, Codable{
    case academic
    case adventure
    case career
    case children
    case emotional
    case environment
    case family
    case financial
    case friends
    case fun
    case health
    case home
    case involvement
    case lifestyle
    case mental
    case personal
    case philanthropy
    case physical
    case political
    case religious
    case romantic
    case sexual
    case sideProjects
    case social
    case spiritual
    case travel
        
    func toIcon() -> IconType{
        return .aspect
    }
    
    func toString() -> String{
        switch self {
        case .academic: return "Academic"
        case .adventure: return "Adventure"
        case .career: return "Career"
        case .children: return "Children"
        case .emotional: return "Emotional"
        case .environment: return "Environment"
        case .family: return "Family"
        case .financial: return "Financial"
        case .friends: return "Friends"
        case .fun: return "Fun"
        case .health: return "Health"
        case .home: return "Home"
        case .involvement: return "Involvement"
        case .lifestyle: return "Lifestyle"
        case .mental: return "Mental"
        case .personal: return "Personal"
        case .philanthropy: return "Philanthropy"
        case .physical: return "Physical"
        case .political: return "Political"
        case .religious: return "Religious"
        case .romantic: return "Romantic"
        case .sexual: return "Sexual"
        case .sideProjects: return "Side Projects"
        case .social: return "Social"
        case .spiritual: return "Spiritual"
        case .travel: return "Travel"
        }
    }
    
    static func fromString(input: String) -> Self{
        return Self.allCases.first(where: {$0.toString() == input}) ?? .academic
    }
}
