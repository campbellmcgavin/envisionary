//
//  ModalManager.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/20/23.
//

import SwiftUI

struct ModalManager: View {
    
    @Binding var isPresenting: Bool
    @Binding var modalType: ModalType
    
    var objectType: ObjectType?
    var objectId: UUID?
    var properties: Properties?
    var statusToAdd: StatusType?
    
    @Binding var shouldDelete: Bool

    @State var isPresentingAdd = false
    @State var isPresentingSearch = false
    @State var isPresentingGrouping = false
    @State var isPresentingFilter = false
    @State var isPresentingNotification = false
    @State var isPresentingHelp = false
    @State var isPresentingEdit = false
    @State var isPresentingDelete = false
    @State var isPresentingPhotoSource = false
    @State var sourceType: UIImagePickerController.SourceType? = nil
    
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        ZStack(alignment: .top){
            BuildModal()
        }
        .frame(maxHeight:.infinity)
        .ignoresSafeArea()
        .onChange(of:isPresenting){ _ in
            if isPresenting {
                switch modalType {
                case .add:
                    isPresentingAdd = true
                case .search:
                    isPresentingSearch = true
                case .settings:
                    isPresentingGrouping = true
                case .filter:
                    isPresentingFilter = true
                case .notifications:
                    isPresentingNotification = true
                case .help:
                    isPresentingHelp = true
                case .edit:
                    isPresentingEdit = true
                case .delete:
                    isPresentingDelete = true
                case .photoSource:
                    let _ = "why"
                case .photo:
                    let _ = "why"
                }
            }
        }
        .onChange(of: isPresentingAdd){ _ in
            if isPresentingAdd == false {
                isPresenting = false
            }
        }
        .onChange(of: isPresentingSearch){ _ in
            if isPresentingSearch == false {
                isPresenting = false
            }
        }
        .onChange(of: isPresentingGrouping){ _ in
            if isPresentingGrouping == false {
                isPresenting = false
            }
        }
        .onChange(of: isPresentingFilter){ _ in
            if isPresentingFilter == false {
                isPresenting = false
            }
        }
        .onChange(of: isPresentingNotification){ _ in
            if isPresentingNotification == false {
                isPresenting = false
            }
        }
        .onChange(of: isPresentingHelp){ _ in
            if isPresentingHelp == false {
                isPresenting = false
            }
        }
        .onChange(of: isPresentingEdit){ _ in
            if isPresentingEdit == false {
                isPresenting = false
            }
        }
        .onChange(of: isPresentingDelete){ _ in
            if isPresentingDelete == false {
                isPresenting = false
            }
        }
        .onChange(of:shouldDelete){
            _ in
            isPresentingDelete = false
            DeleteObject()
        }
    }
    
    @ViewBuilder
    func BuildModal() -> some View{
        switch modalType {
        case .add:
            ModalAdd(isPresenting: $isPresentingAdd, isPresentingPhotoSource: $isPresentingPhotoSource, sourceType: $sourceType, objectId: nil, parentGoalId: GetParentGoalId(), parentChapterId: GetParentChapterId(), objectType: GetObjectType(), modalType: .add, status: statusToAdd)
        case .search:
            ModalSearch(isPresenting: $isPresentingSearch, objectType: objectType ?? .goal)
        case .settings:
            ModalSettings(isPresenting: $isPresentingGrouping)
        case .filter:
            ModalFilter(isPresenting: $isPresentingFilter)
        case .edit:
            ModalAdd(isPresenting: $isPresentingEdit, isPresentingPhotoSource: $isPresentingPhotoSource, sourceType: $sourceType, objectId: GetObjectId(), parentGoalId: GetParentGoalId(), parentChapterId: GetParentChapterId(), objectType: GetObjectType(), modalType: .edit)
        case .delete:
            Modal(modalType: .delete, objectType: objectType ?? .goal, isPresenting: $isPresentingDelete, shouldConfirm: $shouldDelete, isPresentingImageSheet: .constant(false), allowConfirm: true, modalContent: {EmptyView()}, headerContent: {EmptyView()}, bottomContent: {EmptyView()}, betweenContent: {EmptyView()})
        case .photoSource:
            ModalPhotoSource(objectType: GetObjectType(), isPresenting: $isPresentingPhotoSource, sourceType: $sourceType)
        default:
            EmptyView()
        }
    }

    
    func GetObjectType() -> ObjectType {
        if let objectType {
            
            switch objectType {
            case .creed:
                return .value
            default:
                return objectType
            }
        }
        return .goal
    }
    func GetParentGoalId() -> UUID?{
        
        if modalType == .add {
            return objectId
        }
        else if modalType == .edit{
            
            if objectType == .goal {
                return vm.GetGoal(id: objectId ?? UUID())?.parentId
            }
        }
        return nil
    }
    
    func GetParentChapterId() -> UUID?{
        if modalType == .add && objectType == .entry{
            let chapter = vm.GetChapter(id: objectId ?? UUID())
            return chapter?.id
        }
        return nil
    }
    
    func GetObjectId() -> UUID?{
        if modalType == .add {
            return nil
        }
        return objectId
    }
    
    func GetNewProperties() -> Properties{
        return Properties()
    }
    
    func DeleteObject(){
        if let objectId {
            if let objectType {
                withAnimation{
                    switch objectType{
                    case .goal:
                        _ = vm.DeleteGoal(id: objectId)
                    case .value:
                        _ = vm.DeleteCoreValue(id: objectId)
                    case .creed:
                        _ = vm.DeleteCoreValue(id: objectId)
                    case .aspect:
                        _ = vm.DeleteAspect(id: objectId)
                    case .dream:
                        _ = vm.DeleteDream(id: objectId)
                    case .chapter:
                        _ = vm.DeleteChapter(id: objectId)
                    case .emotion:
                        _ = vm.DeleteEmotion(id: objectId)
//                    case .task:
//                        _ = vm.DeleteTask(id: objectId)
                    case .session:
                        _ = vm.DeleteSession(id: objectId)
                    case .habit:
                        _ = vm.DeleteHabit(id: objectId)
                    default:
                        let _ = "why" //do nothing
                    }
                }
            }
        }
    }
}

struct ModalManager_Previews: PreviewProvider {
    static var previews: some View {
        ModalManager(isPresenting: .constant(true), modalType: .constant(.add), objectType: .goal, shouldDelete: .constant(false))
    }
}
