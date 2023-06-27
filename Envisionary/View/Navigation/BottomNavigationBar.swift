//
//  NavigationBar.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/9/23.
//

import SwiftUI

struct BottomNavigationBar: View {
    @Binding var selectedContentView: ContentViewType
    var setupStep: SetupStepType
    
    var body: some View {
        VStack(spacing:0){
            Divider()
                .background(Color.specify(color: .grey3))
            HStack{
                ForEach(ContentViewType.allCases,id:\.self){
                    contentView in
                    ContentButton(selectedContentView: $selectedContentView, contentView: contentView, setupStep: setupStep)
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
        BottomNavigationBar(selectedContentView: .constant(.plan), setupStep: .value)
    }
}
