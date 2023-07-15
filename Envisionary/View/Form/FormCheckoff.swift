//
//  FormCheckoff.swift
//  Envisionary
//
//  Created by Campbell McGavin on 7/12/23.
//

import SwiftUI

struct FormCheckoff: View {
    @Binding var fieldValue: Int
    @Binding var finishedLoad: Bool
    var caption: String?
    var iconType: IconType? = nil
    var color: CustomColor = .grey2
    let checkoffType: CheckOffType
    let totalAmount: Int
    var unitType: UnitType?
    @State var shouldComplete: Bool = false
    @State var shouldIncreaseAmount: Bool = false
    @State var shouldIncreaseAmountMuch: Bool = false
    @State var shouldDecreaseAmount: Bool = false
    var body: some View {
        HStack{
            if iconType != nil {
                IconLabel(size: SizeType.small, iconType: iconType!, iconColor: .grey4)
                    .padding(.leading,10)
                    .padding(.trailing,-10)
            }
            ZStack(alignment:.topLeading){
                
                if checkoffType == .amount{
                    FormCaption(fieldName: "Track", fieldValue: GetFieldValueString())
                }
                
                HStack{
                    
                    if checkoffType == .amount {
                        Text(String(fieldValue))
                            .padding([.leading,.bottom])
                            .padding(.top, checkoffType == .amount ? 15 : 0)
                            .frame(height: SizeType.mediumLarge.ToSize())
                            .font(.specify(style: .body1))
                            .foregroundColor(.specify(color: .grey10))
                            .offset(y: checkoffType == .amount ? 6 : 0)
                        Text(GetFieldValueString())
                            .frame(height: SizeType.mediumLarge.ToSize())
                            .font(.specify(style: .body4))
                            .foregroundColor(.specify(color: .grey7))
                            .offset(y: 8)
                            .padding(.leading,-4)
                    }
                    else{
                        Text("Finish up")
                            .scrollDismissesKeyboard(.interactively)
                            .padding([.leading,.top,.bottom])
                            .frame(height: SizeType.mediumLarge.ToSize())
                            .font(.specify(style: .h6))
                            .foregroundColor(.specify(color: .grey9))
//                            .offset(y: 6)
                    }
                    
                    Spacer()
                    
                    
                    if !GetIsComplete() && checkoffType == .amount{
                        IconButton(isPressed: $shouldDecreaseAmount, size: .medium, iconType: .down, iconColor: .grey10, circleColor: .grey3)
                            .disabled(fieldValue <= 0)
                            .opacity(fieldValue <= 0 ? 0.4 : 1.0)
                        IconButton(isPressed: $shouldIncreaseAmount, size: .medium, iconType: .up, iconColor: .grey10, circleColor: .grey3)
                        IconButton(isPressed: $shouldIncreaseAmountMuch, size: .medium, iconType: .up2, iconColor: .grey10, circleColor: .grey3)
                    }
                    
                    IconButton(isPressed: $shouldComplete, size: .medium, iconType: .confirm, iconColor: .grey10, circleColor: GetIsComplete() ? .green : .grey3)
                        .padding(.trailing,6)
                }
            }
        }
            .modifier(ModifierForm(color: color))
            .onAppear{
                shouldComplete = fieldValue >= totalAmount
            }
            .onChange(of: shouldIncreaseAmount){ _ in
                fieldValue += 1
            }
            .onChange(of: shouldIncreaseAmountMuch){ _ in
                fieldValue = (fieldValue + 5) > totalAmount ? totalAmount : fieldValue + 5
            }
            .onChange(of: shouldDecreaseAmount){ _ in
                fieldValue -= 1
            }
            .onChange(of: shouldComplete){
                _ in
                if finishedLoad{
                    fieldValue = GetIsComplete() ? 0 : totalAmount
                }
            }
    }
    
    func GetIsComplete() -> Bool {
        return fieldValue >= totalAmount
    }
    
    func GetFieldValueString() -> String{
        switch checkoffType {
        case .checkoff:
            return "Progress"
        case .amount:
            let denString = "/ \(totalAmount) "
            let unitString = unitType?.toStringShort() ?? ""
            return denString + unitString
        }
    }
}

struct FormCheckoff_Previews: PreviewProvider {
    static var previews: some View {
        FormCheckoff(fieldValue: .constant(0), finishedLoad: .constant(false), checkoffType: .checkoff, totalAmount: 10, unitType: .minutes)
    }
}
