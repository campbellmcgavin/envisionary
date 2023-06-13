//
//  ChapterType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/12/23.
//

import SwiftUI

enum ChapterType: CaseIterable {
    case backpackingEurope
    case romance
    case imSad
    case businessIdeas
    case gratitude
    case allTheTimesIFailed
    case myInternalMusings
    case privateDoNotRead
    case highSchoolMems
    case famDamily
    case cookingAndWine
    case tattooWishlist
    case spiritualExperiences
    case neitherHereNorThere
        
    
    func toString() -> String{
        switch self {
        case .backpackingEurope:
            return "Backpacking Europe"
        case .romance:
            return "Romantic life"
        case .imSad:
            return "S is for sad"
        case .businessIdeas:
            return "Business Ideas"
        case .gratitude:
            return "Gratitude Journal"
        case .allTheTimesIFailed:
            return "All the times I failed"
        case .myInternalMusings:
            return "Internal Musings. Dangerous."
        case .privateDoNotRead:
            return "Private, do not read"
        case .highSchoolMems:
            return "High School Mems"
        case .famDamily:
            return "Fam...damily"
        case .cookingAndWine:
            return "Cooking and wine"
        case .tattooWishlist:
            return "Tattoo wishlist"
        case .spiritualExperiences:
            return "Spiritual Experiences"
        case .neitherHereNorThere:
            return "Neither here nor there."
        }
    }
    
    func toDescription() -> String{
        switch self {
        case .backpackingEurope:
            return "Adventures in Europe while living out of a backpack"
        case .romance:
            return "Roses are red, kisses are cute"
        case .imSad:
            return "Me, complaining about life and being sad and stuff."
        case .businessIdeas:
            return "One idea. Everyday. One killer idea. Every year. One millionaire by 40."
        case .gratitude:
            return "An attitude of gratitude"
        case .allTheTimesIFailed:
            return "also known as my personal fail compilation"
        case .myInternalMusings:
            return "Literally don't know if this will make sense to anyone else lol."
        case .privateDoNotRead:
            return "plz plz plz I will be so embaressed. don't touch me."
        case .highSchoolMems:
            return "17 again. braces. pimples. me in my prime."
        case .famDamily:
            return "oh how I love my perfectly disfunctional family."
        case .cookingAndWine:
            return "my recipes, my wines, and my cheeses."
        case .tattooWishlist:
            return "there's so many to choose from. it's too hard."
        case .spiritualExperiences:
            return "It's so crucial that I can see how the higher power is involved in my life directly."
        case .neitherHereNorThere:
            return "for all of the other things."
        }
    }
    
    func toRequest() -> CreateChapterRequest{
        switch self {
        case .backpackingEurope:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: .travel)
        case .romance:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: .romantic)
        case .imSad:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: .emotional)
        case .businessIdeas:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: .career)
        case .gratitude:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: .personal)
        case .allTheTimesIFailed:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: .fun)
        case .myInternalMusings:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: .personal)
        case .privateDoNotRead:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: .personal)
        case .highSchoolMems:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: .academic)
        case .famDamily:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: .family)
        case .cookingAndWine:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: .home)
        case .tattooWishlist:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: .physical)
        case .spiritualExperiences:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: .spiritual)
        case .neitherHereNorThere:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: .fun)
        }
    }
    
    static func fromString(from string: String) -> Self{
        return Self.allCases.first(where: {$0.toString() == string}) ?? .gratitude
    }
    
}
