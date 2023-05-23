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
            
            ModalAdd(isPresenting: $isPresentingAdd, isPresentingPhotoSource: $isPresentingPhotoSource, sourceType: $sourceType, objectId: nil, parentId: GetParentId(), objectType: GetObjectType(), modalType: .add, status: statusToAdd)
            ModalAdd(isPresenting: $isPresentingEdit, isPresentingPhotoSource: $isPresentingPhotoSource, sourceType: $sourceType, objectId: GetObjectId(), parentId: GetParentId(), objectType: GetObjectType(), modalType: .edit)
            ModalFilter(isPresenting: $isPresentingFilter)
            ModalSearch(isPresenting: $isPresentingSearch, objectType: objectType ?? .goal)
            ModalGrouping(isPresenting: $isPresentingGrouping)
            Modal(modalType: .delete, objectType: objectType ?? .goal, isPresenting: $isPresentingDelete, shouldConfirm: $shouldDelete, isPresentingImageSheet: .constant(false), modalContent: {EmptyView()}, headerContent: {EmptyView()}, bottomContent: {EmptyView()}, betweenContent: {EmptyView()})
            ModalPhotoSource(objectType: GetObjectType(), isPresenting: $isPresentingPhotoSource, sourceType: $sourceType)
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
                case .group:
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
    func GetParentId() -> UUID?{
        
        if modalType == .add {
            return objectId
        }
        else if modalType == .edit{
            return vm.GetGoal(id: objectId ?? UUID())?.parentId
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
                    case .task:
                        _ = vm.DeleteTask(id: objectId)
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
