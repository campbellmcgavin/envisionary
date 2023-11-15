//
//  FormInlineDescription.swift
//  Envisionary
//
//  Created by Campbell McGavin on 8/14/23.
//

import SwiftUI

struct FormInlineDescription: View {
    let description: String
    var body: some View {
        HStack{
            Text(description)
                .frame(alignment:.leading)
                .padding([.leading,.trailing])
                .padding(.bottom)
                .font(.specify(style: .caption))
                .foregroundColor(.specify(color: .grey4))
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .frame(alignment:.leading)
        .frame(maxWidth:.infinity)
    }
}

struct FormInlineDescription_Previews: PreviewProvider {
    static var previews: some View {
        FormInlineDescription(description: "Example text description of an in-line form element")
    }
}
