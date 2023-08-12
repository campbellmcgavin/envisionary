//
//  SessionLookingForwardCard.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/9/23.
//

import SwiftUI

struct SessionReviewUpcomingCard: View {
    @Binding var goalProperty: Properties
    @Binding var evaluation: EvaluationType
    @Binding var pushOff: Int
    @Binding var confirmed: Bool
    let timeframe: TimeframeType
    @State var shouldConfirm = false
    @State var evaluationString: String = ""
    @State var localProperties = Properties()
    @State var isValidForm = true
    @State var didAttemptToSave = false
    
    var body: some View {
        VStack{
            PhotoCardSimple(objectType: .goal, properties: goalProperty)
            
            if confirmed {
//                GetButton()
                
                FormTextConfirm(fieldValue: $confirmed, fieldName: "Evaluation", fieldDescription: GetEvaluationDescription(), iconType: .confirm)
            }
            else{
                FormStackPicker(fieldValue: $evaluationString, fieldName: "Evaluation", options: .constant(EvaluationType.allCases.map({$0.toString()})),iconType: .help)
            }
            
            switch evaluation {
            case .keepAsIs:
                EmptyView()
            case .editDetails:
                if !confirmed{
                    FormPropertiesStack(properties: $localProperties, images: .constant([UIImage]()), isPresentingPhotoSource: .constant(false), isValidForm: $isValidForm, didAttemptToSave: $didAttemptToSave, objectType: .goal, modalType: .add, isSimple: true)
                        .modifier(ModifierCard(color:.grey15))
                        .padding(.top)
                    GetButton()
                }
                
            case .pushOffTillNext:
                if !confirmed {
                    FormCounter(fieldValue: $pushOff, fieldName: "Number of " + timeframe.toString(), iconType: .timeForward)
                    GetButton()
                }
                
            case .deleteIt:
                if !confirmed {
                    GetButton()
                }
            }
        }
        .padding(8)
        .modifier(ModifierForm(color:.grey15))
        .onAppear(){
            evaluationString = evaluation.toString()
            localProperties = goalProperty
        }
        .onChange(of: evaluationString){
            _ in
            evaluation = EvaluationType.fromString(from: evaluationString)
        }
        .onChange(of: shouldConfirm){
            _ in
            didAttemptToSave = true
            
            if isValidForm{
                confirmed = true
            }
        }
        .onChange(of: confirmed){ _ in
            goalProperty = localProperties
        }
    }
    
    @ViewBuilder
    func GetButton() -> some View{
        TextIconButton(isPressed: $shouldConfirm, text: confirmed ? "Confirmed" : "Confirm", color: confirmed ? .grey7 : .grey0, backgroundColor: confirmed ? .grey4 : didAttemptToSave && !isValidForm ? .grey5 : .grey10, fontSize: .h3, shouldFillWidth: true, iconType: .confirm)
            .padding(.top)
            .disabled(confirmed)
    }
    
    func GetEvaluationDescription() -> String{
        switch evaluation {
        case .keepAsIs:
            return ""
        case .editDetails:
            return "Edits confirmed"
        case .pushOffTillNext:
            return "Pushed off by " + String(pushOff) + " " + timeframe.toString().lowercased() + "s"
        case .deleteIt:
            return "This goal and all associated content will be deleted."
        }
    }
    
    func GetFieldName() -> String{
        switch evaluation {
        case .keepAsIs:
            return ""
        case .editDetails:
            return "Confirm Edits"
        case .pushOffTillNext:
            return "Confirm Push"
        case .deleteIt:
            return "Confirm Deletion"
        }
    }
    
    func GetFieldDescription() -> String{
        switch evaluation {
        case .keepAsIs:
            return ""
        case .editDetails:
            return "Are you sure you want to save?"
        case .pushOffTillNext:
            return "Are you sure you want to push off this goal by " + String(pushOff) + " " + timeframe.toString() + "?"
        case .deleteIt:
            return "Are you sure you want to delete this goal and all associated content?"
        }
    }
}

struct SessionReviewUpcomingCard_Previews: PreviewProvider {
    static var previews: some View {
        SessionReviewUpcomingCard(goalProperty: .constant(Properties(goal: Goal())), evaluation: .constant(.keepAsIs), pushOff: .constant(0), confirmed: .constant(false), timeframe: .year)
    }
}
