//
//  HabitType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/12/23.
//

import SwiftUI

enum HabitType: CaseIterable {
    case brushTeeth
    case readABook
    case dailyExercise
    case makeBed
    case getUp6am
    case goToBe10pm
    case eatHealthy
    case drink8glassesWater
    case learnNewVocabWord
    case driveUnderSpeedLimit
    case connectWithFriend
    case pullUpChallenge
    case save$20
    case newPerson
    
    func toImageString() -> String{
        switch self{
        case .dailyExercise:
            return "sample_exercise"
        case .getUp6am:
            return "sample_alarm"
        case .eatHealthy:
            return "sample_food"
        default:
            return ""
        }
    }
    
    func toString() -> String{
        switch self {
        case .brushTeeth:
            return "Brush Teeth everyday"
        case .readABook:
            return "Read 2hr/day"
        case .dailyExercise:
            return "Exercise"
        case .makeBed:
            return "Make my bed"
        case .getUp6am:
            return "Get up at 6am"
        case .goToBe10pm:
            return "Go to bed at 10pm"
        case .eatHealthy:
            return "Eat Healthy"
        case .drink8glassesWater:
            return "Drink 8 glasses of water"
        case .learnNewVocabWord:
            return "Learn new vocab word"
        case .driveUnderSpeedLimit:
            return "Drive under the speed limit"
        case .connectWithFriend:
            return "Connect with someone I care about"
        case .pullUpChallenge:
            return "Pull Up challenge: +1 each day"
        case .save$20:
            return "Save $20/day"
        case .newPerson:
            return "Meet a new person"
        }
    }
    
    func toRequest() -> CreateHabitRequest{
        switch self {
        case .brushTeeth:
            return CreateHabitRequest(title: self.toString(), priority: .moderate, startDate: Date(), endDate: Date().AdvanceMonth(forward: true), schedule: .aCertainAmountPerDay, amount: 2, unitOfMeasure: .times, image: nil, aspect: AspectType.personal.toString(), timeframe: .month)
        case .readABook:
            return CreateHabitRequest(title: self.toString(), priority: .moderate, startDate: Date(), endDate: Date().AdvanceMonth(forward: true), schedule: .aCertainAmountPerDay, amount: 2, unitOfMeasure: .hours, image: nil, aspect: AspectType.academic.toString(), timeframe: .month)
        case .dailyExercise:
            return CreateHabitRequest(title: self.toString(), priority: .moderate, startDate: Date(), endDate: Date().AdvanceMonth(forward: true), schedule: .aCertainAmountPerDay, amount: 30, unitOfMeasure: .minutes, image: nil, aspect: AspectType.physical.toString(), timeframe: .month)
        case .makeBed:
            return CreateHabitRequest(title: self.toString(), priority: .moderate, startDate: Date(), endDate: Date().AdvanceMonth(forward: true), schedule: .oncePerDay, amount: 0, unitOfMeasure: .times, image: nil, aspect: AspectType.personal.toString(), timeframe: .month)
        case .getUp6am:
            return CreateHabitRequest(title: self.toString(), priority: .moderate, startDate: Date(), endDate: Date().AdvanceMonth(forward: true), schedule: .oncePerDay, amount: 0, unitOfMeasure: .times, image: nil, aspect: AspectType.personal.toString(), timeframe: .month)
        case .goToBe10pm:
            return CreateHabitRequest(title: self.toString(), priority: .moderate, startDate: Date(), endDate: Date().AdvanceMonth(forward: true), schedule: .oncePerDay, amount: 0, unitOfMeasure: .times, image: nil, aspect: AspectType.personal.toString(), timeframe: .month)
        case .eatHealthy:
            return CreateHabitRequest(title: self.toString(), priority: .moderate, startDate: Date(), endDate: Date().AdvanceMonth(forward: true), schedule: .aCertainAmountPerDay, amount: 3, unitOfMeasure: .times, image: nil, aspect: AspectType.personal.toString(), timeframe: .month)
        case .drink8glassesWater:
            return CreateHabitRequest(title: self.toString(), priority: .moderate, startDate: Date(), endDate: Date().AdvanceMonth(forward: true), schedule: .aCertainAmountPerDay, amount: 8, unitOfMeasure: .times, image: nil, aspect: AspectType.personal.toString(), timeframe: .month)
        case .learnNewVocabWord:
            return CreateHabitRequest(title: self.toString(), priority: .moderate, startDate: Date(), endDate: Date().AdvanceMonth(forward: true), schedule: .oncePerDay, amount: 0, unitOfMeasure: .times, image: nil, aspect: AspectType.academic.toString(), timeframe: .month)
        case .driveUnderSpeedLimit:
            return CreateHabitRequest(title: self.toString(), priority: .moderate, startDate: Date(), endDate: Date().AdvanceMonth(forward: true), schedule: .oncePerDay, amount: 0, unitOfMeasure: .times, image: nil, aspect: AspectType.environment.toString(), timeframe: .month)
        case .connectWithFriend:
            return CreateHabitRequest(title: self.toString(), priority: .moderate, startDate: Date(), endDate: Date().AdvanceMonth(forward: true), schedule: .oncePerDay, amount: 0, unitOfMeasure: .times, image: nil, aspect: AspectType.emotional.toString(), timeframe: .month)
        case .pullUpChallenge:
            return CreateHabitRequest(title: self.toString(), priority: .moderate, startDate: Date(), endDate: Date().AdvanceMonth(forward: true), schedule: .oncePerDay, amount: 0, unitOfMeasure: .times, image: nil, aspect: AspectType.personal.toString(), timeframe: .month)
        case .save$20:
            return CreateHabitRequest(title: self.toString(), priority: .moderate, startDate: Date(), endDate: Date().AdvanceMonth(forward: true), schedule: .oncePerDay, amount: 20, unitOfMeasure: .dollars, image: nil, aspect: AspectType.financial.toString(), timeframe: .month)
        case .newPerson:
            return CreateHabitRequest(title: self.toString(), priority: .moderate, startDate: Date(), endDate: Date().AdvanceMonth(forward: true), schedule: .oncePerDay, amount: 0, unitOfMeasure: .times, image: nil, aspect: AspectType.social.toString(), timeframe: .month)
        }
    }
    
    
    static func fromString(from string: String) -> Self{
        return Self.allCases.first(where: {$0.toString() == string}) ?? .brushTeeth
    }
}
