//
//  SessionLookingForward.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/14/23.
//

import SwiftUI

struct SessionLookingForward: View {
    var goalProperties: [Properties]
    @State var shouldExpandAll: Bool = false
    var body: some View {
        LazyVStack{
            ParentHeaderButton(shouldExpandAll: $shouldExpandAll, color: .purple, header: "Expand All", headerCollapsed:  "Collapse All")
            ForEach(goalProperties){
                goalProperty in
                VStack{
                    PhotoCardSimple(objectType: .goal, properties: goalProperty)
                    DetailChildren(shouldExpand: $shouldExpandAll, objectId: goalProperty.id, objectType: .goal, shouldShowBackground: false, isExpanded: false)
                        .padding(.bottom,-16)
                    FormPropertiesMiniStackWithButtons(objectType: .goal, objectId: goalProperty.id)
                }
                .padding(8)
                .padding(.bottom,-20)
                .modifier(ModifierForm(color: .grey15))
            }
        }
    }
}

struct SessionLookingForward_Previews: PreviewProvider {
    static var previews: some View {
        SessionLookingForward(goalProperties: [Properties]())
    }
}
