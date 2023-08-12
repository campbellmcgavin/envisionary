//
//  ChapterType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/12/23.
//

import SwiftUI

enum ChapterType: CaseIterable {
    case myInsecurities
    case songIdeas
    case artsyFartsy
    case inspirationalQuotes
    case bikingTheAlps
    case restaurantJournal
    case personalMotivationJournal
    case onePercentBetterEveryday
    case seeingTheImpact
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
    
    
    func toImageString() -> String{
        switch self {
        case .myInsecurities:
            return "sample_egg"
        case .songIdeas:
            return "sample_song"
        case .artsyFartsy:
            return "sample_artsy"
        case .inspirationalQuotes:
            return "sample_quotes"
        case .bikingTheAlps:
            return "sample_biking"
        case .restaurantJournal:
            return "sample_library"
        case .personalMotivationJournal:
            return "sample_motivation"
        case .onePercentBetterEveryday:
            return "sample_onepercent"
        case .seeingTheImpact:
            return "sample_impact"
        case .backpackingEurope:
            return "sample_backpacking"
        case .romance:
            return "sample_romance"
        case .imSad:
            return "sample_sad"
        case .businessIdeas:
            return "sample_ideas"
        case .gratitude:
            return "sample_gratitude"
        case .allTheTimesIFailed:
            return "sample_fail"
        case .myInternalMusings:
            return "sample_musings"
        case .privateDoNotRead:
            return "sample_private"
        case .highSchoolMems:
            return "sample_hs"
        case .famDamily:
            return "sample_famdamily"
        case .cookingAndWine:
            return "sample_wine"
        case .tattooWishlist:
            return "sample_tattoo"
        case .spiritualExperiences:
            return "sample_spiritual"
        case .neitherHereNorThere:
            return "sample_random"
        }
    }
    
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
        case .myInsecurities:
            return "My insecurities"
        case .songIdeas:
            return "Song ideas"
        case .artsyFartsy:
            return "Artsy Fartsy"
        case .inspirationalQuotes:
            return "Inspirational Quotes"
        case .bikingTheAlps:
            return "Biking the alps"
        case .restaurantJournal:
            return "Restaurant Journal"
        case .personalMotivationJournal:
            return "Personal Motivation Quotes"
        case .onePercentBetterEveryday:
            return "1% Better Everyday"
        case .seeingTheImpact:
            return "Seeing the Impact"
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
        case .myInsecurities:
            return "I carry myself confidently, but on the inside..."
        case .songIdeas:
            return "Good ones, bad ones, and the next top hit."
        case .artsyFartsy:
            return "My creative side."
        case .inspirationalQuotes:
            return "Famous words that fill."
        case .bikingTheAlps:
            return "Summary 2023. All the good mems."
        case .restaurantJournal:
            return "Every restaurant I've tried."
        case .personalMotivationJournal:
            return "Where I tell myself I'm good enough."
        case .onePercentBetterEveryday:
            return "Written record of my improvements over time."
        case .seeingTheImpact:
            return "Where I show that I really am making a difference."
        }
    }
    
    func toRequest() -> CreateChapterRequest{
        switch self {
        case .backpackingEurope:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: AspectType.travel.toString())
        case .romance:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: AspectType.romantic.toString())
        case .imSad:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: AspectType.emotional.toString())
        case .businessIdeas:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: AspectType.career.toString())
        case .gratitude:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: AspectType.personal.toString())
        case .allTheTimesIFailed:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: AspectType.fun.toString())
        case .myInternalMusings:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: AspectType.personal.toString())
        case .privateDoNotRead:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: AspectType.personal.toString())
        case .highSchoolMems:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: AspectType.academic.toString())
        case .famDamily:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: AspectType.family.toString())
        case .cookingAndWine:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: AspectType.home.toString())
        case .tattooWishlist:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: AspectType.physical.toString())
        case .spiritualExperiences:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: AspectType.spiritual.toString())
        case .neitherHereNorThere:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: AspectType.fun.toString())
        case .myInsecurities:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: AspectType.personal.toString())
        case .songIdeas:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: AspectType.sideProjects.toString())
        case .artsyFartsy:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: AspectType.sideProjects.toString())
        case .inspirationalQuotes:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: AspectType.personal.toString())
        case .bikingTheAlps:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: AspectType.travel.toString())
        case .restaurantJournal:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: AspectType.travel.toString())
        case .personalMotivationJournal:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: AspectType.personal.toString())
        case .onePercentBetterEveryday:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: AspectType.personal.toString())
        case .seeingTheImpact:
            return CreateChapterRequest(title: self.toString(), description: self.toDescription(), aspect: AspectType.personal.toString())
        }
    }
    
    static func fromString(from string: String) -> Self{
        return Self.allCases.first(where: {$0.toString() == string}) ?? .gratitude
    }
    
}
