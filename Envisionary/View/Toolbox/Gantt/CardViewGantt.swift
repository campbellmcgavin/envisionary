//
//  GanttCardView.swift
//  Visionary
//
//  Created by Campbell McGavin on 5/13/22.
//

import SwiftUI

struct CardViewGantt: View {
    
    @Binding var goal: Goal
    @Binding var propertyTypeMenu: [Bool]
    @Binding var focusGoal: UUID
    @Binding var expandedGoals: [UUID]
    @EnvironmentObject  var dataModel: DataModel
    @Environment(\.colorScheme) var colorScheme
    let isPreview: Bool
    
    var body: some View {

        HStack(alignment: .center){
                VStack{
                    GanttMain(goal: $goal, propertyTypeMenu: $propertyTypeMenu, focusGoal: $focusGoal, expandedGoals: $expandedGoals, isPreview: isPreview)
                        .environmentObject(dataModel)
                    Spacer(minLength: 30)
                }
            
        }
        .frame(minHeight:150)
        .padding(10)
    }
    
}


struct CardViewGantt_Previews: PreviewProvider {
    static var previews: some View {
        CardViewGantt(goal: .constant(Goal.sampleGoals[0]), propertyTypeMenu: .constant([Bool](repeating: true, count:PropertyType.allCases.count)), focusGoal: .constant(UUID()), expandedGoals: .constant([UUID]()), isPreview: false)
            .environmentObject(DataModel())
    }
}
