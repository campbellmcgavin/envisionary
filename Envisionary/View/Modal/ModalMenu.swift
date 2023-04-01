//
//  ModalMenu.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/17/23.
//

import SwiftUI

struct ModalMenu: View {
    let modalType: ModalType
    let color: CustomColor
    @Binding var shouldHelp: Bool
    @Binding var shouldClose: Bool
    @Binding var shouldConfirm: Bool
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
                IconButton(isPressed: $shouldConfirm, size: .medium, iconType: .confirm, iconColor: color, circleColor: .grey10)
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
                return true
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
            }
        default:
            return false
        }
    }
}

struct ModalMenu_Previews: PreviewProvider {
    static var previews: some View {
        ModalMenu(modalType: .add, color: .purple, shouldHelp: .constant(true), shouldClose: .constant(true), shouldConfirm: .constant(true))
    }
}
