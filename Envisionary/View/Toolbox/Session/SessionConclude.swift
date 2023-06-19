//
//  SessionConclude.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/14/23.
//

import SwiftUI

struct SessionConclude: View {
    let sessionId: UUID
    @State var properties: Properties = Properties()
    @EnvironmentObject var vm: ViewModel
    @State var shouldExpandAll: Bool = false
    var body: some View {
        
        VStack{
            ParentHeaderButton(shouldExpandAll: $shouldExpandAll, color: .purple, header: "Expand All", headerCollapsed:  "Collapse All")
            DetailProperties(shouldExpand: $shouldExpandAll, objectType: .session, properties: properties)
                .onAppear(){
                    properties = Properties(session: (vm.GetSession(id: sessionId) ?? Session()))
                }
            DetailAffectedGoals(shouldExpand: $shouldExpandAll, sessionProperties: properties)
        }
    }
}

struct SessionConclude_Previews: PreviewProvider {
    static var previews: some View {
        SessionConclude(sessionId: UUID())
    }
}
