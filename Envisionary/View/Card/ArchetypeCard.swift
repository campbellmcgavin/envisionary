//
//  ArchetypeCard.swift
//  Envisionary
//
//  Created by Campbell McGavin on 7/6/23.
//

import SwiftUI

struct ArchetypeCard: View {
    @Binding var selectedArchetype: ArchetypeType?
    let archetype: ArchetypeType
    
    var body: some View {
        Button{
            selectedArchetype = archetype
        }
    label:{
        HStack(alignment:.center, spacing:0){
            ImageCircle(imageSize: SizeType.mediumLarge.ToSize(), image: nil, iconSize: .medium, icon: IconType.favorite, iconColor: IsSelected() ? .purple : .grey6, circleColor: IsSelected() ? .lightPurple : .grey3)

            VStack(alignment:.leading, spacing:0){
                Text("The " + archetype.toString())
                    .font(.specify(style: .h4))
                    .foregroundColor(.specify(color: .grey10))
                    .padding(.top,3)
                    .lineLimit(1)
                
                Text("Focuses on")
                    .font(.specify(style: .subCaption))
                    .textCase(.uppercase)
                    .foregroundColor(.specify(color: IsSelected() ? .grey8 : .grey6))
                    .padding(.top,6)
                
                Text(archetype.toDescription())
                    .font(.specify(style: .h6))
                    .foregroundColor(.specify(color: IsSelected() ? .grey9 : .grey7))
                    .multilineTextAlignment(.leading)
                    .padding(.bottom,3)
            }
            .padding(.leading)
            .padding(.trailing,20)
            .frame(height:90)
            Spacer()
        }
        .padding(.leading,10)
        .padding(8)
        .modifier(ModifierForm(color: IsSelected() ? .purple : .clear, radius: .cornerRadiusSmall))
    }

    }
    
    func IsSelected() -> Bool{
        return selectedArchetype == archetype
    }
}

struct ArchetypeCard_Previews: PreviewProvider {
    static var previews: some View{
    ArchetypeCard(selectedArchetype: .constant(.Essentialist), archetype: .Achiever)
    }
}
