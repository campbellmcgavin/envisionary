//
//  HeaderImage.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/14/23.
//

import SwiftUI

struct HeaderImage: View {
    
    var offset: CGPoint
    var headerFrame: CGSize
    var modalType: ModalType?
    var image: UIImage?
    @Binding var isPresentingImageSheet: Bool
    
    var body: some View {
        ZStack{
            
            ImageCircle(imageSize: GetCircleHeight(), image: image, iconSize: .large)
                .opacity(GetOpacity())
                .offset(y:offset.y > 0 ? headerFrame.height-offset.y/2 : headerFrame.height-offset.y/3)
            
            if modalType == .add || modalType == .edit {
                IconButton(isPressed: $isPresentingImageSheet, size: .medium, iconType: .photo, iconColor: .grey10, circleColor: .grey3)
                    .offset(x: headerFrame.height/2 - SizeType.extraSmall.ToSize(), y: offset.y > 0 ? SizeType.headerCircle.ToSize()/2 + headerFrame.height-offset.y : SizeType.headerCircle.ToSize()/2 + headerFrame.height-offset.y/3  - SizeType.extraSmall.ToSize())
                    .opacity(GetOpacity())
            }

        }
    }
    
    func GetOpacity() -> CGFloat{
            return  (1.0 - ((1.0 * offset.y/headerFrame.height*2)))
    }
    
    func GetCircleHeight() -> CGFloat{
        if offset.y < 0 {
            return SizeType.headerCircle.ToSize() - offset.y * 0.2
        }
        return SizeType.headerCircle.ToSize()
    }
}

struct HeaderImage_Previews: PreviewProvider {
    static var previews: some View {
        HeaderImage(offset: CGPointZero, headerFrame: CGSizeZero, modalType: .add, image: nil, isPresentingImageSheet: .constant(false))
    }
}
