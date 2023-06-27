//
//  ModalMenu.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/17/23.
//

import SwiftUI

struct ModalMenu: View {
    let modalType: ModalType
    let objectType: ObjectType
    let color: CustomColor
    @Binding var shouldHelp: Bool
    @Binding var shouldClose: Bool
    @Binding var shouldConfirm: Bool
    @Binding var allowConfirm: Bool
    var body: some View {
        HStack{
            Spacer()
            
//            if ShouldShowButton(iconType: .help){
//                IconButton(isPressed: $shouldHelp, size: .medium, iconType: .help, iconColor: color, circleColor: .grey10)
//            }
            if ShouldShowButton(iconType: .cancel){
                IconButton(isPressed: $shouldClose, size: .medium, iconType: .cancel, iconColor: color, circleColor: .grey10)
            }
            if ShouldShowButton(iconType: .confirm){
                IconButton(isPressed: $shouldConfirm, size: .medium, iconType: .confirm, iconColor: color, circleColor: allowConfirm ? .grey10 : .red)
            }

        }
        .padding()
        .background(Color.specify(color: color))
    }
    
    func ShouldShowButton(iconType: IconType)-> Bool{
        switch iconType{
        case .cancel:
            return modalType != .group && modalType != .filter
        case .help:
            switch modalType {
            case .add:
                return true
            case .edit:
                return true
            default:
                return false
            }
        case .confirm:
            switch modalType {
            case .add:
                return objectType != .session
            case .search:
                return false
            case .group:
                return true
            case .filter:
                return true
            case .notifications:
                return false
            case .help:
                return false
            case .edit:
                return true
            case .delete:
                return true
            case .photoSource:
                return false
            case .photo:
                return false
            case .setup:
                return false
            }
        default:
            return false
        }
    }
}

struct ModalMenu_Previews: PreviewProvider {
    static var previews: some View {
        ModalMenu(modalType: .add, objectType: .goal, color: .purple, shouldHelp: .constant(true), shouldClose: .constant(true), shouldConfirm: .constant(true), allowConfirm: .constant(true))
    }
}
