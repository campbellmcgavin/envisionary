//
//  SetupType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/8/23.
//

import SwiftUI

enum SetupStepType: CaseIterable {
    
    case welcome
    case envisionary
    case phases
    case objects
    case getStarted
    case value
    case creed
    case dream
    case aspect
    case goalIntro
    case goalContext
    case goalSetup
    case habit
    case session
    case home
    case chapter
    case entry
    case emotion
    case garduated
    
    func toString() -> String{
        switch self {
        case .welcome:
            return "welcome"
        case .envisionary:
            return "envisionary"
        case .phases:
            return "phases"
        case .objects:
            return "objects"
        case .getStarted:
            return "getStarted"
        case .value:
            return "value"
        case .creed:
            return "creed"
        case .dream:
            return "dream"
        case .aspect:
            return "aspect"
        case .goalIntro:
            return "goalIntro"
        case .goalContext:
            return "goalContext"
        case .goalSetup:
            return "goalSetup"
        case .habit:
            return "habit"
        case .session:
            return "session"
        case .home:
            return "home"
        case .chapter:
            return "chapter"
        case .entry:
            return "entry"
        case .emotion:
            return "emotion"
        case .garduated:
            return "graduated"
        }
    }
    
    func toContentView() -> ContentViewType{
        switch self {
        case .welcome:
            return .envision
        case .envisionary:
            return .envision
        case .phases:
            return .envision
        case .objects:
            return .envision
        case .getStarted:
            return .envision
        case .value:
            return .envision
        case .creed:
            return .envision
        case .dream:
            return .envision
        case .aspect:
            return .envision
        case .goalIntro:
            return .plan
        case .goalContext:
            return .plan
        case .goalSetup:
            return .plan
        case .habit:
            return .plan
        case .session:
            return .plan
        case .home:
            return .execute
        case .chapter:
            return .journal
        case .entry:
            return .journal
        case .emotion:
            return .journal
        case .garduated:
            return .execute
        default:
            return .execute
        }
    }
    
    func hasObject() -> Bool{
        switch self {
        case .welcome:
            return false
        case .envisionary:
            return false
        case .phases:
            return false
        case .objects:
            return false
        case .getStarted:
            return false
        default:
            return true
        }
    }
    
    func toObject() -> ObjectType{
        switch self {
        case .value:
            return .value
        case .creed:
            return .creed
        case .dream:
            return .dream
        case .aspect:
            return .aspect
        case .goalIntro:
            return .goal
        case .goalContext:
            return .goal
        case .goalSetup:
            return .goal
        case .habit:
            return .habit
        case .session:
            return .session
        case .home:
            return .home
        case .chapter:
            return .chapter
        case .entry:
            return .entry
        case .emotion:
            return .emotion
            //        case .garduated:
            //            return .stats
        default:
            return .stats
        }
    }
    
    func GetSubheader() -> String{
        switch self {
        case .welcome:
            return "Hello, and"
        case .envisionary:
            return "What is"
        case .phases:
            return "What are"
        case .objects:
            return "What are"
        case .getStarted:
            return "You're ready to"
        case .garduated:
            return "Welcome to your"
        default:
            return self.toObject().toContentType().toString()
        }
    }
    
    func GetHeader() -> String{
        switch self {
        case .welcome:
            return "Welcome!"
        case .envisionary:
            return "Envisionary?"
        case .phases:
            return "Phases?"
        case .objects:
            return "Objects?"
        case .getStarted:
            return "Get started!"
        case .garduated:
            return "Graduation"
        default:
            return self.toObject().toPluralString()
        }
    }
    
    func GetColor() -> CustomColor {
        switch self {
        case .welcome:
            return .grey2
        case .envisionary:
            return .grey2
        case .phases:
            return .grey2
        case .objects:
            return .grey2
        case .getStarted:
            return .grey2
        default:
            return .purple
        }
    }
    
    func HasNext() -> Bool{
        if self == .goalIntro || self == .goalContext {
            return true
        }
        return false
    }
    
    func GetNext() -> Self{
        switch self {
        case .welcome:
            return .envisionary
        case .envisionary:
            return .phases
        case .phases:
            return .objects
        case .objects:
            return .getStarted
        case .getStarted:
            return .getStarted
        case .value:
            return .creed
        case .creed:
            return .dream
        case .dream:
            return .aspect
        case .aspect:
            return .goalIntro
        case .goalIntro:
            return .goalContext
        case .goalContext:
            return .goalSetup
        case .goalSetup:
            return .habit
        case .habit:
            return .session
        case .session:
            return .home
        case .home:
            return .chapter
        case .chapter:
            return .entry
        case .entry:
            return .emotion
        case .emotion:
            return .garduated
        case .garduated:
            return .garduated
        }
    }
    
    
    
    func toTextArray() -> [String]{
        
        var array = [String]()
        
        if self.hasObject() && self != .goalSetup && self != .garduated{
            array.append(self.toObject().toPluralString() + " " + self.toObject().toDescription())
        }
        
        switch self {
        case .welcome:
            array.append("You’ve been waiting for this moment your entire life!")
            array.append("You just didn’t know it yet. 😛")
        case .envisionary:
            array.append("A productivity platform that emboldens you to envision your entire life’s work... 🏆")
            array.append("... and then break it down into manageable chunks. 🧀")
        case .phases:
            array.append("Distinct segments of the process for mapping out and accomplishing everything in life.")
        case .objects:
            array.append("Little blobs of information about you. 🔵 🟧 🟤 🟩 🟡")
            array.append("Each phase has different objects associated with it.")
            array.append("For example, the envision phase allows you to create Values, Creed, Dreams and Aspects.")
        case .getStarted:
            array.append("Let's jump right in and get everything setup.")
            array.append("Sooo exciting! 😱😱😱")
        case .value:
            array.append("Take a minute to add 5 or more personal values that resonate with you. ❤️")
            array.append("You can change this later.")
        case .creed:
            array.append("We built out your life's creed based on the values you selected.")
            array.append("You'll edit it later. 📝")
        case .dream:
            array.append("Be a dreamer for a minute here. ✨✨✨")
            array.append("Select a few dreams you would like to see come to fruition over the course of your life.")
            array.append("You can change any of these after the fact.")
        case .aspect:
            array.append("Select a few aspects that you will use to split up your life into various boxes.")
            array.append("#change-me-later")
        case .goalIntro:
            array.append("You can break big goals down into smaller goals 🌷. Each goal is locked to a timeframe 🗓.")
            array.append("Timeframes are distinct segments of time.")
            array.append("Namely, decades, years, months, weeks and days ☀️.")
            array.append("🕦🕣🕗")
        case .goalContext:
            array.append("Let's say you have always dreamed of going to Envisionary University (EU), the most prestigious planning institution in the entire world.")
            array.append("Buttttt it's super difficult to get into 🤓, so you're going to have to map out a pretty detailed plan. 💪")
            array.append("You'll need to build up your resume...")
            array.append("take all 37 😵‍💫 certification exams...")
            array.append("and go through a 23 stage interview process 🥺🥺🥺")
            array.append("It's gonna be a lot of work 👀, but if we split it up into small bites, you'll get there in no time.")
            array.append("And you have a secret weapon... this app! 💥💥💥")
        case .goalSetup:
            array.append("We're gonna do a full send and create your path to victory 😎")
            array.append("Go ahead and add each goal.")
            array.append("Something to keep in mind: \n\nAs timeframe goes ⬇️, specificity goes ⬆️")
        case .habit:
            array.append("Habits are great for when you want do something over and over again...\n\n🔁🔁🔁🔁🔁")
            array.append("😸")
            array.append("They are tied to schedules... like once a day, once a week, or on weekends.")
            array.append("Let's add a few habits. 💁")
            array.append("And no worries 👍. You can change them later.")
        case .session:
            array.append("And... Plans. Always. Change.")
            array.append("😬😬😬")
            array.append("Pick a timeframe and a date, and then sessions automatically gathers everything you have planned for that period. 🦄")
            array.append("You'll be able to align big goals with your core values. ❤️")
            array.append("You're also able to push off, edit, or delete anything for maximum flexibility 🤸")
        case .home:
            array.append("So much execute, all in one place. \n\n✅☑️✅☑️✅☑️✅")
            array.append("You'll see the goals and habits that are happening now, as well as anything you've marked as favorites.")
            array.append("Home is also really good at reminding you to do things like...")
            array.append("Review your values ❤️")
            array.append("Write in your journal 📓")
            array.append("Do a planning session 😎")
            array.append("and so on...")
        case .chapter:
            array.append("Just like chapters in a book...")
            array.append("your book")
            array.append("of life!!! ☀️ ☀️ ☀️ ☀️ ☀️ ☀️ ☀️ ☀️ ☀️ ")
            array.append("Go ahead and take a minute to add a few chapters!")
            array.append("You will never change these again.")
            array.append("...")
            array.append("just kidding. 🤣")
        case .entry:
            array.append("Think... pages in a chapter... in your book of life. ☀️🐇")
            array.append("And... wow... you're kinda choking up, aren't you...")
            array.append("This is a big moment. Taking your first steps in learning the tool that will help you become who you want to be.")
            array.append("Let's write about it.")
        case .emotion:
            array.append("So... basically your replacement for screaming into your pillow")
            array.append("Don't worry... no one will know 😉")
            array.append("Let's get you going on your mood tracking!")
        case .garduated:
            array.append("10 years later")
            array.append(". . . Where are you? ")
            array.append(". . . You're at your own graduation! 👩‍🎓👩‍🎓👩‍🎓")
            array.append("You were able to apply to Envisionary University, and get accepted! And turns out, you graduated top of your class 💁‍♀️.")
            array.append("Congratulations!!!")
            array.append("You're now ready to go conquer the world.")
            array.append("Joking... kind of 🙊")
        case .emotion:
            array.append("")
        }
                         
         return array
    }
    
//    func toFirstText() -> String{
//        switch self {
//        case .goalIntro:
//            return self.toObject().toPluralString() + " " + self.toObject().toDescription() + ". Goals are the most crucial part of the entire platform. A goal can have sub-goals, and is broken up into timeframes."
//        case .goalContext:
//            return "Let's say you have always dreamed of going to Envisionary University (EU), the most prestigious planning institution in the entire world. But it's super difficult to get into, so you're going to have to map out a pretty detailed plan."
//        case .goalSetup:
//            return "Let's practice!!! 😸"
//        default:
//            return self.toObject().toPluralString() + " " + self.toObject().toDescription()
//        }
//    }
//
//    func toSecondText() -> String{
//
//        switch self {
//        case .value:
//            return "Take a minute to add 5 to 10 personal values that resonate with you. You can change this later."
//        case .creed:
//            return "We built out your life's creed based on the values you selected. You can change this later."
//        case .dream:
//            return "Be a dreamer for a minute here. Select a few dreams you would like to see come to fruition over the course of your life. You can change this later."
//        case .aspect:
//            return "Select up to 10 aspects that you will use to split up your life into various segments. You can change this later."
//        case .goalIntro:
//            return "Timeframes are distinct segments of time. Namely, decades, years, months, weeks and days."
//        case .goalContext:
//            return "You first decide that you want to go to this ambitious school. Awesome. You're also going to need to do some study prep, build up your resume and CV, and then take all 37 certification exams! You'll then need to apply, go through the 23 stage interview process, and be the 1 in 47,000 that get accepted. It's gonna be a lot of work, but if we split it up into small bites, you'll get there in no time. And you have a secret weapon... this app!"
//        case .goalSetup:
//            return "Go ahead and add each goal, starting with a decade goal and then moving downwards to year goals and so on."
//        case .habit:
//            return ""
////        case .session:
////            <#code#>
////        case .chapter:
////            <#code#>
////        case .entry:
////            <#code#>
////        case .emotion:
////            <#code#>
////        case .stats:
////            <#code#>
////        case .prompt:
////            <#code#>
////        case .recurrence:
////            <#code#>
//        default:
//            return ""
//        }
//    }
    
    static func fromString(from string: String) -> Self{
        return Self.allCases.first(where: {$0.toString() == string}) ?? .value
    }
}
