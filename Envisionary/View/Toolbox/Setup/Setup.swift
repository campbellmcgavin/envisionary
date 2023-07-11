//
//  Setup.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/5/23.
//

import SwiftUI

struct Setup: View {
    @Binding var shouldClose: Bool
    @State var setupStep: SetupStepType = .welcome
    @State var shouldAct: Bool = false
    @State var canProceedStep: [SetupStepType: Bool] = [SetupStepType: Bool]()
    @State var canProceedMessages: [SetupStepType: Bool] = [SetupStepType: Bool]()
    @State var bumpScrollView: Bool = false
    @State var contentView: ContentViewType = .envision
    @State var count: Double = 0.0
    @State var shouldGoBack: Bool = false
    @State var timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    @State var archetype: ArchetypeType? = nil
    let counterTime: Double = 20
    @State var shouldBlock = false
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
        ZStack{
            VStack{
                ScrollViewReader{
                    value in
                    ScrollView{
                        EmptyView()
                            .id(0)
                        VStack(alignment: .leading){
                            Text(setupStep.GetSubheader())
                                .foregroundColor(.specify(color: .grey8))
                                .font(.specify(style: .h5))
                                .frame(maxWidth:.infinity, alignment:.leading)
                            Text(setupStep.GetHeader(archetype: archetype))
                                .foregroundColor(.specify(color: .grey10))
                                .font(.specify(style: .h1))
                                .padding(.bottom,20)
                                .padding(.top,-16)
                                .frame(maxWidth:.infinity, alignment:.leading)
                        }
                        .frame(maxWidth:.infinity)
                        .frame(alignment: .leading)
                        .transition(.slide)
                        .padding([.leading,.trailing])
                        .background(
                            Color.specify(color: .grey2)
                                .modifier(ModifierRoundedCorners(radius: 36))
                                .edgesIgnoringSafeArea(.all)
                                .padding(.top,-3000)
                                .frame(maxHeight:.infinity))
                        .padding(.bottom,15)
                        .padding(.top,40)
                        
                        VStack{
                            GetSetupStepView()
                            Spacer()
                        }
                        .padding([.leading,.trailing,.top],8)
                        .frame(maxWidth:.infinity)
                        .frame(minHeight:400)
                        .modifier(ModifierCard(color: .grey05))
                        .padding(.bottom,125)
                        
                        EmptyView()
                            .id(1)
                            .onChange(of: bumpScrollView){
                                _ in
                                withAnimation{
                                    value.scrollTo(1)
                                }
                            }
                    }
                    .onChange(of: shouldAct){
                        _ in
                        shouldBlock = true
                        startTimer()
                        count+=1
                    }
                    .onChange(of: shouldGoBack){
                        _ in
                        setupStep = setupStep.GetPrevious()
//                        vm.tutorialStep = setupStep.GetPrevious()
                    }
                    .onReceive(timer, perform: {
                        _ in
                        
                        stopTimer()
                        withAnimation(.spring()){
                            value.scrollTo(0,anchor:.top)
                            vm.tutorialStep = setupStep.GetNext()
                            UserDefaults.standard.set(vm.tutorialStep.toString(), forKey: SettingsKeyType.tutorial_step.toString())
                            
                            setupStep = setupStep.GetNext()
                        }
                        shouldBlock = false
                        
                        if setupStep == .done{
                            shouldClose.toggle()
                        }
                    })
                }
            }
            
//            if setupStep.GetColor() == .purple {
//                VStack{
//                    Spacer()
//                    BottomNavigationBar(selectedContentView: $contentView)
//                        .disabled(true)
//                }
//            }
            
            VStack{
                Spacer()
                HStack{
                    
                    if setupStep != .welcome && setupStep != .getStarted{
                        IconButton(isPressed: $shouldGoBack, size: .large, iconType: .left, iconColor: .grey0, circleColor: .grey4)
                    }
                    Spacer()
                    let disabled = GetDisabled()
                    
                    if setupStep != .getStarted{
                            
                            IconButton(isPressed: $shouldAct, size: .large, iconType: .right, iconColor: disabled ? .clear : .grey0, circleColor: disabled ? .clear : .grey10)
                            .disabled(disabled || shouldBlock)
//                            }
                    }
                    else if !disabled{
                        LargeTextButtonWithicon(isPressed: $shouldAct)
                    }
        
                }
            }
            .padding([.leading,.trailing],20)
            
        }
        .background(Color.specify(color: .grey0))
        .onAppear(){
            stopTimer()
            setupStep = vm.tutorialStep
            
            if let archetype = UserDefaults.standard.string(forKey: SettingsKeyType.archetype_type.toString())
            {
                self.archetype = ArchetypeType.fromString(from: archetype)
            }
        }
    }

    @ViewBuilder
    func GetSetupStepView() -> some View {

        switch setupStep {
        case .welcome:
            SetupTemplate(canProceed: BindingCanProceedMessages(for: .welcome), bumpScrollView: $bumpScrollView, textArray: SetupStepType.welcome.toTextArray(), content: {TutorialWelcome(canProceed: BindingCanProceedStep(for: .welcome))})
        case .envisionary:
            SetupTemplate(canProceed: BindingCanProceedMessages(for: .envisionary), bumpScrollView: $bumpScrollView, textArray: SetupStepType.envisionary.toTextArray(), content: {TutorialEnvisionary(canProceed: BindingCanProceedStep(for: .envisionary))})
        case .phases:
            SetupTemplate(canProceed: BindingCanProceedMessages(for: .phases), bumpScrollView: $bumpScrollView, textArray: SetupStepType.phases.toTextArray(), content: {TutorialPhases(canProceed: BindingCanProceedStep(for: .phases), selectedContent: $contentView, isOverview: true)})
        case .archetype:
            SetupTemplate(canProceed: BindingCanProceedMessages(for: .archetype), bumpScrollView: $bumpScrollView, textArray: SetupStepType.archetype.toTextArray(), content: {TutorialArchetype(canProceed: BindingCanProceedStep(for: .archetype), selectedArchetype: $archetype)})
        case .getStarted:
            SetupTemplate(canProceed: BindingCanProceedMessages(for: .getStarted), bumpScrollView: $bumpScrollView, textArray: SetupStepType.getStarted.toTextArray(), content: {TutorialGetStarted(canProceed: BindingCanProceedStep(for: .getStarted))})
        case .thePoint:
            SetupTemplate(canProceed: BindingCanProceedMessages(for: .thePoint), bumpScrollView: $bumpScrollView, textArray: SetupStepType.thePoint.toTextArray(), content: {TutorialThePoint(canProceed: BindingCanProceedStep(for: .thePoint))})
        default:
            EmptyView()
        }
    }
    
    func GetDisabled() -> Bool{
        if canProceedStep[setupStep] != nil && canProceedMessages[setupStep] != nil{
            let canProceed = canProceedStep[setupStep]! && canProceedMessages[setupStep]!
            return !canProceed
        }
        return true
    }
    
    func BindingCanProceedStep(for key: SetupStepType) -> Binding<Bool>{
        return Binding(get: {
            return self.canProceedStep[key] ?? false},
                       set: {
                self.canProceedStep[key] = $0
        })
    }
    
    func BindingCanProceedMessages(for key: SetupStepType) -> Binding<Bool>{
        return Binding(get: {
            return self.canProceedMessages[key] ?? false},
                       set: {
                self.canProceedMessages[key] = $0
        })
    }
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    func startTimer() {
        self.timer = Timer.publish(every: 0.35, on: .main, in: .common).autoconnect()
    }
}

struct Setup_Previews: PreviewProvider {
    static var previews: some View {
        Setup(shouldClose: .constant(false))
        
    }
}
