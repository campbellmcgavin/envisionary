//
//  FormDropdown.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/20/23.
//

import SwiftUI

struct FormDropdown: View {
    @Binding var fieldValue: String
    @Binding var isExpanded: Bool
    let fieldName: String
    var iconType: IconType?
    var color: CustomColor?

    
    var body: some View {
        HStack{
            if iconType != nil {
                IconLabel(size: SizeType.small, iconType: iconType!, iconColor: .grey4)
                    .padding(.leading,10)
                    .padding(.trailing,-10)
            }
            ZStack(alignment:.topLeading){
                
                FormCaption(fieldName: fieldName, fieldValue: fieldValue)
                
                Text($fieldValue.wrappedValue)
                    .scrollDismissesKeyboard(.interactively)
                    .padding()
                    .padding(.bottom,fieldValue.isEmpty ? 0 : 5)
                    .frame(minHeight:60)
                    .font(.specify(style: .body1))
                    .foregroundColor(.specify(color: .grey10))
                    .offset(y: fieldValue.isEmpty ? 0 : 8)
                    .animation(.default)

                HStack{
                    Spacer()
                    IconButton(isPressed: $isExpanded, size: .small, iconType: .down, iconColor: .grey6)
                        .rotationEffect(Angle(degrees: isExpanded ? 0.0 : -90.0))
                        .offset(y:10)
                        .shadow(color: Color.specify(color: .grey2), radius: 9)
                        .padding(.trailing,10)
                        .padding(.leading,-15)
                        .animation(.default)
                }

                
            }
        }

            .modifier(ModifierForm(color: color))
            .onTapGesture {
                isExpanded.toggle()
            }
    }
}

struct FormDropdown_Previews: PreviewProvider {
    static var previews: some View {
        FormDropdown(fieldValue: .constant("Academic"), isExpanded: .constant(true), fieldName: "Aspect")
    }
}
