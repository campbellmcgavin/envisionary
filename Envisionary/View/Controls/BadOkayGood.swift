//
//  BadOkayGood.swift
//  Envisionary
//
//  Created by Campbell McGavin on 8/10/23.
//

import SwiftUI

struct BadOkayGood: View {
    @Binding var fieldValue: Int
    
    let options = [0,1,2]
    var body: some View {
        HStack(spacing:0){
            ForEach(options, id:\.self){
                state in
                
                Button{
                    fieldValue = state
                }
            label:{
                ZStack(alignment:.center){
                    Circle()
                        .stroke(Color.specify(color: GetColor(option: state)), lineWidth: 3)
                        .frame(width:SizeType.small.ToSize(), height:SizeType.small.ToSize())
                        .opacity(0.18)                    
                    
                    Circle()
                        .frame(width:SizeType.small.ToSize()-5, height:SizeType.small.ToSize()-5)
                        .foregroundColor(.specify(color: GetColor(option: state)))
                        .opacity(fieldValue == state ? 1.0 : 0.0001)
                }
                .frame(maxWidth:.infinity)
            }

            .buttonStyle(.plain)
            }
        }
        .animationsDisabled()
        .padding([.top,.bottom],4)
    }
    
    func GetColor(option: Int) -> CustomColor{
        if option == 0{
            return .red
        }
        if option == 1{
            return .yellow
        }
        if option == 2{
            return .green
        }
        return .clear
    }
}

struct BadOkayGood_Previews: PreviewProvider {
    static var previews: some View {
        BadOkayGood(fieldValue: .constant(2))
    }
}
