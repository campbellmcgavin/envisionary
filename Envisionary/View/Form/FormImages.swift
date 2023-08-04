//
//  FormImages.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/21/23.
//

import SwiftUI

struct FormImages: View {
    
    @Binding var fieldValue: [UIImage]
    @Binding var shouldPopImagesModal: Bool
    let fieldName: String
    var iconType: IconType?
    @State var isExpanded: Bool = false
    @State var fieldValueString = ""


    var body: some View {
        ZStack(alignment:.topLeading){
            
            VStack{
                FormDropdown(fieldValue: $fieldValueString, isExpanded: $isExpanded, fieldName: fieldName, iconType: iconType)
                if isExpanded{
                    ImageStack(images: $fieldValue, shouldPopImagesModal: $shouldPopImagesModal, selectedImage: .constant(nil), isEditMode: true)
                        .padding([.top,.bottom])
                }
            }
            .transition(.move(edge:.bottom))
            .modifier(ModifierForm(color:.grey15))
            
        }
        
        .onAppear{
            GetFieldValueString()
        }
        .onChange(of: fieldValue){ _ in
           GetFieldValueString()
        }
        .animation(.easeInOut)
    }
    
    func GetFieldValueString(){
        fieldValueString = String(fieldValue.count) + " images"
    }
}

struct FormImages_Previews: PreviewProvider {
    static var previews: some View {
        FormImages(fieldValue: .constant([UIImage]()), shouldPopImagesModal: .constant(false), fieldName: PropertyType.images.toString())
    }
}
