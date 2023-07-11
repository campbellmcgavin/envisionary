////
////  ModalHelp.swift
////  Envisionary
////
////  Created by Campbell McGavin on 6/28/23.
////
//
//import SwiftUI
//
//struct ModalHelp: View {
//    
//    @Binding var isPresenting: Bool
//    
//    @EnvironmentObject var vm: ViewModel
//    
//    var body: some View {
//        Modal(modalType: .help, objectType: .home, isPresenting: $isPresenting, shouldConfirm: $isPresenting, isPresentingImageSheet: .constant(false), allowConfirm: true, modalContent: {GetContent()}, headerContent:{EmptyView()}, bottomContent: {EmptyView()}, betweenContent: {EmptyView()})
//            .onChange(of: vm.helpPrompts.object){
//                _ in
//                UserDefaults.standard.set(vm.helpPrompts.object, forKey: SettingsKeyType.help_prompts_object.toString())
//            }
//            .onChange(of: vm.helpPrompts.content){
//                _ in
//                UserDefaults.standard.set(vm.helpPrompts.content, forKey: SettingsKeyType.help_prompts_content.toString())
//            }
//            .onChange(of: vm.helpPrompts.showing){
//                _ in
//                UserDefaults.standard.set(vm.helpPrompts.showing, forKey: SettingsKeyType.help_prompts_showing.toString())
//            }
//        
//    }
//    
//    @ViewBuilder
//    func GetContent() -> some View {
//        VStack(spacing:10){
//            FormRadioButton(fieldValue: $vm.helpPrompts.content, fieldName: HelpPromptType.content.toString(), iconType: .help, color: .purple)
//            FormRadioButton(fieldValue: $vm.helpPrompts.object, fieldName: HelpPromptType.object.toString(), iconType: .help, color: .purple)
//            FormRadioButton(fieldValue: $vm.helpPrompts.showing, fieldName: HelpPromptType.showing.toString(), iconType: .help, color: .purple)
//        }
//        .padding(8)
//    }
//}
//
//struct ModalHelp_Previews: PreviewProvider {
//    static var previews: some View {
//        ModalHelp(isPresenting: .constant(true))
//    }
//}
