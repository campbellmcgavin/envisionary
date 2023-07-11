//
//  SelectedButton.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/18/23.
//

import SwiftUI

struct SelectedButton: View {
    @Binding var isSelected: Bool
    
    var selectedColor: CustomColor? = .purple
    var body: some View {
        
        Button{
            withAnimation{
                isSelected.toggle()
            }
        }
    label:{
        
        ZStack{
            Circle()
                .frame(width:SizeType.mediumLarge.ToSize(),height:SizeType.medium.ToSize())
                .foregroundColor(.specify(color: .grey2))
            Circle()
                .frame(width:SizeType.medium.ToSize(),height:SizeType.extraSmall.ToSize())
                .foregroundColor(.specify(color: selectedColor ?? .purple))
                .opacity(isSelected ? 1.0 : 0.0)
            Circle()
                .strokeBorder(Color.specify(color: isSelected ? selectedColor ?? .purple : .grey5), lineWidth:5)
                .frame(width:SizeType.mediumLarge.ToSize(),height:SizeType.medium.ToSize())
        }

    }
    }
}

struct SelectedButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack{
            SelectedButton(isSelected: .constant(false))
                .padding(.trailing)
            Text("Example task")
            Spacer()
        }
        .padding(8)
        .padding(.leading,-5)
        .frame(maxWidth:.infinity)
        .modifier(ModifierForm())
 
    }
}
