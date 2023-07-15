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
    
    func expensiveWiggling(shouldWiggle: Bool = true, intensity: Double = 2.0, period: Double = 50) -> some View {
        modifier(ExpensiveWiggleModifier(shouldWiggle: shouldWiggle, intensity: intensity, period: period))
    }
}

struct WiggleModifier: ViewModifier {
    @State private var isRotating = false
    @State private var isBouncing = false
    
    var shouldWiggle: Bool
    var intensity: Double
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    private static func randomize(interval: TimeInterval, withVariance variance: Double) -> TimeInterval {
        let random = (Double(arc4random_uniform(1000)) - 500.0) / 500.0
        return interval + variance * random
    }
    
    private let rotateAnimation = Animation
        .easeInOut(
            duration: WiggleModifier.randomize(
                interval: 1.4,
                withVariance: 0.6
            )
        )
        .repeatForever(autoreverses: true)
    
    private let bounceAnimation = Animation
        .easeInOut(
            duration: WiggleModifier.randomize(
                interval: 1.0,
                withVariance: 0.5
            )
        )
        .repeatForever(autoreverses: true)
    
    func body(content: Content) -> some View {
        
        if shouldWiggle {
            content
                .rotationEffect(.degrees(isRotating ? intensity * 0.7 : -intensity * 0.7))
                .offset(x: 0, y: isBouncing ? intensity : -intensity)
                .onAppear() {
                    withAnimation(bounceAnimation){
                        isRotating.toggle()
                    }
                    withAnimation(rotateAnimation){
                        isBouncing.toggle()
                    }
                }
        }
        else{
            content
        }
    }
}

struct ExpensiveWiggleModifier: ViewModifier {
    @State private var isRotating = false
    @State private var isBouncing = false
    @State var isAscending = true
    @State var trace: CGFloat = 0.0
    var shouldWiggle: Bool
    var intensity: Double
    var period: Double
    
    private static func randomize(interval: TimeInterval, withVariance variance: Double) -> TimeInterval {
        let random = (Double(arc4random_uniform(1000)) - 500.0) / 500.0
        return interval + variance * random
    }
    
    func body(content: Content) -> some View {
        let interval = ExpensiveWiggleModifier.randomize(
            interval: period / 1000,
            withVariance: period / 2000
        )
        
        let timer = Timer.publish(every: interval, on: .main, in: .common).autoconnect()
        
        if shouldWiggle {
            content
                .rotationEffect(.degrees(trace * intensity / (period*2)))
                .offset(x: 0, y: trace * intensity / (period*2))
                .onReceive(timer) { _ in
                    withAnimation{
                        if isAscending{
                            trace += period/10
                        }
                        else{
                            trace -= period/10
                        }
                    }
                    if trace <= -period{
                        isAscending = true
                    }
                    if trace >= period {
                        isAscending = false
                    }
                }
                .onAppear{
                    trace = CGFloat.random(in: -period...period)
                }
        }
        else{
            content
        }
    }
}


struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

// A View wrapper to make the modifier easier to use
extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
