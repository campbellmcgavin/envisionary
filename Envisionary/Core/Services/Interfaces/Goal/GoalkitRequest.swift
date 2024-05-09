//
//  GoalkitRequest.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/29/24.
//

import SwiftUI

struct GoalKit: Hashable {
    var priority: PriorityType
    var aspect: String
    var image: ExampleImages
    var superItem: GoalKitParentItem
    var items: [GoalKitItem]
    
    static func GetDayOffset(id: Int, items: [GoalKitItem]) -> Int{
        
        var cycle = 0
        var offset = 0
        var localId = id
        
        while cycle < 10{
            cycle = cycle + 1
            if let item = items.first(where: { $0.id == localId }) {
                offset = offset + item.start
                localId = item.parentId
            }
            else{
                break
            }
        }

        return offset
    }
}

struct GoalKitItem: Equatable, Hashable {
    var id: Int
    var parentId: Int
    var title: String
    var start: Int
    var end: Int
    
}

struct GoalKitParentItem: Equatable, Hashable {
    var title: String
    var description: String
}



extension GoalKit{
    
    static let template =
        GoalKit(priority: .high,
            aspect: AspectType.academic.toString(),
            image: .harvard,
            superItem: GoalKitParentItem(title: "title", description: "description."),
            items: [
                GoalKitItem(id: 1, parentId: 0, title:   "title", start: 0, end: 90),
                GoalKitItem(id: 2, parentId: 0, title:   "title", start: 90, end: 180),
                GoalKitItem(id: 3, parentId: 2, title:   "title", start: 0, end: 150),
                GoalKitItem(id: 4, parentId: 3, title:   "title", start: 0, end: 62),
                GoalKitItem(id: 5, parentId: 4, title:   "title", start: 30, end: 2),
                GoalKitItem(id: 6, parentId: 4, title:   "title", start: 45, end: 90),
                GoalKitItem(id: 7, parentId: 4, title:   "title", start: 60, end: 90),
                GoalKitItem(id: 8, parentId: 3, title:   "title", start: 60, end: 60),
                GoalKitItem(id: 9, parentId: 3, title:   "title", start: 120, end: 30),
                GoalKitItem(id: 10, parentId: 0, title:  "title", start: 180, end: 360),
                GoalKitItem(id: 11, parentId: 10, title: "title", start: 0, end: 60),
                GoalKitItem(id: 12, parentId: 11, title: "title", start: 60, end: 60),
                GoalKitItem(id: 13, parentId: 11, title: "title", start: 60, end: 60),
                GoalKitItem(id: 14, parentId: 11, title: "title", start: 60, end: 60),
                GoalKitItem(id: 15, parentId: 0, title:  "title", start: 400, end: 800),
            ])
    
    static let harvard =
        GoalKit(priority: .high,
             aspect: AspectType.academic.toString(),
             image: .harvard,
             superItem: GoalKitParentItem(title: "Get a Harvard MBA", description: "Go to Harvard for my Masters in Business Administration"),
             items: [
             GoalKitItem(id: 1, parentId: 0, title: "Determine resume weaknesses", start: 0, end: 90),
             GoalKitItem(id: 2, parentId: 0, title: "Study and take GMAT", start: 90, end: 180),
             GoalKitItem(id: 3, parentId: 2, title: "Take GMAT prep course", start: 0, end: 150),
             GoalKitItem(id: 4, parentId: 3, title: "Study for the quant segment", start: 0, end: 62),
             GoalKitItem(id: 5, parentId: 4, title: "Practice Test 1", start: 30, end: 2),
             GoalKitItem(id: 6, parentId: 4, title: "Practice Test 2", start: 45, end: 2),
             GoalKitItem(id: 7, parentId: 4, title: "Practice Test 3", start: 60, end: 2),
             GoalKitItem(id: 8, parentId: 3, title: "Study for Verbal Reasoning segment", start: 60, end: 60),
             GoalKitItem(id: 9, parentId: 3, title: "Study for integrated reasoning segment", start: 120, end: 30),
             GoalKitItem(id: 10, parentId: 0, title: "Build up a small revenue producing startup", start: 180, end: 360),
             GoalKitItem(id: 11, parentId: 10, title: "Conception and marketing", start: 0, end: 60),
             GoalKitItem(id: 12, parentId: 11, title: "Determine brand", start: 60, end: 60),
             GoalKitItem(id: 13, parentId: 11, title: "Market research", start: 60, end: 60),
             GoalKitItem(id: 14, parentId: 11, title: "Product launch", start: 60, end: 60),
             GoalKitItem(id: 15, parentId: 0, title: "Invest time into local service organization.", start: 60, end: 60),
             ])
    
    static let humanRights =
        GoalKit(priority: .high,
            aspect: AspectType.academic.toString(),
            image: .humanRights,
            superItem: GoalKitParentItem(title: "Found a human rights Org.", description: "I want to make the world a better place, and I commit to building a organization to focus on the rights of my fellow sisters and brothers."),
            items: [
            GoalKitItem(id: 1, parentId: 0, title: "Mission statement and purpose", start: 0, end: 90),
            GoalKitItem(id: 2, parentId: 0, title: "Find partner and layout leadership team.", start: 90, end: 180),
            GoalKitItem(id: 3, parentId: 2, title: "Branding and product/service declaration", start: 0, end: 150),
            GoalKitItem(id: 4, parentId: 3, title: "Determine brand and audience", start: 0, end: 62),
            GoalKitItem(id: 5, parentId: 4, title: "Branding", start: 30, end: 2),
            GoalKitItem(id: 6, parentId: 4, title: "Geographic region selection", start: 45, end: 90),
            GoalKitItem(id: 7, parentId: 4, title: "Contract out website design", start: 60, end: 90),
            GoalKitItem(id: 8, parentId: 3, title: "Contract out website", start: 60, end: 60),
            GoalKitItem(id: 9, parentId: 3, title: "End of year evaluation of purpose", start: 120, end: 30),
            GoalKitItem(id: 10, parentId: 0, title: "Build out the program", start: 180, end: 360),
            GoalKitItem(id: 11, parentId: 10, title: "Organize and host first event", start: 0, end: 60),
            GoalKitItem(id: 12, parentId: 11, title: "Publicity and outreach", start: 60, end: 60),
            GoalKitItem(id: 13, parentId: 11, title: "Supply and volunteer recruiting", start: 60, end: 60),
            GoalKitItem(id: 14, parentId: 11, title: "Host event. Min attendance 1800", start: 60, end: 60),
            GoalKitItem(id: 15, parentId: 0, title: "Expand region", start: 400, end: 800),
            ])
    
    static let travel =
        GoalKit(priority: .high,
            aspect: AspectType.academic.toString(),
            image: .travel,
            superItem: GoalKitParentItem(title: "Travel to all 7 Continents", description: "I am going to travel the world! Bucketlist is becoming reality 😎"),
            items: [
            GoalKitItem(id: 1, parentId: 0, title:   "Explore North America", start: 0, end: 90),
            GoalKitItem(id: 2, parentId: 0, title:   "Europe", start: 90, end: 180),
            GoalKitItem(id: 3, parentId: 2, title:   "Western Europe", start: 0, end: 150),
            GoalKitItem(id: 4, parentId: 3, title:   "United Kingdom", start: 0, end: 62),
            GoalKitItem(id: 5, parentId: 4, title:   "Ireland", start: 30, end: 2),
            GoalKitItem(id: 6, parentId: 4, title:   "England", start: 45, end: 90),
            GoalKitItem(id: 7, parentId: 4, title:   "Scotland", start: 60, end: 90),
            GoalKitItem(id: 8, parentId: 3, title:   "Spain and Portugal", start: 60, end: 60),
            GoalKitItem(id: 9, parentId: 3, title:   "France, Germany, Italy", start: 120, end: 30),
            GoalKitItem(id: 10, parentId: 0, title:  "South America", start: 180, end: 360),
            GoalKitItem(id: 11, parentId: 10, title: "South Central America", start: 0, end: 60),
            GoalKitItem(id: 12, parentId: 11, title: "Mexico", start: 60, end: 60),
            GoalKitItem(id: 13, parentId: 11, title: "Guatemala", start: 60, end: 60),
            GoalKitItem(id: 14, parentId: 11, title: "Honduras", start: 60, end: 60),
            GoalKitItem(id: 15, parentId: 0, title:  "East Asia", start: 400, end: 800),
            ])
    
    static let olympics =
        GoalKit(priority: .high,
            aspect: AspectType.academic.toString(),
            image: .olympics,
            superItem: GoalKitParentItem(title: "Compete in Olympics as Gymnast", description: "Compete as a gymnast in the Olympics"),
            items: [
                GoalKitItem(id: 1, parentId: 0, title:   "Try out for Olympic Team", start: 0, end: 90),
                GoalKitItem(id: 2, parentId: 0, title:   "Train and complete in local competitions", start: 90, end: 180),
                GoalKitItem(id: 3, parentId: 2, title:   "Compete at the local (US) qualifier competition.", start: 0, end: 150),
                GoalKitItem(id: 4, parentId: 3, title:   "Fly out to Phoenix for first competition", start: 0, end: 62),
                GoalKitItem(id: 5, parentId: 4, title:   "Day 1 of competition", start: 30, end: 2),
                GoalKitItem(id: 6, parentId: 4, title:   "Day 2 of competition", start: 45, end: 90),
                GoalKitItem(id: 7, parentId: 4, title:   "Day 3 of competition", start: 60, end: 90),
                GoalKitItem(id: 8, parentId: 3, title:   "Fly to CA for 2nd qualifier", start: 60, end: 60),
                GoalKitItem(id: 9, parentId: 3, title:   "Florida for qualifier 3 of 3", start: 120, end: 30),
                GoalKitItem(id: 10, parentId: 0, title:  "Training and getting body to ideal", start: 180, end: 360),
                GoalKitItem(id: 11, parentId: 10, title: "Increase 18 pounds of muscle", start: 0, end: 60),
                GoalKitItem(id: 12, parentId: 11, title: "Weight, exercise, diet routine", start: 60, end: 60),
                GoalKitItem(id: 13, parentId: 11, title: "Weight, exercise, diet routine", start: 60, end: 60),
                GoalKitItem(id: 14, parentId: 11, title: "Weight, exercise, diet routine", start: 60, end: 60),
                GoalKitItem(id: 15, parentId: 0, title:  "Compete in the Olympics!", start: 400, end: 800),
            ])
    
    
    static let company =
        GoalKit(priority: .high,
            aspect: AspectType.academic.toString(),
            image: .company,
            superItem: GoalKitParentItem(title: "Start up my dream company", description: "Start up my dream company"),
            items: [
                GoalKitItem(id: 1, parentId: 0, title:   "Mission statement, business model, market research", start: 0, end: 90),
                GoalKitItem(id: 2, parentId: 0, title:   "Establish minimum viable product", start: 90, end: 180),
                GoalKitItem(id: 3, parentId: 2, title:   "Design product", start: 0, end: 150),
                GoalKitItem(id: 4, parentId: 3, title:   "Send off for rapid prototyping", start: 0, end: 62),
                GoalKitItem(id: 5, parentId: 4, title:   "3d print", start: 30, end: 2),
                GoalKitItem(id: 6, parentId: 4, title:   "Assemble", start: 45, end: 90),
                GoalKitItem(id: 7, parentId: 4, title:   "Evaluate", start: 60, end: 90),
                GoalKitItem(id: 8, parentId: 3, title:   "Prototype round 2", start: 60, end: 60),
                GoalKitItem(id: 9, parentId: 3, title:   "Prototype round 3", start: 120, end: 30),
                GoalKitItem(id: 10, parentId: 0, title:  "Secure funding", start: 180, end: 360),
                GoalKitItem(id: 11, parentId: 10, title: "Secure pitches", start: 0, end: 60),
                GoalKitItem(id: 12, parentId: 11, title: "Pitch 1", start: 60, end: 60),
                GoalKitItem(id: 13, parentId: 11, title: "Pitch 2", start: 60, end: 60),
                GoalKitItem(id: 14, parentId: 11, title: "Pitch 3", start: 60, end: 60),
                GoalKitItem(id: 15, parentId: 0, title:  "Market launch", start: 400, end: 800),
            ])
    
    
    static let dreamHome =
        GoalKit(priority: .high,
            aspect: AspectType.academic.toString(),
            image: .dreamHome,
            superItem: GoalKitParentItem(title: "Build my dream home", description: "Big and beautiful (or small and comfy). It's just right and it's all mine."),
            items: [
                GoalKitItem(id: 1, parentId: 0, title:   "Study designs and architecture", start: 0, end: 90),
                GoalKitItem(id: 2, parentId: 0, title:   "Build home", start: 90, end: 180),
                GoalKitItem(id: 3, parentId: 2, title:   "Foundation and framing", start: 0, end: 150),
                GoalKitItem(id: 4, parentId: 3, title:   "Pour foundation", start: 0, end: 62),
                GoalKitItem(id: 5, parentId: 4, title:   "Clear ground and dig hole", start: 30, end: 2),
                GoalKitItem(id: 6, parentId: 4, title:   "Pour concrete", start: 45, end: 90),
                GoalKitItem(id: 7, parentId: 4, title:   "Let set", start: 60, end: 90),
                GoalKitItem(id: 8, parentId: 3, title:   "Frame out", start: 60, end: 60),
                GoalKitItem(id: 9, parentId: 3, title:   "Windows and doors", start: 120, end: 30),
                GoalKitItem(id: 10, parentId: 0, title:  "Interior space", start: 180, end: 360),
                GoalKitItem(id: 11, parentId: 10, title: "Rough-in", start: 0, end: 60),
                GoalKitItem(id: 12, parentId: 11, title: "Electrical", start: 60, end: 60),
                GoalKitItem(id: 13, parentId: 11, title: "Plumbing", start: 60, end: 60),
                GoalKitItem(id: 14, parentId: 11, title: "Drywall", start: 60, end: 60),
                GoalKitItem(id: 15, parentId: 0, title:  "Landscaping", start: 400, end: 800),
            ])
    
    
    static let executive =
        GoalKit(priority: .high,
            aspect: AspectType.academic.toString(),
            image: .executive,
            superItem: GoalKitParentItem(title: "Become a C-Suite Executive", description: "Long hours makes big salary"),
            items: [
                GoalKitItem(id: 1, parentId: 0, title:   "Low-level management position with 5+ reports", start: 0, end: 90),
                GoalKitItem(id: 2, parentId: 0, title:   "Professional MBA", start: 90, end: 180),
                GoalKitItem(id: 3, parentId: 2, title:   "Semester 1", start: 0, end: 150),
                GoalKitItem(id: 4, parentId: 3, title:   "Study for midterm exams", start: 0, end: 62),
                GoalKitItem(id: 5, parentId: 4, title:   "Take exam 1", start: 30, end: 2),
                GoalKitItem(id: 6, parentId: 4, title:   "Take exam 2", start: 45, end: 90),
                GoalKitItem(id: 7, parentId: 4, title:   "Take exam 3", start: 60, end: 90),
                GoalKitItem(id: 8, parentId: 3, title:   "Group Project", start: 60, end: 60),
                GoalKitItem(id: 9, parentId: 3, title:   "Final Exam Period", start: 120, end: 30),
                GoalKitItem(id: 10, parentId: 0, title:  "Climb the corporate ladder", start: 180, end: 360),
                GoalKitItem(id: 11, parentId: 10, title: "Land a mid-level P & L position at a tech company", start: 0, end: 60),
                GoalKitItem(id: 12, parentId: 11, title: "Master basic job responsibilities", start: 60, end: 60),
                GoalKitItem(id: 13, parentId: 11, title: "Get to know key players", start: 60, end: 60),
                GoalKitItem(id: 14, parentId: 11, title: "Propose first major initiative", start: 60, end: 60),
                GoalKitItem(id: 15, parentId: 0, title:  "Become CFO", start: 400, end: 800),
            ])
    
    
    static let influencer =
        GoalKit(priority: .high,
            aspect: AspectType.academic.toString(),
            image: .influencer,
            superItem: GoalKitParentItem(title: "Become influencer with 10M Followers", description: "Almost as big as Taylor Swift"),
            items: [
                GoalKitItem(id: 1, parentId: 0, title:   "Determine market space and competition", start: 0, end: 90),
                GoalKitItem(id: 2, parentId: 0, title:   "Start channel", start: 90, end: 180),
                GoalKitItem(id: 3, parentId: 2, title:   "Create branding, logos and sound bites.", start: 0, end: 150),
                GoalKitItem(id: 4, parentId: 3, title:   "Send off ideas to marketing company", start: 0, end: 62),
                GoalKitItem(id: 5, parentId: 4, title:   "Evaluate designs", start: 30, end: 2),
                GoalKitItem(id: 6, parentId: 4, title:   "Iteration on leading design", start: 45, end: 90),
                GoalKitItem(id: 7, parentId: 4, title:   "Finalize", start: 60, end: 90),
                GoalKitItem(id: 8, parentId: 3, title:   "Setup recording studio", start: 60, end: 60),
                GoalKitItem(id: 9, parentId: 3, title:   "Shoot first test episode", start: 120, end: 30),
                GoalKitItem(id: 10, parentId: 0, title:  "1M Follower Milestone", start: 180, end: 360),
                GoalKitItem(id: 11, parentId: 10, title: "1 video per week, double viewership each week", start: 0, end: 60),
                GoalKitItem(id: 12, parentId: 11, title: "Collaborate with another influencer in the space", start: 60, end: 60),
                GoalKitItem(id: 13, parentId: 11, title: "Free product giveaway", start: 60, end: 60),
                GoalKitItem(id: 14, parentId: 11, title: "Partner with a musician for increased viewership", start: 60, end: 60),
                GoalKitItem(id: 15, parentId: 0, title:  "10M Follower Milestone", start: 400, end: 800),
            ])
    
    static let artist =
        GoalKit(priority: .high,
            aspect: AspectType.academic.toString(),
            image: .artist,
            superItem: GoalKitParentItem(title: "Get artwork into dream gallery", description: "Probably somewhere in New York... or LA... or Italy"),
            items: [
                GoalKitItem(id: 1, parentId: 0, title:   "Finish art school and figure out my style", start: 0, end: 90),
                GoalKitItem(id: 2, parentId: 0, title:   "Study competition. Determine Business model", start: 90, end: 180),
                GoalKitItem(id: 3, parentId: 2, title:   "Study similar artists", start: 0, end: 150),
                GoalKitItem(id: 4, parentId: 3, title:   "Trip to NY to visit all the art galleries", start: 0, end: 62),
                GoalKitItem(id: 5, parentId: 4, title:   "Hauser & Wirth", start: 30, end: 2),
                GoalKitItem(id: 6, parentId: 4, title:   "Gagosian", start: 45, end: 90),
                GoalKitItem(id: 7, parentId: 4, title:   "David Zwirner", start: 60, end: 90),
                GoalKitItem(id: 8, parentId: 3, title:   "Imitate and iterate", start: 60, end: 60),
                GoalKitItem(id: 9, parentId: 3, title:   "Get feedback from my network", start: 120, end: 30),
                GoalKitItem(id: 10, parentId: 0, title:  "Get into my first Gallery", start: 180, end: 360),
                GoalKitItem(id: 11, parentId: 10, title: "Networking", start: 0, end: 60),
                GoalKitItem(id: 12, parentId: 11, title: "Reach out to all my contacts", start: 60, end: 60),
                GoalKitItem(id: 13, parentId: 11, title: "Give pitch and presentation", start: 60, end: 60),
                GoalKitItem(id: 14, parentId: 11, title: "Solidify first gallery spot", start: 60, end: 60),
                GoalKitItem(id: 15, parentId: 0, title:  "Land in major gallery in major city", start: 400, end: 800),
            ])
    
    
    static let philanthropist =
        GoalKit(priority: .high,
            aspect: AspectType.academic.toString(),
            image: .philanthropist,
            superItem: GoalKitParentItem(title: "Start international charity org", description: "Blessing lives and defeating the bad guy."),
            items: [
                GoalKitItem(id: 1, parentId: 0, title:   "Determine mission statement and purpose", start: 0, end: 90),
                GoalKitItem(id: 2, parentId: 0, title:   "Find partner and layout leadership team.", start: 90, end: 180),
                GoalKitItem(id: 3, parentId: 2, title:   "Branding and product/service declaration", start: 0, end: 150),
                GoalKitItem(id: 4, parentId: 3, title:   "Determine brand and audience", start: 0, end: 62),
                GoalKitItem(id: 5, parentId: 4, title:   "Branding", start: 30, end: 2),
                GoalKitItem(id: 6, parentId: 4, title:   "Geographic region selection", start: 45, end: 90),
                GoalKitItem(id: 7, parentId: 4, title:   "Recap and iterations if necessary", start: 60, end: 90),
                GoalKitItem(id: 8, parentId: 3, title:   "Contract out website", start: 60, end: 60),
                GoalKitItem(id: 9, parentId: 3, title:   "End of year evaluation of purpose", start: 120, end: 30),
                GoalKitItem(id: 10, parentId: 0, title:  "Build out the program", start: 180, end: 360),
                GoalKitItem(id: 11, parentId: 10, title: "Organize and host first event", start: 0, end: 60),
                GoalKitItem(id: 12, parentId: 11, title: "Publicity and outreach", start: 60, end: 60),
                GoalKitItem(id: 13, parentId: 11, title: "Supply and volunteer recruiting", start: 60, end: 60),
                GoalKitItem(id: 14, parentId: 11, title: "Host event. Min attendance 1800", start: 60, end: 60),
                GoalKitItem(id: 15, parentId: 0, title:  "Expand region", start: 400, end: 800),
            ])
    
    
    static let politician =
        GoalKit(priority: .high,
            aspect: AspectType.academic.toString(),
            image: .politician,
            superItem: GoalKitParentItem(title: "Become a congressperson", description: "Let's make some laws and stuff."),
            items: [
                GoalKitItem(id: 1, parentId: 0, title:   "Determine my platform", start: 0, end: 90),
                GoalKitItem(id: 2, parentId: 0, title:   "Run for mayor", start: 90, end: 180),
                GoalKitItem(id: 3, parentId: 2, title:   "Run the campaign", start: 0, end: 150),
                GoalKitItem(id: 4, parentId: 3, title:   "Find campaign manager and committee", start: 0, end: 62),
                GoalKitItem(id: 5, parentId: 4, title:   "Sign on campaign manager", start: 30, end: 2),
                GoalKitItem(id: 6, parentId: 4, title:   "Get volunteers set up on phones", start: 45, end: 90),
                GoalKitItem(id: 7, parentId: 4, title:   "Print signs and materials", start: 60, end: 90),
                GoalKitItem(id: 8, parentId: 3, title:   "Locally-televised debated", start: 60, end: 60),
                GoalKitItem(id: 9, parentId: 3, title:   "Host fundraising event", start: 120, end: 30),
                GoalKitItem(id: 10, parentId: 0, title:  "Campaign for congress", start: 180, end: 360),
                GoalKitItem(id: 11, parentId: 10, title: "Raise awareness", start: 0, end: 60),
                GoalKitItem(id: 12, parentId: 11, title: "Fundraising within region", start: 60, end: 60),
                GoalKitItem(id: 13, parentId: 11, title: "Attend convention", start: 60, end: 60),
                GoalKitItem(id: 14, parentId: 11, title: "Campaign across the region", start: 60, end: 60),
                GoalKitItem(id: 15, parentId: 0, title:  "Election year", start: 400, end: 800),
            ])

}


struct GoalKits{
    static let kits: [GoalKit] = [
        GoalKit.harvard,
        GoalKit.humanRights,
        GoalKit.travel,
        GoalKit.olympics,
        GoalKit.company,
        GoalKit.dreamHome,
        GoalKit.executive,
        GoalKit.influencer,
        GoalKit.artist,
        GoalKit.philanthropist,
        GoalKit.politician
    ]
}




