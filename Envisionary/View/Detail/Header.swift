//
//  Header.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/17/23.
//

import SwiftUI

struct Header<Content: View>: View {
    @State var offset: CGPoint = .zero
    var title: String
    var subtitle: String
    var objectType: ObjectType
    let color: CustomColor
    @Binding var isPresentingImageSheet: Bool
    var modalType: ModalType?
    var image: UIImage?
    var headerFrame: CGFloat = 150
    @ViewBuilder var content: Content
    private let coordinateSpaceName = UUID()
    
    var body: some View {
        BuildHeader()
    

    }
    
    @ViewBuilder
    func BuildHeader() -> some View{
        ZStack{
            HeaderText(title: title, subtitle: subtitle, color: color, modalType: modalType, objectType: objectType, content: {content})
            if(ShouldShowImage()){
                HeaderImage(offset: offset, modalType: modalType, image: image, isPresentingImageSheet: $isPresentingImageSheet)
            }
        }
        .offset(y:GetOffset())
    }

    
    func GetScaleEffect() -> CGFloat {
//        let scale = modalType == nil ? (offset.y > 0 ?  1.0 : 1.0 - 0.0015 * offset.y) : 1
        let scale = (offset.y > 0 ?  1.0 : 1.0 - 0.0015 * offset.y)
        return scale
    }
    
    func GetOffset() -> CGFloat {
        let offset = modalType == nil ? (offset.y < 0 ? offset.y * 0.5 : 0) : 0
        return offset
    }
    
    func ShouldShowImage() -> Bool{
        return modalType == nil ? objectType.ShouldShowImage() : modalType!.ShouldShowImage(objectType: objectType)
    }
    
    func GetOpacity() -> CGFloat{
        let opacity = modalType == nil ? (1.0 - ((1.0 * offset.y/headerFrame*2))) : 1.0
        return opacity
    }
    
    func GetRadius() -> CGFloat{
        if offset.y > 0 {
            return abs( 36 - ((36 * offset.y/(headerFrame + (ShouldShowImage() ? 0 : 24)))))
        }
        return 36
    }
}
