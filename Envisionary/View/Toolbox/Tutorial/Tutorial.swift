////
////  Tutorial.swift
////  Envisionary
////
////  Created by Campbell McGavin on 6/5/23.
////
//
//import SwiftUI
//
//struct Tutorial: View {
//    @Binding var shouldClose: Bool
//    @Binding var isPresentingSetup: Bool
//    @State var tutorialStep: TutorialStepType = .welcome
//    @State var counter: Double = 10
//    @State var shouldAct = false
//    @State var selectedContent: ContentViewType? = nil
//    @State var shouldResetTimer: Bool = false
//    let counterTime: Double = 10
//    var body: some View {
//        ZStack{
//            ScrollViewReader{
//                value in
//                ScrollView{
//                    EmptyView()
//                        .id(0)
//                    VStack(alignment: .leading){
//                        Text(tutorialStep.toCaption())
//                            .foregroundColor(.specify(color: .grey8))
//                            .font(.specify(style: .h5))
//                            .frame(maxWidth:.infinity, alignment:.leading)
//                        Text(tutorialStep.toString())
//                            .foregroundColor(.specify(color: .grey10))
//                            .font(.specify(style: .h1))
//                            .padding(.bottom,20)
//                            .padding(.top,-16)
//                            .frame(maxWidth:.infinity, alignment:.leading)
//                    }
//                    .frame(maxWidth:.infinity)
//                    .frame(alignment: .leading)
//                    .transition(.slide)
//                    .padding([.leading,.trailing])
//                    .background(
//                        Color.specify(color: .grey2)
//                            .modifier(ModifierRoundedCorners(radius: 36))
//                            .edgesIgnoringSafeArea(.all)
//                            .padding(.top,-3000)
//                            .frame(maxHeight:.infinity))
//                    .padding(.bottom,15)
//                    .padding(.top,40)
//
//                    VStack{
//                        Text(tutorialStep.toDescription())
//                            .foregroundColor(.specify(color: .grey9))
//                            .font(.specify(style: .h5))
//                            .frame(maxWidth:.infinity, alignment:.leading)
//                            .padding()
//                            .modifier(ModifierForm(color:.grey2))
//                            .padding(8)
//
//                        GetTutorialStepView()
//                            .opacity(0.94)
//                            .padding([.top,.bottom],50)
//                    }
//
//                    .frame(maxWidth:.infinity)
//                    .modifier(ModifierCard(color: .grey1))
//                    Spacer()
//                }
//                .onChange(of: shouldAct){
//                    _ in
//                    value.scrollTo(0,anchor:.top)
//                    withAnimation(.spring()){
//                        tutorialStep = tutorialStep.getNext()
//                        shouldResetTimer.toggle()
//                    }
//                    counter = counterTime
//                    selectedContent = tutorialStep.toContentType()
//                }
//                .onAppear{
//                    counter = counterTime
//                }
//            }
//
//
//            VStack{
//                Spacer()
//                HStack{
//                    Spacer()
//                    ZStack{
//                        if tutorialStep != .getStarted{
//                            IconButton(isPressed: $shouldAct, size: .largeish, iconType: .right, iconColor: (counter <= 0.1) ? .grey0 : .clear, circleColor: (counter <= 0.1) ? .grey10 : .clear)
////                                .disabled(counter > 0.3)
//                        }
//                        else{
//                        HStack{
//                            Spacer()
//                            TextButton(isPressed: $shouldClose, text: "     Get Started", color: .grey0, backgroundColor: .grey10, style: .h5, shouldHaveBackground: true, shouldFill: false, iconType: .right, height: .largeish)
//                                .frame(width:210)
//                        }
//
//                        }
//
//
//                        if tutorialStep != .getStarted {
//                            Countdown(counter: $counter, shouldReset: $shouldResetTimer, timeAmount: Int(counterTime), color: (counter <= 0.1) ? .clear : .grey10, size: .largeish, shouldCountDown: true, shouldShowClock: false, shouldAnimate: true)
//                                .opacity(0.4)
//                        }
//                    }
//                    .offset(x:-20, y:-15)
//                }
//            }
//        }
//        .background(Color.specify(color: .grey0))
//
//
//    }
//
//    @ViewBuilder
//    func GetTutorialStepView() -> some View {
//
//        switch tutorialStep {
//        case .welcome:
//            TutorialWelcome()
//        case .envisionary:
//            TutorialEnvisionary()
//        case .phases:
//            TutorialPhases(selectedContent: $selectedContent)
//        case .envision:
//            TutorialPhases(selectedContent: $selectedContent)
//        case .plan:
//            TutorialPhases(selectedContent: $selectedContent)
//        case .execute:
//            TutorialPhases(selectedContent: $selectedContent)
//        case .journal:
//            TutorialPhases(selectedContent: $selectedContent)
//        case .evaluate:
//            TutorialPhases(selectedContent: $selectedContent)
//        case .objects:
//            TutorialObjects()
//        case .getStarted:
//            TutorialGetStarted()
//        }
//    }
//}
//
//struct Tutorial_Previews: PreviewProvider {
//    static var previews: some View {
//        Tutorial(shouldClose: .constant(false), isPresentingSetup: .constant(false))
//    }
//}
