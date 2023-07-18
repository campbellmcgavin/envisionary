//
//  FormDragger.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/25/23.
//

import SwiftUI

struct FormSlider: View {
    @Binding var fieldValue: Int
    let fieldName: String
    var iconType: IconType?
    @State var isExpanded: Bool = false
    @State var fieldValueString = ""
    var body: some View {
        ZStack(alignment:.topLeading){
            
            VStack{
                FormDropdown(fieldValue: $fieldValueString, isExpanded: $isExpanded, fieldName: fieldName, iconType: iconType)
                if isExpanded{
                    CustomSlider(value: $fieldValue)
                        .padding()
                        .frame(height:50,alignment:.center)
                        .padding(.bottom,10)
                }
            }
            .transition(.move(edge:.bottom))
            .modifier(ModifierForm(color:.grey15))
            .onAppear{
                fieldValueString = String(fieldValue) + "%"
            }
        }
        
        .onAppear{
            if fieldValue < 0 {
                fieldValue = 0
            }
            else if fieldValue > 100 {
                fieldValue = 100
            }
        }
        .onChange(of: fieldValue){
            _ in
            fieldValueString = String(fieldValue)
        }
        .animation(.easeInOut)
    }
}

struct FormSlider_Previews: PreviewProvider {
    static var previews: some View {
        FormSlider(fieldValue: .constant(30), fieldName: "Progress")
    }
}
