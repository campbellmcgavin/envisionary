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
    
    @State var shouldPresentSettingsView: Bool = false
    @State var shouldPresentSearchView: Bool = false
    @State var shouldPresentFeedbackView: Bool = false
    @State var shouldPresentGroupBySelection: Bool = false
    
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
        
        HStack{
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    IconButton(isPressed: $shouldPresentSettingsView, size: .small, iconType: .settings, iconColor: .grey7)
                    
                    if vm.filtering.filterObject.hasSearch(){
                        IconButton(isPressed: $shouldPresentSearchView, size: .small, iconType: .search, iconColor: .grey7)
                    }
                    
                    IconButton(isPressed: $shouldPresentFeedbackView, size: .small, iconType: .chat, iconColor: .grey7)
                    
                    if ShouldDisplayGroupByButton(){
                        HStack{
                            IconButton(isPressed: $shouldPresentGroupBySelection, size: .small, iconType: .group, iconColor: .grey7, hasAnimation: true)
                            
                            if shouldPresentGroupBySelection{
                                HStack{
                                    ForEach(Array(GetGroupByFilters()), id:\.self){ grouping in
                                        Button{
                                            withAnimation{
                                                SetGrouping(grouping: grouping)
                                                shouldPresentGroupBySelection = false
                                            }
                                        }
                                    label:{
                                        TextIconLabel(text: grouping.toString(), color: .grey7, backgroundColor: GetGroupingColor(grouping: grouping), fontSize: .caption, shouldFillWidth: false, addHeight: -3)
                                    }
                                    }
                                }
                                .padding(.trailing,2)
                            }
                        }
                        .padding([.top,.bottom],-5)
                        .background(
                            Capsule()
                                .foregroundColor(.specify(color: shouldPresentGroupBySelection ? .grey15 : .grey1))
                                )
                                
                        .padding(.trailing)
                    }
                }
            }
            
            Spacer()
            Divider()
                .foregroundColor(.specify(color: shouldPresentGroupBySelection ? .grey15 : .grey1))
                .padding([.top,.bottom],3)
                .padding(.leading,-5)
            
            
                IconButton(isPressed: $shouldPop, size: .small, iconType: .minimize, iconColor: .grey7)
                    .opacity((1.0 - offset.y/75.0) < 0 ? 0 : (1.0 - offset.y/75.0))
                    .disabled(offset.y > 75.0)
            
        }
        .padding(.top,7)
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
        
        func SetGrouping(grouping: GroupingType){
            switch vm.filtering.filterObject{
            case .goal:
                vm.grouping.goal = GroupingType.allCases.first(where:{$0 == grouping}) ?? .title
                UserDefaults.standard.set(grouping.toString(), forKey: SettingsKeyType.group_goal.toString())
                
            case .journal:
                if vm.filtering.filterEntry{
                    vm.grouping.entry = GroupingType.allCases.first(where:{$0 == grouping}) ?? .title
                    UserDefaults.standard.set(grouping.toString(), forKey: SettingsKeyType.group_entry.toString())
                }
                else{
                    vm.grouping.chapter = GroupingType.allCases.first(where:{$0 == grouping}) ?? .title
                    UserDefaults.standard.set(grouping.toString(), forKey: SettingsKeyType.group_chapter.toString())
                }
            default:
                let _ = "why"
            }

        }
        
    func GetGroupByFilters() -> [GroupingType]{
        switch vm.filtering.filterObject{
        case .goal:
            return GroupingType.allCases.filter({$0.hasObject(object: .goal)})
        case .journal:
            if vm.filtering.filterEntry {
                return GroupingType.allCases.filter({$0.hasObject(object: .entry)})
            }
            else{
                return GroupingType.allCases.filter({$0.hasObject(object: .journal)})
            }
        default:
            return []
        }
    }
    
    func GetGroupByText() -> String{
        switch vm.filtering.filterObject{
        case .goal:
            return vm.grouping.goal.toString()
        case .journal:
            if vm.filtering.filterEntry {
                return vm.grouping.entry.toString()
            }
            else{
                return vm.grouping.chapter.toString()
            }
        default:
            return ""
        }
    }
    
    func GetGroupingColor(grouping: GroupingType) -> CustomColor{
        switch vm.filtering.filterObject{
        case .goal:
            return vm.grouping.goal == grouping ? .grey25 : .grey15
        case .journal:
            if vm.filtering.filterEntry{
                return vm.grouping.entry == grouping ? .grey25 : .grey15
            }
            return vm.grouping.chapter == grouping ? .grey25 : .grey15
        default:
            return .clear
        }
        
    }
    
    func ShouldDisplayGroupByButton() -> Bool{
        let object = vm.filtering.filterObject
        
        if object == .goal || object == .journal {
            return true
        }
        return false
    }
}

struct GadgetsMenu_Previews: PreviewProvider {
    static var previews: some View {
        GadgetsMenu(shouldPop: .constant(true), offset:.constant(.zero), isPresentingModal: .constant(true), modalType: .constant(.add), filterCount: 3)
            .environmentObject(ViewModel())
    }
}
