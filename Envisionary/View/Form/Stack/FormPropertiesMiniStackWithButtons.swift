//
//  FormPropertiesMiniStackWithButtons.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/14/23.
//

import SwiftUI

struct FormPropertiesMiniStackWithButtons: View {
    let objectType: ObjectType
    let objectId: UUID
    @State var properties: Properties = Properties()
    @EnvironmentObject var vm: ViewModel
    
    @State var isValidForm: Bool = false
    @StateObject var validator: FormPropertiesValidator = FormPropertiesValidator()
    @State var isPresentingNewGoal = false
    @State var shouldAddGoal = false
    @State var goal: Goal? = nil
    @State var didAttemptToSave = false
    
    var body: some View {
        VStack(alignment:.leading){
            
            if isPresentingNewGoal {
                VStack(alignment:.leading){
                    Text("Add Goal")
                        .font(.specify(style: .h3))
                        .foregroundColor(.specify(color: .grey10))
                        .frame(alignment:.leading)
                    
                    Text("The timeframe and dates are assumed based on the session dates and timeframe.")
                        .font(.specify(style: .caption))
                        .foregroundColor(.specify(color: .grey5))
                        .frame(alignment:.leading)
                        .multilineTextAlignment(.leading)
                }
                .padding([.top,.bottom])
                .padding(.leading,8)

                
                FormPropertiesStack(properties: $properties, images: .constant([UIImage]()), isPresentingPhotoSource: .constant(false), isValidForm: $isValidForm, didAttemptToSave: $didAttemptToSave, objectType: .goal, modalType: .add, isSimple: true)
                    .padding(.bottom)
                
                TextIconButton(isPressed: $shouldAddGoal, text: "Add goal", color: .grey2, backgroundColor: !isValidForm && didAttemptToSave ? .grey3 : .grey10, fontSize: .h3, shouldFillWidth: true, iconType: .add)
                    .disabled(!isValidForm)
            }
            TextIconButton(isPressed: $isPresentingNewGoal, text: isPresentingNewGoal ? "Cancel" : "Add goal", color: isPresentingNewGoal ? .grey10 : .grey10, backgroundColor: isPresentingNewGoal ? .grey4 : .grey5, fontSize: .h3, shouldFillWidth: true, iconType: isPresentingNewGoal ? .cancel : .add)
        }
        .padding(8)
        .modifier(ModifierForm(color: isPresentingNewGoal ? .grey15 : .clear))
        .padding([.top,.bottom])
        .onChange(of: shouldAddGoal){
            _ in
            
            if isValidForm{
                isPresentingNewGoal = false
                var request = CreateGoalRequest(properties: properties)
                _ = vm.CreateGoal(request: request)
            }
            didAttemptToSave = true
        }
        .onAppear(){
            goal = vm.GetGoal(id: objectId)
            if let goal{
                properties.priority = goal.priority
                properties.aspect = goal.aspect
                properties.parentGoalId = goal.id
                properties.startDate = goal.startDate
                properties.endDate = goal.endDate
            }
        }
    }
}

struct FormPropertiesMiniStackWithButtons_Previews: PreviewProvider {
    static var previews: some View {
        FormPropertiesMiniStackWithButtons(objectType: .goal, objectId: UUID())
    }
}
