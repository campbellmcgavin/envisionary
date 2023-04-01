////
////  ContentViewStack.swift
////  Envisionary
////
////  Created by Campbell McGavin on 3/16/23.
////
//
//import SwiftUI
//
//struct ContentViewStack: View {
//    @Binding var shouldExpandAll: Bool
//    @State var list: [Int] = [1,2,3,4,5,6,7,8,9,10]
//    var body: some View {
//            VStack(spacing:0){
//                VStack(spacing:0){
//                    ParentHeaderButton(shouldExpandAll: $shouldExpandAll, color: .purple, header: "Expand All", headerCollapsed: "Collapse All")
//                    DetailProperties(shouldExpand: $shouldExpandAll, objectType: .goal, properties: Properties())
//                        .frame(maxWidth:.infinity)
//                    ForEach(ObjectType.allCases,id:\.rawValue){ listHeader in
//                        HeaderWithContent(shouldExpand: $shouldExpandAll, headerColor: .grey10, header: listHeader.toString(), content: {
//                            ForEach($list, id:\.self, editActions: .delete){ item in
//                                PhotoCard(objectType: listHeader, header: "Study for AWS exam", subheader: "May, 2021 - June, 2021", caption: "In Progress")
//                                Divider()
//                                    .overlay(Color.specify(color: .grey2))
//                                    .frame(height:1)
//                                    .padding(.leading,16+50+16)
//                            }
//
//                        })
//                    }
//                }
//                .modifier(ModifierCard())
//                .padding(.top,90)
//            }
//
//
//    }
//}
//
//struct ContentViewStack_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentViewStack(shouldExpandAll: .constant(true))
//    }
//}
