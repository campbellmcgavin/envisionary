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
    case marchForACause
    case becomeGovernor
    case becomeMayor
    case becomeCongressperson
    
    case valedictorian
    case _4_0_gpa
    case graduateTopOfClass
    case headOfClub
    
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
            return "Deep sea fishing"
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
        case .marchForACause:
            return "March for a cause"
        case .becomeGovernor:
            return "Become Governor"
        case .becomeMayor:
            return "Become Mayor"
        case .becomeCongressperson:
            return "Congress Person"
        case .valedictorian:
            return "Valedictorian"
        case ._4_0_gpa:
            return "4.0 GPA"
        case .graduateTopOfClass:
            return "Graduate top of class"
        case .headOfClub:
            return "Head of Club"
        }
    }
    
    func toAspect() -> String{
        switch self {
        case .inspireOthers:
            return AspectType.philanthropy.toString()
        case .masterSkill:
            return AspectType.career.toString()
        case .getPrestigiousDegree:
            return AspectType.academic.toString()
        case .getMba:
            return AspectType.academic.toString()
        case .getMastersDegree:
            return AspectType.academic.toString()
        case .getDoctorateDegree:
            return AspectType.academic.toString()
        case .becomeMd:
            return AspectType.academic.toString()
        case .getJd:
            return AspectType.academic.toString()
        case .leaderInIndustry:
            return AspectType.career.toString()
        case .businessExecutive:
            return AspectType.career.toString()
        case .millionaire:
            return AspectType.financial.toString()
        case .billionaire:
            return AspectType.financial.toString()
        case .travel7Continents:
            return AspectType.travel.toString()
        case .travelDreamCountry:
            return AspectType.travel.toString()
        case .reach100k:
            return AspectType.financial.toString()
        case .reach500k:
            return AspectType.financial.toString()
        case .reach1m:
            return AspectType.financial.toString()
        case .publishNovel:
            return AspectType.career.toString()
        case .runMarathon:
            return AspectType.physical.toString()
        case .get6Pack:
            return AspectType.physical.toString()
        case .becomeDebtFree:
            return AspectType.financial.toString()
        case .buyDreamCar:
            return AspectType.lifestyle.toString()
        case .sevenWonders:
            return AspectType.travel.toString()
        case .allSevenWonders:
            return AspectType.travel.toString()
        case .retireComfortably:
            return AspectType.lifestyle.toString()
        case .graduateCollege:
            return AspectType.academic.toString()
        case .learnNewLanguage:
            return AspectType.mental.toString()
        case .foundCharity:
            return AspectType.philanthropy.toString()
        case .ltr:
            return AspectType.romantic.toString()
        case .marryLoveOfLife:
            return AspectType.romantic.toString()
        case .climbMountain:
            return AspectType.physical.toString()
        case .climbEverest:
            return AspectType.physical.toString()
        case .learnSurfing:
            return AspectType.travel.toString()
        case .masterMusicalInstrument:
            return AspectType.mental.toString()
        case .learnHowToRockclimb:
            return AspectType.physical.toString()
        case .liveInForeignCountry:
            return AspectType.travel.toString()
        case .noJunkFood:
            return AspectType.physical.toString()
        case .becomeArtist:
            return AspectType.career.toString()
        case .learnPottery:
            return AspectType.fun.toString()
        case .masterBallroomDancing:
            return AspectType.fun.toString()
        case .composeSong:
            return AspectType.sideProjects.toString()
        case .reachIdealBodyType:
            return AspectType.physical.toString()
        case .getPaidForPassion:
            return AspectType.career.toString()
        case .findLifePartner:
            return AspectType.romantic.toString()
        case .healthyDiet:
            return AspectType.physical.toString()
        case .liftWeightsBuildMuscle:
            return AspectType.physical.toString()
        case .generatePassiveIncome:
            return AspectType.financial.toString()
        case .deepSeeFishing:
            return AspectType.travel.toString()
        case .firstHome:
            return AspectType.home.toString()
        case .buildDreamHome:
            return AspectType.home.toString()
        case .goSkydiving:
            return AspectType.fun.toString()
        case .goHangGliding:
            return AspectType.fun.toString()
        case .rideHotAirBalloon:
            return AspectType.fun.toString()
        case .snorkelInOcean:
            return AspectType.travel.toString()
        case .climbGlacier:
            return AspectType.travel.toString()
        case .whitewaterRafting:
            return AspectType.fun.toString()
        case .favoriteFootballTeam:
            return AspectType.fun.toString()
        case .olympics:
            return AspectType.fun.toString()
        case .holeInOne:
            return AspectType.fun.toString()
        case .golfGame:
            return AspectType.fun.toString()
        case .assembleCollection:
            return AspectType.personal.toString()
        case .run6MinuteMile:
            return AspectType.physical.toString()
        case .declutterHome:
            return AspectType.home.toString()
        case .appearOnPodcast:
            return AspectType.personal.toString()
        case .runAPodcast:
            return AspectType.sideProjects.toString()
        case .youtubeChannel:
            return AspectType.sideProjects.toString()
        case .financialInheritance:
            return AspectType.financial.toString()
        case .traceAncestry:
            return AspectType.family.toString()
        case .veganDiet:
            return AspectType.physical.toString()
        case .favoriteMusician:
            return AspectType.fun.toString()
        case .happyFamily:
            return AspectType.family.toString()
        case .newFamilyTradition:
            return AspectType.family.toString()
        case .workLifeBalance:
            return AspectType.personal.toString()
        case .startOnlineBusiness:
            return AspectType.career.toString()
        case .relationshipAnniversaries:
            return AspectType.romantic.toString()
        case .meetFavoriteAthlete:
            return AspectType.fun.toString()
        case .meetFavoriteCeleb:
            return AspectType.fun.toString()
        case .startSmallBusiness:
            return AspectType.career.toString()
        case .seeTheBallDrop:
            return AspectType.fun.toString()
        case .getDreamPet:
            return AspectType.family.toString()
        case .giveUpSoda:
            return AspectType.physical.toString()
        case .northernLights:
            return AspectType.travel.toString()
        case .volcanoErupt:
            return AspectType.travel.toString()
        case .goOnACruise:
            return AspectType.travel.toString()
        case .goToMardiGras:
            return AspectType.fun.toString()
        case ._750CreditScore:
            return AspectType.financial.toString()
        case .learnSelfDefense:
            return AspectType.physical.toString()
        case .learnkarate:
            return AspectType.physical.toString()
        case .learnYoga:
            return AspectType.physical.toString()
        case .vocabulary:
            return AspectType.mental.toString()
        case .recSportsLeague:
            return AspectType.physical.toString()
        case .professionalAthlete:
            return AspectType.career.toString()
        case .famousActor:
            return AspectType.career.toString()
        case .thrivingGarden:
            return AspectType.lifestyle.toString()
        case .haveChildren:
            return AspectType.family.toString()
        case .growGarden:
            return AspectType.lifestyle.toString()
        case .writeMovieScript:
            return AspectType.sideProjects.toString()
        case .learnSing:
            return AspectType.sideProjects.toString()
        case .singInChoir:
            return AspectType.philanthropy.toString()
        case .makeWebsite:
            return AspectType.sideProjects.toString()
        case .ventureCapitalist:
            return AspectType.career.toString()
        case .sponsorAChild:
            return AspectType.philanthropy.toString()
        case .crossCountryRoadtrip:
            return AspectType.travel.toString()
        case .visitEveryCountry:
            return AspectType.travel.toString()
        case .payOffStudentLoans:
            return AspectType.financial.toString()
        case .learnToCode:
            return AspectType.mental.toString()
        case .improveDrawingSkills:
            return AspectType.sideProjects.toString()
        case .goOnSoloVacation:
            return AspectType.travel.toString()
        case .learnToSew:
            return AspectType.lifestyle.toString()
        case .marchForACause:
            return AspectType.involvement.toString()
        case .becomeGovernor:
            return AspectType.political.toString()
        case .becomeMayor:
            return AspectType.political.toString()
        case .becomeCongressperson:
            return AspectType.political.toString()
        case .valedictorian:
            return AspectType.academic.toString()
        case ._4_0_gpa:
            return AspectType.academic.toString()
        case .graduateTopOfClass:
            return AspectType.academic.toString()
        case .headOfClub:
            return AspectType.academic.toString()
        }
    }
    
    static func fromString(from string: String) -> Self{
        return Self.allCases.first(where: {$0.toString() == string}) ?? .happyFamily
    }
}
