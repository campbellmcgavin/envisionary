//
//  FormRadioButton.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/28/23.
//

import SwiftUI

struct FormRadioButton: View {
    @Binding var fieldValue: Bool
    let caption: String
    let fieldName: String
    var iconType: IconType?
    var color: CustomColor?
    var selectedColor: CustomColor = .grey9
    var body: some View {
        HStack{
            if iconType != nil {
                IconLabel(size: SizeType.small, iconType: iconType!, iconColor: .grey4)
                    .padding(.leading, 10)
                    .padding(.trailing,-16)
            }
            
            ZStack(alignment:.topLeading){
                
                FormCaption(fieldName: caption, fieldValue: String(fieldValue))
                HStack{
                    Text(fieldName)
                        .padding()
                        .padding(.bottom,fieldName.isEmpty ? 0 : 5)
                        .frame(height: SizeType.largeMedium.ToSize())
                        .font(.specify(style: .body1))
                        .foregroundColor(.specify(color: .grey10))
                        .offset(y: 6)
                    Spacer()
                    RadioButton(isSelected: $fieldValue, selectedColor: selectedColor)
                        .padding(.trailing,10)
                }
                .frame(height:60)
            }
        }

        .modifier(ModifierForm(color: color, radius: .cornerRadiusForm))
    }
}

struct FormRadioButton_Previews: PreviewProvider {
    static var previews: some View {
        FormRadioButton(fieldValue: .constant(true),caption: "Prompt", fieldName: "Objects", iconType: .help)
    }
}
