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
    
    @Binding var shouldDelete: Bool
    @State var isPresentingAdd = false
    @State var isPresentingSearch = false
    @State var isPresentingGrouping = false
    @State var isPresentingFilter = false
    @State var isPresentingNotification = false
    @State var isPresentingHelp = false
    @State var isPresentingEdit = false
    @State var isPresentingDelete = false
    
    @EnvironmentObject var dm: DataModel
    @EnvironmentObject var gs: GoalService
    
    var body: some View {
        ZStack(alignment: .top){
            
            ModalAdd(isPresenting: $isPresentingAdd, objectId: objectId, properties: Properties(), objectType: objectType ?? .goal, modalType: .add)
            ModalAdd(isPresenting: $isPresentingEdit, objectId: objectId, properties: properties ?? Properties(), objectType: objectType ?? .goal, modalType: .edit)
            ModalFilter(isPresenting: $isPresentingFilter)
            ModalSearch(isPresenting: $isPresentingSearch, objectType: objectType ?? .goal)
            ModalGrouping(isPresenting: $isPresentingGrouping)
            Modal(modalType: .delete, objectType: objectType ?? .goal, isPresenting: $isPresentingDelete, shouldConfirm: $shouldDelete, modalContent: {EmptyView()}, headerContent: {EmptyView()})
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
    
    func DeleteObject(){
        if objectId != nil {
            gs.DeleteGoal(id: objectId!)
        }

    }
}

struct ModalManager_Previews: PreviewProvider {
    static var previews: some View {
        ModalManager(isPresenting: .constant(true), modalType: .constant(.add), objectType: .goal, shouldDelete: .constant(false))
    }
}
