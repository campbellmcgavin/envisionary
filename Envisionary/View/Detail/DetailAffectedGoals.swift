//
//  DetailAffectedGoals.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/14/23.
//

import SwiftUI

struct DetailAffectedGoals: View {
    @Binding var shouldExpand: Bool
    var sessionProperties: Properties
    @State var isExpanded: Bool = true
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
        VStack(spacing:0){
            HeaderButton(isExpanded: $isExpanded, color: .grey10, header: "Affected Goals")
            
            if isExpanded {
                
                BuildView()
                    .frame(maxWidth:.infinity)
                    .frame(alignment:.leading)
                    .modifier(ModifierCard())
                
            }
        }
        .onChange(of:shouldExpand){
            _ in
            withAnimation{
                if shouldExpand{
                    isExpanded = true
                }
                else{
                    isExpanded = false
                }
            }
        }
        
        
    }
    
    
    @ViewBuilder
    func BuildView() -> some View{
        VStack(alignment:.leading){
            if let goalProperties = sessionProperties.goalProperties{
                ForEach(goalProperties){ goalProperty in
                    VStack{
                        PhotoCardSimple(objectType: .goal, properties: goalProperty, imageSize: .minimumTouchTarget)
                    }
                    
                }
            }
        }
        .frame(alignment:.leading)
        .padding()
    }
}

struct DetailAffectedGoals_Previews: PreviewProvider {
    static var previews: some View {
        DetailAffectedGoals(shouldExpand: .constant(true), sessionProperties: Properties())
    }
}
