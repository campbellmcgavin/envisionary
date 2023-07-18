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
    var shouldLeftAlign: Bool = false
    var body: some View {
        
        Text(GetText())
            .font(.specify(style: shouldLeftAlign ? .caption : .h6))
            .multilineTextAlignment(shouldLeftAlign ? .leading : .center)
            .foregroundColor(.specify(color: .grey3))
            .padding([.top,.bottom],shouldLeftAlign ? 15: 30)
            .padding([.leading,.trailing])
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


struct UnderConstructionLabel: View {
    
    var body: some View {
        
        VStack{
            Text("Oops. You're in a construction zone. Check back soon for exciting upgrades!")
                .font(.specify(style:.h6))
                .multilineTextAlignment(.center)
                .foregroundColor(.specify(color: .grey3))
                .padding(30)
            IconLabel(size: .large, iconType: .constructionCone, iconColor: .grey5, circleColor: .grey1)
        }

    }
}

