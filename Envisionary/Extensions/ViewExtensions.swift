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


extension View {
    
    func wiggling(shouldWiggle: Bool = true, intensity: Double = 2.0) -> some View {
        modifier(WiggleModifier(shouldWiggle: shouldWiggle, intensity: intensity))
    }
}

struct WiggleModifier: ViewModifier {
    @State private var isWiggling = false
    var shouldWiggle: Bool
    var intensity: Double
    
    private static func randomize(interval: TimeInterval, withVariance variance: Double) -> TimeInterval {
        let random = (Double(arc4random_uniform(1000)) - 500.0) / 500.0
        return interval + variance * random
    }
    
    private let rotateAnimation = Animation
        .easeInOut(
            duration: WiggleModifier.randomize(
                interval: 1.5,
                withVariance: 0.8
            )
        )
        .repeatForever(autoreverses: true)
    
    private let bounceAnimation = Animation
        .easeInOut(
            duration: WiggleModifier.randomize(
                interval: 0.18,
                withVariance: 0.05
            )
        )
        .repeatForever(autoreverses: true)
    
    func body(content: Content) -> some View {
        
        if shouldWiggle {
            content
                .rotationEffect(.degrees(isWiggling ? intensity : -intensity))
                .animation(rotateAnimation)
                .offset(x: 0, y: isWiggling ? intensity : 0)
                .animation(bounceAnimation)
                .onAppear() { isWiggling.toggle() }
        }
        else{
            content
        }
    }
}
