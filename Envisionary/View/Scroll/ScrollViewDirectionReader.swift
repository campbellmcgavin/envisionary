//
//  ScrollViewDirectionReader.swift
//  Envisionary
//
//  Created by Campbell McGavin on 11/15/23.
//

import SwiftUI

struct ScrollViewDirectionReader: View {
    let axis: Axis
    let sensitivity: CGFloat
    let startingPoint: CGPoint
    @Binding var isPositive: Bool
    @Binding var offsetBind: CGPoint
    var shouldAnimate: Bool = true
    @State var offset: CGPoint = .zero
    private let id = UUID()
    var offsetBindSensitivity: CGFloat = 50
    
    @State var lastOffset = CGPoint.zero
    
    var body: some View {
        
        PositionObservingView(
            coordinateSpace: .named(id),
            position: Binding(
                get: { offset },
                set: { newOffset in
                    offset = CGPoint(
                        x: -newOffset.x,
                        y: -newOffset.y
                    )
                }
            ),
            content: {Text("here").opacity(0.001)}
        )
        .onChange(of: offset){ [offset] newOffset in
            if shouldAnimate{
                withAnimation{
                    
                    if axis == .horizontal{
                        if abs(offset.x - newOffset.x) > sensitivity  && newOffset.x > startingPoint.x{
                            if newOffset.x - offset.x < 0 {
                                isPositive = true
                            }
                            else{
                                isPositive = false
                            }
                        }

                    }
                    else{
                        if abs(offset.y - newOffset.y) > sensitivity && newOffset.y > startingPoint.y {
                            if newOffset.y - offset.y > 0 {
                                isPositive = true
                            }
                            else{
                                isPositive = false
                            }
                        }

                    }
                }
            }
            else{
                if axis == .horizontal{
                    if abs(offset.x - newOffset.x) > sensitivity  && newOffset.x > startingPoint.x{
                        if newOffset.x - offset.x < 0 {
                            isPositive = true
                        }
                        else{
                            isPositive = false
                        }
                    }

                }
                else{
                    if abs(offset.y - newOffset.y) > sensitivity && newOffset.y > startingPoint.y {
                        if newOffset.y - offset.y > 0 {
                            isPositive = true
                        }
                        else{
                            isPositive = false
                        }
                    }
                }
            }
            
//            if offsetBindSensitivity < abs(offset.y - lastOffset.y) {
//                lastOffset = offset
//                withAnimation{
                    offsetBind = offset
//                }
//            }
        }
    }
}
