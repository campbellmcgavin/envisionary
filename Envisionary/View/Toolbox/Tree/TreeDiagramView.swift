//
//  Diagram.swift
//  Visionary
//
//  Created by Campbell McGavin on 2/4/22.
//

import SwiftUI

struct TreeDiagramView<Value: Identifiable, V: View>: View where Value: Equatable {
    var goalId: UUID
    @Binding var focusGoal: UUID
    @Binding var expandedGoals: [UUID]
    let value: (Value) -> V
    let childCount: Int
    var isStatic = false
    @EnvironmentObject var dataModel: DataModel
    @EnvironmentObject var gs: GoalService

    typealias Key = CollectDict<UUID, Anchor<CGPoint>>

    var body: some View {

            VStack(alignment: .leading, spacing:0) {
                
                value(goalId as! Value)
                   .anchorPreference(key: Key.self, value: .center, transform: {
                       [self.goalId: $0]
                   })
                   .padding(.bottom,20)
            
                if ( expandedGoals.contains(where:{$0 == goalId})){

                VStack(alignment: .leading, spacing:0) {
                    ForEach(gs.ListsChildGoalsByParentId(id: goalId), content: { childId in
                        
                        TreeDiagramView(goalId: childId, focusGoal: $focusGoal, expandedGoals: $expandedGoals, value: self.value, childCount: childCount + 1, isStatic: isStatic)
                            .environmentObject(dataModel)
                            .offset(x: isStatic ? 0 : 60)
                    })
                }
            }
        }
        .backgroundPreferenceValue(Key.self, { (centers: [UUID: Anchor<CGPoint>]) in
            
                GeometryReader { proxy in
                    ForEach(gs.ListsChildGoalsByParentId(id: goalId), id:\.self, content: { child in
                        
                        if centers[goalId] != nil && centers[child] != nil {
                            
                            let point1: CGPoint = proxy[centers[self.goalId]!]
                            let point2: CGPoint = proxy[centers[child]!]
                            
                            Path { path in
                                path.move(to: point1)
                                path.addCurve(
                                    to: point2,
                                    control1: CGPoint(x: point1.x + 10, y: point2.y - 10),
                                    control2: CGPoint(x: point1.x + 10, y: point2.y - 10))
                            }
                            .stroke(lineWidth: 1)
                            .foregroundColor(.specify(color: isStatic ? .clear : .grey5))
                            .offset(x:-60)
                        }
                    })
                }
            

                })
        

    }
}



struct newPath: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    let center:CGPoint = CGPoint(x: rect.midX,y: rect.midY)
    path.move(to: CGPoint(x: center.x + 64, y: center.y))
    path.addArc(center: center, radius: 64, startAngle: .degrees(0),   endAngle: .degrees(360), clockwise: false)
    return path
  }
}
