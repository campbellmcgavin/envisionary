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
    @State var contentView: ContentViewType = .values
    @State var shouldGoBack: Bool = false
    @State var didUsePreviousData: Bool = false
    let counterTime: Double = 20
//    @State var shouldBlock = false
    
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
                            Text(setupStep.GetHeader())
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
                        .frame(minHeight:300)
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
//                        shouldBlock = true
                        
                        withAnimation(.spring()){
                            value.scrollTo(0,anchor:.top)
                            
                            let nextStep = CalculateNextStep()
                            vm.tutorialStep = nextStep
                            UserDefaults.standard.set(vm.tutorialStep.toString(), forKey: SettingsKeyType.tutorial_step.toString())
                            
                            setupStep = nextStep
                            
                            if setupStep == .done{
                                shouldClose.toggle()
                            }
                        }
//                        shouldBlock = false
                        
                    }
                    .onChange(of: shouldGoBack){
                        _ in
                        setupStep = setupStep.GetPrevious()
//                        vm.tutorialStep = setupStep.GetPrevious()
                    }
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
                    
                    if setupStep != .welcome && setupStep != .getStarted && setupStep != .thePoint && setupStep != .oneMoreThing && setupStep != .envisionary && setupStep != .loadPreviousData{
                        IconButton(isPressed: $shouldGoBack, size: .large, iconType: .left, iconColor: .grey0, circleColor: .grey4)
                    }
                    Spacer()
                    let disabled = GetDisabled()
                    
                    if setupStep != .getStarted{
                            
                            IconButton(isPressed: $shouldAct, size: .large, iconType: .right, iconColor: disabled ? .clear : .grey0, circleColor: disabled ? .clear : .grey10)
                            .disabled(disabled)
//                            }
                    }
                    else if !disabled{
                        
                        TextIconButton(isPressed: $shouldAct, text: "Get Envisioning", color: .grey0, backgroundColor: .grey10, fontSize: .h3, shouldFillWidth: false, iconType: .arrow_right)
                    }
        
                }
            }
            .padding([.leading,.trailing])
            .padding(.bottom)
            
        }
        .background(Color.specify(color: .grey0))
        .onAppear(){
            setupStep = vm.tutorialStep
        }
    }

    @ViewBuilder
    func GetSetupStepView() -> some View {

        switch setupStep {
        case .welcome:
            SetupTemplate(canProceed: BindingCanProceedMessages(for: .welcome), bumpScrollView: $bumpScrollView, textArray: SetupStepType.welcome.toTextArray(), content: {TutorialWelcome(canProceed: BindingCanProceedStep(for: .welcome))})
        case .envisionary:
            SetupTemplate(canProceed: BindingCanProceedMessages(for: .envisionary), bumpScrollView: $bumpScrollView, textArray: SetupStepType.envisionary.toTextArray(), content: {TutorialEnvisionary(canProceed: BindingCanProceedStep(for: .envisionary))})
        case .getStarted:
            SetupTemplate(canProceed: BindingCanProceedMessages(for: .getStarted), bumpScrollView: $bumpScrollView, textArray: SetupStepType.getStarted.toTextArray(), content: {TutorialGetStarted(canProceed: BindingCanProceedStep(for: .getStarted))})
        case .thePoint:
            SetupTemplate(canProceed: BindingCanProceedMessages(for: .thePoint), bumpScrollView: $bumpScrollView, textArray: SetupStepType.thePoint.toTextArray(), content: {TutorialArchetype(canProceed: BindingCanProceedStep(for: .thePoint))})
        case .loadPreviousData:
            SetupTemplate(canProceed: BindingCanProceedMessages(for: .loadPreviousData), bumpScrollView: $bumpScrollView, textArray: SetupStepType.loadPreviousData.toTextArray(), content: {TutorialLoadPreviousData(canProceed: BindingCanProceedStep(for: .loadPreviousData), didUsePreviousData: $didUsePreviousData)})
        case .oneMoreThing:
            SetupTemplate(canProceed: BindingCanProceedMessages(for: .oneMoreThing), bumpScrollView: $bumpScrollView, textArray: SetupStepType.oneMoreThing.toTextArray(), content: {TutorialPermissions(canProceed: BindingCanProceedStep(for: .oneMoreThing))}, shouldShowCard: false)
        default:
            EmptyView()
        }
    }
    
    func CalculateNextStep() -> SetupStepType{
        switch setupStep{
        case .welcome:
            if vm.CheckDataModelHasContent() {
                return .loadPreviousData
            }
            else{
                return .envisionary
            }
        case .loadPreviousData:
            if didUsePreviousData{
                return setupStep.GetNext()
            }
            else{
                return .envisionary
            }
        default:
            return setupStep.GetNext()
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
}

struct Setup_Previews: PreviewProvider {
    static var previews: some View {
        Setup(shouldClose: .constant(false))
        
    }
}
