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
    
    
    func isCommon() -> Bool {
        switch self {
        case .Accountability:
            return true
        case .Achievement:
            return true
        case .Altruism:
            return true
        case .Autonomy:
            return true
        case .Balance:
            return true
        case .Charity:
            return true
        case .Compassion:
            return true
        case .Courage:
            return true
        case .Dedication:
            return true
        case .Dependability:
            return true
        case .Diversity:
            return true
        case .Entrepreneurship:
            return true
        case .Excellence:
            return true
        case .Faith:
            return true
        case .FinancialSecurity:
            return true
        case .Freedom:
            return true
        case .Generosity:
            return true
        case .Goodness:
            return true
        case .GrowthMindset:
            return true
        case .Happiness:
            return true
        case .Honesty:
            return true
        case .Hope:
            return true
        case .Humility:
            return true
        case .Influence:
            return true
        case .Innovation:
            return true
        case .Integrity:
            return true
        case .Joy:
            return true
        case .Kindness:
            return true
        case .Knowledge:
            return true
        case .Passion:
            return true
        case .Patience:
            return true
        case .PositiveAttitude:
            return true
        case .Prosperity:
            return true
        case .Reciprocity:
            return true
        case .Respect:
            return true
        case .Selflessness:
            return true
        case .Spirituality:
            return true
        case .Success:
            return true
        case .Teamwork:
            return true
        case .Thoughtfulness:
            return true
        case .Tolerance:
            return true
        case .Trust:
            return true
        case .WorkEthic:
            return true
        default:
            return false
        }
    }
    
    func toDescription() -> String {
        switch self {
        case .Accountability:
            return "I take responsibility for all of my actions, regardless of the positive or negative impact."
        case .Achievement:
            return "I push myself to achieve wonderful things every day if my life."
        case .Altruism:
            return "I selflessly seek the greater good for everyone"
        case .Autonomy:
            return "I strive to create a lifestyle that allows me to be independent from others."
        case .Balance:
            return "I live a life that is balanced in all things. I invest in all parts of my life simultaneously"
        case .Charity:
            return "I am charitable towards humanity, both with my time and resources."
        case .Compassion:
            return "I allow the burdons and hardships of others to deeply impact my soul, and I moved to serve others."
        case .Courage:
            return "I minimize fear of temporal things and take courage to be the best version of myself that I can."
        case .Dedication:
            return "I am dedicated to the parts of life that I commit to. I give everything my 100%."
        case .Dependability:
            return "When I commit to someone, they can always count on me to fulfill my commitment."
        case .Diversity:
            return "I strive to surround myself with all types of people."
        case .Entrepreneurship:
            return "I thrive on the rush of bringing about my own business ideas."
        case .Excellence:
            return "I will always strive to give 110%."
        case .Faith:
            return "I believe in a better tomorrow. I believe that things will turn out for our good. I believe we are watched over and protected."
        case .FinancialSecurity:
            return "The tenant of 'saving more than you spend' is core to my health as a person."
        case .Freedom:
            return "I desire to continually lead myself towards a state in life that I have as much freedom as possible, both civilly as well as personally."
        case .Generosity:
            return "I give of my resources to others, even to the point of it hurting a little bit."
        case .Goodness:
            return "I am a source of goodness in the lives of those who know me. Everything I touch becomes better, happier, and more full."
        case .GrowthMindset:
            return "Everyday is an opportunity to grow. To progress. I will take advantage of everyday to improve."
        case .Happiness:
            return "I can choose to be happy. I can choose to have joy"
        case .Honesty:
            return "I will always speak my truth. I will not hold back. I will be transparent with my words and actions."
        case .Hope:
            return "It is fundamental to my being to assume things will get better. No matter how dark today is, tomorrow will be better."
        case .Humility:
            return "I strive to both be the best, most successful version of myself I can be, as well as recognizing my own faults and shortcomings. I try to understand my own insignificant place in the infinite universe."
        case .Influence:
            return "I am influential to many. My presence influences you to become better."
        case .Innovation:
            return "I do not simply accept the current status quo or the current way of doing things. I live to improve the systems and processes around me and bring about true innovation."
        case .Integrity:
            return "While I may adapt my communication style in different crowds, I am the same integrous person everywhere. I do not shape shift to please or manipulate others."
        case .Joy:
            return "I want to experience joy always. I recognize this is not possible, but everything I do in life, I do in an attempt to increase my own personal joy."
        case .Kindness:
            return "I treat others with kindness. My actions and my words reflect this kindness. Others feel safe and respected around me."
        case .Knowledge:
            return "I am knowledgeable about the things I choose to pursue in life. It is my goal to become a knowledge expert in my areas of focus."
        case .Passion:
            return "I invest a maximum level of energy and zest into my chosen fields of interest."
        case .Patience:
            return "I am patient with others and their shortcomings, but most importantly I am patient with myself and my own shortcomings."
        case .PositiveAttitude:
            return "I recognize bad things happen in life, but I can control my attitude. I choose to view all things as events in life that I can benefit from."
        case .Prosperity:
            return "I work towards a state of life where I am prosperous in all things. Financial things, social things, emotional things."
        case .Reciprocity:
            return "I reciprocate. I give back. I return favors. I invest in those who invest in me."
        case .Respect:
            return "I respect myself. I respect my body. I respect my mental health. I ensure that my actions are aligned with respecting myself"
        case .Selflessness:
            return "I give my life to improve the lives of my loved ones. By uplifting others, I uplift myself."
        case .Spirituality:
            return "I exercise spirituality in my own unique form. I connect with the higher power and feel a oneness with that power."
        case .Success:
            return "I am determined to be as successful as I possibly can. I see a bright future for myself with achievements and accolades."
        case .Teamwork:
            return "The biggest obstacles in life are only accomplished through teamwork. I invest in being a team member and a team leader simultaneously."
        case .Thoughtfulness:
            return "My words and actions are pre-meditated to uplift and serve others. I am thoughtful."
        case .Tolerance:
            return "I recognize my own uniqueness in a world of unique beings. I am tolerant of the unique and different elements to other beings, and I encourage their tolerance towards me in my uniqueness."
        case .Trust:
            return "I let a select number of people into my life fully. I trust them with my privacy, my emotions, and my hardships. I trust that they have the best intentions for my life."
        case .WorkEthic:
            return "I firmly believe that success, happiness and stability are all strongly correlated to work ethic. I work hard. I an devoted. I never shy away from work."
        case .Introduction:
            return "I am a beautifully flawed human being trying my best every day."
        case .Conclusion:
            return "This is my life's creed. A collection of values that I hold most dear."
        default:
            return "I believe " + self.toString() + " is an important core value and I invest everyday to making it more a core part of my life."
        }
    }
    static func fromString(input: String) -> Self{
        return Self.allCases.first(where: {$0.toString() == input}) ?? .Kindness
    }
}
