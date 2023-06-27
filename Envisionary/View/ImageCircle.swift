//
//  ImageCircle.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/15/23.
//

import SwiftUI

struct ImageCircle: View {
    var imageSize: CGFloat
    var image: UIImage?
    var iconSize: SizeType = .medium
    var icon: IconType? = nil
    var iconColor: CustomColor = .grey5
    var body: some View {
        
        if image == nil{
            ZStack{
                Circle()
                    .frame(width: imageSize, height: imageSize)
                    .frame(alignment: .center)
                    .foregroundColor(.specify(color: .grey2))
                
                if icon != nil {
                    IconLabel(size: iconSize, iconType: icon!, iconColor: iconColor)
                }
            }
        }
        else{
            Image(uiImage: image!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .frame(width: imageSize, height: imageSize)
                .frame(alignment: .center)
        }
    }
}

struct ImageCircle_Previews: PreviewProvider {
    static var previews: some View {
        ImageCircle(imageSize: SizeType.headerCircle.ToSize(), image: nil)
    }
}
