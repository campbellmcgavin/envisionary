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
    let shouldAllowNavigation: Bool = false
    var shouldShowBackground = true
    @State var isExpanded: Bool = true
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
        VStack(spacing:0){
            let goal = vm.GetGoal(id: objectId)
            HeaderButton(isExpanded: $isExpanded, color: .grey10, header: (goal?.timeframe.toChildTimeframe().toString() ?? "") + " goals")
            
            if isExpanded {
                let childGoals = vm.ListChildGoals(id: objectId)
                
                VStack{
                    
                    ForEach(childGoals){ goal in
                        
                        if shouldAllowNavigation{
                            PhotoCard(objectType: .goal, objectId: goal.id, properties: Properties(goal:goal))
                        }
                        else{
                            PhotoCardSimple(objectType: .goal, properties: Properties(goal:goal))
                        }
                        
                        if childGoals.last != goal{
                            Divider()
                                .overlay(Color.specify(color: .grey2))
                                .frame(height:1)
                                .padding(.leading,16+50+16)
                        }
                    }
                    
                    if childGoals.count == 0 {
                        NoObjectsLabel(objectType: objectType, labelType: .session)
                    }
                }
                .frame(maxWidth:.infinity)
                .frame(alignment:.leading)
                .frame(minHeight: childGoals.count == 0 ? 70 : 0)
                .padding(8)
                .modifier(ModifierCard(color: shouldShowBackground ? .grey1 : .clear ))

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
