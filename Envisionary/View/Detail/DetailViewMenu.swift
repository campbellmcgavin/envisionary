////
////  DetailViewMenu.swift
////  Envisionary
////
////  Created by Campbell McGavin on 3/30/23.
////
//
//import SwiftUI
//
//struct DetailViewMenu: View {
//    
//    let viewType: ViewType
//
//    @Binding var expandedObjects: [UUID]
//    @Binding var selectedObjectId: UUID
//    @Binding var selectedObjectType: ObjectType
//    @Binding var modalType: ModalType
//    @Binding var isPresentingModal: Bool
//    @Binding var shouldPushBack: Bool
//    @Binding var shouldPushForward: Bool
//    var shouldEnable: Bool
//    
//
//    
////    @EnvironmentObject var gs: GoalService
//    
//    var body: some View {
//        
//        HStack{
//            IconButton(isPressed: $shouldDelete, size: .medium, iconType: .delete, iconColor: .red, circleColor: .grey2)
//            Spacer()
//            
//            if viewType.shouldHaveButton(button: .timeBack){
//                IconButton(isPressed: $shouldPushBack, size: .medium, iconType: .timeBack, iconColor: .grey9, circleColor: .grey2)
//                IconButton(isPressed: $shouldPushForward, size: .medium, iconType: .timeForward, iconColor: .grey9, circleColor: .grey2)
//            }
//            if viewType.shouldHaveButton(button: .expand) && selectedGoal?.timeframe != .day && selectedGoal?.children.count ?? 0 > 0 {
//                if expandedObjects.contains(selectedObjectId){
//                    IconButton(isPressed: $shouldExpand, size: .medium, iconType: .minimize, iconColor: .grey9, circleColor: .grey2)
//                }
//                else{
//                    IconButton(isPressed: $shouldExpand, size: .medium, iconType: .maximize, iconColor: .grey9, circleColor: .grey2)
//                }
//                
//            }
//            
//            IconButton(isPressed: $shouldChangePhoto, size: .medium, iconType: .photo, iconColor: .grey9, circleColor: .grey2)
//            IconButton(isPressed: $shouldEdit, size: .medium, iconType: .edit, iconColor: .grey9, circleColor: .grey2)
//            
//            if selectedGoal?.timeframe != .day {
//                IconButton(isPressed: $shouldAdd, size: .medium, iconType: .add, iconColor: .grey9, circleColor: .grey2)
//            }
//            
//            NavigationLink(destination: Detail(objectType: selectedObjectType, objectId: selectedObjectId), label:
//                            {
//                IconButton(isPressed: $shouldGoTo, size: .medium, iconType: .arrow_right, iconColor: .grey9, circleColor: .grey2)
//                    .disabled(true)
//            })
//        }
//        .opacity(ShouldEnable() ? 1.0 : 0.4)
//        .disabled(!ShouldEnable())
//        .onChange(of: shouldExpand){
//            _ in
//            withAnimation{
//                if expandedObjects.contains(selectedObjectId){
//                    expandedObjects.removeAll(where: {$0 == selectedObjectId})
//                }
//                else{
//                    expandedObjects.append(selectedObjectId)
//                }
//            }
//        }
//        .onChange(of: shouldDelete){ _ in
//            modalType = .delete
//            isPresentingModal.toggle()
//        }
//        .onChange(of: shouldAdd){ _ in
//            modalType = .add
//            isPresentingModal.toggle()
//        }
//        .onChange(of: shouldEdit){ _ in
//            modalType = .edit
//            isPresentingModal.toggle()
//        }
//        .onChange(of: shouldGoTo){ _ in
//            modalType = .delete
//            isPresentingModal.toggle()
//        }
//        
//    }
//        func ShouldEnable() -> Bool {
//            return gs.GetGoal(id: selectedObjectId) != nil
//        }
//    }
//}
//
////struct DetailViewMenu_Previews: PreviewProvider {
////    static var previews: some View {
////        DetailViewMenu(viewType: .tree, shouldDelete: .constant(false), shouldPushBack: .constant(false), shouldPushForward: .constant(false), shouldExpand: .constant(false), shouldChangePhoto: .constant(false), shouldEdit: .constant(false), shouldAdd: .constant(false), shouldGoTo: .constant(false))
////    }
////}
