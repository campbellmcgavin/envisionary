//
//  FormCounter.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/20/23.
//

import SwiftUI

struct FormCounter: View {
    @Binding var fieldValue: Int
    var fieldName: String
    var iconType: IconType?
    var color: CustomColor?
    var buttonSize: SizeType = .small
    let minValue = 0
    var maxValue: Int = 20
    var unit: UnitType? = nil
    @State var fieldValueString = "1"
    @State var shouldGoUp = false
    @State var shouldGoDown = false
    
    var body: some View {
        HStack{
            if iconType != nil {
                IconLabel(size: SizeType.small, iconType: iconType!, iconColor: .grey4)
                    .padding(.leading,10)
                    .padding(.trailing,-10)
            }
            ZStack(alignment:.topLeading){
                
                FormCaption(fieldName: fieldName, fieldValue: fieldValueString)
                
                Text("\($fieldValue.wrappedValue) " + (unit?.toString() ?? ""))
                    .scrollDismissesKeyboard(.interactively)
                    .padding()
                    .padding(.bottom, 5)
                    .frame(minHeight:60)
                    .font(.specify(style: .body1))
                    .foregroundColor(.specify(color: .grey10))
                    .offset(y: 8)

                Counter(fieldValue: $fieldValue, maxValue: maxValue, size: buttonSize)
                .offset(x:-10, y:10)
                .onChange(of: fieldValue){
                    _ in
                    fieldValueString = String(fieldValue)
                }
                .onAppear{
                    fieldValueString = String(fieldValue)
                }

                
            }
        }
            .modifier(ModifierForm(color: color))
    }
}

struct FormCounter_Previews: PreviewProvider {
    static var previews: some View {
        FormCounter(fieldValue: .constant(3), fieldName: "Number of months")
    }
}
