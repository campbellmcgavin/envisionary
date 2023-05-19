//
//  FormLabel.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/19/23.
//

import SwiftUI

struct FormLabel: View {
    var fieldValue: String
    let fieldName: String
    var iconType: IconType?
    var color: CustomColor?
    var shouldShowLock: Bool?
    var body: some View {
        
        HStack{
            if iconType != nil {
                IconLabel(size: SizeType.small, iconType: iconType!, iconColor: .grey4)
                    .padding(.leading,10)
                    .padding(.trailing,-20)
            }
            ZStack(alignment:.topLeading){
                
                FormCaption(fieldName: fieldName, fieldValue: fieldValue)
                
                HStack{
                    
                    Text(fieldValue)
                        .padding()
                        .padding(.bottom,fieldValue.isEmpty ? 0 : 5)
                        .frame(minHeight:60)
                        .font(.specify(style: .body1))
                        .foregroundColor(.specify(color: .grey10))
                        .offset(y: fieldValue.isEmpty ? 0 : 8)
                        .animation(.default)
                }
            }
            
            if(shouldShowLock == true){
                IconLabel(size: SizeType.small, iconType: .lock, iconColor: .purple, circleColor: .darkPurple)
                    .padding(.trailing,10)
            }

        }
            .modifier(ModifierForm(color: color))
    }
}

struct FormLabel_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            FormLabel(fieldValue: "Learn Spanish", fieldName:"Title")
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color.specify(color: .grey0))
    }
}
