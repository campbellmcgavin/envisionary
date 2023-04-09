//
//  GanttCardView.swift
//  Visionary
//
//  Created by Campbell McGavin on 5/13/22.
//

import SwiftUI

struct DetailGantt: View {
    @Binding var shouldExpand: Bool
    @Binding var isPresentingModal: Bool
    @Binding var modalType: ModalType
    @Binding var focusGoal: UUID
    @State var expandedGoals = [UUID]()
    var goalId: UUID
    @State var isExpanded: Bool = true

    @EnvironmentObject  var dm: DataModel
    @EnvironmentObject var gs: GoalService
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        DetailView(viewType: .gantt, objectId: goalId, selectedObjectId: $focusGoal, selectedObjectType: .constant(.goal), shouldExpandAll: $shouldExpand, expandedObjects: $expandedGoals, isPresentingModal: $isPresentingModal, modalType: $modalType, content: {
            
            GanttMain(goalId: goalId, focusGoal: $focusGoal, expandedGoals: $expandedGoals)
                .frame(alignment:.leading)
                .onAppear{
                    expandedGoals.append(goalId)
                }
                .onChange(of: expandedGoals){
                    _ in
                    print(String(expandedGoals.count) + " goals in expanded goals")
                }
        })

            
        
    }
    
}


//struct CardViewGantt_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailGantt(goal: .constant(Goal.sampleGoals[0]), propertyTypeMenu: .constant([Bool](repeating: true, count:PropertyType.allCases.count)), focusGoal: .constant(UUID()), expandedGoals: .constant([UUID]()), isPreview: false)
//            .environmentObject(DataModel())
//    }
//}
