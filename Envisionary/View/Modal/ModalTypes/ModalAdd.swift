//
//  ModalAdd.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/20/23.
//

import SwiftUI

struct ModalAdd: View {
    @Binding var isPresenting: Bool
    @Binding var isPresentingPhotoSource: Bool
    @Binding var sourceType: UIImagePickerController.SourceType?
    let objectId: UUID?
    var parentGoalId: UUID?
    var parentChapterId: UUID?
    let objectType: ObjectType
    let modalType: ModalType
    var status: StatusType?
    @StateObject var validator = FormPropertiesValidator()
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
        switch objectType {
        case .session:
            ModalAddSession(isPresenting: $isPresenting, sessionStep: .overview)
                .environmentObject(validator)
        default:
            ModalAddDefault(isPresenting: $isPresenting, isPresentingPhotoSource: $isPresentingPhotoSource, sourceType: $sourceType, objectId: objectId, parentGoalId: parentGoalId, parentChapterId: parentChapterId, objectType: objectType, modalType: modalType)
                .environmentObject(validator)
        }
    }
}

struct ModalAdd_Previews: PreviewProvider {
    static var previews: some View {
        ModalAdd(isPresenting: .constant(true), isPresentingPhotoSource: .constant(false), sourceType: .constant(.camera), objectId: UUID(), objectType: .goal, modalType: .add)
    }
}
