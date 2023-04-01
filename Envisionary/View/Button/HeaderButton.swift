//
//  HeaderButton.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/9/23.
//

import SwiftUI

struct HeaderButton: View {
    @Binding var isExpanded: Bool
    let color: CustomColor
    let header: String
    var arrowOpacity: CGFloat?
    var body: some View {
        HStack(spacing:0){
            Button{
                withAnimation{
                    isExpanded.toggle()
                }
            }label:{
                Text(header)
                    .font(.specify(style: .h3))
                    .foregroundColor(.specify(color: color))

                    IconType.down.ToIconString().ToImage(imageSize: SizeType.medium.ToSize())
                        .foregroundColor(.specify(color: color))
                        .opacity(arrowOpacity != nil ? arrowOpacity! : 1.0)
                        .rotationEffect(Angle(degrees: isExpanded ? 0.0 : -90.0))
                
                Spacer()
            }
            .padding([.leading])
            .padding(.top,10)

            
        }
    }
}

struct HeaderButton_Previews: PreviewProvider {
    static var previews: some View {
        HeaderButton(isExpanded: .constant(true), color: .purple, header: "Collapse All")
            .background(Color.specify(color: .grey0))
    }
}
