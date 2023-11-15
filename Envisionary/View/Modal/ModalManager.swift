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
    @Binding var convertDreamId: UUID?
    
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
    @State var isPresentingFeedback = false
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
                case .feedback:
                    isPresentingFeedback = true
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
        .onChange(of: isPresentingFeedback){ _ in
            if isPresentingFeedback == false {
                isPresenting = false
            }
        }
    }
    
    @ViewBuilder
    func BuildModal() -> some View{
        switch modalType {
        case .add:
            ModalAdd(isPresenting: $isPresentingAdd, convertDreamId: $convertDreamId, objectId: nil, parentGoalId: GetParentGoalId(), parentChapterId: GetParentChapterId(), objectType: GetObjectType(), modalType: .add, status: statusToAdd)
        case .search:
            ModalSearch(isPresenting: $isPresentingSearch, objectType: objectType ?? .goal)
        case .settings:
            ModalSettings(isPresenting: $isPresentingGrouping)
        case .filter:
            ModalFilter(isPresenting: $isPresentingFilter)
        case .edit:
            ModalAdd(isPresenting: $isPresentingEdit, convertDreamId: .constant(nil), objectId: GetObjectId(), parentGoalId: GetParentGoalId(), parentChapterId: GetParentChapterId(), objectType: GetObjectType(), modalType: .edit)
        case .delete:
            Modal(modalType: .delete, objectType: objectType ?? .goal, isPresenting: $isPresentingDelete, shouldConfirm: $shouldDelete, isPresentingImageSheet: .constant(false), allowConfirm: true, modalContent: {EmptyView()}, headerContent: {EmptyView()}, bottomContent: {EmptyView()}, betweenContent: {EmptyView()})
        case .photoSource:
            ModalPhotoSource(objectType: GetObjectType(), isPresenting: $isPresentingPhotoSource, sourceType: $sourceType)
        case .feedback:
            ModalFeedback(isPresenting: $isPresentingFeedback)
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
        
        if modalType == .add && convertDreamId == nil{
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
    
    func ArchiveObject(){
        if let objectId {
            if let objectType {
                withAnimation{
                    switch objectType{
                    case .goal:
                        if let object = vm.GetGoal(id: objectId){
                            var request = UpdateGoalRequest(goal: object)
                            request.archived = true
                            _ = vm.UpdateGoal(id: objectId, request: request)
                        }
                    case .dream:
                        if let object = vm.GetDream(id: objectId){
                            var request = UpdateDreamRequest(dream: object)
                            request.archived = true
                            _ = vm.UpdateDream(id: objectId, request: request)
                        }
                    case .chapter:
                        if let object = vm.GetChapter(id: objectId){
                            var request = UpdateChapterRequest(chapter: object)
                            request.archived = true
                            _ = vm.UpdateChapter(id: objectId, request: request)

                            var criteria = Criteria()
                            criteria.chapterId = objectId
                            let entries = vm.ListEntries(criteria: criteria)
                            entries.forEach({
                                var entryRequest = UpdateEntryRequest(entry: $0)
                                entryRequest.archived = true
                                _ = vm.UpdateEntry(id: $0.id, request: entryRequest)
                            })
                        }
                    case .session:
                        _ = vm.DeleteSession(id: objectId)
                    case .habit:
                        if let object = vm.GetHabit(id: objectId){
                            var request = UpdateHabitRequest(habit: object)
                            request.archived = true
                            _ = vm.UpdateHabit(id: objectId, request: request)
                        }
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
        ModalManager(isPresenting: .constant(true), modalType: .constant(.add), convertDreamId: .constant(nil), objectType: .goal, shouldDelete: .constant(false))
    }
}
