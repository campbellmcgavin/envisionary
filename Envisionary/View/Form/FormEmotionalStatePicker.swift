//
//  FormEmotionalStatePicker.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/24/23.
//

import SwiftUI

struct FormEmotionalStatePicker: View {
    @Binding var fieldValue: Int
    let fieldName: String
    @State var emotionalStates: [Int] = [0,1,2,3,4]
    @State var isExpanded: Bool = false
    @State var textLabel = ""
    var body: some View {
        
        VStack{
            FormDropdown(fieldValue: $textLabel, isExpanded: $isExpanded, fieldName: fieldName, iconType: .upDown)
            
            if isExpanded{
                HStack{
                    ForEach(emotionalStates, id:\.self){
                        state in
                        
                        Button{
                            fieldValue = state
                        }
                    label:{
                        VStack{
                            Circle()
                                .frame(width:30, height:30)
                                .foregroundColor(.specify(color: state.toEmotionalStateColor()))

                                .shadow(color: state == fieldValue ? .specify(color: state.toEmotionalStateColor()) : .clear, radius: 8)
//                                .shadow(color: state == fieldValue ? .specify(color: state.toEmotionalStateColor()) : .clear, radius: 4)
                                .shadow(color: state == fieldValue ? .specify(color: .grey10) : .clear, radius: 3)
                            Text(state.toEmotionalState())
                                .font(.specify(style: .caption))
                        }
                        .frame(maxWidth:.infinity)
                        .opacity(state == fieldValue ? 1.0 : 0.4)
                    }
                    .buttonStyle(.plain)
                    }
                }
                .padding()

            }
        }
        .modifier(ModifierForm(color:.grey15))
        .transition(.move(edge:.bottom))
        .modifier(ModifierForm(color:.grey15))
        .animation(.easeInOut)
        .onAppear(){
            textLabel = fieldValue.toEmotionalState()
        }
        .onChange(of: fieldValue, perform: {_ in textLabel = fieldValue.toEmotionalState()})
        
    }
}

struct FormEmotionalStatePicker_Previews: PreviewProvider {
    static var previews: some View {
        FormEmotionalStatePicker(fieldValue: .constant(4), fieldName: "Emotional State")
    }
}
