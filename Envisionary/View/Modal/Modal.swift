//
//  Modal.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/17/23.
//

import SwiftUI

struct Modal<ModalContent: View, HeaderContent: View, BottomContent: View, BetweenContent: View>: View {
    let modalType: ModalType
    var objectType: ObjectType
    @Binding var isPresenting: Bool
    @Binding var shouldConfirm: Bool
    @Binding var isPresentingImageSheet: Bool
    var title: String?
    var subtitle: String?
    var image: UIImage?
    
    @ViewBuilder var modalContent: ModalContent
    @ViewBuilder var headerContent: HeaderContent
    @ViewBuilder var bottomContent: BottomContent
    @ViewBuilder var betweenContent: BetweenContent
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
                                Header(offset: $offset, title: GetTitle(), subtitle: GetSubtitle(), objectType: objectType, color: GetHeaderColor(), headerFrame: $headerFrame, isPresentingImageSheet: $isPresentingImageSheet, modalType: modalType, image: image, content: {headerContent})
                                
                                betweenContent
                                    .offset(y:offset.y < 150 ? 85 - offset.y/1.8 : -85)
                                
                                VStack{
                                    modalContent
                                    
                                    if GetIsMini(){
                                        Spacer()
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .modifier(ModifierCard(color: GetIsMini() ? .clear : .grey1))
                                .offset(y:offset.y < 150 ? -offset.y/1.5 : -100)
                                .frame(alignment:.leading)
                                .offset(y:100)
                                .padding(.bottom,200)
                            }
                            .frame(alignment:.top)
                    })
                    .safeAreaInset(edge: .bottom, content: {
                        if isPresenting{
                            bottomContent
                        }
                    })
                    .disabled(modalType == .delete)
                    .ignoresSafeArea()
                    
                    ModalMenu(modalType: modalType, objectType: objectType, color: GetHeaderColor(), shouldHelp: $shouldHelp, shouldClose: $isPresenting, shouldConfirm: $shouldConfirm)
                        .frame(alignment:.top)
                }
                .frame(alignment:.bottom)
                .frame(maxHeight:GetHeight())
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

    func GetIsMini() -> Bool {
        switch modalType {
        case .add:
            return false
        case .search:
            return false
        case .group:
            return false
        case .filter:
            return false
        case .notifications:
            return false
        case .help:
            return false
        case .edit:
            return false
        case .delete:
            return true
        case .photoSource:
            return true
        case .photo:
            return true
        }
    }
    
    func GetHeight() -> CGFloat {
        if modalType == .delete{
            return 250
        }
        else if modalType == .photoSource {
            return 500
        }
        return UIScreen.screenHeight - 50
    }
    
    func GetBackgroundColor() -> CustomColor {
        if modalType == .delete || modalType == .photoSource {
            return .grey2
        }
        return .grey0
    }
    
    
    func GetHeaderColor() -> CustomColor {
        if modalType == .delete || modalType == .photoSource{
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
        case .photoSource:
            return "Photo source"
        case .photo:
            return "Photo"
        }
    }
    
    func GetSubtitle() -> String{
        
        if subtitle != nil {
            return subtitle!
        }
        else{
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
            case .photoSource:
                return "Select"
            case .photo:
                return "View"
            }
        }

    }
}

struct Modal_Previews: PreviewProvider {
    static var previews: some View {
        Modal(modalType: .add, objectType: .goal, isPresenting: .constant(true), shouldConfirm: .constant(false),isPresentingImageSheet:.constant(false), title: Properties(objectType: .goal).title!, modalContent: {
//            HeaderButton(isExpanded: .constant(true), color: .grey10, header: "Hello")
//            HeaderButton(isExpanded: .constant(true), color: .grey10, header: "Hello")
//            HeaderButton(isExpanded: .constant(true), color: .grey10, header: "Hello")
//            HeaderButton(isExpanded: .constant(true), color: .grey10, header: "Hello")
//            HeaderButton(isExpanded: .constant(true), color: .grey10, header: "Hello")
            EmptyView()
        }, headerContent: {FormStackPicker(fieldValue: .constant("Goal"), fieldName: "Objects", options: .constant(ObjectType.allCases.map({$0.toString()})))}, bottomContent: {EmptyView()}, betweenContent: {EmptyView()})
    }
}
