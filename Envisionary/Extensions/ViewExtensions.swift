//
//  ViewExtensions.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/11/23.
//

import SwiftUI

struct SizeCalculator: ViewModifier {
    
    @Binding var size: CGSize
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear // we just want the reader to get triggered, so let's use an empty color
                        .onAppear {
                            size = proxy.size
                        }
                        .onChange(of:proxy.size){
                            _ in
                            size = proxy.size
                        }
                }
            )
    }
}

//struct OffsetCalculator: ViewModifier {
//    var coordinateSpace: CoordinateSpace
//    @Binding var position: CGPoint
//    @Binding var size: CGPoint
//
//    func body(content: Content) -> some View {
//        content
//            .background(GeometryReader { geometry in
//                Color.clear.preference(
//        key: PreferenceKey.self,
//        value: geometry.frame(in: coordinateSpace).origin
//        )
//            })
//            .onPreferenceChange(PreferenceKey.self) { position in
//                self.position = position
//            }
//    }
//}





extension View {
    func saveSize(in size: Binding<CGSize>) -> some View {
        modifier(SizeCalculator(size: size))
    }
    
//    func observeOffset(in offset: Binding<CGPoint>) -> some View{
//        modifier
//    }
}
