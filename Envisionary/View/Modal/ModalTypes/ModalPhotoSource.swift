//
//  ModalPhotoSource.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/14/23.
//

import SwiftUI

struct ModalPhotoSource: View {
    let objectType: ObjectType
    @Binding var isPresenting: Bool
    @Binding var sourceType: UIImagePickerController.SourceType?
    @State var shouldSelectTakePhoto = false
    @State var shouldSelectCameraRoll = false
    
    var body: some View {
        Modal(modalType: .photoSource, objectType: .na, isPresenting: $isPresenting, shouldConfirm: .constant(false), isPresentingImageSheet: .constant(false), allowConfirm: true, modalContent: {
            VStack{
                TextIconButton(isPressed: $shouldSelectTakePhoto, text: "Take photo", color: .grey2, backgroundColor: .grey10, fontSize: .h3, shouldFillWidth: true)
                
                TextIconButton(isPressed: $shouldSelectCameraRoll, text: "Photo library", color: .grey10, backgroundColor: .grey3, fontSize: .h3, shouldFillWidth: true)
            }
            .padding([.bottom,.top])
        }, headerContent: {EmptyView()}, bottomContent: {EmptyView()}, betweenContent: {EmptyView()})
        .onChange(of: shouldSelectTakePhoto){
            _ in
            sourceType = .camera
        }
        .onChange(of: shouldSelectCameraRoll){
            _ in
            sourceType = .photoLibrary
        }
    }
}

struct ModalPhotoSource_Previews: PreviewProvider {
    static var previews: some View {
        ModalPhotoSource(objectType: .goal, isPresenting: .constant(true), sourceType: .constant(.camera))
    }
}
