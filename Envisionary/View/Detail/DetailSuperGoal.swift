//
//  DetailSuperGoal.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/15/23.
//

import SwiftUI

struct DetailSuperGoal: View {
    @Binding var shouldExpand: Bool
    let objectId: UUID
    let properties: Properties
    @State var isExpanded: Bool = true
    
    var body: some View {
        
        PhotoCard(objectType: .goal, objectId: objectId, properties: properties)
            .frame(maxWidth:.infinity)
            .padding([.top,.bottom])
//        VStack(spacing:0){
//            HeaderButton(isExpanded: $isExpanded, color: .grey10, header: "Super Goal")
//
//            if isExpanded {
//                VStack(alignment:.leading){
//                    Text("The top of the goal hierarchy")
//                        .font(.specify(style: .h5))
//                        .foregroundColor(.specify(color: .grey8))
//                        .padding()
//                        .padding(.bottom,-5)
//
//                }
//                .modifier(ModifierCard())
//            }
//        }
//        .onChange(of:shouldExpand){
//            _ in
//            withAnimation{
//                if shouldExpand{
//                    isExpanded = true
//                }
//                else{
//                    isExpanded = false
//                }
//            }
//        }
    }
}

struct DetailSuperGoal_Previews: PreviewProvider {
    static var previews: some View {
        DetailSuperGoal(shouldExpand: .constant(true), objectId: UUID(), properties: Properties())
    }
}
