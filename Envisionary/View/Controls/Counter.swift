//
//  Counter.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/25/23.
//

import SwiftUI

struct Counter: View {
    @Binding var fieldValue: Int
    var minValue = 0
    var maxValue: Int = 20
    var size: SizeType = .small
    
    @State var shouldGoUp = false
    @State var shouldGoDown = false
    var body: some View {
        HStack(spacing:0){
            Spacer()
            IconButton(isPressed: $shouldGoDown, size: size, iconType: .arrow_down, iconColor: .grey10, circleColor: .grey3)
                .disabled(fieldValue <= minValue)
                .opacity(fieldValue <= minValue ? 0.2 : 1.0)
            IconButton(isPressed: $shouldGoUp, size: size, iconType: .arrow_up, iconColor: .grey10, circleColor: .grey3)
                .disabled(fieldValue >= maxValue)
                .opacity(fieldValue >= maxValue ? 0.2 : 1.0)
        }
        .onChange(of:shouldGoUp){
            _ in
            fieldValue += 1
            
        }
        .onChange(of:shouldGoDown){
            _ in
            
            fieldValue -= 1
        }
    }
}

struct Counter_Previews: PreviewProvider {
    static var previews: some View {
        Counter(fieldValue: .constant(0))
    }
}
