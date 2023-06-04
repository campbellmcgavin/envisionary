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
    
    var body: some View {
        HeaderWithContent(shouldExpand: $isExpanded, headerColor: .grey10, header: "Affected Goals", content: {
            
            VStack{
                
                ForEach(goalProperties) { goalProperty in
                    PhotoCardSimple(objectType: .goal, properties: goalProperty)
                        .padding([.leading, .trailing])
                    if goalProperties.last != goalProperty{
                        StackDivider()
                    }
                }
            }
            .padding([.top,.bottom])
            .modifier(ModifierForm(color:.grey15))
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
                
                FormPropertiesStack(properties: $properties, images: .constant([UIImage]()), isPresentingPhotoSource: .constant(false), isValidForm: $isValidForm, objectType: .goal, modalType: .add, isSimple: true)
                    .padding(.bottom)
                
                TextButton(isPressed: $shouldAddGoal, text: "Add goal", color: .grey2, backgroundColor: .grey10, style: .h3, shouldHaveBackground: true)
                    .disabled(!isValidForm)
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
    }
}

//struct SessionAddContent_Previews: PreviewProvider {
//    static var previews: some View {
//        SessionAddContent(goalProperties: .constant([Properties]()), timeframe: .month, date: Date())
//    }
//}
