//
//  ScrollPicker3.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/9/23.
//

import SwiftUI

struct ScrollPicker3<Content: View>: View {
    var axes: Axis.Set = [.vertical]
    var showsIndicators = true
    var shouldHaveSidePadding = true
    @Binding var index: Int
    @ViewBuilder var content: () -> Content
    
    @State var offset: CGPoint = .zero
    // The name of our coordinate space doesn't have to be
    // stable between view updates (it just needs to be
    // consistent within this view), so we'll simply use a
    // plain UUID for it:
    private let coordinateSpaceName = UUID()
    
    var body: some View {
        
        ScrollViewReader{
            proxy in
            
            ScrollView(axes, showsIndicators: showsIndicators) {
                PositionObservingView(
                    coordinateSpace: .named(coordinateSpaceName),
                    position: Binding(
                        get: { offset },
                        set: { newOffset in
                            offset = CGPoint(
                                x: -newOffset.x,
                                y: -newOffset.y
                            )
                        }
                    ),
                    content: content
                )
                
                .onChange(of:index){
                    _ in
                    proxy.scrollTo(index, anchor:.center)
                }
            }
            .scrollDismissesKeyboard(.interactively)
            .coordinateSpace(name: coordinateSpaceName)
        }

    }
    
    
}
