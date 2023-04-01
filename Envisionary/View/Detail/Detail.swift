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
    @State var properties: Properties = Properties()
    @State var shouldDelete: Bool = false
    @State var offset: CGPoint = .zero
    @State var headerFrame: CGSize = .zero
    @State var isPresentingModal: Bool = false
    @State var modalType: ModalType = .add
    
    @State var focusObjectid: UUID = UUID()
    @State var focusObjectType: ObjectType? = nil
    
    @EnvironmentObject var gs: GoalService
    
    @Environment(\.presentationMode) private var dismiss
    
    var body: some View {
        
        ZStack(alignment:.top){
            
            ObservableScrollView(offset: $offset, content:{
                
                ZStack(alignment:.top){
                    
                    LazyVStack(alignment:.leading){
                        Header(offset: $offset, title: properties.title ?? "", subtitle: "View " + objectType.toString(), objectType: objectType, shouldShowImage: objectType.ShouldShowImage(), color: .purple, headerFrame: $headerFrame, content: {EmptyView()})
                        
//                        if(!isPresentingModal){
                            DetailStack(offset: $offset, focusObjectId: $focusObjectid, isPresentingModal: $isPresentingModal, modalType: $modalType, properties: properties, objectId: objectId, objectType: objectType)
//                        }
                    }
                }
                .frame(alignment:.top)
                
                Spacer()
                        .frame(height:250)
                
            })
            .ignoresSafeArea()

                
            DetailMenu(dismiss: dismiss, isPresentingModal: $isPresentingModal, modalType: $modalType, objectId: objectId, selectedObjectID: $focusObjectid)
                .frame(alignment:.top)
            
            
            ModalManager(isPresenting: $isPresentingModal, modalType: $modalType, objectType: objectType, objectId: focusObjectid, properties: properties, shouldDelete: $shouldDelete)
            
        }
        .background(Color.specify(color: .grey0))
        .navigationBarHidden(true)
        .onAppear{
            RefreshProperties()
            focusObjectid = objectId
            focusObjectType = objectType
        }
        .onChange(of: gs.goalsDictionary){ _ in
            RefreshProperties()
        }
        .onChange(of: shouldDelete){ _ in
            dismiss.wrappedValue.dismiss()
        }
    }
    
    func RefreshProperties(){
        properties = Properties(goal: gs.GetGoal(id: objectId))
    }
    
    @ViewBuilder
    func GetModalContent() -> some View {
        switch modalType {
        case .add:
            Text("Add new object")
        case .search:
            Text("Search")
        case .group:
            Text("Group")
        case .filter:
            Text("Filter")
        case .notifications:
            Text("Notifications")
        case .help:
            Text("Help")
        case .edit:
            Text("Edit")
        case .delete:
            Text("Delete")
        }
    }
}

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        Detail(objectType: .goal, objectId: UUID(), properties: Properties(objectType: .goal))
    }
}
