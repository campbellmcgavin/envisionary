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
        HStack{
            ForEach(options, id:\.self){
                state in
                
                Button{
                    fieldValue = state
                }
            label:{
                ZStack{
                    Circle()
                        .frame(width:SizeType.medium.ToSize(), height:SizeType.medium.ToSize())
                        .foregroundColor(.specify(color: fieldValue == state ? .grey3 : .grey2))
                    
                    Circle()
                        .frame(width:SizeType.medium.ToSize() - 10, height:SizeType.medium.ToSize() - 10)
                        .foregroundColor(.specify(color: fieldValue == state ? GetColor(option: state) : .clear))
                }
                .frame(maxWidth:.infinity)
            }
            .buttonStyle(.plain)
            }
        }
        .padding(8)
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
