//
//  NavigationBar.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/9/23.
//

import SwiftUI

struct BottomNavigationBar: View {
    @Binding var selectedContentView: ContentViewType
    @Binding var selectedObject: ObjectType
    
    var body: some View {
        VStack(spacing:0){
            Divider()
                .overlay(Color.specify(color: .grey4))
//                .background(Color.specify(color: .red))
            HStack{
                ForEach(ContentViewType.allCases,id:\.self){
                    contentView in
                    
                    if contentView != .execute {
                        ContentButton(selectedContentView: $selectedContentView, contentView: contentView)
                            .frame(maxWidth:.infinity)
                    }
                }
            }
            .frame(height:50)
            .background(Color.specify(color: .grey0))
        }
        .onChange(of: selectedContentView){ _ in
            
            switch selectedContentView {
            case .values:
                selectedObject = .value
            case .goals:
                selectedObject = .goal
            case .execute:
                selectedObject = .home
            case .journals:
                selectedObject = .journal
            }
        }
    }
}

struct BottomNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavigationBar(selectedContentView: .constant(.goals), selectedObject: .constant(.goal))
    }
}
