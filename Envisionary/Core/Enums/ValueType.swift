//
//  ValueType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/5/23.
//

import SwiftUI

enum ValueType: CaseIterable, Codable, Hashable {
    case Introduction
    case Conclusion
    
    case Acceptance
    case Accountability
    case Achievement
    case Adaptability
    case Adventure
    case Altruism
    case AnimalRights
    case AntiRacism
    case Appreciation
    case Autonomy
    case Awareness
    case Balance
    case Boldness
    case Bravery
    case Change
    case Charity
    case Community
    case Compassion
    case Confidence
    case Consistency
    case Cooperation
    case Courage
    case Creativity
    case Curiosity
    case Decisiveness
    case Dedication
    case Dependability
    case Diversity
    case Effective
    case Efficiency
    case EmotionalIntelligence
    case Empathy
    case Entrepreneurship
    case EnvironmentalProtection
    case Excellence
    case Fairness
    case Faith
    case Faithfulness
    case Fame
    case FamilyFirst
    case Fidelity
    case FinancialSecurity
    case Flexibility
    case Forgiveness
    case Freedom
    case Generosity
    case Goodness
    case Gracefulness
    case Gratitude
    case GrowthMindset
    case Happiness
    case Honesty
    case Hope
    case Humility
    case Humor
    case Imagination
    case Independence
    case Influence
    case Innovation
    case InspireOthers
    case Integrity
    case Joy
    case Justice
    case Kindness
    case Knowledge
    case Laughter
    case Leadership
    case LearningFromMistakes
    case Listening
    case Loyalty
    case Management
    case Mentorship
    case Modesty
    case OpenMindedness
    case Optimism
    case Originality
    case Passion
    case Patience
    case Peacefulness
    case Persistence
    case PersonalDevelopment
    case Planning
    case PositiveAttitude
    case Power
    case PrideInYourWork
    case Professionalism
    case Profit
    case Prosperity
    case Reciprocity
    case Reliability
    case Respect
    case Responsibility
    case Righteousness
    case Romance
    case SelfControl
    case SelfDevelopment
    case SelfDiscipline
    case Selflessness
    case SelfLove
    case SelfMotivation
    case ServiceOriented
    case Sincerity
    case Socializing
    case SocialJustice
    case Spirituality
    case Spontaneity
    case Stability
    case Strength
    case Success
    case Sustainability
    case Sweetness
    case Teamwork
    case Thoughtfulness
    case Tolerance
    case Tradition
    case Transparency
    case Trust
    case Warmth
    case Wealth
    case Wellness
    case Wisdom
    case WorkEthic
    case WorkLifeBalance
    
    func toString() -> String{
        switch self {
        case .Introduction:
            return "Introduction"
        case .Conclusion:
            return "Conclusion"
        case .Acceptance:
            return "Acceptance"
        case .Accountability:
            return "Accountability"
        case .Achievement:
            return "Achievement"
        case .Adaptability:
            return "Adaptability"
        case .Adventure:
            return "Adventure"
        case .Altruism:
            return "Altruism"
        case .AnimalRights:
            return "Animal Rights"
        case .AntiRacism:
            return "Anti-Racism"
        case .Appreciation:
            return "Appreciation"
        case .Autonomy:
            return "Autonomy"
        case .Awareness:
            return "Awareness"
        case .Balance:
            return "Balance"
        case .Boldness:
            return "Boldness"
        case .Bravery:
            return "Bravery"
        case .Change:
            return "Change"
        case .Charity:
            return "Charity"
        case .Community:
            return "Community"
        case .Compassion:
            return "Compassion"
        case .Confidence:
            return "Confidence"
        case .Consistency:
            return "Consistency"
        case .Cooperation:
            return "Cooperation"
        case .Courage:
            return "Courage"
        case .Creativity:
            return "Creativity"
        case .Curiosity:
            return "Curiosity"
        case .Decisiveness:
            return "Decisiveness"
        case .Dedication:
            return "Dedication"
        case .Dependability:
            return "Dependability"
        case .Diversity:
            return "Diversity"
        case .Effective:
            return "Effective"
        case .Efficiency:
            return "Efficiency"
        case .EmotionalIntelligence:
            return "Emotional Intelligence"
        case .Empathy:
            return "Empathy"
        case .Entrepreneurship:
            return "Entrepreneurship"
        case .EnvironmentalProtection:
            return "Environmental Protection"
        case .Excellence:
            return "Excellence"
        case .Fairness:
            return "Fairness"
        case .Faith:
            return "Faith"
        case .Faithfulness:
            return "Faithfulness"
        case .Fame:
            return "Fame"
        case .FamilyFirst:
            return "Family First"
        case .Fidelity:
            return "Fidelity"
        case .FinancialSecurity:
            return "Financial Security"
        case .Flexibility:
            return "Flexibility"
        case .Forgiveness:
            return "Forgiveness"
        case .Freedom:
            return "Freedom"
        case .Generosity:
            return "Generosity"
        case .Goodness:
            return "Goodness"
        case .Gracefulness:
            return "Gracefulness"
        case .Gratitude:
            return "Gratitude"
        case .GrowthMindset:
            return "Growth Mindset"
        case .Happiness:
            return "Happiness"
        case .Honesty:
            return "Honesty"
        case .Hope:
            return "Hope"
        case .Humility:
            return "Humility"
        case .Humor:
            return "Humor"
        case .Imagination:
            return "Imagination"
        case .Independence:
            return "Independence"
        case .Influence:
            return "Influence"
        case .Innovation:
            return "Innovation"
        case .InspireOthers:
            return "Inspire Others"
        case .Integrity:
            return "Integrity"
        case .Joy:
            return "Joy"
        case .Justice:
            return "Justice"
        case .Kindness:
            return "Kindness"
        case .Knowledge:
            return "Knowledge"
        case .Laughter:
            return "Laughter"
        case .Leadership:
            return "Leadership"
        case .LearningFromMistakes:
            return "Learning From Mistakes"
        case .Listening:
            return "Listening"
        case .Loyalty:
            return "Loyalty"
        case .Management:
            return "Management"
        case .Mentorship:
            return "Mentorship"
        case .Modesty:
            return "Modesty"
        case .OpenMindedness:
            return "Open-Mindedness"
        case .Optimism:
            return "Optimism"
        case .Originality:
            return "Originality"
        case .Passion:
            return "Passion"
        case .Patience:
            return "Patience"
        case .Peacefulness:
            return "Peacefulness"
        case .Persistence:
            return "Persistence"
        case .PersonalDevelopment:
            return "Personal Development"
        case .Planning:
            return "Planning"
        case .PositiveAttitude:
            return "Positive Attitude"
        case .Power:
            return "Power"
        case .PrideInYourWork:
            return "Pride in your Work"
        case .Professionalism:
            return "Professionalism"
        case .Profit:
            return "Profit"
        case .Prosperity:
            return "Prosperity"
        case .Reciprocity:
            return "Reciprocity"
        case .Reliability:
            return "Reliability"
        case .Respect:
            return "Respect"
        case .Responsibility:
            return "Responsibility"
        case .Righteousness:
            return "Righteousness"
        case .Romance:
            return "Romance"
        case .SelfControl:
            return "Self-Control"
        case .SelfDevelopment:
            return "Self-Development"
        case .SelfDiscipline:
            return "Self-Discipline"
        case .Selflessness:
            return "Selflessness"
        case .SelfLove:
            return "Self-Love"
        case .SelfMotivation:
            return "Self-Motivation"
        case .ServiceOriented:
            return "Service-Oriented"
        case .Sincerity:
            return "Sincerity"
        case .Socializing:
            return "Socializing"
        case .SocialJustice:
            return "Social Justice"
        case .Spirituality:
            return "Spirituality"
        case .Spontaneity:
            return "Spontaneity"
        case .Stability:
            return "Stability"
        case .Strength:
            return "Strength"
        case .Success:
            return "Success"
        case .Sustainability:
            return "Sustainability"
        case .Sweetness:
            return "Sweetness"
        case .Teamwork:
            return "Teamwork"
        case .Thoughtfulness:
            return "Thoughtfulness"
        case .Tolerance:
            return "Tolerance"
        case .Tradition:
            return "Tradition"
        case .Transparency:
            return "Transparency"
        case .Trust:
            return "Trust"
        case .Warmth:
            return "Warmth"
        case .Wealth:
            return "Wealth"
        case .Wellness:
            return "Welness"
        case .Wisdom:
            return "Wisdom"
        case .WorkEthic:
            return "Work Ethic"
        case .WorkLifeBalance:
            return "Work-Life Balance"
        }
    }
    
    static func fromString(input: String) -> Self{
        return Self.allCases.first(where: {$0.toString() == input}) ?? .Kindness
    }
}
