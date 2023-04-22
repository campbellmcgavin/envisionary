//
//  DetailChildren.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/30/23.
//

import SwiftUI

struct DetailChildren: View {
    @Binding var shouldExpand: Bool
    let objectId: UUID
    let objectType: ObjectType
    
    @State var isExpanded: Bool = true
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
        VStack(spacing:0){
            HeaderButton(isExpanded: $isExpanded, color: .grey10, header: "Children")
            
            if isExpanded {
                let childGoals = vm.ListChildGoals(id: objectId)
                
                VStack{
                    
                    ForEach(childGoals){ goal in
                        PhotoCard(objectType: .goal, objectId: goal.id, properties: Properties(goal:goal), header: goal.title, subheader: goal.description, caption: goal.startDate.toString(timeframeType: goal.timeframe, isStartDate: goal.timeframe == .week ? true : nil) + " - " + goal.endDate.toString(timeframeType: goal.timeframe, isStartDate: goal.timeframe == .week ? false : nil))
                        
                        if childGoals.last != goal{
                            Divider()
                                .overlay(Color.specify(color: .grey2))
                                .frame(height:1)
                                .padding(.leading,16+50+16)
                        }
                    }
                    
                    if childGoals.count == 0 {
                        NoObjectsLabel(objectType: objectType)
                    }
                }
                .frame(maxWidth:.infinity)
                .frame(alignment:.leading)
                .frame(minHeight: childGoals.count == 0 ? 70 : 0)
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
}

struct DetailChildren_Previews: PreviewProvider {
    static var previews: some View {
        DetailChildren(shouldExpand: .constant(false), objectId: UUID(), objectType: .goal)
    }
}
