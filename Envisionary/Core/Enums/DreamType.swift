//
//  DreamType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/8/23.
//

import SwiftUI

enum DreamType: CaseIterable {

    case inspireOthers
    case masterSkill
    case getPrestigiousDegree
    case getMba
    case getMastersDegree
    case getDoctorateDegree
    case becomeMd
    case getJd
    case leaderInIndustry
    case businessExecutive
    case millionaire
    case billionaire
    case travel7Continents
    case travelDreamCountry
    case reach100k
    case reach500k
    case reach1m
    case publishNovel
    case runMarathon
    case get6Pack
    case becomeDebtFree
    case buyDreamCar
    case sevenWonders
    case allSevenWonders
    case retireComfortably
    case graduateCollege
    case learnNewLanguage
    case foundCharity
    case ltr
    case marryLoveOfLife
    case climbMountain
    case climbEverest
    case learnSurfing
    case masterMusicalInstrument
    case learnHowToRockclimb
    case liveInForeignCountry
    case noJunkFood
    case becomeArtist
    case learnPottery
    case masterBallroomDancing
    case composeSong
    case reachIdealBodyType
    case getPaidForPassion
    case findLifePartner
    case healthyDiet
    case liftWeightsBuildMuscle
    case generatePassiveIncome
    case deepSeeFishing
    case firstHome
    case buildDreamHome
    case goSkydiving
    case goHangGliding
    case rideHotAirBalloon
    case snorkelInOcean
    case climbGlacier
    case whitewaterRafting
    case favoriteFootballTeam
    case olympics
    case holeInOne
    case golfGame
    case assembleCollection
    case run6MinuteMile
    case declutterHome
    case appearOnPodcast
    case runAPodcast
    case youtubeChannel
    case financialInheritance
    case traceAncestry
    case veganDiet
    case favoriteMusician
    case happyFamily
    case newFamilyTradition
    case workLifeBalance
    case startOnlineBusiness
    case relationshipAnniversaries
    case meetFavoriteAthlete
    case meetFavoriteCeleb
    case startSmallBusiness
    case seeTheBallDrop
    case getDreamPet
    case giveUpSoda
    case northernLights
    case volcanoErupt
    case goOnACruise
    case goToMardiGras
    case _750CreditScore
    case learnSelfDefense
    case learnkarate
    case learnYoga
    case vocabulary
    case recSportsLeague
    case professionalAthlete
    case famousActor
    case thrivingGarden
    case haveChildren
    case growGarden
    case writeMovieScript
    case learnSing
    case singInChoir
    case makeWebsite
    case ventureCapitalist
    case sponsorAChild
    case crossCountryRoadtrip
    case visitEveryCountry
    case payOffStudentLoans
    case learnToCode
    case improveDrawingSkills
    case goOnSoloVacation
    case learnToSew
    
    
    func toString() -> String{
        switch self {
        case .inspireOthers:
            return "Inspire others"
        case .masterSkill:
            return "Master a skill"
        case .getPrestigiousDegree:
            return "Get a degree at prestigious university"
        case .getMba:
            return "Get an MBA"
        case .getMastersDegree:
            return "Get a Masters Degree"
        case .getDoctorateDegree:
            return "Get a Doctorate Degree"
        case .becomeMd:
            return "Become an MD"
        case .getJd:
            return "Get a JD"
        case .leaderInIndustry:
            return "Become a leader in industry"
        case .businessExecutive:
            return "Become a Business Exec"
        case .millionaire:
            return "Millionaire"
        case .billionaire:
            return "Billionaire"
        case .travel7Continents:
            return "Travel to all 7 continents"
        case .travelDreamCountry:
            return "Travel to dream country"
        case .reach100k:
            return "Reach $100k salary"
        case .reach500k:
            return "Reach $500k salary"
        case .reach1m:
            return "Reach $1M salary"
        case .publishNovel:
            return "Publish a novel"
        case .runMarathon:
            return "Run a marathon"
        case .get6Pack:
            return "Get a 6 pack"
        case .becomeDebtFree:
            return "Become debt free"
        case .buyDreamCar:
            return "Buy dream car"
        case .sevenWonders:
            return "See one of the seven wonders"
        case .allSevenWonders:
            return "See all seven wonders"
        case .retireComfortably:
            return "Retire comfortably"
        case .graduateCollege:
            return "Graduate college"
        case .learnNewLanguage:
            return "Learn a new language"
        case .foundCharity:
            return "Found a charity"
        case .ltr:
            return "Long term relationship"
        case .marryLoveOfLife:
            return "Marry the love of my life"
        case .climbMountain:
            return "Climb a mountain"
        case .climbEverest:
            return "Climb Mount Everest"
        case .learnSurfing:
            return "Learn to surf"
        case .masterMusicalInstrument:
            return "Master musical instrument"
        case .learnHowToRockclimb:
            return "Learn to rockclimb"
        case .liveInForeignCountry:
            return "Live in foreign country"
        case .noJunkFood:
            return "No junk food"
        case .becomeArtist:
            return "Become an artist"
        case .learnPottery:
            return "Learn pottery"
        case .masterBallroomDancing:
            return "Master ballroom dancing"
        case .composeSong:
            return "Compose a song"
        case .reachIdealBodyType:
            return "Reach ideal body type"
        case .getPaidForPassion:
            return "Get paid for my passion"
        case .findLifePartner:
            return "Find life partner"
        case .healthyDiet:
            return "Healthy diet"
        case .liftWeightsBuildMuscle:
            return "Lift weights and build muscle"
        case .generatePassiveIncome:
            return "Generate passive income"
        case .deepSeeFishing:
            return "Deep see fishing"
        case .firstHome:
            return "Purchase first home"
        case .buildDreamHome:
            return "Build my dream home"
        case .goSkydiving:
            return "Sky diving"
        case .goHangGliding:
            return "Hang gliding"
        case .rideHotAirBalloon:
            return "Hot air balloon"
        case .snorkelInOcean:
            return "Snorkel in ocean"
        case .climbGlacier:
            return "Climb a glacier"
        case .whitewaterRafting:
            return "Whitewater rafting"
        case .favoriteFootballTeam:
            return "See favorite football team"
        case .olympics:
            return "See olympics in person"
        case .holeInOne:
            return "Get a hole in one"
        case .golfGame:
            return "Golf on par"
        case .assembleCollection:
            return "Assemble a collection of art"
        case .run6MinuteMile:
            return "6 minute mile"
        case .declutterHome:
            return "Declutter home"
        case .appearOnPodcast:
            return "Appear on podcast"
        case .runAPodcast:
            return "Run a podcast"
        case .youtubeChannel:
            return "Run a youtube channel"
        case .financialInheritance:
            return "Leave an inheritance"
        case .traceAncestry:
            return "Trace ancestry"
        case .veganDiet:
            return "Vegan diet"
        case .favoriteMusician:
            return "See favorite musician live"
        case .happyFamily:
            return "Have a happy family"
        case .newFamilyTradition:
            return "Instigate new family tradition"
        case .workLifeBalance:
            return "Healthy work-life balance"
        case .startOnlineBusiness:
            return "Start online business"
        case .relationshipAnniversaries:
            return "Celebrate anniversaries"
        case .meetFavoriteAthlete:
            return "Meet favorite athlete"
        case .meetFavoriteCeleb:
            return "Meet favorite celeb"
        case .startSmallBusiness:
            return "Start small business"
        case .seeTheBallDrop:
            return "See the NYE ball drop"
        case .getDreamPet:
            return "Get dream pet"
        case .giveUpSoda:
            return "Give up soda"
        case .northernLights:
            return "See northern lights"
        case .volcanoErupt:
            return "See volcano erupt"
        case .goOnACruise:
            return "Go on a cruise"
        case .goToMardiGras:
            return "Go to Mardi Gras"
        case ._750CreditScore:
            return "800 Credit Score"
        case .learnSelfDefense:
            return "Learn self defense"
        case .learnkarate:
            return "Learn Karate"
        case .learnYoga:
            return "Learn yoga"
        case .vocabulary:
            return "Expand my vocabulary"
        case .recSportsLeague:
            return "Participate in sports league"
        case .professionalAthlete:
            return "Become professional athlete"
        case .famousActor:
            return "Become a famout actor/actress"
        case .thrivingGarden:
            return "Nurture thriving garden"
        case .haveChildren:
            return "Have children"
        case .growGarden:
            return "Grow a garden'"
        case .writeMovieScript:
            return "Write a movie script"
        case .learnSing:
            return "Learn to sing"
        case .singInChoir:
            return "Sing in choir"
        case .makeWebsite:
            return "Make a website"
        case .ventureCapitalist:
            return "Become a VC"
        case .sponsorAChild:
            return "Sponsor a child in need"
        case .crossCountryRoadtrip:
            return "Cross-country roadtrip"
        case .visitEveryCountry:
            return "Visit every country"
        case .payOffStudentLoans:
            return "Pay off student loans"
        case .learnToCode:
            return "Learn to code"
        case .improveDrawingSkills:
            return "Improve drawing skills"
        case .goOnSoloVacation:
            return "Go on solo vacation"
        case .learnToSew:
            return "Learn to sew"
        }
    }
    
    func toAspect() -> AspectType{
        switch self {
        case .inspireOthers:
            return .philanthropy
        case .masterSkill:
            return .career
        case .getPrestigiousDegree:
            return .academic
        case .getMba:
            return .academic
        case .getMastersDegree:
            return .academic
        case .getDoctorateDegree:
            return .academic
        case .becomeMd:
            return .academic
        case .getJd:
            return .academic
        case .leaderInIndustry:
            return .career
        case .businessExecutive:
            return .career
        case .millionaire:
            return .financial
        case .billionaire:
            return .financial
        case .travel7Continents:
            return .travel
        case .travelDreamCountry:
            return .travel
        case .reach100k:
            return .financial
        case .reach500k:
            return .financial
        case .reach1m:
            return .financial
        case .publishNovel:
            return .career
        case .runMarathon:
            return .physical
        case .get6Pack:
            return .physical
        case .becomeDebtFree:
            return .financial
        case .buyDreamCar:
            return .lifestyle
        case .sevenWonders:
            return .travel
        case .allSevenWonders:
            return .travel
        case .retireComfortably:
            return .lifestyle
        case .graduateCollege:
            return .academic
        case .learnNewLanguage:
            return .mental
        case .foundCharity:
            return .philanthropy
        case .ltr:
            return .romantic
        case .marryLoveOfLife:
            return .romantic
        case .climbMountain:
            return .physical
        case .climbEverest:
            return .physical
        case .learnSurfing:
            return .travel
        case .masterMusicalInstrument:
            return .mental
        case .learnHowToRockclimb:
            return .physical
        case .liveInForeignCountry:
            return .travel
        case .noJunkFood:
            return .physical
        case .becomeArtist:
            return .career
        case .learnPottery:
            return .fun
        case .masterBallroomDancing:
            return .fun
        case .composeSong:
            return .sideProjects
        case .reachIdealBodyType:
            return .physical
        case .getPaidForPassion:
            return .career
        case .findLifePartner:
            return .romantic
        case .healthyDiet:
            return .physical
        case .liftWeightsBuildMuscle:
            return .physical
        case .generatePassiveIncome:
            return .financial
        case .deepSeeFishing:
            return .travel
        case .firstHome:
            return .home
        case .buildDreamHome:
            return .home
        case .goSkydiving:
            return .fun
        case .goHangGliding:
            return .fun
        case .rideHotAirBalloon:
            return .fun
        case .snorkelInOcean:
            return .travel
        case .climbGlacier:
            return .travel
        case .whitewaterRafting:
            return .fun
        case .favoriteFootballTeam:
            return .fun
        case .olympics:
            return .fun
        case .holeInOne:
            return .fun
        case .golfGame:
            return .fun
        case .assembleCollection:
            return .personal
        case .run6MinuteMile:
            return .physical
        case .declutterHome:
            return .home
        case .appearOnPodcast:
            return .personal
        case .runAPodcast:
            return .sideProjects
        case .youtubeChannel:
            return .sideProjects
        case .financialInheritance:
            return .financial
        case .traceAncestry:
            return .family
        case .veganDiet:
            return .physical
        case .favoriteMusician:
            return .fun
        case .happyFamily:
            return .family
        case .newFamilyTradition:
            return .family
        case .workLifeBalance:
            return .personal
        case .startOnlineBusiness:
            return .career
        case .relationshipAnniversaries:
            return .romantic
        case .meetFavoriteAthlete:
            return .fun
        case .meetFavoriteCeleb:
            return .fun
        case .startSmallBusiness:
            return .career
        case .seeTheBallDrop:
            return .fun
        case .getDreamPet:
            return .family
        case .giveUpSoda:
            return .physical
        case .northernLights:
            return .travel
        case .volcanoErupt:
            return .travel
        case .goOnACruise:
            return .travel
        case .goToMardiGras:
            return .fun
        case ._750CreditScore:
            return .financial
        case .learnSelfDefense:
            return .physical
        case .learnkarate:
            return .physical
        case .learnYoga:
            return .physical
        case .vocabulary:
            return .mental
        case .recSportsLeague:
            return .physical
        case .professionalAthlete:
            return .career
        case .famousActor:
            return .career
        case .thrivingGarden:
            return .lifestyle
        case .haveChildren:
            return .family
        case .growGarden:
            return .lifestyle
        case .writeMovieScript:
            return .sideProjects
        case .learnSing:
            return .sideProjects
        case .singInChoir:
            return .philanthropy
        case .makeWebsite:
            return .sideProjects
        case .ventureCapitalist:
            return .career
        case .sponsorAChild:
            return .philanthropy
        case .crossCountryRoadtrip:
            return .travel
        case .visitEveryCountry:
            return .travel
        case .payOffStudentLoans:
            return .financial
        case .learnToCode:
            return .mental
        case .improveDrawingSkills:
            return .sideProjects
        case .goOnSoloVacation:
            return .travel
        case .learnToSew:
            return .lifestyle
        }
    }
    
    static func fromString(from string: String) -> Self{
        return Self.allCases.first(where: {$0.toString() == string}) ?? .happyFamily
    }
}
