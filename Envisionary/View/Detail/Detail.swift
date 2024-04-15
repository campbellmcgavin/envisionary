//
//  Detail.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/11/23.
//

import SwiftUI

struct Detail: View {
    
    @State var objectType: ObjectType
    @State var objectId: UUID
    @State var isPresentingPhotoSource: Bool = false
    @State var sourceType: UIImagePickerController.SourceType? = nil
    @State var properties: Properties = Properties()
    @State var shouldDelete: Bool = false
    @State var headerFrame: CGSize = .zero
    @State var isPresentingModal: Bool = false
    @State var modalType: ModalType = .add
    @State var statusToAdd: StatusType = .notStarted
    @State var focusObjectid: UUID = UUID()
    @State var focusObjectType: ObjectType? = nil
    @State var image: UIImage? = nil
    @State var isPresentingImagePicker: Bool = false
    @State var newImage: UIImage? = nil
    @State var shouldMarkAsFavorite = true
    @State var shouldMarkAsArchived = false
    @State var finishedLoading = false
    @State var shouldAllowDelete = true
    @State var shouldConvertToGoal = false
    @State var convertDreamId: UUID? = nil
    @State var selectedImage: UIImage? = nil
    @EnvironmentObject var vm: ViewModel
    
    @Environment(\.presentationMode) private var dismiss
    
    var body: some View {
        
        ZStack(alignment:.top){
            
            ScrollViewReader{
                proxy in
                
                
                ScrollView(.vertical){
                    VStack(alignment:.center){
                        
                        Header(title: properties.title ?? "", subtitle: "View " + objectType.toString(), objectType: objectType, color: .purple, headerFrame: $headerFrame, isPresentingImageSheet: .constant(false), image: image, content: {EmptyView()})
                            .id(0)
                        
                        DetailStack(focusObjectId: $focusObjectid, isPresentingModal: $isPresentingModal, modalType: $modalType, statusToAdd: $statusToAdd, isPresentingSourceType: $isPresentingPhotoSource, shouldConvertToGoal: $shouldConvertToGoal, selectedImage: $selectedImage, properties: properties, objectId: objectId, objectType: objectType, proxy: proxy)
                    }
                    .onAppear{
                        proxy.scrollTo(0)
                    }
                    .frame(alignment:.top)
                    
                    Spacer()
                        .frame(height:UIScreen.screenHeight/2 + 100)
                }
                .scrollDismissesKeyboard(.interactively)
                .frame(width: UIScreen.screenWidth)
                .frame(maxWidth: UIScreen.screenWidth)
                .ignoresSafeArea()
                
            }
            
            DetailMenu(objectType: objectType, dismiss: dismiss, isPresentingModal: $isPresentingModal, modalType: $modalType, objectId: objectId, selectedObjectID: $focusObjectid, shouldMarkAsFavorite: $shouldMarkAsFavorite, shouldMarkAsArchived: $shouldMarkAsArchived, finishedLoading: $finishedLoading, shouldAllowDelete: shouldAllowDelete)
                .frame(alignment:.top)
            
            ModalManager(isPresenting: $isPresentingModal, modalType: $modalType, convertDreamId: $convertDreamId, objectType: GetObjectType(), objectId: focusObjectid, properties: properties, statusToAdd: statusToAdd, shouldDelete: $shouldDelete)
            
            ModalPhotoSource(objectType: .goal, isPresenting: $isPresentingPhotoSource, sourceType: $sourceType)
            
            HighlightImage(selectedImage: $selectedImage)
            
        }
        .frame(alignment:.center)
        .background(Color.specify(color: .grey0))
        .navigationBarHidden(true)
        .onAppear{
            RefreshProperties()
            focusObjectid = objectId
            focusObjectType = objectType
            RefreshImage()
            RefreshFavorite()
            RefreshArchive()
            ShouldAllowDelete()
            
            Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false) { timer in
                finishedLoading = true
            }
        }
        .onChange(of: shouldMarkAsFavorite){
            _ in
            
            if finishedLoading{
                if shouldMarkAsFavorite {
                    let request = CreatePromptRequest(type: .favorite, title: "", description: "", date: Date(), objectType: objectType, objectId: objectId)
                    _ = vm.CreatePrompt(request: request)
                }
                else{
                    if let prompt = vm.ListPrompts(criteria: Criteria(type: .favorite)).first(where: {$0.objectId == objectId}){
                        _ = vm.DeletePrompt(id: prompt.id)
                    }

                }
            }
        }
        .onChange(of: shouldMarkAsArchived){
            _ in
            
            if finishedLoading{
                switch objectType {
                case .dream:
                    var request = UpdateDreamRequest(properties: properties)
                    request.archived = shouldMarkAsArchived
                    _ = vm.UpdateDream(id: objectId, request: request)
                case .goal:
                    _ = vm.ArchiveGoal(id: objectId, shouldArchive: shouldMarkAsArchived)
                case .habit:
                    var request = UpdateHabitRequest(properties: properties)
                    request.archived = shouldMarkAsArchived
                    _ = vm.UpdateHabit(id: objectId, request: request)
                case .journal:
                    var request = UpdateChapterRequest(properties: properties)
                    request.archived = shouldMarkAsArchived
                    _ = vm.UpdateChapter(id: objectId, request: request)
                case .entry:
                    var request = UpdateEntryRequest(properties: properties)
                    request.archived = shouldMarkAsArchived
                    _ = vm.UpdateEntry(id: objectId, request: request)
                default:
                    let _ = "why"
                }
            }
        }
        .onChange(of: vm.updates){ _ in
            if let convertDreamId{
                self.objectId = convertDreamId
                self.convertDreamId = nil
                self.objectType = .goal
            }
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
        .onChange(of: shouldConvertToGoal){
            _ in
            
            if shouldConvertToGoal{
                modalType = .add
                isPresentingModal = true
                convertDreamId = objectId
            }
        }
        .onChange(of: isPresentingModal){
            _ in
            if !isPresentingModal{
                shouldConvertToGoal = false
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
    
    func GetObjectType() -> ObjectType {
        if objectType == .journal {
            if modalType == .add{
                return .entry
            }
        }
        else if objectType == .dream && shouldConvertToGoal{
            return .goal
        }
        return objectType
    }
    
    func RefreshFavorite(){
        shouldMarkAsFavorite = vm.ListPrompts(criteria: Criteria(type: .favorite)).contains(where:{$0.objectId != nil && $0.objectId == objectId})
    }
    
    func RefreshArchive(){
        shouldMarkAsArchived = properties.archived ?? false
    }
    
    func RefreshImage(){
        if properties.image != nil {
            image = vm.GetImage(id: properties.image!)
        }
    }
    
    func ShouldAllowDelete(){
        switch objectType{
        case .aspect:
            shouldAllowDelete = vm.ListAspects().count > 3
        case .value:
            shouldAllowDelete = vm.ListCoreValues().count > 3
        default:
            shouldAllowDelete = true
        }
    }
    
    func RefreshProperties(){
        switch objectType {
        case .value:
            properties = Properties(value: vm.GetCoreValue(id: objectId))
        case .dream:
            properties = Properties(dream: vm.GetDream(id: objectId))
        case .aspect:
            properties = Properties(aspect: vm.GetAspect(id: objectId))
        case .goal:
            properties = Properties(goal: vm.GetGoal(id: objectId))
        case .session:
            properties = Properties(session: vm.GetSession(id: objectId))
//        case .task:
//            properties = Properties(task: vm.GetTask(id: objectId))
        case .habit:
            properties = Properties(habit: vm.GetHabit(id: objectId))
        case .journal:
            properties = Properties(chapter: vm.GetChapter(id: objectId))
        case .entry:
            properties = Properties(entry: vm.GetEntry(id: objectId))
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
