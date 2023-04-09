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
    var isSearchable: Bool = false
    @State var isExpanded: Bool = false
    @State var searchString = ""
    @State var optionsList = [String]()
    @State var isRestrictingOptions = false
    
    let maxOptionsListCount = 30
    var body: some View {
            
        VStack{
            if isSearchable {
                FormSearchableDropdown(fieldValue: $fieldValue, isExpanded: $isExpanded, searchString: $searchString, fieldName: fieldName, isSearchable: true, iconType: iconType)
            }
            else{
                FormDropdown(fieldValue: $fieldValue, isExpanded: $isExpanded, fieldName: fieldName, iconType: iconType)
            }
            
            if isExpanded{
                WrappingHStack(fieldValue: $fieldValue, options: $optionsList, isRestrictingOptions: isRestrictingOptions)
                    .padding()
            }
        }
        .onAppear{
            searchString = fieldValue
            UpdateOptions()
        }
        .onChange(of: searchString){
            _ in
            UpdateOptions()
        }
        .transition(.move(edge:.bottom))
        .onChange(of: fieldValue){
            _ in
            
            if options.contains(where:{$0 == fieldValue}){
                isExpanded = false
            }
        }
        .modifier(ModifierForm(color:.grey15))
        .animation(.easeInOut)
    }
    
    func UpdateOptions(){
        
        if isSearchable {
            if searchString == " " || searchString.count == 0 {
                if options.count > maxOptionsListCount {
                    optionsList = Array(options[0..<maxOptionsListCount])
                    isRestrictingOptions = true
                }
                else{
                    optionsList = options
                    isRestrictingOptions = false
                }
            }
            else{
                let filteredList = options.filter({$0.description.localizedCaseInsensitiveContains(searchString)})
                if filteredList.count > maxOptionsListCount {
                    optionsList = Array(filteredList[0..<maxOptionsListCount])
                    isRestrictingOptions = true
                }
                else{
                    optionsList = filteredList
                    isRestrictingOptions = false
                }
            }
        }
        else{
            optionsList = options
        }


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
