//
//  SetupStepContent.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/25/23.
//

import SwiftUI

struct SetupStepContent: View {
    
    @Binding var setupStep: SetupStepType
    @Binding var isFinishedWithMessages: Bool
    @Binding var isFinishedWithActions: Bool
    @Binding var bumpScrollView: Bool
    @Binding var shouldAct: Bool
    
    var body: some View {
        GetContent()
    }
    
    @ViewBuilder
    func GetContent() -> some View {

        switch setupStep {
        case .value:
            SetupTemplate(canProceed: $isFinishedWithMessages, bumpScrollView: $bumpScrollView, textArray: SetupStepType.value.toTextArray(), content: {SetupValue(canProceed: $isFinishedWithActions, shouldAct: $shouldAct)})
        case .creed:
            SetupTemplate(canProceed: $isFinishedWithMessages, bumpScrollView: $bumpScrollView, textArray: SetupStepType.creed.toTextArray(), content: {SetupCreed(canProceed: $isFinishedWithActions).padding(.bottom)})
        case .dream:
            SetupTemplate(canProceed: $isFinishedWithMessages, bumpScrollView: $bumpScrollView, textArray: SetupStepType.dream.toTextArray(), content: {SetupDream(canProceed: $isFinishedWithActions, shouldAct: $shouldAct)})
        case .aspect:
            SetupTemplate(canProceed: $isFinishedWithMessages, bumpScrollView: $bumpScrollView, textArray: SetupStepType.aspect.toTextArray(), content: {SetupAspect(canProceed: $isFinishedWithActions, shouldAct: $shouldAct)})
        case .goalIntro:
            SetupTemplate(canProceed: $isFinishedWithMessages, bumpScrollView: $bumpScrollView, textArray: SetupStepType.goalIntro.toTextArray(), content: {SetupGoalIntro(canProceed: $isFinishedWithActions)})
        case .goalContext:
            SetupTemplate(canProceed: $isFinishedWithMessages, bumpScrollView: $bumpScrollView, textArray: SetupStepType.goalContext.toTextArray(), content: {SetupGoalContext(canProceed: $isFinishedWithActions)})
        case .goalSetup:
            SetupTemplate(canProceed: $isFinishedWithMessages, bumpScrollView: $bumpScrollView, textArray: SetupStepType.goalSetup.toTextArray(), content: {SetupGoalSetup(canProceed: $isFinishedWithActions)})
        case .habit:
            SetupTemplate(canProceed: $isFinishedWithMessages, bumpScrollView: $bumpScrollView, textArray: SetupStepType.habit.toTextArray(), content: {SetupHabit(canProceed: $isFinishedWithActions, shouldAct: $shouldAct)})
        case .session:
            SetupTemplate(canProceed: $isFinishedWithMessages, bumpScrollView: $bumpScrollView, textArray: SetupStepType.session.toTextArray(), content: {SetupSession(canProceed: $isFinishedWithActions)})
        case .home:
            SetupTemplate(canProceed: $isFinishedWithMessages, bumpScrollView: $bumpScrollView, textArray: SetupStepType.home.toTextArray(), content: {SetupHome(canProceed: $isFinishedWithActions)})

        case .chapter:
            SetupTemplate(canProceed: $isFinishedWithMessages, bumpScrollView: $bumpScrollView, textArray: SetupStepType.chapter.toTextArray(), content: {SetupChapter(canProceed: $isFinishedWithActions, shouldAct: $shouldAct)})
        case .entry:
            SetupTemplate(canProceed: $isFinishedWithMessages, bumpScrollView: $bumpScrollView, textArray: SetupStepType.entry.toTextArray(), content: {SetupEntry(canProceed: $isFinishedWithActions)})
        case .garduated:
            SetupTemplate(canProceed: $isFinishedWithMessages, bumpScrollView: $bumpScrollView, textArray: SetupStepType.garduated.toTextArray(), content: {SetupGraduation(shouldClose: $isFinishedWithActions)})
        case .emotion:
            SetupTemplate(canProceed: $isFinishedWithMessages, bumpScrollView: $bumpScrollView, textArray: SetupStepType.emotion.toTextArray(), content: {SetupMood(canProceed: $isFinishedWithActions)})
            
        default:
            EmptyView()
        }
    }
}
//
//struct SetupStepContent_Previews: PreviewProvider {
//    static var previews: some View {
//        SetupStepContent()
//    }
//}
