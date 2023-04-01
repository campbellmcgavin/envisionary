//
//  Modal.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/17/23.
//

import SwiftUI

struct Modal<ModalContent: View, HeaderContent: View>: View {
    let modalType: ModalType
    var objectType: ObjectType
    @Binding var isPresenting: Bool
    @Binding var shouldConfirm: Bool
    var title: String?
    @ViewBuilder var modalContent: ModalContent
    @ViewBuilder var headerContent: HeaderContent
    @State var shouldHelp: Bool = false
    @State var headerFrame: CGSize = .zero
    @State var offset: CGPoint = .zero
    var body: some View {
        
        

        
        
        ZStack(alignment:.bottom){
            if isPresenting{
                Color.specify(color: .grey0)
                    .opacity(0.9)
                    .ignoresSafeArea()
                    .onTapGesture{
                        isPresenting = false
                    }
                
                ZStack(alignment:.top){
                    
                    
                    ObservableScrollView(offset: $offset, content: {
                            
                            VStack{
                                Header(offset: $offset, title: GetTitle(), subtitle: GetSubtitle(), objectType: objectType, shouldShowImage: modalType.ShouldShowImage(objectType: objectType), color: GetHeaderColor(), headerFrame: $headerFrame, content: {headerContent})
                                
                                if modalType != .delete{
                                    VStack{
                                        modalContent
                                        

                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity, minHeight:UIScreen.screenHeight)
                                    .modifier(ModifierCard())
                                    .offset(y:offset.y < 150 ? -offset.y/1.5 : -100)
                                    .frame(alignment:.leading)
                                    .offset(y:100)
                                }
                            }
                            .frame(alignment:.top)
                    })
                    .disabled(modalType == .delete)
                    .ignoresSafeArea()
                    
                    ModalMenu(modalType: modalType, color: GetHeaderColor(), shouldHelp: $shouldHelp, shouldClose: $isPresenting, shouldConfirm: $shouldConfirm)
                        .frame(alignment:.top)
                    }
                .frame(alignment:.top)
                .frame(height:GetHeight())
                .frame(maxWidth: .infinity)
                .background(Color.specify(color: .grey0))
                .cornerRadius(SizeType.cornerRadiusLarge.ToSize(), corners: [.topLeft,.topRight])
                .transition(.move(edge:.bottom))
            }

            
            }
        .frame(maxWidth: .infinity, maxHeight:.infinity,alignment:.bottom)
        .ignoresSafeArea()
        .animation(.easeInOut)

    }
    

    
    func GetHeight() -> CGFloat {
        if modalType == .delete {
            return 250
        }
        return UIScreen.screenHeight - 50
    }
    
    func GetBackgroundColor() -> CustomColor {
        if modalType == .delete {
            return .grey2
        }
        return .grey0
    }
    
    
    func GetHeaderColor() -> CustomColor {
        if modalType == .delete {
            return .grey2
        }
        return .purple
    }
    
    func GetTitle() -> String{
        
        switch modalType {
        case .add:
            return title ?? ""
        case .search:
            return objectType.toPluralString()
        case .group:
            return "Grouping"
        case .filter:
            return "Filters"
        case .notifications:
            return "Notifications"
        case .help:
            return "Help"
        case .edit:
            return title ?? ""
        case .delete:
            return "Are you sure?"
        }
    }
    
    func GetSubtitle() -> String{
        
        switch modalType {
        case .add:
            return "Add " + objectType.toString()
        case .search:
            return "Search"
        case .group:
            return "View"
        case .filter:
            return "View"
        case .notifications:
            return "View"
        case .help:
            return "Find"
        case .edit:
            return "Edit " + objectType.toString()
        case .delete:
            return "Delete " + objectType.toString()
        }
    }
}

struct Modal_Previews: PreviewProvider {
    static var previews: some View {
        Modal(modalType: .add, objectType: .goal, isPresenting: .constant(true), shouldConfirm: .constant(false), title: Properties(objectType: .goal).title!, modalContent: {
//            HeaderButton(isExpanded: .constant(true), color: .grey10, header: "Hello")
//            HeaderButton(isExpanded: .constant(true), color: .grey10, header: "Hello")
//            HeaderButton(isExpanded: .constant(true), color: .grey10, header: "Hello")
//            HeaderButton(isExpanded: .constant(true), color: .grey10, header: "Hello")
//            HeaderButton(isExpanded: .constant(true), color: .grey10, header: "Hello")
            EmptyView()
        }, headerContent: {FormStackPicker(fieldValue: .constant("Goal"), fieldName: "Objects", options: ObjectType.allCases.map({$0.toString()}))})
    }
}
