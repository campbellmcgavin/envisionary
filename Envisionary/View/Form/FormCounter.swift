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
    var total: Int? = nil
    var unit: UnitType? = nil
    var caption: String? = nil
    var additionalNumerator: Int = 0
    var denominator: Int? = nil
    var isSmall = false
    @State var fieldValueString = "1"
    @State var shouldGoUp = false
    @State var shouldGoDown = false
    
    var body: some View {
        HStack{
            if iconType != nil {
                IconLabel(size: SizeType.small, iconType: iconType!, iconColor: .grey4)
                    .padding(.leading,10)
                    .padding(.trailing,-10)
                    .padding(.top, isSmall ? -3 : 0)
            }
            ZStack(alignment:.topLeading){
                
                FormCaption(fieldName: fieldName, fieldValue: fieldValueString)
                
                HStack{
                    Text(String(fieldValue + additionalNumerator))
                        .scrollDismissesKeyboard(.interactively)
                        .padding([.leading,.top,.bottom])
                        .padding(.bottom, isSmall ? 0 : 5)
                        .frame(height: isSmall ? SizeType.mediumLarge.ToSize() : SizeType.largeMedium.ToSize())
                        .font(.specify(style: .body1))
                        .foregroundColor(.specify(color: .grey10))
                        .offset(y: 6)
                    Text(GetCaption())
                        .padding(.bottom, isSmall ? 0 : 5)
                        .frame(height: isSmall ? SizeType.mediumLarge.ToSize() : SizeType.largeMedium.ToSize())
                        .font(.specify(style: .body4))
                        .foregroundColor(.specify(color: .grey7))
                        .offset(y: 8)
                        .padding(.leading,-4)
                    
                    if let unit {
                        if let total{
                            Text("/\(total) \(unit.toString())")
                                .font(.specify(style: .body2))
                                .foregroundColor(.specify(color: .grey5))
                        }
                    }
                    if let caption {
                        Text(caption)
                            .font(.specify(style: .body3))
                            .foregroundColor(.specify(color: .grey5))
                            .offset(y: isSmall ? 4: 10)
                    }
                }

                Counter(fieldValue: $fieldValue, maxValue: maxValue, size: buttonSize)
                .offset(x:-10, y: isSmall ? 6 : 10)
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
                         
     func GetCaption() -> String{
         
         if denominator != nil{
             let denString = (denominator != nil ? "/ \(denominator!) " : " ")
             let unitString = unit?.toStringShort() ?? ""
             return denString + unitString
         }
         else{
             return ""
         }
     }
}

struct FormCounter_Previews: PreviewProvider {
    static var previews: some View {
        FormCounter(fieldValue: .constant(3), fieldName: "Number of months")
    }
}
