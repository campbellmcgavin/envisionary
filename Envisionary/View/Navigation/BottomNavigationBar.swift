//
//  NavigationBar.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/9/23.
//

import SwiftUI

struct BottomNavigationBar: View {
    @Binding var selectedContentView: ContentViewType
    
    var body: some View {
        VStack(spacing:0){
            Divider()
                .overlay(Color.specify(color: .grey4))
//                .background(Color.specify(color: .red))
            HStack{
                ForEach(ContentViewType.allCases,id:\.self){
                    contentView in
                    ContentButton(selectedContentView: $selectedContentView, contentView: contentView)
                        .frame(maxWidth:.infinity)
                }
            }
            .frame(height:50)
            .background(Color.specify(color: .grey0))
        }
    }
}

struct BottomNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavigationBar(selectedContentView: .constant(.plan))
    }
}
