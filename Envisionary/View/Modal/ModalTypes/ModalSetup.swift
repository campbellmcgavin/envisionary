//
//  ModalSetup.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/25/23.
//

import SwiftUI

struct ModalSetup: View {
    @Binding var objectType: ObjectType
    @Binding var isPresenting: Bool
    @State var setupStep: SetupStepType = .value
    
    @State var isFinishedWithMessages: Bool = false
    @State var isFinishedWithActions: Bool = false
    @State var shouldAct: Bool = false
    @State var shouldFinish: Bool = false
    @State var bumpScrollView: Bool = false
    
    @State var timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
        Modal(modalType: .setup, objectType: objectType, isPresenting: $isPresenting, shouldConfirm: .constant(false), isPresentingImageSheet: .constant(false), allowConfirm: .constant(true), modalContent: { SetupStepContent(setupStep: $setupStep, isFinishedWithMessages: $isFinishedWithMessages, isFinishedWithActions: $isFinishedWithActions, bumpScrollView: $bumpScrollView, shouldAct: $shouldAct)
                .padding(8)
            
        }, headerContent: { EmptyView() }, bottomContent: {
            HStack{
                Spacer()
                IconButton(isPressed: $shouldAct, size: .large, iconType: !setupStep.HasNext() ? .confirm : .right, iconColor: isFinishedWithMessages && isFinishedWithActions ? .grey0 : .clear, circleColor: isFinishedWithMessages && isFinishedWithActions ? .grey10 : .clear)
                        .disabled(!(isFinishedWithMessages && isFinishedWithActions))
            }
            .padding([.trailing,.bottom])

            
        }, betweenContent: {EmptyView()})
        .onAppear{
            setupStep = vm.setupStep
            stopTimer()
        }
        .onChange(of: objectType){
            _ in
            setupStep = GetSetupStepFromObject()
        }
        .onChange(of: shouldFinish){
            _ in
            isPresenting = false
        }
        .onChange(of: shouldAct){
            _ in
            startTimer()
            isFinishedWithActions = false
            isFinishedWithMessages = false
            
        }
        .onReceive(timer, perform: {
            _ in
            
            stopTimer()
            
            if !setupStep.HasNext(){
                isPresenting = false
                vm.setupStep = setupStep.GetNext()
            }
            else{
                setupStep = setupStep.GetNext()
            }
            
            
        })
    }
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    func startTimer() {
        self.timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    }
    
    func GetSetupStepFromObject() -> SetupStepType{
        switch objectType {
        case .value:
            return .value
        case .creed:
            return .creed
        case .dream:
            return .dream
        case .aspect:
            return .aspect
        case .goal:
            return .goalIntro
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
        default:
            return .entry
        }
    }
}

struct ModalSetup_Previews: PreviewProvider {
    static var previews: some View {
        ModalSetup(objectType: .constant(.goal), isPresenting: .constant(true))
    }
}
