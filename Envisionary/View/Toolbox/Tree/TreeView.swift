//
//  Diagram.swift
//  Visionary
//
//  Created by Campbell McGavin on 2/4/22.
//

import SwiftUI

struct TreeView<Value: Identifiable, V: View>: View where Value: Equatable {
    let parentGoalId: UUID
    var goalId: UUID
    @Binding var focusGoal: UUID
    @Binding var filteredGoals: Int
    @Binding var shouldShowAll: Bool
    @Binding var expandedObjects: [UUID]
    let shouldShowExpand: Bool
    let leftPadding: CGFloat
    let value: (Value, CGFloat) -> V
    let childCount: Int
    var isStatic: Bool = false
    var shouldScroll: Bool = true
    var shouldVStack: Bool = false
    @State var shouldExpand = false
    
    @EnvironmentObject var vm: ViewModel
    
    @State var goals = [Goal]()
    
    typealias Key = CollectDict<UUID, Anchor<CGPoint>>
    
    var body: some View {
        
        if shouldScroll{
            ScrollView([.horizontal],showsIndicators: false){
                BuildView()
            }
        }
        else{
            
            if shouldVStack{
                VStack(alignment:.leading, spacing: 0){
                    BuildView()
                }
            }
            else{
                BuildView()
            }
            
        }
    }
    
    @ViewBuilder
    func BuildView() -> some View{
        
        HStack{
            value(goalId as! Value, leftPadding)
            
            if shouldShowExpand && parentGoalId == goalId && focusGoal != goalId{
                Button{
                        shouldExpand.toggle()
                }label:{
                        IconType.down.ToIconString().ToImage(imageSize: SizeType.small.ToSize())
                        .foregroundColor(.specify(color: .grey5))
                            .rotationEffect(Angle(degrees: shouldExpand ? 0.0 : -90.0))
                }
                .onChange(of: shouldExpand){
                    withAnimation{
                        if expandedObjects.contains(parentGoalId){
                            expandedObjects.removeAll(where: {$0 == parentGoalId})
                        }
                        else{
                            expandedObjects.append(parentGoalId)
                        }
                    }
                }
                Spacer()
            }
        }
    
        
                .anchorPreference(key: Key.self, value: .center, transform: {
                    [self.goalId: $0]
                })
        
                .padding([.top,.bottom],5)
                .onChange(of: vm.updates.goal){
                    _ in
                    withAnimation{
                        goals = Goal.ComplexSort(predicates: Goal.predicatesOrderBased, goals: vm.ListChildGoals(id: goalId))
                    }
                }
                .onAppear(){
                    goals = Goal.ComplexSort(predicates: Goal.predicatesOrderBased, goals: vm.ListChildGoals(id: goalId))
                }
                .backgroundPreferenceValue(Key.self, { (centers: [UUID: Anchor<CGPoint>]) in
                    
                    GeometryReader { proxy in
                        ForEach(goals, content: { child in
                            
                            if centers[goalId] != nil && centers[child.id] != nil {
                                
                                let point1: CGPoint = proxy[centers[self.goalId]!]
                                let point2: CGPoint = proxy[centers[child.id]!]
                                
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
    
        if ShouldShowFromTop(){
            ForEach(goals, content: { child in
                
                if ShouldShow(goal: child){
                    TreeView(parentGoalId: parentGoalId, goalId: child.id, focusGoal: $focusGoal, filteredGoals: $filteredGoals, shouldShowAll: $shouldShowAll, expandedObjects: $expandedObjects, shouldShowExpand: shouldShowExpand, leftPadding: leftPadding + 30, value: self.value, childCount: childCount + 1, isStatic: isStatic, shouldScroll: shouldScroll)
                }
            })
            .offset(x: isStatic ? 0 : 60)
            .padding(.trailing, isStatic ? 0 : 60)
        }

            
        

    }
    func ShouldShowFromTop() -> Bool{
        if shouldShowExpand && parentGoalId == goalId{
            
            if expandedObjects.contains(parentGoalId){
                return true
            }
            return false
        }
        return true
    }
    
    func ShouldShow(goal: Goal) -> Bool{
        
        
        if shouldShowAll || goal.progress < 100 {
            return true
        }
        
        return false
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
