//
//  GanttMainDiagram.swift
//  Visionary
//
//  Created by Campbell McGavin on 5/13/22.
//

import SwiftUI

struct GanttMainDiagram<Value: Identifiable, V: View>: View where Value: Equatable {
    @Binding var goal: Goal
    @Binding var propertyTypeMenu: [Bool]
    @Binding var focusGoal: UUID
    @Binding var expandedGoals: [UUID]
    let value: (Value) -> V
    let isPreview: Bool
    let childCount: Int
    let currentTimeframeType: TimeframeType
    @State var shouldMoveBackward = false
    @State var shouldMoveForward = false
//    let maxTimeframecount: Int
    
    @EnvironmentObject var dataModel: DataModel

    typealias Key = CollectDict<UUID, Anchor<CGPoint>>

    var body: some View {
        
        return ZStack{
        VStack(alignment: .leading, spacing: 5) {
            
            value(goal as! Value)
               .anchorPreference(key: Key.self, value: .center, transform: {
                   [self.goal.id: $0]
               })

            
            
            if ((expandedGoals.contains(where:{$0 == goal.id}) && !isPreview) || (isPreview && childCount < 1)){

                
                VStack(alignment: .leading) {
                        
                        ForEach(goal.children, id: \.self, content: { childId in
                            
                            GanttMainDiagram(goal: dataModel.BindingGoal(for: childId), propertyTypeMenu: .constant([Bool](repeating: true, count:PropertyType.allCases.count)), focusGoal: $focusGoal, expandedGoals: $expandedGoals, value: self.value, isPreview: isPreview, childCount: childCount + 1, currentTimeframeType: currentTimeframeType)
                                .environmentObject(dataModel) 
                        })
                    

                }
            }

        }
        .background(
            VStack{
                HStack{
                    Circle()
                        .frame(width:8,height:8)
                        .foregroundColor(.specify(color: .foregroundSelected))
                        .offset(x: -70  + CGFloat(childCount - 1) * 9 - 4, y:10 )
                        .background(
                            VStack{
                                Divider()
                                    .background(Color.specify(color: .foregroundSelected))
                                    .opacity(GetShouldShow() ? 100 : 0)
                                    .offset(x: -70  + CGFloat(childCount - 1) * 9 - 1, y:10 )
                                    .frame(width:12)
                            }
                        )
                    Spacer()
                }

                
                HStack{
                    Divider()
                        .background(Color.specify(color: .foregroundSelected))
                        .offset(x: -70  + CGFloat(childCount) * 9, y: -2 )
                        .padding(.bottom,10)
                    Spacer()
                }
                .opacity(GetShouldShow() ? 100 : 0)
            }



            
        )
//            if(!isPreview){
//                if goal.id == focusGoal {
//                    
//                    VStack{
//                        MenuToolboxButtons(goal: $goal, propertyTypeMenu: $propertyTypeMenu, expandedGoals: $expandedGoals, focusGoal: $focusGoal, viewMenuType: .gantt, timeframeType: currentTimeframeType)
//                            .environmentObject(dataModel)
//                        Spacer()
//                    }
//                }
//            }
        }
        }
    
    func GetShouldShow() -> Bool{
        return (expandedGoals.contains(where:{$0 == goal.id}) && !isPreview && goal.children.count > 0) || childCount == 0
    }
}
