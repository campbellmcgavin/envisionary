//
//  FormCaption.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/19/23.
//

import SwiftUI

struct FormCaption: View {
    var fieldName: String
    var fieldValue: String
    
    var body: some View {
        Text(fieldName)
            .font(fieldValue.isEmpty ? .specify(style: .body1) : .specify(style: .caption))
//            .textCase(fieldValue.isEmpty ? .uppercase : .)
            .offset(y: fieldValue.isEmpty ? 21 : 10)
            .foregroundColor(.specify(color: .grey5))
            .frame(maxWidth: .infinity, alignment:.leading)
            .padding(.leading)
            .animation(.default)
    }
}

struct FormCaption_Previews: PreviewProvider {
    static var previews: some View {
        FormCaption(fieldName: "Aspect", fieldValue: "")
    }
}
