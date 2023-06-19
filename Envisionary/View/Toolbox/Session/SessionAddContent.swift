//
//  SessionAddContent.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/11/23.
//

import SwiftUI

struct SessionAddContent: View {
    @Binding var shouldAddGoal: Bool
    @Binding var properties: Properties
    var goalProperties: [Properties]
    let timeframe: TimeframeType
    let date: Date
    @State var isExpanded: Bool = true
    @State var isPresentingNewGoal = false
    @State var isValidForm = false
    
    @State var shouldAttemptAddGoal = false
    @State var didAttemptToSave = false
    
    var body: some View {
        HeaderWithContent(shouldExpand: $isExpanded, headerColor: .grey10, header: "Affected Goals", content: {
            
            if goalProperties.count > 0 {
                VStack{
                    
                    ForEach(goalProperties) { goalProperty in
                        PhotoCardSimple(objectType: .goal, properties: goalProperty, imageSize: .mediumLarge)
                            .padding([.leading, .trailing],11)
                        if goalProperties.last != goalProperty{
                            StackDivider()
                        }
                    }
                }
                .padding([.top,.bottom],11)
                .modifier(ModifierForm(color:.grey15))
            }
            else{
                NoObjectsLabel(objectType: .goal, labelType: .session)
            }
        })
        VStack(alignment:.leading){
            
            if isPresentingNewGoal {
                Text("Add " + timeframe.toString() + " Goal")
                    .font(.specify(style: .h3))
                    .foregroundColor(.specify(color: .grey10))
                    .frame(alignment:.leading)
                    .padding([.leading,.top])
                
                Text("The timeframe and dates are assumed based on the session dates and timeframe.")
                    .font(.specify(style: .caption))
                    .foregroundColor(.specify(color: .grey5))
                    .frame(alignment:.leading)
                    .padding([.leading,.bottom])
                
                FormPropertiesStack(properties: $properties, images: .constant([UIImage]()), isPresentingPhotoSource: .constant(false), isValidForm: $isValidForm, didAttemptToSave: $didAttemptToSave, objectType: .goal, modalType: .add, isSimple: true)
                    .padding(.bottom)
                
                TextButton(isPressed: $shouldAttemptAddGoal, text: "Add goal", color: .grey2, backgroundColor: !isValidForm && didAttemptToSave ? .grey3 : .grey10, style: .h3, shouldHaveBackground: true)
            }
            TextButton(isPressed: $isPresentingNewGoal, text: isPresentingNewGoal ? "Cancel" : "Add goal", color: isPresentingNewGoal ? .grey10 : .grey2, backgroundColor: isPresentingNewGoal ? .grey4 : .grey10, style: .h3, shouldHaveBackground: true)
        }
        .padding(8)
        .modifier(ModifierForm(color: isPresentingNewGoal ? .grey15 : .clear))
        .padding(.top,30)
        .padding(.bottom,200)
        .onChange(of: shouldAddGoal){
            _ in
            isPresentingNewGoal = false
        }
        .onChange(of:shouldAttemptAddGoal){
            _ in
            if isValidForm {
                shouldAddGoal.toggle()
            }
            didAttemptToSave = true
        }
    }
}

//struct SessionAddContent_Previews: PreviewProvider {
//    static var previews: some View {
//        SessionAddContent(goalProperties: .constant([Properties]()), timeframe: .month, date: Date())
//    }
//}
