//
//  GadgetsMenu.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/9/23.
//

import SwiftUI

struct GadgetsMenu: View {
    @Binding var shouldPop: Bool
    @Binding var offset: CGPoint
    @Binding var isPresentingModal: Bool
    @Binding var modalType: ModalType
    @State var shouldShowHelpPrompts: Bool = false
    var filterCount: Int
    
    @State var shouldPresentFilterView: Bool = false
    @State var shouldPresentSettingsView: Bool = false
//    @State var shouldPresentHelpView: Bool = false
    @State var shouldPresentSearchView: Bool = false
    @State var shouldPresentFeedbackView: Bool = false
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
        HStack(alignment:.center){
            IconButton(isPressed: $shouldPresentSettingsView, size: .small, iconType: .settings, iconColor: .grey7)
            
            
//            if vm.filtering.filterObject.hasFilter(){
//                ZStack{
//                    IconButton(isPressed: $shouldPresentFilterView, size: .small, iconType: .filter, iconColor: .grey7)
//
//                    if filterCount > 0 {
//                        ZStack{
//                            Circle()
//                                .frame(width:14,height:14)
//                                .foregroundColor(.specify(color: .red))
//                            Text(String(filterCount))
//                                .font(.specify(style: .caption))
//                                .foregroundColor(.specify(color: .grey15))
//                        }
//                        .offset(x:8, y:-8)
//                    }
//
//                }
//            }
            
            if vm.filtering.filterObject.hasSearch(){
                IconButton(isPressed: $shouldPresentSearchView, size: .small, iconType: .search, iconColor: .grey7)
            }
            
            IconButton(isPressed: $shouldPresentFeedbackView, size: .small, iconType: .chat, iconColor: .grey7)
            
            Spacer()
//            if(offset.y < 200.0){
            
            
                IconButton(isPressed: $shouldPop, size: .small, iconType: .minimize, iconColor: .grey7)
                    .opacity((1.0 - offset.y/75.0) < 0 ? 0 : (1.0 - offset.y/75.0))
                    .disabled(offset.y > 75.0)
//            }
            
        }
        .padding(.top,5)
        .padding([.leading,.trailing,.bottom],8)
        .frame(height:55)
        .background(
            Color.specify(color: .grey1)
                .modifier(ModifierRoundedCorners(radius: 36))
//                .overlay(RoundedRectangle(cornerRadius: 36)
//                    .stroke(Color.specify(color: .grey05), lineWidth: 1))

                .edgesIgnoringSafeArea(.all)
                .padding(.top,-400)
                .frame(maxHeight:.infinity))
        .onChange(of:shouldPresentFilterView){
            _ in
            isPresentingModal.toggle()
            modalType = .filter
        }
        .onChange(of:shouldPresentSettingsView){
            _ in
            isPresentingModal.toggle()
            modalType = .settings
        }
        .onChange(of:shouldPresentSearchView){
            _ in
            isPresentingModal.toggle()
            modalType = .search
        }
        .onChange(of:shouldPresentFeedbackView){
            _ in
            isPresentingModal.toggle()
            modalType = .feedback
        }
    }
}

struct GadgetsMenu_Previews: PreviewProvider {
    static var previews: some View {
        GadgetsMenu(shouldPop: .constant(true), offset:.constant(.zero), isPresentingModal: .constant(true), modalType: .constant(.add), filterCount: 3)
            .environmentObject(ViewModel())
    }
}
