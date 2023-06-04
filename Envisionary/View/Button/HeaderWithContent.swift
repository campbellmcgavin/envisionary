//
//  HeaderWithContent.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/11/23.
//

import SwiftUI

struct HeaderWithContent<Content: View>: View {
    @Binding var shouldExpand: Bool
    var headerColor: CustomColor
    var header: String
    @State var isExpanded: Bool = true
    @ViewBuilder var content: Content

    
    var body: some View {
        VStack(spacing:0){
            HeaderButton(isExpanded: $isExpanded, color: headerColor, header: header)
            if isExpanded{
                content
//                    .animation(.easeInOut)
//                    .transition(.move(edge:.top))
            }
        }
        .onChange(of:shouldExpand){
            _ in
            withAnimation{
                if shouldExpand{
                    isExpanded = true
                }
                else{
                    isExpanded = false
                }
            }
        }
        
    }
}

struct HeaderWithContent_Previews: PreviewProvider {
    static var previews: some View {
        HeaderWithContent(shouldExpand: .constant(false), headerColor: .grey10, header: "High Priority"){
            PhotoCard(objectType: .goal, objectId: UUID(), properties: Properties())
            PhotoCard(objectType: .goal, objectId: UUID(), properties: Properties())
            PhotoCard(objectType: .goal, objectId: UUID(), properties: Properties())
            PhotoCard(objectType: .goal, objectId: UUID(), properties: Properties())
            PhotoCard(objectType: .goal, objectId: UUID(), properties: Properties())
            PhotoCard(objectType: .goal, objectId: UUID(), properties: Properties())
        }
    }
}
