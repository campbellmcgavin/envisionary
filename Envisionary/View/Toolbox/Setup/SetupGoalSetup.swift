//
//  SetupGoalSetup.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/12/23.
//

import SwiftUI

struct SetupGoalSetup: View {
    @Binding var canProceed: Bool
    
    @State var goalsAdded: [ExampleGoalEnum: UUID] = [ExampleGoalEnum: UUID]()
    @State var focusGoal: UUID = UUID()
    @State var parentGoal: UUID? = nil
    
    @State var shouldAddGoals = false
    @State var nextGoalStep = ExampleGoalEnum.decide
    
    @State var nextGoal = CreateGoalRequest(properties: Properties())
    @State var expandedGoals: [UUID] = [UUID]()
    @State var shouldAdd: Bool = false
    @EnvironmentObject var vm: ViewModel
    @State var addTimer = Timer.publish(every: 6.0, on: .main, in: .common).autoconnect()
    @State var timer = Timer.publish(every: 6.0, on: .main, in: .common).autoconnect()
    @State var imageId: UUID? = nil
    
    var body: some View {
        
        
        VStack{
            if !shouldAddGoals{
                TextButton(isPressed: $shouldAddGoals, text: "Add your goals", color: .grey10, backgroundColor: .green, style:.h3, shouldHaveBackground: true, shouldFill: true)
                    .padding([.top,.bottom],12)
            }

            if let parentGoal{
                ScrollView([.horizontal],showsIndicators: true){
                    VStack(alignment:.leading, spacing:0){
                        TreeDiagramView(goalId: parentGoal, focusGoal: $focusGoal, expandedGoals: $expandedGoals, value: { goalId in
                            BubbleView(goalId: goalId, focusGoal: $focusGoal)
                        }, childCount: 0)
                        .padding(.top,5)
                        .padding(.bottom)
                    }
                    .frame(alignment:.leading)
            }
        }
            Spacer()
        }
        .frame(minHeight:400)
        .frame(maxWidth:.infinity)
        .padding()
            .onAppear{
                stopTimer()
                stopAddTimer()
                shouldAddGoals = false
                let goals = vm.ListGoals(limit:200)
                for goal in goals{
                    vm.DeleteGoal(id: goal.id)
                }
                
                
                
                
                if let image = UIImage(named: "school"){
                    imageId = vm.CreateImage(image: image)
                }
                nextGoal = nextGoalStep.toGoal(parentId: nil, imageId: imageId)
            }
            .onChange(of: shouldAddGoals){
                _ in
                startAddTimer()
            }
            .onReceive(addTimer){
                _ in
                shouldAdd.toggle()
                if nextGoalStep == .decide_getAccepeted{
                    stopAddTimer()
                }
            }
            .onChange(of: shouldAdd){ _ in
                withAnimation{
                    let id = vm.CreateGoal(request: nextGoal)
                    
                    
                    if nextGoalStep == .decide {
                        parentGoal = id
                    }
                    expandedGoals.append(id)
                    goalsAdded[nextGoalStep] = id
                    nextGoalStep = nextGoalStep.getNext()
                    let parentId = goalsAdded[nextGoalStep.toParent()]
                    nextGoal = nextGoalStep.toGoal(parentId: parentId, imageId: imageId)
                }
                if goalsAdded.count >= ExampleGoalEnum.allCases.count {
                    startTimer()
//                    canProceed = true
                }
            }
            .onReceive(timer, perform: {
                _ in
                stopTimer()
                canProceed = true
            })
    }
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    func startTimer() {
        self.timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    }
    
    func stopAddTimer() {
        self.addTimer.upstream.connect().cancel()
    }
    
    func startAddTimer() {
        self.addTimer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    }
}

struct SetupGoalSetup_Previews: PreviewProvider {
    static var previews: some View {
        SetupGoalSetup(canProceed: .constant(true))
    }
}


enum ExampleGoalEnum: CaseIterable{
    case decide
    case decide_buildResumeAndCv
    case decide_study
    case decide_study_certify
    case decide_study_certify_1
    case decide_study_certify_1_PurchaseMaterials
    case decide_study_ceritfy_1_PracticeTests
    case decide_study_certify_1_MakeFlashCards
    case decide_study_certify_2
    case decide_study_certify_3
    case decide_apply
    case decide_apply_interview
    case decide_apply_interview_stage1
    case decide_apply_interview_stage2
    case decide_apply_interview_stage3
    case decide_getAccepeted
    
    
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
        return "An example goal, to make you smile and help you learn the app :)."
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
