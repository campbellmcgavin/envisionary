//
//  ContentViewMenu.swift
//  Envisionary
//
//  Created by Campbell McGavin on 11/15/23.
//

import SwiftUI

struct ContentViewMenu: View {
    @Binding var isPresentingModal: Bool
    @Binding var modalType: ModalType
    @Binding var shouldDisableScrollView: Bool
    let proxy: ScrollViewProxy
    
    @State private var popHeaderTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State var objectFrame = CGSize()
    @State var gadgetFrame = CGSize()
    @State var shouldPopScrollToHideHeader: Bool = false
    @State var offset = CGPoint()
    @State var offsetRate: CGPoint = CGPoint(x: 0, y: 0)
    
    private let coordinateSpaceName = UUID()
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
        PositionObservingView(coordinateSpace: .named(coordinateSpaceName), position: $offset, content: {
            ZStack(alignment:.top){
                
                GadgetsMenu(shouldPop: $shouldPopScrollToHideHeader, offset: $offset, isPresentingModal: $isPresentingModal, modalType: $modalType, filterCount: vm.filtering.filterCount)
                    .id(2)
                    .offset(y:GetGadgetsOffset())
                    .saveSize(in: $gadgetFrame)
                
                ExpandedMenu(offset: $offset.y, frame: $objectFrame)
                    .saveSize(in: $objectFrame)
                    .offset(y:GetObjectOffset())
                
                TopNavigationBar(offset: $offset.y, isPresentingSetup: $isPresentingModal, modalType: $modalType)
                    .offset(y: -offset.y)
            }
        })
        .onAppear{
            popHeaderTimer.upstream.connect().cancel()
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
        .onReceive(popHeaderTimer){ _ in
            withAnimation{
                popHeaderTimer.upstream.connect().cancel()
                shouldDisableScrollView = true
                if offsetRate.y < 0 && offset.y < gadgetFrame.height + objectFrame.height {
                    proxy.scrollTo(0, anchor:.top)
                }
                else{
                    proxy.scrollTo(1, anchor:.top)
                }
            }
        }
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
            return GetCalendarOffset() - offset.y * 0.2
        }
        return GetCalendarOffset()
    }
}

//struct ContentViewMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentViewMenu()
//    }
//}
