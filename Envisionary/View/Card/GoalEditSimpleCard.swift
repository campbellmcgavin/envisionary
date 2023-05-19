//
//  GoalEditSimpleCard.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/9/23.
//

import SwiftUI

struct GoalEditSimpleCard: View {
    @Binding var goal: Goal
    
    @State var aspectString = ""
    @State var priorityString = ""
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
        VStack{
            FormText(fieldValue: $goal.title, fieldName: PropertyType.title.toString(), axis: .horizontal, iconType: .title)
            FormText(fieldValue: $goal.description, fieldName: PropertyType.description.toString(), axis: .vertical, iconType: .description)
            FormStackPicker(fieldValue: $aspectString, fieldName: PropertyType.aspect.toString(), options: vm.ListAspects().map({$0.aspect.toString()}), iconType: .aspect)
            FormStackPicker(fieldValue: $priorityString, fieldName: PropertyType.priority.toString(), options: PriorityType.allCases.map({$0.toString()}), iconType: .priority)
        }
        .onAppear{
            aspectString = goal.aspect.toString()
            priorityString = goal.priority.toString()
        }
        .onChange(of: aspectString){ _ in
            goal.aspect = AspectType.fromString(input: aspectString)
        }
        .onChange(of: priorityString){ _ in
            goal.priority = PriorityType.fromString(input: priorityString)
        }
    }
}

struct GoalEditSimpleCard_Previews: PreviewProvider {
    static var previews: some View {
        GoalEditSimpleCard(goal: .constant(Goal()))
    }
}
