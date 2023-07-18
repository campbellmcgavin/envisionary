//
//  ParentHeaderButton.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/9/23.
//

import SwiftUI

struct ParentHeaderButton: View {
    
    @Binding var shouldExpandAll: Bool
    let color: CustomColor
    let header: String
    var headerCollapsed: String
    var arrowOpacity: CGFloat?
    
    var shouldDisableButton: Bool = false
    
    var body: some View {
        HStack{
            Button{
                withAnimation{
                    shouldExpandAll.toggle()
                }
            }label:{
                Text(shouldExpandAll ? headerCollapsed : header)
                    .font(.specify(style: .h3))
                    .foregroundColor(.specify(color: color))
                
                if !shouldDisableButton{
                    IconType.down.ToIconString().ToImage(imageSize: SizeType.medium.ToSize())
                        .foregroundColor(.specify(color: color))
                        .opacity(arrowOpacity != nil ? arrowOpacity! : 1.0)
                        .rotationEffect(Angle(degrees: shouldExpandAll ? 0.0 : -90.0))
                }
                
                Spacer()
            }
            .padding([.leading,.trailing,.top])
            .disabled(shouldDisableButton)

            
        }
    }
}

struct ParentHeaderButton_Previews: PreviewProvider {
    static var previews: some View {
        ParentHeaderButton(shouldExpandAll: .constant(true), color: .purple, header: "Collapse All", headerCollapsed: "Expand All")
            .background(Color.specify(color: .grey0))
    }
}
