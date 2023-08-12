//
//  ModalAddDefault.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/8/23.
//

import SwiftUI

struct ModalAddDefault: View {
    @Binding var isPresenting: Bool
    @Binding var convertDreamId: UUID?
    let objectId: UUID?
    var parentGoalId: UUID?
    var parentChapterId: UUID?
    @State var properties: Properties = Properties()
    let objectType: ObjectType
    let modalType: ModalType
    var status: StatusType?
    @State var isPresentingPhotoSource: Bool = false
    @State var sourceType: UIImagePickerController.SourceType? = nil
    @State var shouldAct = false
    @State var filteredValues = [ValueType]()
    @State var isPresentingImagePicker: Bool = false
    @State var chapterString = ""
    @State var image: UIImage? = nil
    @State var images: [UIImage] = [UIImage]()
    @State var isValidForm: Bool = true
    @State var didAttemptToSave = false
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
        ZStack{
            Modal(modalType: modalType, objectType: objectType, isPresenting: $isPresenting, shouldConfirm: $shouldAct, isPresentingImageSheet: $isPresentingPhotoSource, allowConfirm: isValidForm, didAttemptToSave: didAttemptToSave,  title: GetTitle(), image: image, modalContent: {
                
                VStack(spacing:0){
                    
                    if parentGoalId != nil {
                        if let parentGoal = vm.GetGoal(id: parentGoalId!){
                            FormLabel(fieldValue: parentGoal.title, fieldName: "Parent goal", iconType: .arrow_up, shouldShowLock: true)
                                .padding(.bottom)
                            
                            if objectType == .goal{
                                Text("When a " + objectType.toString().lowercased() + " has a parent goal, the aspect is managed by the parent goal, and the dates are set to the parent goal's dates.")
                                    .frame(maxWidth:.infinity)
                                    .padding([.leading,.trailing])
                                    .padding(.bottom,40)
                                    .font(.specify(style: .caption))
                                    .foregroundColor(.specify(color: .grey4))
                                    .multilineTextAlignment(.leading)
                            }
                        }
                    }
                    
                    FormPropertiesStack(properties: $properties, images: $images, isPresentingPhotoSource: $isPresentingPhotoSource, isValidForm: $isValidForm, didAttemptToSave: $didAttemptToSave, objectType: objectType, modalType: modalType, parentGoalId: parentGoalId, convertDreamId: convertDreamId)
                        
                }
                .sheet(isPresented: $isPresentingImagePicker){
                    ImagePicker(image: $image, showImagePicker: self.$isPresentingImagePicker, sourceType: self.sourceType ?? .camera)
                }
                .onAppear{
                    SetupFields()
                    isValidForm = true
                }
                .padding(8)
                .onChange(of: image){
                    _ in
                    if image != nil {
                        sourceType = nil
                        isPresentingPhotoSource = false
                        if objectType.hasProperty(property: .images){
                            images.append(image!)
                        }
                    }

                }
                .onChange(of: shouldAct){ _ in
                    if isValidForm{
                        UpdateProperties()
                        TakeAction()
                    }
                    didAttemptToSave = true
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
            }, headerContent: {EmptyView()}, bottomContent: {EmptyView()}, betweenContent: {EmptyView()})
            ModalPhotoSource(objectType: objectType, isPresenting: $isPresentingPhotoSource, sourceType: $sourceType)
        }

    }
    
    func SaveImages(){
        
        // if object has the "singular image" property
        if objectType.hasProperty(property: .image)
        
            // and the image has been newly added
            && ( (properties.image == nil)
        
            // or the image has changed
            || (properties.image != nil && image != vm.GetImage(id: properties.image!)))
            
            // and image isn't blank
            && image != nil {
            let imageId = vm.CreateImage(image: image!)
            properties.image = imageId
        }
        
        // if object has the "plural images" property
        if objectType.hasProperty(property: .images){
            
            if properties.images == nil {
                properties.images = [UUID]()
            }
            
            // if this is a new object
            if objectId == nil{
                
                // if there exist an array of images
                if images.count > 0{
                    
                    // save all the images in data store and then add then to properties
                    for image in images{
                        properties.images!.append(vm.CreateImage(image: image))
                    }
                }
            }
            
            //else if this is an object that exists and is being updated
            else if objectId != nil && objectType.hasProperty(property: .images){
                
                //delete and remove all images
                if let propertiesImages = properties.images{
                    for imageId in propertiesImages{
                        _ = vm.DeleteImage(id: imageId)
                    }
                }
                properties.images!.removeAll()

                //add images
                for image in images{
                    properties.images!.append(vm.CreateImage(image: image))
                }
            }
        }
    }
    
    func GetTitle() -> String{
        if objectType == .emotion{
            return "Check-in"
        }
        if properties.title?.count ?? 0 > 0 {
            return properties.title ?? ""
        }
        else{
            if modalType == .add {
                return "New " + objectType.toString()
            }
            else{
                return "Empty " + objectType.toString()
            }
        }
    }
    
    func TakeAction(){

        SaveImages()
        
        switch objectType {
        case .value:
            if modalType == .add {
                _ = vm.CreateCoreValue(request: CreateCoreValueRequest(properties: properties))
            }
            if modalType == .edit  && objectId != nil {
                _ = vm.UpdateCoreValue(id: objectId!, request: UpdateCoreValueRequest(properties: properties))
            }
        case .dream:
            if modalType == .add {
                _ = vm.CreateDream(request: CreateDreamRequest(properties: properties))
            }
            if modalType == .edit  && objectId != nil {
                _ = vm.UpdateDream(id: objectId!, request: UpdateDreamRequest(properties: properties))
            }
        case .aspect:
            if modalType == .add {
                _ = vm.CreateAspect(request: CreateAspectRequest(properties: properties))
            }
            if modalType == .edit && objectId != nil  {
                _ = vm.UpdateAspect(id: objectId!, request: UpdateAspectRequest(properties: properties))
            }
        case .goal:
            if modalType == .add {
                if convertDreamId != nil {
                    _ = vm.DeleteDream(id: convertDreamId!)
                    convertDreamId = vm.CreateGoal(request: CreateGoalRequest(properties: properties))
                }
                else{
                    _ = vm.CreateGoal(request: CreateGoalRequest(properties: properties))
                }
            }
            if modalType == .edit && objectId != nil {
                _ = vm.UpdateGoal(id: objectId!, request: UpdateGoalRequest(properties: properties))
            }
//        case .task:
//            if modalType == .add {
//                _ = vm.CreateTask(request: CreateTaskRequest(properties: properties))
//            }
//            if modalType == .edit && objectId != nil {
//                _ = vm.UpdateTask(id: objectId!, request: UpdateTaskRequest(properties: properties))
//            }
        case .chapter:
            if modalType == .add {
                _ = vm.CreateChapter(request: CreateChapterRequest(properties: properties))
            }
            if modalType == .edit && objectId != nil {
                _ = vm.UpdateChapter(id: objectId!, request: UpdateChapterRequest(properties: properties))
            }
        case .entry:
            if modalType == .add {
                _ = vm.CreateEntry(request: CreateEntryRequest(properties: properties))
            }
            if modalType == .edit && objectId != nil {
                _ = vm.UpdateEntry(id: objectId!, request: UpdateEntryRequest(properties: properties))
            }
        case .habit:
            if modalType == .add {
                _ = vm.CreateHabit(request: CreateHabitRequest(properties: properties))
            }
            if modalType == .edit && objectId != nil {
                _ = vm.UpdateHabit(id: objectId!, request: UpdateHabitRequest(properties: properties))
            }
//        case .home:
//            <#code#>
//        case .entry:
//            <#code#>
        case .emotion:
            _ = vm.CreateEmotion(request: CreateEmotionRequest(properties: properties))
//        case .stats:
//            <#code#>
        default:
            let _ = ""
        }

        
        isPresenting = false
    }
    
    func SetupFields(){
        
        if modalType == .add{
            
            properties = Properties()
            
            if objectType == .goal{
                if convertDreamId != nil{
                    GetValuesFromDream()
                }
                else{
                    GetValuesFromParentGoalId()
                }
            }
            else if objectType == .entry{
                properties.chapterId = parentChapterId
            }
            
        }
        else if modalType == .edit{
            if objectId != nil {
                switch objectType {
                case .value:
                    if let coreValue = vm.GetCoreValue(id: objectId!){
                        properties = Properties(value: coreValue)
                    }
                case .aspect:
                    if let aspect = vm.GetAspect(id: objectId!){
                        properties = Properties(aspect: aspect)
                    }
                case .goal:
                    if let goal = vm.GetGoal(id: objectId!){
                        properties = Properties(goal: goal)
                    }
                    GetValuesFromParentGoalId()
                case .dream:
                    if let dream = vm.GetDream(id: objectId!){
                        properties = Properties(dream: dream)
                    }
                case .chapter:
                    if let chapter = vm.GetChapter(id: objectId!){
                        properties = Properties(chapter:chapter)
                    }
                case .entry:
                    if let entry = vm.GetEntry(id: objectId!){
                        properties = Properties(entry: entry)
                    }
                case .habit:
                    if let habit = vm.GetHabit(id: objectId!){
                        properties = Properties(habit: habit)
                    }
                default:
                    properties = Properties()
                }
            }
        }
        
        if let imageIds = properties.images {
            images.removeAll()
            for imageId in imageIds{
                if let image = vm.GetImage(id: imageId){
                    images.append(image)
                }
            }
        }
        
        if let imageId = properties.image {
            
            if let image = vm.GetImage(id: imageId){
                self.image = image
            }
        }
        else{
            image = nil
        }
    }
    
    func UpdateProperties(){
            
        if modalType == .add {
            properties.parentGoalId = parentGoalId
            properties.progress = status?.toInt() ?? 0
        }
    }

    func GetValuesFromParentGoalId() {
        if parentGoalId != nil {
            if let goal = vm.GetGoal(id: parentGoalId!){
                
                properties.startDate = goal.startDate
                properties.endDate =  goal.endDate
                properties.priority = goal.priority
                properties.aspect = goal.aspect
                
                if properties.image == nil {
                    properties.image = goal.image
                }
            }
        }
    }
    
    func GetValuesFromDream(){
        if let dream =  vm.GetDream(id: convertDreamId ?? UUID()){
            properties.title = dream.title
            properties.description = dream.description
            properties.startDate = Date()
            properties.endDate =  properties.startDate?.AdvanceDate(timeframe: .decade, forward: true)
            properties.timeframe = .decade
            properties.aspect = dream.aspect
            properties.image = dream.image
            properties.priority = .high
        }
    }
    
}

struct ModalAddDefault_Previews: PreviewProvider {
    static var previews: some View {
        ModalAddDefault(isPresenting: .constant(true), convertDreamId: .constant(nil), objectId: UUID(), objectType: .goal, modalType: .add)
    }
}
