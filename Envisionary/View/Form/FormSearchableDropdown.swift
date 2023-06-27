//
//  FormSearchableDropdown.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/20/23.
//

import SwiftUI

struct FormSearchableDropdown: View {
    @Binding var fieldValue: String
    @Binding var isExpanded: Bool
    let fieldName: String
    let isSearchable: Bool
    
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
                    
                    TextField("", text: $fieldValue, axis: .horizontal)
                        .scrollDismissesKeyboard(.interactively)
                        .submitLabel(.done)
                        .padding()
                        .padding(.bottom,fieldValue.isEmpty ? 0 : 5)
                        .frame(minHeight:60)
                        .focused($isFocused)
                        .font(.specify(style: .body1))
                        .foregroundColor(.specify(color: .grey10))
                        .offset(y: fieldValue.isEmpty ? 0 : 6)
                        .animation(.default)
                }
                .onChange(of: shouldErase){ _ in
                    fieldValue = ""
                }
                .onChange(of: fieldValue){ _ in
                    fieldValue = fieldValue
                }
                .onChange(of: isExpanded){
                    _ in
                    isFocused = isExpanded
                }

                HStack{
                    Spacer()
                    if(fieldValue.count > 0 && isFocused && isSearchable){
                        IconButton(isPressed: $shouldErase, size: .extraSmall, iconType: .cancel, iconColor: .grey6, circleColor:.grey3)
                            .offset(y:10)
                            .shadow(color: Color.specify(color: .grey2), radius: 9)
                            .padding(.trailing,10)
                            .animation(.default)
                    }
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
