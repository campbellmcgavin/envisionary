//
//  ImageStack.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/21/23.
//

import SwiftUI

struct ImageStack: View {
    @Binding var images: [UIImage]
    @Binding var shouldPopImagesModal: Bool
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    let isEditMode: Bool
    
    var body: some View {
        LazyVGrid(columns: gridItemLayout, spacing: 20) {
            ForEach(images, id:\.self) { image in
                ZStack{
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .clipped()
                        .frame(width: SizeType.large.ToSize(),height:SizeType.large.ToSize())
                    
                    if isEditMode{
                        Button{
                            images.removeAll(where: {$0 == image})
                        }
                        label:{
                            IconLabel(size: .small, iconType: .cancel, iconColor: .grey8, circleColor: .grey4)
                        }
                        .offset(x: SizeType.large.ToSize()/2, y: -SizeType.large.ToSize()/2)
                    }
                }
            }
            
            if isEditMode{
                Button{
                    shouldPopImagesModal.toggle()
                }
                label:{
                    ZStack{
                        Rectangle()
    //                        .aspectRatio(1,contentMode: .fit)
                            .foregroundColor(.specify(color: .grey3))
                            .frame(width:SizeType.large.ToSize(),height:SizeType.large.ToSize())
                        IconLabel(size: .medium, iconType: .add, iconColor: .grey7)
                    }
                }
            }
        }
    }
}

struct ImageStack_Previews: PreviewProvider {
    static var previews: some View {
        ImageStack(images: .constant([UIImage]()), shouldPopImagesModal: .constant(false), isEditMode: false)
    }
}
