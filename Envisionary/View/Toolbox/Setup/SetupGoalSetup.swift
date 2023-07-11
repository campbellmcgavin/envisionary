//
//  SetupGoalSetup.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/12/23.
//

import SwiftUI

struct SetupGoalSetup: View {
//    @Binding var canProceed: Bool
    
    @State var goalsAdded: [ExampleGoalEnum: UUID] = [ExampleGoalEnum: UUID]()
    @State var focusGoal: UUID = UUID()
    @State var parentGoal: UUID? = nil
    
    @State var shouldAddGoals = false
    @State var nextGoalStep = ExampleGoalEnum.decide
    
    @State var nextGoal = CreateGoalRequest(properties: Properties())
    @State var expandedGoals: [UUID] = [UUID]()
    
    var body: some View {
        
        
        VStack{

            if let parentGoal{
                ScrollView(.horizontal,showsIndicators: true){
                    VStack(alignment:.leading, spacing:0){
                        
                        TreeDiagramView(goalId: parentGoal, focusGoal: $focusGoal, expandedGoals: $expandedGoals, value: { goalId in
                            BubbleView(goalId: goalId, focusGoal: $focusGoal)
                        }, childCount: 0)
                        .padding(.top,5)
                        .padding(.bottom)
                        .frame(maxWidth:.infinity)
                        .frame(alignment:.leading)
                        
                    }
                    .frame(alignment:.leading)
                    
            }
            .frame(maxWidth:.infinity)
        }
            Spacer()
        }
        .frame(minHeight:400)
        .frame(maxWidth:.infinity)
        .padding()
    }
}

struct SetupGoalSetup_Previews: PreviewProvider {
    static var previews: some View {
        SetupGoalSetup()
    }
}



