//
//  CustomSlider Bar.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/25/23.
//

import SwiftUI

struct CustomSlider: View {
    @Binding var value: Int
    let minValue = 0
    let maxValue = 100
    
    @State var frame: CGSize = .zero
    
    var body: some View {
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.specify(color: .grey2))
                Rectangle()
                    .foregroundColor(.specify(color: .purple))
                    .frame(width: GetWidth())
                Rectangle()
                    .foregroundColor(.specify(color: .purple))
                    .frame(width: 10)
                
            }
            .saveSize(in: $frame)
            .frame(height:36)
            .cornerRadius(18)
            .gesture(
                DragGesture(minimumDistance: 0)
                .onChanged({ value in
                    // TODO: - maybe use other logic here
                    self.value = min(max(0, Int(value.location.x / frame.width * 100)), 100)
                }))
            
        
    }
    
    func GetWidth() -> CGFloat {
        let width = frame.width * CGFloat(CGFloat(self.value) / 100.0)
        return width
    }
}

struct CustomSlider_Previews: PreviewProvider {
    static var previews: some View {
        CustomSlider(value: .constant(30))
    }
}
