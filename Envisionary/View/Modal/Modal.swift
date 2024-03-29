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
    var allowConfirm: Bool = false
    var didAttemptToSave: Bool = false
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
                            
                        VStack(spacing:0){
                                Header(title: GetTitle(), subtitle: GetSubtitle(), objectType: objectType, color: GetHeaderColor(), headerFrame: $headerFrame, isPresentingImageSheet: $isPresentingImageSheet, modalType: modalType, image: image, content: {headerContent})
                                .padding(.bottom, objectType.ShouldShowImage() ? 10 : 0)
                                
                                betweenContent
                                    .offset(y:GetBetweenOffset())
                                
                                VStack{
                                    modalContent
                                    
                                    if GetIsMini(){
                                        Spacer()
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .modifier(ModifierCard(color: GetIsMini() ? .clear : .grey1))
                                .offset(y: GetOffset())
                                .frame(alignment:.leading)
                                .offset(y:100)
                                .padding(.bottom,500)
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
                    
                    ModalMenu(modalType: modalType, objectType: objectType, color: GetHeaderColor(), shouldHelp: $shouldHelp, shouldClose: $isPresenting, shouldConfirm: $shouldConfirm, allowConfirm: allowConfirm, didAttemptToSave: didAttemptToSave)
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
    
    func GetOffset() -> CGFloat{
        if offset.y < 150 {
            return -offset.y/1.5
        }
        else{
            return -100
        }
    }
    
    func GetBetweenOffset() -> CGFloat{
        
        if offset.y < 150{
            return 85 - offset.y/1.8
        }
        else{
            return -85
        }
    }

    func GetIsMini() -> Bool {
        switch modalType {
        case .add:
            return false
        case .search:
            return false
        case .settings:
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
        case .feedback:
            return false
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
        if modalType == .delete || modalType == .photoSource{
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
        case .settings:
            return "Settings"
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
        case .feedback:
            return "Feedback"
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
            case .settings:
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
            case .feedback:
                return "Submit your"
            }
        }

    }
}

struct Modal_Previews: PreviewProvider {
    static var previews: some View {
        Modal(modalType: .add, objectType: .goal, isPresenting: .constant(true), shouldConfirm: .constant(false),isPresentingImageSheet:.constant(false), allowConfirm: true, title: Properties(objectType: .goal).title!, modalContent: {
//            HeaderButton(isExpanded: .constant(true), color: .grey10, header: "Hello")
//            HeaderButton(isExpanded: .constant(true), color: .grey10, header: "Hello")
//            HeaderButton(isExpanded: .constant(true), color: .grey10, header: "Hello")
//            HeaderButton(isExpanded: .constant(true), color: .grey10, header: "Hello")
//            HeaderButton(isExpanded: .constant(true), color: .grey10, header: "Hello")
            EmptyView()
        }, headerContent: {FormStackPicker(fieldValue: .constant("Goal"), fieldName: "Objects", options: .constant(ObjectType.allCases.map({$0.toString()})))}, bottomContent: {EmptyView()}, betweenContent: {EmptyView()})
    }
}
