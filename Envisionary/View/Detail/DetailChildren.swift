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
    
    @State var childIds = [UUID]()
    @State var isExpanded: Bool = true
    @EnvironmentObject var gs: GoalService
    
    var body: some View {
        
        VStack(spacing:0){
            HeaderButton(isExpanded: $isExpanded, color: .grey10, header: "Children")
            
            if isExpanded {
                    
                VStack{
                    ForEach(childIds, id: \.self){ goalId in
                        if let goal = gs.goalsDictionary[goalId] {
                            PhotoCard(objectType: .goal, objectId: goalId, properties: Properties(goal:goal), header: goal.title, subheader: goal.description, caption: goal.startDate.toString(timeframeType: goal.timeframe, isStartDate: goal.timeframe == .week ? true : nil) + " - " + goal.endDate.toString(timeframeType: goal.timeframe, isStartDate: goal.timeframe == .week ? false : nil))
                            
                            if childIds.last != goalId{
                                Divider()
                                    .overlay(Color.specify(color: .grey2))
                                    .frame(height:1)
                                    .padding(.leading,16+50+16)
                            }
                        }
                    }
                    
                    if childIds.count == 0 {
                        NoObjectsLabel(objectType: objectType)
                    }
                }
                .frame(maxWidth:.infinity)
                .frame(alignment:.leading)
                .frame(minHeight: childIds.count == 0 ? 70 : 0)
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
        .onChange(of:gs.goalsDictionary){
            _ in
            childIds = gs.ListsChildGoalsByParentId(id: objectId)
        }
        .onAppear{
            childIds = gs.ListsChildGoalsByParentId(id: objectId)
        }

    }
}

struct DetailChildren_Previews: PreviewProvider {
    static var previews: some View {
        DetailChildren(shouldExpand: .constant(false), objectId: UUID(), objectType: .goal)
    }
}
