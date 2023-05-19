//
//  SessionValueAlignmentCard.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/8/23.
//

import SwiftUI

struct SessionValueAlignmentCard: View {
    @Binding var goalProperty: Properties
    @Binding var alignmentDictionary: [String: Bool]
    
    var body: some View {
        VStack{
            PhotoCardSimple(objectType: .goal, properties: goalProperty)
            
            FormStackMultiPickerTrueFalse(fieldValues: $alignmentDictionary, fieldName: "Value Alignment", options: alignmentDictionary.keys.map({$0}), isTrue: !alignmentDictionary.values.contains(where: {!$0}), iconType: .value)
        }
        .padding(8)
        .modifier(ModifierForm(color:.grey15))
    }
}

struct SessionValueAlignmentCard_Previews: PreviewProvider {
    static var previews: some View {
        SessionValueAlignmentCard(goalProperty: .constant(Properties()), alignmentDictionary: .constant([String:Bool]()))
    }
}
