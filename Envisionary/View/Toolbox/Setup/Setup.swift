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
    
    @State var timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    let counterTime: Double = 20
    
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
                            Color.specify(color: setupStep.GetColor())
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
                        .padding(8)
                        .frame(maxWidth:.infinity)
                        .frame(minHeight:400)
                        .modifier(ModifierCard(color: .grey1))
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
                        startTimer()
                        count+=1
                    }
                    .onReceive(timer, perform: {
                        _ in
                        
                        stopTimer()
                        withAnimation(.spring()){
                            value.scrollTo(0,anchor:.top)
                            setupStep = setupStep.GetNext()
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
                    Spacer()
                    ZStack{
                        let disabled = GetDisabled()
                        
                        if setupStep != .getStarted{
                            
//                            if count > 4 {
//                                ProgressTrack(size: .largeMedium, color: .grey5)
//                                    .opacity(0.6)
//                                ProgressBar(counter: count - 4.0, countTo: SetupStepType.allCases.count - 4, size: .largeMedium, color: .grey5)
//                                    .opacity(1.0)
//                            }
                            
//                            if !disabled {
                                
                                IconButton(isPressed: $shouldAct, size: .large, iconType: .right, iconColor: disabled ? .clear : .grey0, circleColor: disabled ? .clear : .grey10)
                                .disabled(disabled)
//                            }
                        }
                        else if !disabled{
                            HStack{
                                Spacer()
                                TextButton(isPressed: $shouldClose, text: "   Get Envisioning", color: .grey0, backgroundColor: .grey10, style: .h5, shouldHaveBackground: true, shouldFill: false, iconType: .right, height: .large)
                                    .frame(width:230)
                            }
                        }
                    }
        
                }
            }
            .offset(x:-20, y:0)
            
        }
        .background(Color.specify(color: .grey0))
        .onChange(of: setupStep, perform: {
            _ in
            contentView = setupStep.toContentView()
        })
        .onAppear(){
            stopTimer()
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
        case .objects:
            SetupTemplate(canProceed: BindingCanProceedMessages(for: .objects), bumpScrollView: $bumpScrollView, textArray: SetupStepType.objects.toTextArray(), content: {TutorialObjects(canProceed: BindingCanProceedStep(for: .objects))})
        case .getStarted:
            SetupTemplate(canProceed: BindingCanProceedMessages(for: .getStarted), bumpScrollView: $bumpScrollView, textArray: SetupStepType.getStarted.toTextArray(), content: {TutorialGetStarted(canProceed: BindingCanProceedStep(for: .getStarted))})
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
        self.timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    }
}

struct Setup_Previews: PreviewProvider {
    static var previews: some View {
        Setup(shouldClose: .constant(false))
        
    }
}
