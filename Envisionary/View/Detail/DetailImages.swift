//
//  DetailPhotos.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/21/23.
//

import SwiftUI

struct DetailImages: View {
    @Binding var shouldExpand: Bool
    @Binding var selectedImage: UIImage?
    let objectId: UUID
    let objectType: ObjectType
    
    @State var isExpanded: Bool = true
    @State var images: [UIImage] = [UIImage]()
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
        VStack(spacing:0){
            HeaderButton(isExpanded: $isExpanded, color: .grey10, header: "Images")
            
            if isExpanded {
                VStack(alignment:.leading, spacing:0){
                    if images.count > 0 {
                            if objectType == .journal{
                                    Text("The following are images associated with this chapter. To add additional images here, add entries with images.")
                                    .font(.specify(style: .caption))
                                    .foregroundColor(.specify(color: .grey4))
                                    .padding()
                            }
                            ImageStack(images: $images, shouldPopImagesModal: .constant(false), selectedImage: $selectedImage, isEditMode: false)
                                .frame(maxWidth:.infinity)
                                .padding([.top,.bottom])

                    }
                    else{
                        Text(objectType == .journal ? "Looks like you don't have any images yet. Add images in entries." : "Looks like you don't have any images yet. Edit this entry to add images.")
                            .font(.specify(style:.h6))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.specify(color: .grey3))
                            .padding(30)
                            .frame(maxWidth:.infinity)
                    }
                }
                .modifier(ModifierCard())
            }
        }
        .onChange(of:shouldExpand){
            _ in
            withAnimation{
                if shouldExpand{
                    isExpanded = true
                }
                else{
                    isExpanded = false
                }
            }
        }
        .onAppear{
            LoadImages()
        }
        .onChange(of: vm.updates.image){ _ in
            LoadImages()
        }
    }
    
    func LoadImages(){
        images.removeAll()
        withAnimation{
            DispatchQueue.global(qos:.userInteractive).async{
                images = [UIImage]()
                if objectType == .entry{
                    if let entry = vm.GetEntry(id: objectId){
                        for imageId in entry.images{
                            if let image = vm.GetImage(id: imageId){
                                images.append(image)
                            }
                        }
                    }
                }
                else if objectType == .journal{
                    var criteria = Criteria()
                    criteria.chapterId = objectId
                    let entries = vm.ListEntries(criteria: criteria)
                    
                    for entry in entries{
                        for imageId in entry.images{
                            if let image = vm.GetImage(id: imageId){
                                images.append(image)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct DetailPhotos_Previews: PreviewProvider {
    static var previews: some View {
        DetailImages(shouldExpand: .constant(true), selectedImage: .constant(nil), objectId: UUID(), objectType: .entry)
    }
}
