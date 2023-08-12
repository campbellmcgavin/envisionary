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
    @Binding var selectedImage: UIImage?
    
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    let isEditMode: Bool
    @State var imageSize: CGFloat = .zero
    @State var stackSize: CGSize = .zero
    var body: some View {
        
        VStack{
            WrapHStack(images, id:\.self, spacing:.constant(0)) { image in
                        ZStack{
                            
                            Button{
                                withAnimation{
                                    selectedImage = image
                                }
                            }
                        label:{
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: imageSize,height:imageSize)
                                .clipped()
                        }

                            
                            if isEditMode{
                                Button{
                                    images.removeAll(where: {$0 == image})
                                }
                            label:{
                                IconLabel(size: .extraSmall, iconType: .cancel, iconColor: .grey8, circleColor: .grey4)
                            }
                            .offset(x: imageSize/2 - 12, y: -imageSize/2 + 12)
                            }
                        }
            }
            .saveSize(in: $stackSize)
            .padding(20)
            
            if isEditMode{
                TextIconButton(isPressed: $shouldPopImagesModal, text: "Add images", color: .grey0, backgroundColor: .grey10, fontSize: .h3, shouldFillWidth: true)
            }
        }
        .onChange(of: stackSize.width){ _ in
            let screenWidth = stackSize.width
            let numberOfItems = (screenWidth / SizeType.largeish.ToSize()).rounded(.down)
            let screenWidthMod100 = screenWidth.truncatingRemainder(dividingBy: SizeType.largeish.ToSize())
            imageSize = SizeType.largeish.ToSize() + screenWidthMod100 / numberOfItems - 1
        }
    }
}

struct ImageStack_Previews: PreviewProvider {
    static var previews: some View {
        ImageStack(images: .constant([UIImage]()), shouldPopImagesModal: .constant(false), selectedImage: .constant(nil), isEditMode: false)
    }
}
