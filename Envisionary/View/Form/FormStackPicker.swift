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
    @Binding var options: [String]
    @Binding var deleteMe: String
    @Binding var addMe: String
    var iconType: IconType?
    var isSearchable: Bool = false
    var canEdit: Bool = false
    @State var shouldExpand: Bool = false
    @State var isExpanded: Bool = false
    @State var optionsList = [String]()
    @State var isRestrictingOptions = false
    @State var isEditing = false
    @State var addMeText: String = ""
    @State var shouldAdd: Bool = false
    let maxOptionsListCount = 30
    var body: some View {
            
        VStack{
            if isSearchable {
                FormSearchableDropdown(fieldValue: $fieldValue, isExpanded: $shouldExpand, fieldName: fieldName, isSearchable: true, iconType: iconType)
            }
            else{
                FormDropdown(fieldValue: $fieldValue, isExpanded: $shouldExpand, fieldName: fieldName, iconType: iconType)
            }
            
            if isExpanded{
                WrappingHStack(fieldValue: $fieldValue, fieldValues: .constant([String:Bool]()), options: $optionsList, isEditing: $isEditing, deleteMe: $deleteMe, isRestrictingOptions: isRestrictingOptions)
                    .padding()
                if canEdit{
                    HStack{
                        if isEditing {
                            //add
                            
                            FormText(fieldValue: $addMeText, fieldName: "Add", axis: .horizontal, isMini: true, shouldShowErase: false)
                            
                            if addMeText.count > 0 {
                                IconButton(isPressed: $shouldAdd, size: .small, iconType: .confirm, iconColor: .grey0, circleColor: .grey10)
                            }
                        }
                        Spacer()
                        // edit
                        IconButton(isPressed: $isEditing, size: .small, iconType: isEditing ? ( addMeText.count > 0 ? .cancel : .confirm) : .edit, iconColor: .grey10, circleColor: .grey4, hasAnimation: true)
                    }
                    .padding([.leading,.trailing,.bottom])
                }
            }

        }
        .onAppear{
            UpdateOptions()
        }
        .onChange(of: shouldAdd){
            _ in
            addMe = addMeText
            addMeText = ""
        }
        .onChange(of: isEditing){ _ in
            addMeText = ""
        }
        .onChange(of: shouldExpand){
            _ in
            
            withAnimation(.smooth){
                isExpanded = shouldExpand
            }
        }
        .onChange(of: options){
            _ in
            UpdateOptions()
        }
        .onChange(of: fieldValue){
            _ in
            UpdateOptions()
            
            if options.contains(where:{$0 == fieldValue}){
                shouldExpand = false
            }
        }
        .modifier(ModifierForm(color:.grey15))
    }
    
    func UpdateOptions(){
        
        if isSearchable {
            if fieldValue == " " || fieldValue.count == 0 {
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
                let filteredList = options.filter({$0.description.localizedCaseInsensitiveContains(fieldValue)})
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

//struct FormStackPicker_Previews: PreviewProvider {
//    static var previews: some View {
//
//            ScrollView{
//                VStack(spacing:10){
//                FormText(fieldValue: .constant(Properties().title!), fieldName: "Title", axis: .horizontal, iconType: .title)
//                FormText(fieldValue: .constant(Properties().description!), fieldName: "Description", axis: .vertical, iconType: .description)
//                    FormStackPicker(fieldValue: .constant("Career"), fieldName: "Aspect", options: AspectType.allCases.map({$0.toString()}),iconType: .aspect)
//                    FormStackPicker(fieldValue: .constant("Day"), fieldName: "Timeframe", options: TimeframeType.allCases.map({$0.toString()}),iconType: .timeframe)
//            }
//
//        }
//        .padding()
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .modifier(ModifierCard())
//
//
//    }
//}
