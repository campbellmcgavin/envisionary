//
//  RadioButton.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/28/23.
//

import SwiftUI

struct RadioButton: View {
    @Binding var isSelected: Bool
    var selectedColor: CustomColor = .grey9
    var deselectedColor: CustomColor = .grey5
    var switchColor: CustomColor = .grey35
    var iconColor: CustomColor = .grey3
    var iconType: IconType? = nil
    var body: some View {
        Button{
            withAnimation{
                isSelected.toggle()
            }
        }
        label:{
            ZStack{
                Capsule()
                    .frame(width:54, height:35)
                    .foregroundColor(.specify(color: switchColor))
                ZStack{
                    Circle()
                        .frame(width:25, height:25)
                        .foregroundColor(.specify(color: isSelected ? selectedColor : deselectedColor))
                    if let iconType{
                        IconLabel(size: .small, iconType: iconType, iconColor: isSelected ? iconColor : switchColor)
                    }
                }

                    .offset(x: isSelected ? 8 : -8)
            }
        }

    }
}

struct RadioButton_Previews: PreviewProvider {
    static var previews: some View {
        RadioButton(isSelected: .constant(true))
    }
}
