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
    
    @FocusState private var isFocused: Bool
    @State var shouldErase: Bool = false
    

    
    var body: some View {
        
        HStack{
            if iconType != nil {                
                IconLabel(size: SizeType.small, iconType: iconType!, iconColor: .grey4)
                    .padding(.leading,10)
                    .padding(.trailing,-10)
            }
            ZStack(alignment:.topLeading){
                
                FormCaption(fieldName: fieldName, fieldValue: fieldValue)
                
                
                HStack{
                    
                    TextField("", text: $fieldValue, axis: axis)
                        .scrollDismissesKeyboard(.interactively)
                        .submitLabel(axis == .horizontal ? .done : .return)
                        .padding()
                        .padding(.bottom,fieldValue.isEmpty ? 0 : 5)
                        .frame(minHeight:60)
                        .focused($isFocused)
                        .font(.specify(style: .body1))
                        .foregroundColor(.specify(color: .grey10))
                        .offset(y: fieldValue.isEmpty ? 0 : 8)
                        .animation(.default)
                        

                }
                .onChange(of: shouldErase){ _ in
                    fieldValue = ""
                }

                HStack{
                    Spacer()
                    if(fieldValue.count > 0 && isFocused){
                        IconButton(isPressed: $shouldErase, size: .extraSmall, iconType: .cancel, iconColor: .grey6, circleColor:.grey3)
                            .offset(y:10)
                            .shadow(color: Color.specify(color: .grey2), radius: 9)
                            .padding(.trailing,10)
                            .padding(.leading,-15)
                            .animation(.default)
//                            .frame(alignment:.topTrailing)
                    }
                }

                
            }
        }

            .modifier(ModifierForm(color: color))
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
