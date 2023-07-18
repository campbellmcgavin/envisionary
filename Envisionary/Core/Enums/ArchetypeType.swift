//
//  ArchetypeType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 7/6/23.
//

import SwiftUI

enum ArchetypeType: CaseIterable {
    case Achiever
    case Activist
    case Adventurer
    case Athlete
    case Entrepreneur
    case Essentialist
    case Executive
    case Influencer
    case Artist
    case Philanthropist
    case Politician
    case Student
    
    func toString() -> String{
        switch self {
        case .Achiever:
            return "Achiever"
        case .Activist:
            return "Activist"
        case .Adventurer:
            return "Adventurer"
        case .Artist:
            return "Artist"
        case .Athlete:
            return "Athlete"
        case .Entrepreneur:
            return "Entrepreneur"
        case .Essentialist:
            return "Essentialist"
        case .Executive:
            return "Executive"
        case .Influencer:
            return "Influencer"
        case .Philanthropist:
            return "Philanthropist"
        case .Politician:
            return "Politician"
        case .Student:
            return "Student"
        }
    }
    
    func toImageString() -> String{
        switch self {
        case .Achiever:
            return "sample_harvard"
        case .Activist:
            return "sample_rights"
        case .Adventurer:
            return "sample_travel"
        case .Athlete:
            return "sample_gymnast"
        case .Entrepreneur:
            return "sample_company"
        case .Essentialist:
            return "sample_home"
        case .Executive:
            return "sample_exec"
        case .Influencer:
            return "sample_influencer"
        case .Artist:
            return "sample_gallery"
        case .Philanthropist:
            return "sample_change"
        case .Politician:
            return "sample_politician"
        case .Student:
            return "sample_harvard"
        }
    }
    
    func toDescription() -> String{
        
        switch self {
        case .Achiever:
            return "Status, goals, reputation, and dazzling the masses."
        case .Activist:
            return "Protecting human rights and paving the way for a better tomorrow."
        case .Adventurer:
            return "New opportunities, new places, and new experiences."
        case .Athlete:
            return "Physical fitness, dominating the field, and getting the trophy."
        case .Entrepreneur:
            return "Creating an empire through ingenuity and willpower."
        case .Essentialist:
            return "Achieving balance, simplicity, and maintenance."
        case .Executive:
            return "Promotions, power, and prestige on the corporate fast-track."
        case .Influencer:
            return "A massive social media following, personal aesthetic, and brand."
        case .Artist:
            return "Passion, flexibility, and creative impact for humanity."
        case .Philanthropist:
            return "A legacy of service and compassion for the underprivileged."
        case .Politician:
            return "Convincing the masses of an ideology, and becoming a prominent public servant."
        case .Student:
            return "Excelling in the academic world, participating extra-curriculars, and general college survival."
        }
    }
    
    func hasValue(value: ValueType) -> Bool{
        switch self {
        case .Achiever:
            switch value{
            case .Achievement: return true
            case .Confidence: return true
            case .Decisiveness: return true
            case .Efficiency: return true
            case .GrowthMindset: return true
            case .Imagination: return true
            case .Optimism: return true
            case .PersonalDevelopment: return true
            case .SelfControl: return true
            case .Success: return true
            default: return false
            }
        case .Activist:
            switch value{
            case .Acceptance: return true
            case .Accountability: return true
            case .Altruism: return true
            case .Boldness: return true
            case .Compassion: return true
            case .Courage: return true
            case .Dedication: return true
            case .Fairness: return true
            case .InspireOthers: return true
            case .SocialJustice: return true
            default: return false
            }
        case .Adventurer:
            switch value{
            case .Adventure: return true
            case .Creativity: return true
            case .Curiosity: return true
            case .Flexibility: return true
            case .Happiness: return true
            case .Independence: return true
            case .Laughter: return true
            case .Passion: return true
            case .Spontaneity: return true
            case .WorkLifeBalance: return true
            default: return false
            }
        case .Artist:
            switch value{
            case .Adaptability: return true
            case .Creativity: return true
            case .Excellence: return true
            case .Imagination: return true
            case .Influence: return true
            case .Innovation: return true
            case .InspireOthers: return true
            case .Passion: return true
            case .PrideInYourWork: return true
            case .SelfDevelopment: return true
            default: return false
            }
        case .Athlete:
            switch value{
            case .Achievement: return true
            case .Confidence: return true
            case .Dedication: return true
            case .Excellence: return true
            case .GrowthMindset: return true
            case .InspireOthers: return true
            case .Passion: return true
            case .Respect: return true
            case .SelfDiscipline: return true
            case .Strength: return true
            default: return false
            }
        case .Entrepreneur:
            switch value{
            case .Autonomy: return true
            case .Boldness: return true
            case .Confidence: return true
            case .Entrepreneurship: return true
            case .Excellence: return true
            case .GrowthMindset: return true
            case .Innovation: return true
            case .Power: return true
            case .Profit: return true
            case .SelfMotivation: return true
            default: return false
            }
        case .Essentialist:
            switch value{
            case .Accountability: return true
            case .Appreciation: return true
            case .Balance: return true
            case .Community: return true
            case .Dedication: return true
            case .Dependability: return true
            case .Fairness: return true
            case .Honesty: return true
            case .LearningFromMistakes: return true
            case .Prosperity: return true
            default: return false
            }
        case .Executive:
            switch value{
            case .Boldness: return true
            case .Decisiveness: return true
            case .Excellence: return true
            case .GrowthMindset: return true
            case .Leadership: return true
            case .PersonalDevelopment: return true
            case .Power: return true
            case .Profit: return true
            case .Responsibility: return true
            case .SelfMotivation: return true
            default: return false
            }
        case .Influencer:
            switch value{
            case .Achievement: return true
            case .Creativity: return true
            case .Influence: return true
            case .InspireOthers: return true
            case .Originality: return true
            case .PersonalDevelopment: return true
            case .PrideInYourWork: return true
            case .SelfMotivation: return true
            case .Success: return true
            case .Wealth: return true
            default: return false
            }
        case .Philanthropist:
            switch value{
            case .Altruism: return true
            case .Bravery: return true
            case .Charity: return true
            case .Community: return true
            case .Compassion: return true
            case .Dedication: return true
            case .Fairness: return true
            case .Influence: return true
            case .Passion: return true
            case .ServiceOriented: return true
            default: return false
            }
        case .Politician:
            switch value{
            case .Boldness: return true
            case .Confidence: return true
            case .Fame: return true
            case .GrowthMindset: return true
            case .Influence: return true
            case .InspireOthers: return true
            case .Passion: return true
            case .Power: return true
            case .Professionalism: return true
            case .Respect: return true
            default: return false
            }
        case .Student:
            switch value{
            case .Accountability: return true
            case .Consistency: return true
            case .Dedication: return true
            case .Efficiency: return true
            case .Excellence: return true
            case .Knowledge: return true
            case .Patience: return true
            case .Persistence: return true
            case .PositiveAttitude: return true
            case .SelfDiscipline: return true
            default: return false
            }
        }
    }
    
    func hasDream(dream: DreamType) -> Bool{
        switch self {
        case .Achiever:
            switch dream{
            case .inspireOthers: return true
            case .getPrestigiousDegree: return true
            case .leaderInIndustry: return true
            case .millionaire: return true
            case .runMarathon: return true
            case .buyDreamCar: return true
            case .climbEverest: return true
            case .reachIdealBodyType: return true
            case .buildDreamHome: return true
            case .ltr: return true
            default: return false
            }
        case .Activist:
            switch dream{
            case .inspireOthers: return true
            case .publishNovel: return true
            case .foundCharity: return true
            case .runAPodcast: return true
            case .marchForACause: return true
            case .makeWebsite: return true
            case .findLifePartner: return true
            case .retireComfortably: return true
            default: return false
            }
        case .Adventurer:
            switch dream{
            case .travel7Continents: return true
            case .travelDreamCountry: return true
            case .runMarathon: return true
            case .sevenWonders: return true
            case .climbEverest: return true
            case .learnSurfing: return true
            case .learnHowToRockclimb: return true
            case .getPaidForPassion: return true
            case .deepSeeFishing: return true
            case .whitewaterRafting: return true
            default: return false
            }
        case .Athlete:
            switch dream{
            case .masterSkill: return true
            case .reach1m: return true
            case .runMarathon: return true
            case .buyDreamCar: return true
            case .retireComfortably: return true
            case .foundCharity: return true
            case .liftWeightsBuildMuscle: return true
            case .buildDreamHome: return true
            case .olympics: return true
            case .professionalAthlete: return true
            default: return false
            }
        case .Entrepreneur:
            switch dream{
            case .inspireOthers: return true
            case .leaderInIndustry: return true
            case .millionaire: return true
            case .billionaire: return true
            case .reach1m: return true
            case .buyDreamCar: return true
            case .retireComfortably: return true
            case .reachIdealBodyType: return true
            case .getPaidForPassion: return true
            case .buildDreamHome: return true
            default: return false
            }
        case .Essentialist:
            switch dream{
            case .masterSkill: return true
            case .reach100k: return true
            case .publishNovel: return true
            case .becomeDebtFree: return true
            case .learnNewLanguage: return true
            case .reachIdealBodyType: return true
            case .marryLoveOfLife: return true
            case .favoriteFootballTeam: return true
            case .run6MinuteMile: return true
            case .getDreamPet: return true
            default: return false
            }
        case .Executive:
            switch dream{
            case .getMba: return true
            case .businessExecutive: return true
            case .millionaire: return true
            case .buyDreamCar: return true
            case .retireComfortably: return true
            case .foundCharity: return true
            case .masterBallroomDancing: return true
            case .reachIdealBodyType: return true
            case .buildDreamHome: return true
            case .startOnlineBusiness: return true
            default: return false
            }
        case .Influencer:
            switch dream{
            case .inspireOthers: return true
            case .millionaire: return true
            case .buyDreamCar: return true
            case .reachIdealBodyType: return true
            case .getPaidForPassion: return true
            case .generatePassiveIncome: return true
            case .buildDreamHome: return true
            case .goSkydiving: return true
            case .whitewaterRafting: return true
            case .meetFavoriteCeleb: return true
            default: return false
            }
        case .Artist:
            switch dream{
            case .inspireOthers: return true
            case .learnNewLanguage: return true
            case .masterMusicalInstrument: return true
            case .learnPottery: return true
            case .becomeArtist: return true
            case .composeSong: return true
            case .buildDreamHome: return true
            case .veganDiet: return true
            case .northernLights: return true
            case .famousActor: return true
            default: return false
            }
        case .Philanthropist:
            switch dream{
            case .inspireOthers: return true
            case .publishNovel: return true
            case .foundCharity: return true
            case .liveInForeignCountry: return true
            case .getPaidForPassion: return true
            case .findLifePartner: return true
            case .northernLights: return true
            case .sponsorAChild: return true
            case .visitEveryCountry: return true
            case .marchForACause: return true
            default: return false
            }
        case .Politician:
            switch dream{
            case .inspireOthers: return true
            case .publishNovel: return true
            case .ltr: return true
            case .volcanoErupt: return true
            case .goOnACruise: return true
            case .becomeGovernor: return true
            case .becomeMayor: return true
            case .becomeCongressperson: return true
            case .northernLights: return true
            case .happyFamily: return true
            default: return false
            }
        case .Student:
            switch dream{
            case .valedictorian: return true
            case ._4_0_gpa: return true
            case .graduateTopOfClass: return true
            case .graduateCollege: return true
            case .headOfClub: return true
            case .goSkydiving: return true
            case .goHangGliding: return true
            case .learnNewLanguage: return true
            case .ltr: return true
            default: return false
            }
        }
    }
    
    func hasAspect(aspect: AspectType) -> Bool{
        switch aspect {
        case .academic:
            return self == .Student
        case .adventure:
            return self == .Adventurer
        case .career:
            return true
        case .children:
            return self == .Essentialist
        case .emotional:
            return true
        case .environment:
            return true
        case .family:
            return true
        case .financial:
            return true
        case .friends:
            return false
        case .fun:
            return true
        case .health:
            return true
        case .home:
            return self == .Essentialist
        case .involvement:
            return self == .Philanthropist || self == .Achiever
        case .lifestyle:
            return false
        case .mental:
            return true
        case .personal:
            return true
        case .philanthropy:
            return self == .Philanthropist || self == .Achiever || self == .Essentialist || self == .Athlete
        case .physical:
            return true
        case .political:
            return self == .Politician || self == .Achiever || self == .Athlete || self == .Essentialist
        case .religious:
            return false
        case .romantic:
            return true
        case .sexual:
            return false
        case .sideProjects:
            return self == .Achiever || self == .Entrepreneur
        case .social:
            return true
        case .spiritual:
            return false
        case .travel:
            return self == .Adventurer || self == .Artist || self == .Achiever || self == .Essentialist
        }
    }
    
    func hasHabit(habit: HabitType) -> Bool{
        switch habit{
        case .dailyExercise: return true
        case .getUp6am: return true
        case .eatHealthy: return true
        default: return false
        }
    }
    
    func hasChapter(chapter: ChapterType) -> Bool{
        switch self {
        case .Achiever:
            switch chapter{
            case .myInsecurities: return true
            case .onePercentBetterEveryday: return true
            case .allTheTimesIFailed: return true
            case .gratitude: return true
            default: return false
            }
        case .Activist:
            switch chapter{
            case .seeingTheImpact: return true
            case .gratitude: return true
            case .inspirationalQuotes: return true
            case .privateDoNotRead: return true
            default: return false
            }
        case .Adventurer:
            switch chapter{
            case .bikingTheAlps: return true
            case .backpackingEurope: return true
            case .restaurantJournal: return true
            case .personalMotivationJournal: return true
            case .tattooWishlist: return true
            default: return false
            }
        case .Athlete:
            switch chapter{
            case .inspirationalQuotes: return true
            case .personalMotivationJournal: return true
            case .seeingTheImpact: return true
            case .allTheTimesIFailed: return true
            default: return false
            }
        case .Entrepreneur:
            switch chapter{
            case .personalMotivationJournal: return true
            case .onePercentBetterEveryday: return true
            case .romance: return true
            case .allTheTimesIFailed: return true
            case .businessIdeas: return true
            default: return false
            }
        case .Essentialist:
            switch chapter{
            case .artsyFartsy: return true
            case .inspirationalQuotes: return true
            case .imSad: return true
            case .gratitude: return true
            case .privateDoNotRead: return true
            default: return false
            }
        case .Executive:
            switch chapter{
            case .personalMotivationJournal: return true
            case .onePercentBetterEveryday: return true
            case .romance: return true
            case .allTheTimesIFailed: return true
            case .businessIdeas: return true
            default: return false
            }
        case .Influencer:
            switch chapter{
            case .myInsecurities: return true
            case .inspirationalQuotes: return true
            case .businessIdeas: return true
            case .myInternalMusings: return true
            case .tattooWishlist: return true
            case .neitherHereNorThere: return true
            default: return false
            }
        case .Artist:
            switch chapter{
            case .songIdeas: return true
            case .artsyFartsy: return true
            case .inspirationalQuotes: return true
            case .myInternalMusings: return true
            default: return false
            }
        case .Philanthropist:
            switch chapter{
            case .seeingTheImpact: return true
            case .inspirationalQuotes: return true
            case .personalMotivationJournal: return true
            case .gratitude: return true
            default: return false
            }
        case .Politician:
            switch chapter{
            case .personalMotivationJournal: return true
            case .onePercentBetterEveryday: return true
            case .seeingTheImpact: return true
            case .gratitude: return true
            default: return false
            }
        case .Student:
            switch chapter{
            case .inspirationalQuotes: return true
            case .onePercentBetterEveryday: return true
            case .gratitude: return true
            case .neitherHereNorThere: return true
            default: return false
            }
        }
    }
    
    static func fromString(from string: String) -> Self{
        return Self.allCases.first(where: {$0.toString() == string}) ?? .Achiever
    }
}
