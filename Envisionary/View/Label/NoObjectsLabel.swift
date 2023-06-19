//
//  NoObjectsLabel.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/30/23.
//

import SwiftUI

struct NoObjectsLabel: View {
    
    var objectType: ObjectType
    let labelType: NoObjectLabelType
    var body: some View {
        
        Text(GetText())
            .font(.specify(style:.h6))
            .multilineTextAlignment(.center)
            .foregroundColor(.specify(color: .grey3))
            .padding(30)
    }
    
    func GetText() -> String{
        if objectType == .prompt {
            return "Looks like you don't have any favorites. Mark any object as a favorite by tapping on the ★ button."
        }
        else{
            switch labelType {
            case .home:
                return "Looks like you don't have any " + objectType.toPluralString() + ". \nGo to the " + objectType.toPluralString() + " page and click the + to get started"
            case .session:
                return "Looks like you don't have any " + objectType.toPluralString() + ". \nClick 'add goal' to get started"
            case .page:
                return "Looks like you don't have any " + objectType.toPluralString() + ". \nClick the + to get started"
            }
        }
    }
}

struct NoObjectsLabel_Previews: PreviewProvider {
    static var previews: some View {
        NoObjectsLabel(objectType: .goal, labelType: .page)
    }
}


enum NoObjectLabelType{
    case home
    case session
    case page
}
