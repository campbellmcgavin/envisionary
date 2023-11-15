//
//  ContentView.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/7/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: ViewModel
    
    @State var offset: CGPoint = CGPoint(x: 0, y: 0)
    @State var offsetRate: CGPoint = CGPoint(x: 0, y: 0)
//    @State var headers = [String]()
    @State var filteredObjectsDictionary = [String:[UUID]]()
    @State var objectFrame: CGSize = .zero
    @State var calendarFrame: CGSize = .zero
    @State var headerFrame: CGSize = .zero
    @State var gadgetFrame: CGSize = .zero
    @State var screenHeight: CGSize = .zero
    @State var shouldPopScrollToHideHeader: Bool = false
    @State var isPresentingModal: Bool = false
    @State var isPresentingMainMenu: Bool = false
    @State var modalType: ModalType = .add
    @State private var scrollViewID = 1
    @State var isPresentingSplashScreen = true
    @State var isPresentingCalendarView = false
    @State private var splashScreenTimer = Timer.publish(every: 1.75, on: .main, in: .common).autoconnect()
    @State private var popHeaderTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var shouldDisableScrollViewTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State var filterCount = 0
    @State var shouldDisableScrollView = false
    @State var isFirstAppear: Bool = true
    @State var stackSize: CGSize = .zero
    var body: some View {
        NavigationStack{
            ZStack(alignment:.top){
                    VStack(spacing:0){
                        
                        ScrollViewReader{
                            proxy in
                            ObservableScrollView(showsIndicators: false, offset: $offset, content:{
                                
                                VStack{
                                    Spacer()
                                        .frame(height:0)
                                        .offset(y:-150)
                                        .id(0)
                                    ZStack(alignment:.top){
                                        
                                        GadgetsMenu(shouldPop: $shouldPopScrollToHideHeader, offset: $offset, isPresentingModal: $isPresentingModal, modalType: $modalType, filterCount: vm.filtering.filterCount)
                                            .id(2)
                                            .offset(y:GetGadgetsOffset())
                                            .saveSize(in: $gadgetFrame)
                                        
                                        ExpandedMenu(offset: $offset.y, frame: $objectFrame)
                                            .saveSize(in: $objectFrame)
                                            .offset(y:GetObjectOffset())
                                    }
                                    
                                    VStack(spacing:0){
                                        
                                        Spacer()
                                            .frame(height:100)
                                            .id(1)
                                        
                                        ContentViewStack(isPresenting: $isPresentingModal, modalType: $modalType, offset: $offset)
                                        
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
                                .onReceive(popHeaderTimer){ _ in
                                    withAnimation{
                                        
                                        
                                        popHeaderTimer.upstream.connect().cancel()
                                        shouldDisableScrollViewTimer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
                                        shouldDisableScrollView = true
                                        if offsetRate.y < 0 && offset.y < gadgetFrame.height + objectFrame.height {
                                            proxy.scrollTo(0, anchor:.top)
                                        }
                                        else{
                                            proxy.scrollTo(1, anchor:.top)
                                        }
                                    }
                                }
                                .frame(alignment:.top)
                               
                            })
                            .disabled(shouldDisableScrollView)
                        }
                    }
                    .frame(alignment:.top)

                //navigation
                VStack(spacing:0){
                    TopNavigationBar(offset: $offset.y, isPresentingSetup: $isPresentingModal, modalType: $modalType)
                    
                    Spacer()
                    
                    if (ShouldShowFloatingActionButton()){
                        FloatingActionButton(shouldAct: $isPresentingModal, modalType: $modalType)
                    }

                    BottomNavigationBar(selectedContentView: $vm.filtering.filterContent)
                }

                ModalManager(isPresenting: $isPresentingModal, modalType: $modalType, convertDreamId: .constant(nil), objectType: vm.filtering.filterObject, shouldDelete: .constant(false))
                    .frame(alignment:.bottom)
                
                if isPresentingMainMenu{
                    Setup(shouldClose: $isPresentingMainMenu)
                }
                
                SplashScreen(isPresenting: $isPresentingSplashScreen)
                
            }
            .background(Color.specify(color: .grey0))
            .saveSize(in:$screenHeight)
            .onReceive(splashScreenTimer){ _ in
                isPresentingSplashScreen = false
                splashScreenTimer.upstream.connect().cancel()
            }
            .onReceive(shouldDisableScrollViewTimer){ _ in
                shouldDisableScrollView = false
            }
            .onChange(of: vm.triggers.shouldPresentModal){ _ in
                isPresentingModal.toggle()
            }

            .onChange(of: vm.filtering){
                _ in
                vm.filtering.filterCount = vm.filtering.GetFilterCount()
            }
            .onChange(of: offset){ [offset] newOffset in
                                
                DispatchQueue.global(qos:.userInteractive).async{
                    
                    if abs(newOffset.y - offset.y) > 3{
                        offsetRate = CGPoint(x: newOffset.x - offset.x, y: newOffset.y - offset.y)
                    }

                    
                    if offset.y < (objectFrame.height + gadgetFrame.height) + 100 && offset.y > 20 && abs(offset.y - (objectFrame.height + gadgetFrame.height - 45)) > 10 {
                        popHeaderTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
                    }
                    else{
                        popHeaderTimer.upstream.connect().cancel()
                    }
                }
            }
            .onAppear{
                popHeaderTimer.upstream.connect().cancel()
                
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
        
        if vm.filtering.filterObject != .home && vm.filtering.filterObject != .creed && vm.unlockedObjects.fromObject(object: vm.filtering.filterObject) {
            return true
        }
        return false
    }
    
    func GetObjectOffset() -> CGFloat {
        return 40
    }
    
    func GetCalendarOffset() -> CGFloat {
        if offset.y < 0 {
            return objectFrame.height + GetObjectOffset() - offset.y * 0.1
        }
        return objectFrame.height + GetObjectOffset()
    }
    
    func GetGadgetsOffset() -> CGFloat {
        
        if offset.y < 0 {
            return GetCalendarOffset() + calendarFrame.height - offset.y * 0.2
        }
        return GetCalendarOffset() + calendarFrame.height
    }
    
    func GetStackOffset() -> CGFloat {
        if offset.y < -5 {
            return -5 - offset.y * 0.3
        }
        return -5
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}
