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
    @State var offset: CGPoint = .zero
    private let id = UUID()
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
    }
}

//struct ScrollViewDirectionReader_Previews: PreviewProvider {
//    static var previews: some View {
//        ScrollViewDirectionReader()
//    }
//}
