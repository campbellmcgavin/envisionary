//
//  FormTextConfirm.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/9/23.
//

import SwiftUI

struct FormTextConfirm: View {
    @Binding var fieldValue: Bool
    let fieldName: String
    let fieldDescription: String
    var iconType: IconType?
    var color: CustomColor?
    var invalidColor: CustomColor?
    var shouldShowLock: Bool?
    var body: some View {
        
        HStack{
            if iconType != nil {
                IconLabel(size: SizeType.small, iconType: iconType!, iconColor: .grey4)
                    .padding(.leading,10)
                    .padding(.trailing,-20)
            }
            ZStack(alignment:.topLeading){
                FormCaption(fieldName: fieldName, fieldValue: fieldDescription)
                Text(fieldDescription)
                    .padding()
                    .multilineTextAlignment(.leading)
                    .frame(minHeight:60, alignment:.leading)
                    .font(.specify(style: .body3))
                    .foregroundColor(.specify(color: .grey10))
                    .offset(y: 6)
                    .animation(.default)
            }
            
            IconButton(isPressed: $fieldValue, size: .small, iconType: fieldValue ? .lock : .confirm, iconColor: GetIconColor(), circleColor: GetCircleColor(), opacity: GetOpacity(), circleOpacity: GetOpacity())
                .padding(.trailing,10)
                .disabled(fieldValue)
        }
            .modifier(ModifierForm(color: GetBackgroundColor()))
    }
    
    func GetBackgroundColor() -> CustomColor?{
        if let invalidColor{
            return fieldValue ? color : invalidColor
        }
        return color
    }
    func GetIconColor() -> CustomColor {
        return fieldValue ? .purple : .grey10
    }
    func GetCircleColor() -> CustomColor{
        return fieldValue ? .darkPurple : .grey4
    }
    func GetOpacity() -> Double{
        return fieldValue ? 1.0 : 0.4
    }
}

struct FormTextConfirm_Previews: PreviewProvider {
    static var previews: some View {
        FormTextConfirm(fieldValue: .constant(true), fieldName: "Confirm Deletion", fieldDescription: "Are you sure you want to delete this goal and all associated objects?")
    }
}
