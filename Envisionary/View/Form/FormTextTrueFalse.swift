//
//  FormYesNo.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/8/23.
//

import SwiftUI

struct FormTextTrueFalse: View {
    @Binding var fieldValue: Bool
    let fieldName: String
    let fieldDescription: String
    var iconType: IconType?
    var color: CustomColor?
    
    @State var shouldTurnFalse = false
    @State var shouldTurnTrue = false
    
    var body: some View {
        HStack{
            if iconType != nil {
                IconLabel(size: SizeType.small, iconType: iconType!, iconColor: .grey4)
                    .padding(.leading,10)
                    .padding(.trailing,-10)
            }
            ZStack(alignment:.topLeading){
                
                FormCaption(fieldName: fieldName, fieldValue: "not empty!")
                
                HStack{
                    Text("\(fieldDescription)")
                        .padding()
                        .padding(.bottom, 5)
                        .frame(minHeight:60)
                        .font(.specify(style: .body4))
                        .foregroundColor(.specify(color: .grey10))
                        .offset(y: 6)
                }
            }
            Spacer()
            
            IconButton(isPressed: $shouldTurnFalse, size: .medium, iconType: .cancel, iconColor: .grey10, circleColor: fieldValue ? .darkRed : .red)
            IconButton(isPressed: $shouldTurnTrue, size: .medium, iconType: .confirm, iconColor: .grey10, circleColor: fieldValue ? .green : .darkGreen)
                .padding(.trailing)
        }
        .onChange(of: shouldTurnFalse){
            _ in
            
            fieldValue = false
        }
        .onChange(of: shouldTurnTrue){
            _ in
            
            fieldValue = true
        }
            .modifier(ModifierForm(color: color))
    }
}

struct FormYesNo_Previews: PreviewProvider {
    static var previews: some View {
        FormTextTrueFalse(fieldValue: .constant(true), fieldName: "Value Alignment", fieldDescription: "Kindness, Compassion, Honesty, Virtue, Hardwork, Comedy", iconType: .value)
            
    }
}
