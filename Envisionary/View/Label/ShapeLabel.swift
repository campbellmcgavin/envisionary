//
//  ShapeLabel.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/11/23.
//

import SwiftUI

struct ShapeLabel: View {
    let size: SizeType
    let shapeType: ShapeType
    let shapeColor: CustomColor
    var opacity: Double = 1
    var circleOpacity: Double = 1
    var body: some View {
        shapeType.toShapeString().ToImage(imageSize: size.ToSize())
            .foregroundColor(.specify(color: shapeColor))
            .opacity(opacity)
            .frame(width:GetFrameSize(),height:GetFrameSize())
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

struct ShapeLabel_Previews: PreviewProvider {
    static var previews: some View {
        ShapeLabel(size: .large, shapeType: .pin, shapeColor: .purple)
    }
}
