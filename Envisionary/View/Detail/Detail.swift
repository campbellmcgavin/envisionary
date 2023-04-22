//
//  Detail.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/11/23.
//

import SwiftUI

struct Detail: View {
    
    let objectType: ObjectType
    let objectId: UUID
    @State var isPresentingPhotoSource: Bool = false
    @State var sourceType: UIImagePickerController.SourceType? = nil
    @State var properties: Properties = Properties()
    @State var shouldDelete: Bool = false
    @State var offset: CGPoint = .zero
    @State var headerFrame: CGSize = .zero
    @State var isPresentingModal: Bool = false
    @State var modalType: ModalType = .add
    @State var statusToAdd: StatusType = .notStarted
    @State var focusObjectid: UUID = UUID()
    @State var focusObjectType: ObjectType? = nil
    @State var image: UIImage? = nil
    @State var isPresentingImagePicker: Bool = false
    @State var newImage: UIImage? = nil
    @EnvironmentObject var vm: ViewModel
    
    @Environment(\.presentationMode) private var dismiss
    
    var body: some View {
        
        ZStack(alignment:.top){
            
            ObservableScrollView(offset: $offset, content:{
                
                ZStack(alignment:.top){
                    
                    LazyVStack(alignment:.leading){
                        Header(offset: $offset, title: properties.title ?? "", subtitle: "View " + objectType.toString(), objectType: objectType, color: .purple, headerFrame: $headerFrame, isPresentingImageSheet: .constant(false), image: image, content: {EmptyView()})
                        
//                        if(!isPresentingModal){
                        DetailStack(offset: $offset, focusObjectId: $focusObjectid, isPresentingModal: $isPresentingModal, modalType: $modalType, statusToAdd: $statusToAdd, isPresentingSourceType: $isPresentingPhotoSource, properties: properties, objectId: objectId, objectType: objectType)
//                        }
                    }
                }
                .frame(alignment:.top)
                
                Spacer()
                        .frame(height:250)
                
            })
            .ignoresSafeArea()

                
            DetailMenu(objectType: objectType, dismiss: dismiss, isPresentingModal: $isPresentingModal, modalType: $modalType, objectId: objectId, selectedObjectID: $focusObjectid)
                .frame(alignment:.top)
            
            ModalManager(isPresenting: $isPresentingModal, modalType: $modalType, objectType: objectType, objectId: focusObjectid, properties: properties, statusToAdd: statusToAdd, shouldDelete: $shouldDelete)
            
            ModalPhotoSource(objectType: .goal, isPresenting: $isPresentingPhotoSource, sourceType: $sourceType)
            
        }
        .background(Color.specify(color: .grey0))
        .navigationBarHidden(true)
        .onAppear{
            RefreshProperties()
            focusObjectid = objectId
            focusObjectType = objectType
            RefreshImage()
        }
        .onChange(of: vm.updates){ _ in
            RefreshProperties()
            RefreshImage()
        }
        .onChange(of: shouldDelete){ _ in

            if focusObjectid == objectId {
                dismiss.wrappedValue.dismiss()
            }
        }
        .onChange(of: isPresentingModal){
             _ in
            if !isPresentingModal {
                statusToAdd = .notStarted
            }
        }
        .onChange(of: statusToAdd){
            _ in
            print(statusToAdd)
        }
        .onChange(of: sourceType){
            _ in
            if sourceType != nil {
                isPresentingImagePicker = true
            }
            else{
                isPresentingImagePicker = false
            }
        }
        .sheet(isPresented: $isPresentingImagePicker){
            ImagePicker(image: $newImage, showImagePicker: self.$isPresentingImagePicker, sourceType: self.sourceType ?? .camera)
        }
        .onChange(of: newImage){ _ in
            
            if let goal = vm.GetGoal(id: focusObjectid){
                if let newImage{
                    var request = UpdateGoalRequest(goal: goal)
                    let imageId = vm.CreateImage(image: newImage)
                    request.image = imageId
                    _ = vm.UpdateGoal(id: goal.id, request: request)
                }
            }
            
            withAnimation{
                sourceType = nil
                isPresentingImagePicker = false
                isPresentingPhotoSource = false
            }
        }
    }
    
    func RefreshImage(){
        if properties.image != nil {
            DispatchQueue.global(qos:.userInteractive).async{
                withAnimation{
                    image = vm.GetImage(id: properties.image!)
                }
            }
        }
    }
    
    func RefreshProperties(){
        switch objectType {
        case .value:
            properties = Properties(value: vm.GetCoreValue(id: objectId))
//        case .creed:
//            <#code#>
        case .dream:
            properties = Properties(dream: vm.GetDream(id: objectId))
        case .aspect:
            properties = Properties(aspect: vm.GetAspect(id: objectId))
        case .goal:
            properties = Properties(goal: vm.GetGoal(id: objectId))
//        case .session:
//            <#code#>
//        case .task:
//            <#code#>
//        case .habit:
//            <#code#>
//        case .home:
//            <#code#>
//        case .chapter:
//            <#code#>
//        case .entry:
//            <#code#>
//        case .emotion:
//            <#code#>
//        case .stats:
//            <#code#>
        default:
            let _ = ""
        }
        
    }
}

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        Detail(objectType: .goal, objectId: UUID(), properties: Properties(objectType: .goal))
            .environmentObject(ViewModel())
    }
}
