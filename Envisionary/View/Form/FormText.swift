//
//  FormText.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/19/23.
//

import SwiftUI

struct FormText: View {
    @Binding var fieldValue: String
    let fieldName: String
    let axis: Axis
    var iconType: IconType?
    var color: CustomColor?
    var isMini: Bool = false
    var shouldShowErase = true
    @FocusState private var isFocused: Bool
    @State var shouldErase: Bool = false
    

    
    var body: some View {
        
        HStack{
            if iconType != nil {                
                IconLabel(size: SizeType.small, iconType: iconType!, iconColor: .grey4)
                    .padding(.leading, isMini ? 3 : 10)
                    .padding(.trailing,-10)
            }
            ZStack(alignment:.topLeading){
                
                if !isMini{
                    FormCaption(fieldName: fieldName, fieldValue: fieldValue)
                }
                
                HStack{
                    TextField("", text: $fieldValue, axis: axis)
                        .scrollDismissesKeyboard(.interactively)
                        .submitLabel(axis == .horizontal ? .done : .return)
                        .padding()
                        .padding(.bottom,fieldValue.isEmpty ? 0 : 5)
                        .frame(minHeight: isMini ? 40 : 60)
                        .frame(maxHeight: isMini ? 44 : 1000)
                        .focused($isFocused)
                        .font(.specify(style: .body1))
                        .foregroundColor(.specify(color: .grey10))
                        .offset(y: isMini ? 3 : fieldValue.isEmpty ? 0 : 6)
                }
                .onChange(of: shouldErase){ _ in
                    fieldValue = ""
                }

                HStack{
                    Spacer()
                    if(fieldValue.count > 0 && isFocused && shouldShowErase){
                        IconButton(isPressed: $shouldErase, size: .extraSmall, iconType: .cancel, iconColor: .grey6, circleColor:.grey3)
                            .offset(y: isMini ? 0 : 10)
                            .shadow(color: Color.specify(color: .grey2), radius: 9)
                            .padding(.trailing,10)
                            .padding(.leading,-15)
                            .animation(.default)
                    }
                }

                
            }
        }
        .transition(.slide)
        .modifier(ModifierForm(color: color, radius: isMini ? .cornerRadiusSmall : .cornerRadiusForm))
            .onTapGesture {
                isFocused = true
            }
    }
}

struct FormText_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            FormText(fieldValue: .constant("Goal"), fieldName:"Title", axis: .vertical)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color.specify(color: .grey0))
    }
}
