//
//  TutorialObjects.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/5/23.
//

import SwiftUI

struct TutorialArchetype: View {
    @Binding var canProceed: Bool
    @Binding var selectedArchetype: ArchetypeType?
    @State var goalsAdded: [ExampleGoalEnum: UUID] = [ExampleGoalEnum: UUID]()
    @EnvironmentObject var vm: ViewModel
    
    @State var nextGoal = CreateGoalRequest(properties: Properties())
    @State var imageId: UUID? = nil
    @State var nextGoalStep = ExampleGoalEnum.decide
    var body: some View {
        
        SetupView()
            .onChange(of: selectedArchetype){
                _ in
                canProceed = true
            }
            .onDisappear{
                _ = vm.WipeDate()
                vm.UpdateArchetype(archetype: selectedArchetype ?? .Achiever)
                CreateObjects()
            }
    }
    
    func CreateObjects(){
        if let selectedArchetype{
            
            let requestIntro = CreateCoreValueRequest(title: ValueType.Introduction.toString(), description: ValueType.Introduction.toDescription())
            _ = vm.CreateCoreValue(request: requestIntro)
        
            let requestConclusion = CreateCoreValueRequest(title: ValueType.Conclusion.toString(), description: ValueType.Conclusion.toDescription())
            _ = vm.CreateCoreValue(request: requestConclusion)
    
            ValueType.allCases.filter({selectedArchetype.hasValue(value: $0)}).forEach{
                let request = CreateCoreValueRequest(title: $0.toString(), description: $0.toDescription())
                _ = vm.CreateCoreValue(request: request)}
            
            DreamType.allCases.filter({selectedArchetype.hasDream(dream: $0)}).forEach{
                let request = CreateDreamRequest(title: $0.toString(), description: "", aspect: $0.toAspect())
                _ = vm.CreateDream(request: request)}
            
            AspectType.allCases.filter({selectedArchetype.hasAspect(aspect: $0)}).forEach{
                let request = CreateAspectRequest(title: $0.toString(), description: "")
                _ = vm.CreateAspect(request: request)}
            
            HabitType.allCases.filter({selectedArchetype.hasHabit(habit: $0)}).forEach{
                let request = $0.toRequest()
                _ = vm.CreateHabit(request: request)
            }
            
            if let image = UIImage(named: "school"){
                imageId = vm.CreateImage(image: image)
            }
            
            ExampleGoalEnum.allCases.sorted(by: {$0.rawValue < $1.rawValue}).forEach{
                var parentId: UUID? = goalsAdded[$0.toParent()]
                let request = $0.toGoal(parentId: parentId, imageId: imageId)
                goalsAdded[$0] = vm.CreateGoal(request: request)
            }
            
            ChapterType.allCases.filter({selectedArchetype.hasChapter(chapter: $0)}).forEach{
                _ = vm.CreateChapter(request: $0.toRequest())
            }
            
            let chapterId = vm.ListChapters().first?.id ?? UUID()
            
            let entryRequest = CreateEntryRequest(title: "A day to remember!", description: "Today is the day I downloaded Envisionary! I was able to learn some impressive tools that I am going to put into practice. I'm really excited because this is all going to contribute to me becoming the beautiful person that I know I can become.", startDate: Date(), chapterId: chapterId, images: [UUID]())
            
            _ = vm.CreateEntry(request: entryRequest)
        }
    }
    
    @ViewBuilder
    func SetupView() -> some View{
        VStack{
            ForEach(ArchetypeType.allCases, id:\.self){
                archetype in
                ArchetypeCard(selectedArchetype: $selectedArchetype, archetype: archetype)
                
                if archetype != ArchetypeType.allCases.last!{
                    StackDivider(color: .grey3)
                }
            }
        }
        .padding(8)
    }
}

struct TutorialArchetype_Previews: PreviewProvider {
    static var previews: some View {
        TutorialArchetype(canProceed: .constant(true), selectedArchetype: .constant(nil))
    }
}


enum ExampleGoalEnum: Int, CaseIterable {
    case decide = 0
    case decide_buildResumeAndCv = 1
    case decide_study = 2
    case decide_study_certify = 3
    case decide_study_certify_1 = 4
    case decide_study_certify_1_PurchaseMaterials = 5
    case decide_study_ceritfy_1_PracticeTests = 6
    case decide_study_certify_1_MakeFlashCards = 7
    case decide_study_certify_2 = 8
    case decide_study_certify_3 = 9
    case decide_apply = 10
    case decide_apply_interview = 11
    case decide_apply_interview_stage1 = 12
    case decide_apply_interview_stage2 = 13
    case decide_apply_interview_stage3 = 14
    case decide_getAccepeted = 15
    
    
    func toGoal(parentId: UUID?, imageId: UUID?) -> CreateGoalRequest {
        switch self{
        case .decide:
            return CreateGoalRequest(title: self.toTitle(), description: self.toDescription(), priority: .critical, startDate: Date(), endDate: self.toEndDate(), percentComplete: 0, image: imageId, aspect: .academic, timeframe: .decade, parent: parentId)
        case .decide_buildResumeAndCv:
            return CreateGoalRequest(title: self.toTitle(), description: self.toDescription(), priority: .critical, startDate: Date(), endDate: self.toEndDate(), percentComplete: 0, image: imageId, aspect: .academic, timeframe: .year, parent: parentId)
        case .decide_study:
            return CreateGoalRequest(title: self.toTitle(), description: self.toDescription(), priority: .critical, startDate: Date(), endDate: self.toEndDate(), percentComplete: 0, image: imageId, aspect: .academic, timeframe: .year, parent: parentId)
        case .decide_study_certify:
            return CreateGoalRequest(title: self.toTitle(), description: self.toDescription(), priority: .critical, startDate: Date(), endDate: self.toEndDate(), percentComplete: 0, image: imageId, aspect: .academic, timeframe: .month, parent: parentId)
        case .decide_study_certify_1:
            return CreateGoalRequest(title: self.toTitle(), description: self.toDescription(), priority: .critical, startDate: Date(), endDate: self.toEndDate(), percentComplete: 0, image: imageId, aspect: .academic, timeframe: .week, parent: parentId)
            
            
        case .decide_study_certify_1_PurchaseMaterials:
            return CreateGoalRequest(title: self.toTitle(), description: self.toDescription(), priority: .moderate, startDate: Date(), endDate: self.toEndDate(), percentComplete: 0, image: imageId, aspect: .academic, timeframe: .day, parent: parentId)
        case .decide_study_ceritfy_1_PracticeTests:
            return CreateGoalRequest(title: self.toTitle(), description: self.toDescription(), priority: .high, startDate: Date(), endDate: self.toEndDate(), percentComplete: 0, image: imageId, aspect: .academic, timeframe: .day, parent: parentId)
        case .decide_study_certify_1_MakeFlashCards:
            return CreateGoalRequest(title: self.toTitle(), description: self.toDescription(), priority: .low, startDate: Date(), endDate: self.toEndDate(), percentComplete: 0, image: imageId, aspect: .academic, timeframe: .day, parent: parentId)
            
            
        case .decide_study_certify_2:
            return CreateGoalRequest(title: self.toTitle(), description: self.toDescription(), priority: .critical, startDate: Date(), endDate: self.toEndDate(), percentComplete: 0, image: imageId, aspect: .academic, timeframe: .week, parent: parentId)
        case .decide_study_certify_3:
            return CreateGoalRequest(title: self.toTitle(), description: self.toDescription(), priority: .critical, startDate: Date(), endDate: self.toEndDate(), percentComplete: 0, image: imageId, aspect: .academic, timeframe: .week, parent: parentId)
        case .decide_apply:
            return CreateGoalRequest(title: self.toTitle(), description: self.toDescription(), priority: .critical, startDate: Date(), endDate: self.toEndDate(), percentComplete: 0, image: imageId, aspect: .academic, timeframe: .year, parent: parentId)
        case .decide_apply_interview:
            return CreateGoalRequest(title: self.toTitle(), description: self.toDescription(), priority: .critical, startDate: Date(), endDate: self.toEndDate(), percentComplete: 0, image: imageId, aspect: .academic, timeframe: .month, parent: parentId)
        case .decide_apply_interview_stage1:
            return CreateGoalRequest(title: self.toTitle(), description: self.toDescription(), priority: .critical, startDate: Date(), endDate: self.toEndDate(), percentComplete: 0, image: imageId, aspect: .academic, timeframe: .week, parent: parentId)
        case .decide_apply_interview_stage2:
            return CreateGoalRequest(title: self.toTitle(), description: self.toDescription(), priority: .critical, startDate: Date(), endDate: self.toEndDate(), percentComplete: 0, image: imageId, aspect: .academic, timeframe: .week, parent: parentId)
        case .decide_apply_interview_stage3:
            return CreateGoalRequest(title: self.toTitle(), description: self.toDescription(), priority: .critical, startDate: Date(), endDate: self.toEndDate(), percentComplete: 0, image: imageId, aspect: .academic, timeframe: .week, parent: parentId)
        case .decide_getAccepeted:
            return CreateGoalRequest(title: self.toTitle(), description: self.toDescription(), priority: .critical, startDate: Date(), endDate: self.toEndDate(), percentComplete: 0, image: imageId, aspect: .academic, timeframe: .year, parent: parentId)
        }
    }
    
    func toTitle() -> String{
        switch self {
        case .decide:
            return "Go to Envisionary University"
        case .decide_buildResumeAndCv:
            return "Build Resume and CV"
        case .decide_study:
            return "Study!!!!"
        case .decide_study_certify:
            return "Study for certs"
        case .decide_study_certify_1:
            return "Cert 1: History of planning"
        case .decide_study_certify_1_PurchaseMaterials:
            return "Purchase study materials"
        case .decide_study_ceritfy_1_PracticeTests:
            return "Take practice tests"
        case .decide_study_certify_1_MakeFlashCards:
            return "Make flash cards"
        case .decide_study_certify_2:
            return "Cert 2: Etymology of the word plan"
        case .decide_study_certify_3:
            return "Cert 3: More exciting info"
        case .decide_apply:
            return "Application Process"
        case .decide_apply_interview:
            return "Interviews"
        case .decide_apply_interview_stage1:
            return "Stage 1: meet the board"
        case .decide_apply_interview_stage2:
            return "Stage 2: impress someone"
        case .decide_apply_interview_stage3:
            return "Stage 3: meet more people"
        case .decide_getAccepeted:
            return "Get accepted!!!"
        }
    }
    
    func toDescription() -> String{
        return "Demo: Envisionary University."
    }
    
    func toEndDate() -> Date{
        switch self {
        case .decide:
            return Date().AdvanceDate(timeframe: .decade, forward: true)
        case .decide_buildResumeAndCv:
            return Date().AdvanceDate(timeframe: .year, forward: true)
        case .decide_study:
            return Date().AdvanceDate(timeframe: .year, forward: true)
        case .decide_study_certify:
            return Date().AdvanceDate(timeframe: .month, forward: true)
        case .decide_study_certify_1:
            return Date().AdvanceDate(timeframe: .week, forward: true)
        case .decide_study_certify_1_PurchaseMaterials:
            return Date().AdvanceDate(timeframe: .day, forward: true, count:6)
        case .decide_study_ceritfy_1_PracticeTests:
            return Date().AdvanceDate(timeframe: .day, forward: true, count:6)
        case .decide_study_certify_1_MakeFlashCards:
            return Date().AdvanceDate(timeframe: .day, forward: true, count:6)
        case .decide_study_certify_2:
            return Date().AdvanceDate(timeframe: .week, forward: true)
        case .decide_study_certify_3:
            return Date().AdvanceDate(timeframe: .week, forward: true)
        case .decide_apply:
            return Date().AdvanceDate(timeframe: .year, forward: true)
        case .decide_apply_interview:
            return Date().AdvanceDate(timeframe: .month, forward: true)
        case .decide_apply_interview_stage1:
            return Date().AdvanceDate(timeframe: .week, forward: true)
        case .decide_apply_interview_stage2:
            return Date().AdvanceDate(timeframe: .week, forward: true)
        case .decide_apply_interview_stage3:
            return Date().AdvanceDate(timeframe: .week, forward: true)
        case .decide_getAccepeted:
            return Date().AdvanceDate(timeframe: .year, forward: true)
        }
    }
    
    func toParent() -> Self{
        switch self {
        case .decide:
            return .decide
        case .decide_buildResumeAndCv:
            return .decide
        case .decide_study:
            return .decide
        case .decide_study_certify:
            return .decide_study
        case .decide_study_certify_1:
            return .decide_study_certify
        case .decide_study_certify_1_PurchaseMaterials:
            return .decide_study_certify_1
        case .decide_study_ceritfy_1_PracticeTests:
            return .decide_study_certify_1
        case .decide_study_certify_1_MakeFlashCards:
            return .decide_study_certify_1
        case .decide_study_certify_2:
            return .decide_study_certify
        case .decide_study_certify_3:
            return .decide_study_certify
        case .decide_apply:
            return .decide
        case .decide_apply_interview:
            return .decide_apply
        case .decide_apply_interview_stage1:
            return .decide_apply_interview
        case .decide_apply_interview_stage2:
            return .decide_apply_interview
        case .decide_apply_interview_stage3:
            return .decide_apply_interview
        case .decide_getAccepeted:
            return .decide

        }
    }
    
    func getNext() -> Self{
        switch self {
        case .decide:
            return .decide_buildResumeAndCv
        case .decide_buildResumeAndCv:
            return .decide_study
        case .decide_study:
            return .decide_study_certify
        case .decide_study_certify:
            return .decide_study_certify_1
        case .decide_study_certify_1:
            return .decide_study_certify_1_PurchaseMaterials
        case .decide_study_certify_1_PurchaseMaterials:
            return .decide_study_ceritfy_1_PracticeTests
        case .decide_study_ceritfy_1_PracticeTests:
            return .decide_study_certify_1_MakeFlashCards
        case .decide_study_certify_1_MakeFlashCards:
            return .decide_study_certify_2
        case .decide_study_certify_2:
            return .decide_study_certify_3
        case .decide_study_certify_3:
            return .decide_apply
        case .decide_apply:
            return .decide_apply_interview
        case .decide_apply_interview:
            return .decide_apply_interview_stage1
        case .decide_apply_interview_stage1:
            return .decide_apply_interview_stage2
        case .decide_apply_interview_stage2:
            return .decide_apply_interview_stage3
        case .decide_apply_interview_stage3:
            return .decide_getAccepeted
        case .decide_getAccepeted:
            return .decide_getAccepeted
        }
    }
}
