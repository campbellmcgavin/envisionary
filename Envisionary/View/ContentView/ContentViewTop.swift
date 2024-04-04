//
//  ContentViewTop.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/3/24.
//

import SwiftUI

struct ContentViewTop: View {
    @Binding var shouldPopScrollToHideHeader: Bool
    @Binding var isPresentingModal: Bool
    @Binding var modalType: ModalType
    @Binding var shouldDisableScrollView: Bool
    @Binding var shouldShowTopTitle: Bool
    let proxy: ScrollViewProxy
    @State var objectFrame: CGSize = .zero
    @State var headerFrame: CGSize = .zero
    @State var gadgetFrame: CGSize = .zero
    @State var offset: CGPoint = CGPoint(x: 0, y: 0)
    @State var offsetRate: CGPoint = CGPoint(x: 0, y: 0)
    @State private var popHeaderTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var shouldDisableScrollViewTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @EnvironmentObject var vm: ViewModel
    let coordinateSpaceName: UUID
    var body: some View {
        ZStack(alignment:.top){
            

            

            
            PositionObservingView(
                coordinateSpace: .named(coordinateSpaceName),
                position: Binding(
                    get: { offset },
                    set: { newOffset in
                        offset = CGPoint(
                            x: -newOffset.x,
                            y: -newOffset.y
                        )
                    }
                ),
                content: {
                    GadgetsMenu(shouldPop: $shouldPopScrollToHideHeader, offset: $offset, isPresentingModal: $isPresentingModal, modalType: $modalType, filterCount: vm.filtering.filterCount)
                        .id(2)
                        .offset(y:GetCalendarOffset())
                        .saveSize(in: $gadgetFrame)

                    ExpandedMenu(offset: $offset.y, frame: $objectFrame)
                        .saveSize(in: $objectFrame)
                        .offset(y:GetObjectOffset())
                }
            )
        }
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
                
                withAnimation{
                    if offset.y > 120 {
                        shouldShowTopTitle = true
                    }
                    else {shouldShowTopTitle = false}
                }
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
        .onReceive(shouldDisableScrollViewTimer){ _ in
            shouldDisableScrollView = false
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
    }
    
    func GetObjectOffset() -> CGFloat {
        if offset.y < 0 {
            return 40 + offset.y * 0.1
        }
        return 40
    }
    
    func GetCalendarOffset() -> CGFloat {
        return objectFrame.height + 40
    }
}

//struct ContentViewTop_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentViewTop(shouldPopScrollToHideHeader: <#Binding<Bool>#>, isPresentingModal: <#Binding<Bool>#>, modalType: <#Binding<ModalType>#>)
//    }
//}
