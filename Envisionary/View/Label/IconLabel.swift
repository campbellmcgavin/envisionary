//
//  IconLabel.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/11/23.
//

import SwiftUI

struct IconLabel: View {
    let size: SizeType
    let iconType: IconType
    let iconColor: CustomColor
    var circleColor: CustomColor = .clear
    var opacity: Double = 1
    var circleOpacity: Double = 1
    var showIcon = true
    var body: some View {
        ZStack{
            Circle()
                .frame(width:size.ToSize(), height: size.ToSize())
                .foregroundColor(Color.specify(color: circleColor))
                .opacity(circleOpacity)
            
            iconType.ToIconString().ToImage(imageSize: GetIconSize())
                .foregroundColor(.specify(color: iconColor))
                .opacity(opacity)
        }
        .frame(width:GetFrameSize(),height:GetFrameSize())

    }
    
    func GetIconSize() -> CGFloat{
        if circleColor == .clear {
            return size.ToSize() * 1.3
        }
        else{
            if size != .large {
                return size.ToSize()*1.1
            }
            else{
                return size.ToSize()*0.8
            }
        }
    }
    
    func GetFrameSize() -> CGFloat{
        if(size.ToSize() < 39){
            return 39
        }
        else {
            return size.ToSize()
        }
    }
}

struct IconLabel_Previews: PreviewProvider {
    static var previews: some View {
        IconLabel(size: .medium, iconType: .value, iconColor: .grey5)
    }
}
