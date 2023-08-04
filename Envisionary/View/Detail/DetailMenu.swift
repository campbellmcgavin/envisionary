//
//  DetailMenu.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/11/23.
//

import SwiftUI

struct DetailMenu: View {
    let objectType: ObjectType
    @Binding var dismiss: PresentationMode
    @Binding var isPresentingModal: Bool
    @Binding var modalType: ModalType
    var objectId: UUID
    @Binding var selectedObjectID: UUID
    @Binding var shouldMarkAsFavorite: Bool
    @Binding var finishedLoading: Bool
    var shouldAllowDelete: Bool
    @State var shouldPresentDelete: Bool = false
    @State var shouldPresentHelp: Bool = false
    @State var shouldPresentEdit: Bool = false
    @State var shouldPresentAdd: Bool = false
    @State var shouldGoBack: Bool = false
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        HStack(spacing:7){
            IconButton(isPressed: $shouldGoBack, size: .medium, iconType: .arrow_left, iconColor: .purple, circleColor: .grey10)
            Spacer()
            if objectType.hasDetailMenuButton(button: .delete) && shouldAllowDelete{
                IconButton(isPressed: $shouldPresentDelete, size: .medium, iconType: .delete, iconColor: .red, circleColor: .grey10)
            }
            if objectType.hasDetailMenuButton(button: .favorite){
                IconButton(isPressed: $shouldMarkAsFavorite, size: .medium, iconType: .favorite, iconColor: shouldMarkAsFavorite ? .purple : .grey8, circleColor: .grey10)
                    .disabled(!finishedLoading)
            }
//            if objectType.hasDetailMenuButton(button: .help){
//                IconButton(isPressed: $shouldPresentHelp, size: .medium, iconType: .help, iconColor: .purple, circleColor: .grey10)
//            }
            if objectType.hasDetailMenuButton(button: .edit){
                IconButton(isPressed: $shouldPresentEdit, size: .medium, iconType: .edit, iconColor: .purple, circleColor: .grey10)
            }
            if objectType.hasDetailMenuButton(button: .add) && ShouldAllowDelete(){
                IconButton(isPressed: $shouldPresentAdd, size: .medium, iconType: .add, iconColor: .purple, circleColor: .grey10)
            }
        }
        
        .frame(maxWidth: .infinity)
        .frame(height:50)
        .padding([.leading,.trailing])
        .padding(.bottom,10)
        .background(Color.specify(color: .purple)
            .ignoresSafeArea())
        .onChange(of: shouldGoBack){
            _ in
            $dismiss.wrappedValue.dismiss()
        }
        .onChange(of: shouldPresentDelete){ _ in
            modalType = .delete
            selectedObjectID = objectId
            isPresentingModal.toggle()
        }
        .onChange(of: shouldPresentHelp){ _ in
            modalType = .help
            selectedObjectID = objectId
            isPresentingModal.toggle()
        }
        .onChange(of: shouldPresentEdit){ _ in
            modalType = .edit
            selectedObjectID = objectId
            isPresentingModal.toggle()
        }
        .onChange(of: shouldPresentAdd){ _ in
            modalType = .add
            selectedObjectID = objectId
            isPresentingModal.toggle()
        }
//        .onChange(of: shouldPresent)
    }
    
    func ShouldAllowDelete() -> Bool{
        if objectType == .goal{
            return vm.GetGoal(id: objectId)?.timeframe != .day
        }
        return true
    }
}

//struct DetailMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailMenu(dismiss:.constant(PresentationMode), shouldPresentDelete: .constant(true), shouldPresentHelp: .constant(true), shouldPresentEdit: .constant(true), shouldPresentAdd: .constant(true))
//    }
//}
