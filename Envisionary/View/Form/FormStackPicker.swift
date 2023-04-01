//
//  FormStackPicker.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/19/23.
//

import SwiftUI

struct FormStackPicker: View {
    @Binding var fieldValue: String
    let fieldName: String
    let options: [String]
    var iconType: IconType?
    @State var isExpanded: Bool = false
    var body: some View {
            
        VStack{
            FormDropdown(fieldValue: $fieldValue, isExpanded: $isExpanded, fieldName: fieldName, iconType: iconType)
            if isExpanded{
                WrappingHStack(fieldValue: $fieldValue, options: .constant(options))
                    .padding()
            }
        }
        .transition(.move(edge:.bottom))
        .onChange(of: fieldValue){
            _ in
            isExpanded = false
        }
        .modifier(ModifierForm(color:.grey15))
        .animation(.easeInOut)
    }
}

struct FormStackPicker_Previews: PreviewProvider {
    static var previews: some View {

            ScrollView{
                VStack(spacing:10){
                FormText(fieldValue: .constant(Properties().title!), fieldName: "Title", axis: .horizontal, iconType: .title)
                FormText(fieldValue: .constant(Properties().description!), fieldName: "Description", axis: .vertical, iconType: .description)
                    FormStackPicker(fieldValue: .constant("Career"), fieldName: "Aspect", options: AspectType.allCases.map({$0.toString()}),iconType: .aspect)
                    FormStackPicker(fieldValue: .constant("Day"), fieldName: "Timeframe", options: TimeframeType.allCases.map({$0.toString()}),iconType: .timeframe)
            }

        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .modifier(ModifierCard())


    }
}
