//
//  NoObjectsLabel.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/30/23.
//

import SwiftUI

struct NoObjectsLabel: View {
    
    var objectType: ObjectType
    
    var body: some View {
        Text("Looks like you don't have any " + objectType.toPluralString() + ". \nClick the + to get started")
            .font(.specify(style:.h6))
            .multilineTextAlignment(.center)
            .foregroundColor(.specify(color: .grey3))
            .padding(30)
    }
}

struct NoObjectsLabel_Previews: PreviewProvider {
    static var previews: some View {
        NoObjectsLabel(objectType: .goal)
    }
}
