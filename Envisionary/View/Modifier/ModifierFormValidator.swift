//
//  ModifierFormValidator.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/3/23.
//

import SwiftUI

struct ModifierFormValidator: ViewModifier {
    @Binding var fieldPropertyValidator: FormPropertyValidator
    @Binding var isValidForm: Bool
    let propertyType: PropertyType
    var hasIcon = true
    func body(content: Content) -> some View {
        ZStack(alignment:.topLeading){
            content
            if (!fieldPropertyValidator.isValid && fieldPropertyValidator.isDirty) || (!fieldPropertyValidator.isValid && !isValidForm){
                if let error = fieldPropertyValidator.error{
                    Text(error.toString(propertyType: propertyType))
                        .font(.specify(style: .subCaption))
                        .foregroundColor(.specify(color: .red))
                        .padding(.leading)
                        .offset(x: hasIcon ? SizeType.medium.ToSize() : 0, y: 44)
                }
            }
        }
    }
}
