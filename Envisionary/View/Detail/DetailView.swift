//
//  DetailView.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/30/23.
//

import SwiftUI

struct DetailView<Content: View>: View {
    let viewType: ViewType
    @Binding var selectedObjectId: UUID
    @Binding var selectedObjectType: ObjectType
    @Binding var shouldExpandAll: Bool
    @Binding var expandedObjects: [UUID]
    @Binding var isPresentingModal: Bool
    @Binding var modalType: ModalType
    
    @ViewBuilder var content: Content
    
    @State var shouldDelete: Bool = false
    @State var shouldPushBack: Bool = false
    @State var shouldPushForward: Bool = false
    
    @State var shouldExpand: Bool = false
    @State var shouldMinimize: Bool = false
    @State var shouldChangePhoto: Bool = false
    @State var shouldEdit: Bool = false
    @State var shouldAdd: Bool = false
    @State var shouldGoTo: Bool = false
    
    var body: some View {
        HeaderWithContent(shouldExpand: $shouldExpandAll, headerColor: .grey10, header: viewType.toString(), content: {
            VStack(alignment:.leading){
                
                VStack(alignment:.leading, spacing:0){
                    Text(viewType.toDescription())
                        .font(.specify(style: .h5))
                        .foregroundColor(.specify(color: .grey8))
                    
                    Text("Select a " + selectedObjectType.toString() + " to get started.")
                        .font(.specify(style: .caption))
                        .foregroundColor(.specify(color: .grey4))
                        .padding(.bottom)
                    
                    DetailViewMenu(viewType: viewType, expandedObjects: $expandedObjects, selectedObjectId: $selectedObjectId, selectedObjectType: $selectedObjectType, modalType: $modalType, isPresentingModal: $isPresentingModal)
                    
                }
                .padding([.leading,.trailing,.top])
//                .padding(.bottom,3)
                
                
                
                content
                    .padding(.top, 25)
                    .padding(8)
                    .frame(alignment:.leading)
                    .modifier(ModifierCard(color:.grey15, radius: SizeType.cornerRadiusLarge.ToSize() - 8))
                    .padding([.leading,.trailing,.bottom],8)
                    .padding(.bottom,-4)

            }
            .padding(.top,5)
            
            .modifier(ModifierCard())
            
        })
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(viewType: .gantt, selectedObjectId: .constant(UUID()), selectedObjectType: .constant(.goal), shouldExpandAll: .constant(false), expandedObjects: <#Binding<[UUID]>#>, content: {DetailTree(shouldExpand: .constant(false), goalId: UUID(), focusGoal: .constant(UUID()))})
//    }
//}
