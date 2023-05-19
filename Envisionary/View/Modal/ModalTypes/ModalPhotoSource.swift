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
        Modal(modalType: .photoSource, objectType: .home, isPresenting: $isPresenting, shouldConfirm: .constant(false), isPresentingImageSheet: .constant(false), modalContent: {
            VStack{
                TextButton(isPressed: $shouldSelectTakePhoto, text: "Take photo", color: .grey2, backgroundColor: .grey10, style: .h3, shouldHaveBackground: true)
                TextButton(isPressed: $shouldSelectCameraRoll, text: "Photo library", color: .grey10, backgroundColor: .grey3, style: .h3, shouldHaveBackground: true)
            }
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
