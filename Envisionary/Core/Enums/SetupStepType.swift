//
//  SetupType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/8/23.
//

import SwiftUI

enum SetupStepType {

    case welcome
    case envisionary
    case phases
    case envision
    case plan
    case execute
    case journal
    case evaluate
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
//    case emotion
    case garduated
    
    
    func toContentView() -> ContentViewType{
        switch self {
        case .welcome:
            return .envision
        case .envisionary:
            return .envision
        case .phases:
            return .envision
        case .envision:
            return .envision
        case .plan:
            return .plan
        case .execute:
            return .execute
        case .journal:
            return .journal
        case .evaluate:
            return .evaluate
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
        case .garduated:
            return .execute
        }
    }
    
    func toObject() -> ObjectType?{
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
//        case .emotion:
//            return .emotion
//        case .garduated:
//            return .stats
        default:
            return nil
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
        case .envision:
            return "What is"
        case .plan:
            return "What is"
        case .execute:
            return "What is"
        case .journal:
            return "What is"
        case .evaluate:
            return "What is"
        case .objects:
            return "Each phase has"
        case .getStarted:
            return "You're ready to"
        case .garduated:
            return "Welcome to your"
        default:
            return self.toObject()?.toContentType().toString() ?? ""
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
        case .envision:
            return "Envision?"
        case .plan:
            return "Plan?"
        case .execute:
            return "Execute?"
        case .journal:
            return "Journal?"
        case .evaluate:
            return "Evaluate?"
        case .objects:
            return "Objects."
        case .getStarted:
            return "Get started!"
        case .garduated:
            return "Graduation"
        default:
            return self.toObject()?.toString() ?? ""
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
        case .envision:
            return .grey2
        case .plan:
            return .grey2
        case .execute:
            return .grey2
        case .journal:
            return .grey2
        case .evaluate:
            return .grey2
        case .objects:
            return .grey2
        case .getStarted:
            return .grey2
        default:
            return .purple
        }
    }
    
    func GetNext() -> Self{
        switch self {
        case .welcome:
            return .envisionary
        case .envisionary:
            return .phases
        case .phases:
            return .envision
        case .envision:
            return .plan
        case .plan:
            return .execute
        case .execute:
            return .journal
        case .journal:
            return .evaluate
        case .evaluate:
            return .objects
        case .objects:
            return .getStarted
        case .getStarted:
            return .value
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
            return .garduated
//        case .emotion:
//            return .emotion
        case .garduated:
            return .garduated
        }
    }
    
    
    
    func toTextArray() -> [String]{
        
        var array = [String]()
        
        if self != .goalSetup && self != .goalContext && self != .garduated{
            if let object = self.toObject(){
                array.append(object.toPluralString() + " " + object.toDescription())
            }
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
        case .envision:
            array.append("The phase for creating the vision of who you want to become.")
        case .plan:
            array.append("The phase for mapping out concrete plans to achieve your vision.")
        case .execute:
            array.append("The phase for executing day to day work that leads to the vision.")
        case .journal:
            array.append("The phase for recording your thoughts, and emotions along the way.")
        case .evaluate:
            array.append("The phase for quantifying performance, growth and progress.")
        case .objects:
            array.append("For example, the envision phase allows you to create Values, Creed, Dreams and Aspects.")
        case .getStarted:
            array.append("Let’s jump in and start adding your first objects.")
        case .value:
            array.append("Take a minute to add 5 to 10 personal values that resonate with you.")
            array.append("You can change this later.")
        case .creed:
            array.append("We built out your life's creed based on the values you selected.")
            array.append("You'll edit it later.")
        case .dream:
            array.append("Be a dreamer for a minute here.")
            array.append("Select a few dreams you would like to see come to fruition over the course of your life.")
            array.append("You can change any of these after the fact.")
        case .aspect:
            array.append("Select up to 10 aspects that you will use to split up your life into various segments.")
            array.append("#change-me-later")
        case .goalIntro:
            array.append("You can break big goals down into smaller goals. Each goal is locked to a timeframe.")
            array.append("Timeframes are distinct segments of time.")
            array.append("Namely, decades, years, months, weeks and days ☀️.")
            array.append("🕦🕣🕗")
        case .goalContext:
            array.append("Let's say you have always dreamed of going to Envisionary University (EU), the most prestigious planning institution in the entire world.")
            array.append("Buttttt it's super difficult to get into 🤓, so you're going to have to map out a pretty detailed plan. 💪")
            array.append("You first decide that you want to go to this ambitious school.")
            array.append("Awesome. 🤩🤩🤩")
            array.append("You're also going to need to build up your resume and CV, do some study prep, and then take all 37 😵‍💫 certification exams!")
            array.append("You'll then need to apply, go through the 23 stage interview process, and be the 1 in 47,000 that get accepted.")
            array.append("It's gonna be a lot of work 👀, but if we split it up into small bites, you'll get there in no time.")
            array.append("And you have a secret weapon... this app!")
            array.append("💥💥💥")
        case .goalSetup:
            array.append("We're gonna do a full send and create your path to victory 😎")
            array.append("Go ahead and add each goal.")
            array.append("Start at the top (your decade goal) and move down the tree 🌳.")
            array.append("Something to keep in mind: As timeframe goes ⬇️, specificity goes ⬆️")
        case .habit:
            array.append("Habits are great for when you want do something over and over again...")
            array.append("🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁")
            array.append("😸")
            array.append("They are tied to schedules... like once a day, once a week, or on weekends.")
            array.append("Let's add a few habits. 💁")
            array.append("And no worries 👍. You can change them later.")
        case .session:
            array.append("And...")
            array.append("plans...")
            array.append("always...")
            array.append("change...")
            array.append("😬😬😬")
            array.append("Pick a timeframe and a date, and then sessions automatically gathers everything you have planned for that period. 🦄")
            array.append("You'll be able to align big goals with your core values. ❤️")
            array.append("You're also able to push off, edit, or delete anything for maximum flexibility 🤸")
            array.append("And... instead of doing New Year's resolutions... you can dynamically evaluate life and goals however frequently you want.")
            array.append("#RIP-NY-Resolutions 🧟‍♀️🧟‍♀️🧟‍♀️")
            array.append("Try it out when you get a minute. It's soooooo effective.")
        case .home:
            array.append("So much execute, all in one place. \n\n✅☑️✅☑️✅☑️✅")
            array.append("You'll see the goals and habits that are happening now, as well as anything you've marked as favorites.")
            array.append("Home is also really good at reminding you to do things like...")
            array.append("Review your values ❤️")
            array.append("Write in your journal 📓")
            array.append("Do a planning session 😎")
            array.append("and so on...")
            array.append("Think of it like the proactive assistant you always wanted 🥹🥹🥹")
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
        case .garduated:
            array.append("10 years later")
            array.append("......... ......... What's that sound? ")
            array.append("......... It's music... It's definitely music.")
            array.append("Is that... Pomp and Circumtance? It must be! 🎶 🎶 🎶 🎶 🎻 🎻 🎻")
            array.append("Wait... this is your graduation! 👩‍🎓👩‍🎓👩‍🎓")
            array.append("You were able to successfully complete the grueling certifications, apply to Envisionary University, and get accepted! And turns out, you graduated top of your class. Congratulations!!!")
            array.append("You shake hands with the dean and they make you promise something.")
            array.append("'Go forward in life, implementing the tools you learned at EU.'")
            array.append("By doing so, you will be able to become whatever you can dream of.")
            array.append("And as such, it is now bestowed upon you, the keys to the application. Happy graduation, and let's get planning.")
//        case .stats:
//            <#code#>
//        case .prompt:
//            <#code#>
//        case .recurrence:
//            <#code#>
        default:
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
}
