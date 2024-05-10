//
//  ContentView.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/7/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: ViewModel
    
    @State var filteredObjectsDictionary = [String:[UUID]]()
    @State var gadgetFrame: CGSize = .zero
    @State var screenHeight: CGSize = .zero
    @State var shouldPopScrollToHideHeader: Bool = false
    @State var isPresentingModal: Bool = false
    @State var isPresentingMainMenu: Bool = false
    @State var modalType: ModalType = .add
    @State private var scrollViewID = 1
    @State var isPresentingSplashScreen = true
    @State var isPresentingCalendarView = false
    @State var shouldShowTopTitle = false
    @State private var splashScreenTimer = Timer.publish(every: 1.5, on: .main, in: .common).autoconnect()

    @State var filterCount = 0
    @State var shouldDisableScrollView = false
    @State var isFirstAppear: Bool = true
    @State var stackSize: CGSize = .zero
    private let coordinateSpaceName = UUID()
    
    var body: some View {
        NavigationStack{
            ZStack(alignment:.top){
                    VStack(spacing:0){
                        
                        ScrollViewReader{
                            proxy in
                            
                            ScrollView(.vertical, showsIndicators: false){
                                
                                VStack{
                                    Spacer()
                                        .frame(height:0)
                                        .offset(y:-150)
                                        .id(0)
                                    
                                    ContentViewTop(shouldPopScrollToHideHeader: $shouldPopScrollToHideHeader, isPresentingModal: $isPresentingModal, modalType: $modalType, shouldDisableScrollView: $shouldDisableScrollView, shouldShowTopTitle: $shouldShowTopTitle, proxy: proxy, coordinateSpaceName: coordinateSpaceName)
                                    
                                    VStack(spacing:0){
                                        
                                        Spacer()
                                            .frame(height:100)
                                            .id(1)
                                        
                                        ContentViewStack(isPresenting: $isPresentingModal, modalType: $modalType, proxy: proxy)
                                    }
                                        .padding(.top,GetStackOffset())
                                        .saveSize(in: $stackSize)
                                        .padding(.bottom,UIScreen.screenHeight - (stackSize.height < UIScreen.screenHeight ? stackSize.height : UIScreen.screenHeight) + 200)
                                }
                                .onChange(of: shouldPopScrollToHideHeader){
                                    _ in
                                    withAnimation{
                                        proxy.scrollTo(1, anchor:.top)
                                    }
                                }
                                .onChange(of: vm.filtering.filterContent){ _ in
                                    withAnimation{
                                        proxy.scrollTo(0, anchor:.top)
                                    }
                                }
                                .frame(alignment:.top)
                               
                            }
                            .coordinateSpace(name: coordinateSpaceName)
                            .scrollDismissesKeyboard(ScrollDismissesKeyboardMode.interactively)
                            .disabled(shouldDisableScrollView)
                        }
                    }
                    .frame(alignment:.top)

                //navigation
                VStack(spacing:0){
                    TopNavigationBar(shouldShowTopTitle: $shouldShowTopTitle, isPresentingSetup: $isPresentingModal, modalType: $modalType)
                    
                    Spacer()
                    
                    if (ShouldShowFloatingActionButton()){
                        FloatingActionButton(shouldAct: $isPresentingModal, modalType: $modalType)
                    }

                    BottomNavigationBar(selectedContentView: $vm.filtering.filterContent, selectedObject: $vm.filtering.filterObject)
                }

                ModalManager(isPresenting: $isPresentingModal, modalType: $modalType, convertDreamId: .constant(nil), objectType: vm.filtering.filterObject, shouldDelete: .constant(false))
                    .frame(alignment:.bottom)
                
                if isPresentingMainMenu{
                    Setup(shouldClose: $isPresentingMainMenu)
                }
                
                SplashScreen(isPresenting: $isPresentingSplashScreen)
                
            }
            .ignoresSafeArea(.keyboard,edges:.bottom)
            .background(Color.specify(color: .grey0))
            .saveSize(in:$screenHeight)
            .onReceive(splashScreenTimer){ _ in
                withAnimation(.easeInOut(duration:0.7)){
                    isPresentingSplashScreen = false
                }
                
                splashScreenTimer.upstream.connect().cancel()
            }
            .onChange(of: vm.triggers.shouldPresentModal){ _ in
                isPresentingModal.toggle()
            }
            .onAppear{
                
                let isDoneWithTutorial = SetupStepType.fromString(from: UserDefaults.standard.string(forKey: SettingsKeyType.tutorial_step.toString()) ?? "") == .done
                
                if !isDoneWithTutorial{
                    UserDefaults.standard.set(false, forKey: SettingsKeyType.help_prompts_showing.toString())
                    UserDefaults.standard.set(true, forKey: SettingsKeyType.help_prompts_object.toString())
                    UserDefaults.standard.set(false, forKey: SettingsKeyType.help_prompts_content.toString())
                    vm.helpPrompts.object = true
                    vm.helpPrompts.showing = false
                    vm.helpPrompts.content = false
                    
                    isPresentingMainMenu = true
                    UserDefaults.standard.set(true, forKey: SettingsKeyType.finishedFirstLaunch.toString())
                }
                
                UIApplication.shared.applicationIconBadgeNumber = 0
            }
        }

    }
    
    func ShouldShowFloatingActionButton() -> Bool{
        
        if vm.unlockedObjects.fromObject(object: vm.filtering.filterObject) {
            return true
        }
        return false
    }
    
    func GetStackOffset() -> CGFloat {
        return -5
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}
