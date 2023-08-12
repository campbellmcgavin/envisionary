//
//  DetailArchived.swift
//  Envisionary
//
//  Created by Campbell McGavin on 8/5/23.
//

import SwiftUI

struct DetailArchived: View {
    let objectType: ObjectType
    
    var body: some View {
        HStack{
            VStack(alignment:.leading){
                Text("This " + objectType.toString().lowercased() + " is archived.")
                    .font(.specify(style: .h3))
                    .foregroundColor(.specify(color: .grey10))
                    .padding(.leading,4)
                Text("You won't be able to make changes or delete. It also won't appear on the main screen. Use the search feature on the main screen to find archived content.")
                    .multilineTextAlignment(.leading)
                    .font(.specify(style: .caption))
                    .foregroundColor(.specify(color: .grey5))
                    .padding(.leading,4)
                    .padding(.top,-5)
                }
            Spacer()
            }
        .frame(maxWidth:.infinity)
        .padding()
        .modifier(ModifierCard())
    }
}

struct DetailArchived_Previews: PreviewProvider {
    static var previews: some View {
        DetailArchived(objectType: .goal)
    }
}
