//
//  FormStackPicker.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/24/23.
//

import SwiftUI

struct FormStackMultiPicker: View {
    @Binding var fieldValues: [String:Bool]
    let fieldName: String
    @Binding var options: [String]
    var iconType: IconType?
    var isSearchable: Bool = false
    let isActivityPicker: Bool
    @State var isExpanded: Bool = false
    @State var searchString = ""
    @State var optionsList = [String]()
    @State var isRestrictingOptions = false
    @State var fieldValue = ""
    @State var isSearching: Bool = false
    @State var shouldAddOption: Bool = false
    
    let maxOptionsListCount = 20
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
            
        VStack{
            FormDropdown(fieldValue: $fieldValue, isExpanded: $isExpanded, fieldName: fieldName, iconType: iconType)
            
            if isExpanded{
                    WrappingHStack(fieldValue: .constant(""), fieldValues: $fieldValues, options: $optionsList, isMultiSelector: true, isRestrictingOptions: isRestrictingOptions)
                        .padding()
                    
                    if isSearchable{
                        HStack{
                            ZStack{
                                if isSearching{
                                    FormText(fieldValue: $searchString, fieldName: "Search", axis: .horizontal, iconType: isActivityPicker ? .add : .search, color: .grey2, isMini: true)
                                }
                                HStack{
                                    IconButton(isPressed: $isSearching, size: .small, iconType: isActivityPicker ? .add : .search, iconColor: .grey2, circleColor: .grey8)
                                    Spacer()
                                }
                            }
                            
                        }
                        .padding([.leading,.trailing],8)
                        .padding([.top,.bottom],5)
                        .animation(.easeInOut)
                        
                        if isActivityPicker && searchString.count > 3 {
                            TextButton(isPressed: $shouldAddOption, text: "Add \"" + searchString + "\"", color: .grey2, backgroundColor: .grey10, style: .h5, shouldHaveBackground: true, height: .small)
                        }
                    }
            }
        }
        .onAppear{
            searchString = fieldValue
            UpdateOptions()
        }
        .onChange(of: options){
            _ in
            UpdateOptions()
        }
        .onChange(of: searchString){
            _ in
            UpdateOptions()
            
        }
        .onChange(of: shouldAddOption){
            _ in
            if isActivityPicker{
                let request = CreateActivityRequest(keyword: searchString)
                _ = vm.CreateActivity(request: request)
                searchString = ""
            }
        }
        .transition(.move(edge:.bottom))
        .onChange(of: fieldValues){
            _ in
            
            fieldValue = fieldValues.filter({$0.value}).map({$0.key}).toCsvString()
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


