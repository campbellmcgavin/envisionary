//
//  FormStackMultiPickerTrueFalse.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/8/23.
//

import SwiftUI

struct FormStackMultiPickerTrueFalse: View {
    @Binding var fieldValues: [String:Bool]
    let fieldName: String
    let options: [String]
    @State var isTrue: Bool
    var iconType: IconType?

    var isSearchable: Bool = false
    @State var isExpanded: Bool = false
    @State var searchString = ""
    @State var isRestrictingOptions = false
    

    
    var body: some View {
        
        VStack{
            FormTextTrueFalse(fieldValue: $isTrue, fieldName: fieldName, fieldDescription: GetDescription(), iconType: iconType)
                .frame(height:90)
            
            if !isTrue{
                WrappingHStack(fieldValue: .constant("nada"), fieldValues: $fieldValues, options: .constant(options), isMultiSelector: true, isRestrictingOptions: isRestrictingOptions)
                    .padding()
            }
        }
        .transition(.move(edge:.bottom))
        .modifier(ModifierForm(color:.grey2))
        .animation(.easeInOut)
        .onChange(of: isTrue){ _ in
            if isTrue{
                for fieldValue in fieldValues.keys{
                    fieldValues[fieldValue] = true
                }
            }
            else{
                for fieldValue in fieldValues.keys{
                    fieldValues[fieldValue] = false
                }
            }
        }
        .onChange(of: fieldValues){ _ in
            if !fieldValues.values.contains(where: {!$0}){
                isTrue = true
            }
            else if !fieldValues.values.contains(where: {$0}){
                isTrue = false
            }
        }
    }
    
    func GetDescription() -> String{
      
      
      var descriptionString = ""
      
      for str in options {
          descriptionString += str
          if str != options.last {
              descriptionString += ", "
          }
      }
      return descriptionString
    }
}

struct FormStackMultiPickerTrueFalse_Previews: PreviewProvider {
    static var previews: some View {
        FormStackMultiPickerTrueFalse(fieldValues: .constant([String:Bool]()), fieldName: "Value Alignment", options: ["hi","ho","hee","hum"], isTrue: true)
    }
}
