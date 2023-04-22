//
//  DetailPhotos.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/21/23.
//

import SwiftUI

struct DetailImages: View {
    @Binding var shouldExpand: Bool
    let objectId: UUID
    let objectType: ObjectType
    
    @State var isExpanded: Bool = true
    @State var images: [UIImage] = [UIImage]()
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
        VStack(spacing:0){
            HeaderButton(isExpanded: $isExpanded, color: .grey10, header: "Images")
            
            if isExpanded {
                ImageStack(images: $images, shouldPopImagesModal: .constant(false), isEditMode: false)
                    .frame(maxWidth:.infinity)
                    .padding([.top,.bottom])
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
            }
        }
    }
}

struct DetailPhotos_Previews: PreviewProvider {
    static var previews: some View {
        DetailImages(shouldExpand: .constant(true), objectId: UUID(), objectType: .entry)
    }
}
