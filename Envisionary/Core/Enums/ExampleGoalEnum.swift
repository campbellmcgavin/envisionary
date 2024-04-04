//
//  ExampleGoalEnum.swift
//  Envisionary
//
//  Created by Campbell McGavin on 7/17/23.
//

import SwiftUI

enum ExampleGoalEnum: Int, CaseIterable {
    case decade = 0
    case year0 = 1
    case year1 = 2
    case year1_month1 = 3
    case year1_month1_week1 = 4
    case year1_month1_week1_day1 = 5
    case year1_month1_week1_day2 = 6
    case year1_month1_week1_day3 = 7
    case year1_month1_week2 = 8
    case year1_month1_week3 = 9
    case year2 = 10
    case year2_month1 = 11
    case year2_month1_week1 = 12
    case year2_month1_week2 = 13
    case year2_month1_week3 = 14
    case year3 = 15
    
    
    func toGoal(parentId: UUID?, superId: UUID?, imageId: UUID?, archetype: ArchetypeType) -> CreateGoalRequest {
        switch self{
        case .decade:
            return CreateGoalRequest(title: self.toTitle(archetype: archetype), description: self.toDescription(archetype: archetype), priority: .critical, startDate: Date(), endDate: self.toEndDate(date: Date()), percentComplete: 0, image: imageId, aspect: AspectType.academic.toString(), parent: parentId, superId: superId)
            
        case .year0:
            return CreateGoalRequest(title: self.toTitle(archetype: archetype), description: self.toDescription(archetype: archetype), priority: .critical, startDate: Date(), endDate: self.toEndDate(date: Date()), percentComplete: 0, image: imageId, aspect: AspectType.academic.toString(), parent: parentId, superId: superId)
            
        case .year1:
            return CreateGoalRequest(title: self.toTitle(archetype: archetype), description: self.toDescription(archetype: archetype), priority: .critical, startDate: Date().AdvanceYear(forward: true), endDate: self.toEndDate(date: Date().AdvanceYear(forward: true)), percentComplete: 0, image: imageId, aspect: AspectType.academic.toString(), parent: parentId, superId: superId)
        case .year1_month1:
            let date = Date().AdvanceYear(forward: true)
            return CreateGoalRequest(title: self.toTitle(archetype: archetype), description: self.toDescription(archetype: archetype), priority: .critical, startDate: date, endDate: self.toEndDate(date: date), percentComplete: 0, image: imageId, aspect: AspectType.academic.toString(), parent: parentId, superId: superId)
        case .year1_month1_week1:
            let date = Date().AdvanceYear(forward: true)
            return CreateGoalRequest(title: self.toTitle(archetype: archetype), description: self.toDescription(archetype: archetype), priority: .critical, startDate: date, endDate: self.toEndDate(date: date), percentComplete: 0, image: imageId, aspect: AspectType.academic.toString(), parent: parentId, superId: superId)
        case .year1_month1_week1_day1:
            let date = Date().AdvanceYear(forward: true)
            return CreateGoalRequest(title: self.toTitle(archetype: archetype), description: self.toDescription(archetype: archetype), priority: .moderate, startDate: Date(), endDate: self.toEndDate(date: date), percentComplete: 0, image: imageId, aspect: AspectType.academic.toString(), parent: parentId, superId: superId)
        case .year1_month1_week1_day2:
            let date = Date().AdvanceYear(forward: true).AdvanceDay(forward: true)
            return CreateGoalRequest(title: self.toTitle(archetype: archetype), description: self.toDescription(archetype: archetype), priority: .high, startDate: date, endDate: self.toEndDate(date: date), percentComplete: 0, image: imageId, aspect: AspectType.academic.toString(), parent: parentId, superId: superId)
        case .year1_month1_week1_day3:
            let date = Date().AdvanceYear(forward: true).AdvanceWeek(forward: true)
            return CreateGoalRequest(title: self.toTitle(archetype: archetype), description: self.toDescription(archetype: archetype), priority: .low, startDate: date, endDate: self.toEndDate(date: date), percentComplete: 0, image: imageId, aspect: AspectType.academic.toString(), parent: parentId, superId: superId)
        case .year1_month1_week2:
            let date = Date().AdvanceYear(forward: true).AdvanceWeek(forward: true).AdvanceWeek(forward: true).AdvanceWeek(forward: true)
            return CreateGoalRequest(title: self.toTitle(archetype: archetype), description: self.toDescription(archetype: archetype), priority: .critical, startDate: date, endDate: self.toEndDate(date: date), percentComplete: 0, image: imageId, aspect: AspectType.academic.toString(), parent: parentId, superId: superId)
        case .year1_month1_week3:
            let date = Date().AdvanceYear(forward: true).AdvanceMonth(forward: true).AdvanceWeek(forward: true)
            return CreateGoalRequest(title: self.toTitle(archetype: archetype), description: self.toDescription(archetype: archetype), priority: .critical, startDate: date, endDate: self.toEndDate(date: date), percentComplete: 0, image: imageId, aspect: AspectType.academic.toString(), parent: parentId, superId: superId)
        case .year2:
            let date = Date().AdvanceDate(timeframe: .year, forward: true,count: 3)
            return CreateGoalRequest(title: self.toTitle(archetype: archetype), description: self.toDescription(archetype: archetype), priority: .critical, startDate: date, endDate: self.toEndDate(date:date), percentComplete: 0, image: imageId, aspect: AspectType.academic.toString(), parent: parentId, superId: superId)
        case .year2_month1:
            let date = Date().AdvanceDate(timeframe: .year, forward: true,count: 3).AdvanceMonth(forward: true)
            return CreateGoalRequest(title: self.toTitle(archetype: archetype), description: self.toDescription(archetype: archetype), priority: .critical, startDate: date, endDate: self.toEndDate(date: date), percentComplete: 0, image: imageId, aspect: AspectType.academic.toString(), parent: parentId, superId: superId)
        case .year2_month1_week1:
            let date = Date().AdvanceDate(timeframe: .year, forward: true,count: 3).AdvanceMonth(forward: true).AdvanceMonth(forward: true)
            return CreateGoalRequest(title: self.toTitle(archetype: archetype), description: self.toDescription(archetype: archetype), priority: .critical, startDate: date, endDate: self.toEndDate(date:date), percentComplete: 0, image: imageId, aspect: AspectType.academic.toString(), parent: parentId, superId: superId)
        case .year2_month1_week2:
            let date = Date().AdvanceDate(timeframe: .year, forward: true,count: 3).AdvanceMonth(forward: true).AdvanceMonth(forward: true).AdvanceWeek(forward: true)
            return CreateGoalRequest(title: self.toTitle(archetype: archetype), description: self.toDescription(archetype: archetype), priority: .critical, startDate: date, endDate: self.toEndDate(date: date), percentComplete: 0, image: imageId, aspect: AspectType.academic.toString(), parent: parentId, superId: superId)
        case .year2_month1_week3:
            let date = Date().AdvanceDate(timeframe: .year, forward: true,count: 3).AdvanceMonth(forward: true).AdvanceMonth(forward: true).AdvanceMonth(forward: true)
            return CreateGoalRequest(title: self.toTitle(archetype: archetype), description: self.toDescription(archetype: archetype), priority: .critical, startDate: date, endDate: self.toEndDate(date: date), percentComplete: 0, image: imageId, aspect: AspectType.academic.toString(), parent: parentId, superId: superId)
        case .year3:
            let date = Date().AdvanceDate(timeframe: .year, forward: true,count: 7)
            return CreateGoalRequest(title: self.toTitle(archetype: archetype), description: self.toDescription(archetype: archetype), priority: .critical, startDate: date, endDate: self.toEndDate(date: date), percentComplete: 0, image: imageId, aspect: AspectType.academic.toString(), parent: parentId, superId: superId)
        }
    }
    
    func toTitle(archetype: ArchetypeType) -> String{
        switch self {
        case .decade:
            switch archetype {
            case .Achiever: return "Get a Harvard MBA"
            case .Activist: return "Found a human rights Org."
            case .Adventurer: return "Travel to all 7 Continents"
            case .Athlete: return "Compete in Olympics as Gymnast"
            case .Entrepreneur: return "Start up my dream company"
            case .Essentialist: return "Build my dream home"
            case .Executive: return "Become a C-Suite Executive"
            case .Influencer: return "Become influencer with 30M Followers"
            case .Artist: return "Get artwork into dream gallery"
            case .Philanthropist: return "Start international charity org"
            case .Politician: return "Become a congressperson"
            case .Student: return "Go to Harvard for my Masters"
            }
            
        case .year0:
            switch archetype {
            case .Achiever: return "Determine resume weaknesses"
            case .Activist: return "Mission statement and purpose"
            case .Adventurer: return "Explore North America"
            case .Athlete: return "Try out for Olympic Team"
            case .Entrepreneur: return "Mission statement, business model, market research"
            case .Essentialist: return "Study designs and architecture"
            case .Executive: return "Low-level management position with 5+ reports"
            case .Influencer: return "Determine market space and competition"
            case .Artist: return "Finish art school and figure out my style"
            case .Philanthropist: return "Determine mission statement and purpose"
            case .Politician: return "Determine my platform"
            case .Student: return "Determine the weak points on my resume and CV"
            }
        case .year1:
            switch archetype{
            case .Achiever: return "Study and take GMAT"
            case .Activist: return "Find partner and layout leadership team."
            case .Adventurer: return "Europe"
            case .Athlete: return "Train and complete in local competitions"
            case .Entrepreneur: return "Establish minimum viable product"
            case .Essentialist: return "Build home"
            case .Executive: return "Professional MBA"
            case .Influencer: return "Start channel"
            case .Artist: return "Study competition. Determine Business model"
            case .Philanthropist: return "Find partner and layout leadership team."
            case .Politician: return "Run for mayor"
            case .Student: return "Study and take GMAT"
            }
        case .year1_month1:
            switch archetype{
            case .Achiever: return "Take GMAT prep course"
            case .Activist: return "Branding and product/service declaration"
            case .Adventurer: return "Western Europe"
            case .Athlete: return "Compete at the local (US) qualifier competition."
            case .Entrepreneur: return "Design product"
            case .Essentialist: return "Foundation and framing"
            case .Executive: return "Semester 1"
            case .Influencer: return "Create branding, logos and sound bites."
            case .Artist: return "Study similar artists"
            case .Philanthropist: return "Branding and product/service declaration"
            case .Politician: return "Run the campaign"
            case .Student: return "Take GMAT prep course"
            }
        case .year1_month1_week1:
            switch archetype{
            case .Achiever: return "Study for the quant segment"
            case .Activist: return "Determine brand and audience"
            case .Adventurer: return "United Kingdom"
            case .Athlete: return "Fly out to Phoenix for first competition"
            case .Entrepreneur: return "Send off for rapid prototyping"
            case .Essentialist: return "Pour foundation"
            case .Executive: return "Study for midterm exams"
            case .Influencer: return "Send off ideas to marketing company"
            case .Artist: return "Trip to NY to visit all the art galleries"
            case .Philanthropist: return "Determine brand and audience"
            case .Politician: return "Find campaign manager and committee"
            case .Student: return "Study for the quant segment"
            }
        case .year1_month1_week1_day1:
            switch archetype{
            case .Achiever: return "Practice Test 1"
            case .Activist: return "Branding"
            case .Adventurer: return "Ireland"
            case .Athlete: return "Day 1 of competition"
            case .Entrepreneur: return "3d print"
            case .Essentialist: return "Clear ground and dig hole"
            case .Executive: return "Take exam 1"
            case .Influencer: return "Evaluate designs"
            case .Artist: return "Hauser & Wirth"
            case .Philanthropist: return "Branding"
            case .Politician: return "Sign on campaign manager"
            case .Student: return "Practice Test 1"
            }
        case .year1_month1_week1_day2:
            switch archetype{
            case .Achiever: return "Practice Test 2"
            case .Activist: return "Geographic region selection"
            case .Adventurer: return "England"
            case .Athlete: return "Day 2 of competition"
            case .Entrepreneur: return "Assemble"
            case .Essentialist: return "Pour concrete"
            case .Executive: return "Take exam 2"
            case .Influencer: return "Iteration on leading design"
            case .Artist: return "Gagosian"
            case .Philanthropist: return "Geographic region selection"
            case .Politician: return "Get volunteers set up on phones"
            case .Student: return "Practice Test 2"
            }
        case .year1_month1_week1_day3:
            switch archetype{
            case .Achiever: return "Practice Test 3"
            case .Activist: return "Recap and iterations if necessary"
            case .Adventurer: return "Scotland"
            case .Athlete: return "Day 3 of competition"
            case .Entrepreneur: return "Evaluate"
            case .Essentialist: return "Let set"
            case .Executive: return "Take exam 3"
            case .Influencer: return "Finalize"
            case .Artist: return "David Zwirner"
            case .Philanthropist: return "Recap and iterations if necessary"
            case .Politician: return "Print signs and materials"
            case .Student: return "Practice Test 3"
            }
        case .year1_month1_week2:
            switch archetype{
            case .Achiever: return "Study for Verbal Reasoning segment"
            case .Activist: return "Contract out website"
            case .Adventurer: return "Spain and Portugal"
            case .Athlete: return "Fly to CA for 2nd qualifier"
            case .Entrepreneur: return "Prototype round 2"
            case .Essentialist: return "Frame out"
            case .Executive: return "Group Project"
            case .Influencer: return "Setup recording studio"
            case .Artist: return "Imitate and iterate"
            case .Philanthropist: return "Contract out website"
            case .Politician: return "Locally-televised debated"
            case .Student: return "Study for Verbal Reasoning segment"
            }
        case .year1_month1_week3:
            switch archetype{
            case .Achiever: return "Study for integrated reasoning segment"
            case .Activist: return "End of year evaluation of purpose"
            case .Adventurer: return "France, Germany, Italy"
            case .Athlete: return "Florida for qualifier 3 of 3"
            case .Entrepreneur: return "Prototype round 3"
            case .Essentialist: return "Windows and doors"
            case .Executive: return "Final Exam Period"
            case .Influencer: return "Shoot first test episode"
            case .Artist: return "Get feedback from my network"
            case .Philanthropist: return "End of year evaluation of purpose"
            case .Politician: return "Host fundraising event"
            case .Student: return "Study for integrated reasoning segment"
            }
        case .year2:
            switch archetype{
            case .Achiever: return "Build up a small revenue producing startup"
            case .Activist: return "Build out the program"
            case .Adventurer: return "South America"
            case .Athlete: return "Training and getting body to ideal"
            case .Entrepreneur: return "Secure funding"
            case .Essentialist: return "Interior space"
            case .Executive: return "Climb the corporate ladder"
            case .Influencer: return "1M Follower Milestone"
            case .Artist: return "Get into my first Gallery"
            case .Philanthropist: return "Build out the program"
            case .Politician: return "Campaign for congress"
            case .Student: return "Build up a small revenue producing startup"
            }
        case .year2_month1:
            switch archetype{
            case .Achiever: return "Conception and marketing"
            case .Activist: return "Organize and host first event"
            case .Adventurer: return "South Central America"
            case .Athlete: return "Increase 18 pounds of muscle"
            case .Entrepreneur: return "Secure pitches"
            case .Essentialist: return "Rough-in"
            case .Executive: return "Land a mid-level P & L position at a tech company"
            case .Influencer: return "1 video per week, double viewership each week"
            case .Artist: return "Networking"
            case .Philanthropist: return "Organize and host first event"
            case .Politician: return "Raise awareness"
            case .Student: return "Conception and marketing"
            }
        case .year2_month1_week1:
            switch archetype{
            case .Achiever: return "Determine brand"
            case .Activist: return "Publicity and outreach"
            case .Adventurer: return "Mexico"
            case .Athlete: return "Weight, exercise, diet routine"
            case .Entrepreneur: return "Pitch 1"
            case .Essentialist: return "Electrical"
            case .Executive: return "Master basic job responsibilities"
            case .Influencer: return "Collaborate with another influencer in the space"
            case .Artist: return "Reach out to all my contacts"
            case .Philanthropist: return "Publicity and outreach"
            case .Politician: return "Fundraising within region"
            case .Student: return "Determine brand"
            }
        case .year2_month1_week2:
            switch archetype{
            case .Achiever: return "Market research"
            case .Activist: return "Supply and volunteer recruiting"
            case .Adventurer: return "Guatemala"
            case .Athlete: return "Weight, exercise, diet routine"
            case .Entrepreneur: return "Pitch 2"
            case .Essentialist: return "Plumbing"
            case .Executive: return "Get to know key players"
            case .Influencer: return "Free product giveaway"
            case .Artist: return "Give pitch and presentation"
            case .Philanthropist: return "Supply and volunteer recruiting"
            case .Politician: return "Attend convention"
            case .Student: return "Market research"
            }
        case .year2_month1_week3:
            switch archetype{
            case .Achiever: return "Product launch"
            case .Activist: return "Host event. Min attendance 1800"
            case .Adventurer: return "Honduras"
            case .Athlete: return "Weight, exercise, diet routine"
            case .Entrepreneur: return "Pitch 3"
            case .Essentialist: return "Drywall"
            case .Executive: return "Propose first major initiative"
            case .Influencer: return "Partner with a musician for increased viewership"
            case .Artist: return "Solidify first gallery spot"
            case .Philanthropist: return "Host event. Min attendance 1800"
            case .Politician: return "Campaign across the region"
            case .Student: return "Product launch"
            }
        case .year3:
            switch archetype{
            case .Achiever: return "Invest time into local service organization."
            case .Activist: return "Expand region"
            case .Adventurer: return "East Asia"
            case .Athlete: return "Compete in the Olympics!"
            case .Entrepreneur: return "Market launch"
            case .Essentialist: return "Landscaping"
            case .Executive: return "Become CFO"
            case .Influencer: return "10M Follower Milestone"
            case .Artist: return "Land in major gallery in major city"
            case .Philanthropist: return "Expand region"
            case .Politician: return "Election year"
            case .Student: return "Invest time into local service org."
            }
        }
    }
    
    func toDescription(archetype: ArchetypeType) -> String{
        switch archetype{
        case .Achiever: return "DEMO: Go to Harvard for my Masters"
        case .Activist: return "DEMO: Found a human rights organization."
        case .Adventurer: return "DEMO: Travel to all 7 Continents in the world"
        case .Athlete: return "DEMO: Compete as a gymnast in the Olympics"
        case .Entrepreneur: return "DEMO: Start up my dream company"
        case .Essentialist: return "DEMO: Build my dream home"
        case .Executive: return "DEMO: Become a C-Suite Executive"
        case .Influencer: return "DEMO: Become an internet celebrity with 30M followers"
        case .Artist: return "DEMO: Get my artwork into my dream gallery"
        case .Philanthropist: return "DEMO: Start an international charity org"
        case .Politician: return "DEMO: Become a congressperson"
        case .Student: return "DEMO: Go to Harvard for my Masters"
        }
    }
    

    
    func toEndDate(date: Date) -> Date{
        switch self {
        case .decade:
            return date.AdvanceDate(timeframe: .decade, forward: true, count: 1)
        case .year0:
            return date.AdvanceDate(timeframe: .year, forward: true, count: 1)
        case .year1:
            return date.AdvanceDate(timeframe: .year, forward: true, count: 4)
        case .year1_month1:
            return date.AdvanceDate(timeframe: .month, forward: true, count: 4)
        case .year1_month1_week1:
            return date.AdvanceDate(timeframe: .week, forward: true, count: 3)
        case .year1_month1_week1_day1:
            return date.AdvanceDate(timeframe: .day, forward: true, count:6)
        case .year1_month1_week1_day2:
            return date.AdvanceDate(timeframe: .day, forward: true, count:6)
        case .year1_month1_week1_day3:
            return date.AdvanceDate(timeframe: .day, forward: true, count:6)
        case .year1_month1_week2:
            return date.AdvanceDate(timeframe: .week, forward: true, count: 3)
        case .year1_month1_week3:
            return date.AdvanceDate(timeframe: .week, forward: true, count: 3)
        case .year2:
            return date.AdvanceDate(timeframe: .year, forward: true, count: 3)
        case .year2_month1:
            return date.AdvanceDate(timeframe: .month, forward: true, count: 4)
        case .year2_month1_week1:
            return date.AdvanceDate(timeframe: .week, forward: true, count: 3)
        case .year2_month1_week2:
            return date.AdvanceDate(timeframe: .week, forward: true, count: 2)
        case .year2_month1_week3:
            return date.AdvanceDate(timeframe: .week, forward: true, count: 2)
        case .year3:
            return date.AdvanceDate(timeframe: .year, forward: true, count: 4)
        }
    }
    
    func toParent() -> Self{
        switch self {
        case .decade:
            return .decade
        case .year0:
            return .decade
        case .year1:
            return .decade
        case .year1_month1:
            return .year1
        case .year1_month1_week1:
            return .year1_month1
        case .year1_month1_week1_day1:
            return .year1_month1_week1
        case .year1_month1_week1_day2:
            return .year1_month1_week1
        case .year1_month1_week1_day3:
            return .year1_month1_week1
        case .year1_month1_week2:
            return .year1_month1
        case .year1_month1_week3:
            return .year1_month1
        case .year2:
            return .decade
        case .year2_month1:
            return .year2
        case .year2_month1_week1:
            return .year2_month1
        case .year2_month1_week2:
            return .year2_month1
        case .year2_month1_week3:
            return .year2_month1
        case .year3:
            return .decade

        }
    }
    
    func getNext() -> Self{
        switch self {
        case .decade:
            return .year0
        case .year0:
            return .year1
        case .year1:
            return .year1_month1
        case .year1_month1:
            return .year1_month1_week1
        case .year1_month1_week1:
            return .year1_month1_week1_day1
        case .year1_month1_week1_day1:
            return .year1_month1_week1_day2
        case .year1_month1_week1_day2:
            return .year1_month1_week1_day3
        case .year1_month1_week1_day3:
            return .year1_month1_week2
        case .year1_month1_week2:
            return .year1_month1_week3
        case .year1_month1_week3:
            return .year2
        case .year2:
            return .year2_month1
        case .year2_month1:
            return .year2_month1_week1
        case .year2_month1_week1:
            return .year2_month1_week2
        case .year2_month1_week2:
            return .year2_month1_week3
        case .year2_month1_week3:
            return .year3
        case .year3:
            return .year3
        }
    }
}
