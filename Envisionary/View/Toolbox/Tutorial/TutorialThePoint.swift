//
//  TutorialThePoint.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/5/23.
//

import SwiftUI

struct TutorialThePoint: View {
    @Binding var canProceed: Bool
    @EnvironmentObject var vm: ViewModel
    @State var objectId: UUID? = nil
    @State var expandedGoals: [UUID] = [UUID]()
    @State var focusGoal: UUID = UUID()
    
    var body: some View {
        VStack{
            ZStack{
                BuildView()
                    .padding()
        }
            .onAppear(){
                canProceed = true
                var criteria = Criteria()
                criteria.includeCalendar = false
                let parentId = vm.ListGoals(criteria: criteria).first?.id
                
                if let parentId{
                    objectId =  parentId
                    let childGoals = vm.ListAffectedGoals(id: parentId).map({$0.id})
                    expandedGoals.append(contentsOf: childGoals)
                }
            }
Spacer()
        }
        .frame(maxWidth:.infinity)
    }
    
    @ViewBuilder
    func BuildView() -> some View{
        if let objectId{
            ScrollView([.horizontal],showsIndicators: true){
                HStack{
                    TreeDiagramView(goalId: objectId, focusGoal: $focusGoal, expandedGoals: $expandedGoals, value: { goalId in
                        BubbleView(goalId: goalId, focusGoal: $focusGoal, shouldShowStatusLabel: true)
                    }, childCount: 0)
                    .padding(.top,5)
                    .padding(.bottom)
                    Spacer()
            }
                .frame(width: UIScreen.screenWidth + 250)
            .frame(alignment:.leading)
        }
        }
    }
}

struct TutorialThePoint_Previews: PreviewProvider {
    static var previews: some View {
        TutorialThePoint(canProceed: .constant(true))
    }
}
