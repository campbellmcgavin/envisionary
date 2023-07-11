//
//  LargeTextButtonWithicon.swift
//  Envisionary
//
//  Created by Campbell McGavin on 7/1/23.
//

import SwiftUI

struct LargeTextButtonWithicon: View {
    @Binding var isPressed: Bool
    
    var body: some View {
        HStack{
            Spacer()
            
            Button(){
                isPressed.toggle()
            }
        label:{
            ZStack{
                Capsule()
                    .frame(width:250, height: SizeType.large.ToSize())
                    .foregroundColor(.specify(color: .grey10))
                Text("Get Envisioning")
                    .offset(x:-40)
                    .font(.specify(style: .h4))
                    .foregroundColor(.specify(color: .grey0))
                IconLabel(size: .mediumLarge, iconType: .right, iconColor: .grey10, circleColor:.grey0)
                    .offset(x:87)
            }
            }
//                                TextButton(isPressed: $shouldClose, text: "   Get Envisioning", color: .grey0, backgroundColor: .grey10, style: .h5, shouldHaveBackground: true, shouldFill: false, iconType: .right, height: .large)
//                                    .frame(width:230)
        }
    }
}

struct LargeTextButtonWithicon_Previews: PreviewProvider {
    static var previews: some View {
        LargeTextButtonWithicon(isPressed: .constant(false))
    }
}
