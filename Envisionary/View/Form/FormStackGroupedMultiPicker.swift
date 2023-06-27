//
//  FormStackPicker.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/24/23.
//

import SwiftUI

struct FormStackGroupedMultiPicker: View {
    @Binding var fieldValues: [String:Bool]
    let fieldName: String
    @Binding var groupedOptions: [String:[String]]
    var iconType: IconType?
    @State var isExpanded: Bool = false
    @State var isExpandedGroups: Bool = false
    @State var optionsList = [String]()
    @State var isRestrictingOptions = false
    @State var fieldValue = ""
    
    let maxOptionsListCount = 20
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
            
        VStack{
            FormDropdown(fieldValue: $fieldValue, isExpanded: $isExpanded, fieldName: fieldName, iconType: iconType)
            
            if isExpanded{
                if isExpandedGroups{
                    VStack{
                        IconButton(isPressed: $isExpandedGroups, size: .small, iconType: .down, iconColor: .grey10, circleColor: .grey3, opacity: 100, circleOpacity: 100, hasAnimation: true)
                            .rotationEffect(.degrees(isExpandedGroups ? 180 : 0))
                            .padding(.top,8)
                        ForEach(Array(groupedOptions.keys).sorted(by: {$0 < $1}), id:\.self){
                            groupKeyword in
                            
                            if let optionsList = groupedOptions[groupKeyword]{
                                
                                HStack{
                                    Text(groupKeyword)
                                        .font(.specify(style: .h5))
                                        .foregroundColor(.specify(color: .grey8))
                                        .padding(.bottom,-25)
                                    Spacer()
                                }
                                .padding(.leading)
                                WrappingHStack(fieldValue: .constant(""), fieldValues: $fieldValues, options: .constant(optionsList), isMultiSelector: true, isRestrictingOptions: isRestrictingOptions)
                                    .padding()
                            }
                        }
                    }
                    .padding(.top)
                }
                else{
                    WrappingHStack(fieldValue: .constant(""), fieldValues: $fieldValues, options: $optionsList, isMultiSelector: true, isRestrictingOptions: isRestrictingOptions)
                        .padding()
                }
                
//                if !isExpandedGroups{
                IconButton(isPressed: $isExpandedGroups, size: .small, iconType: .down, iconColor: .grey10, circleColor: .grey3, opacity: 100, circleOpacity: 100, hasAnimation: true)
                    .rotationEffect(.degrees(isExpandedGroups ? 180 : 0))
                    .padding(.bottom,8)
//                }
            }
        }
        .onAppear{
            UpdateOptions()
        }
        .onChange(of: groupedOptions){
            _ in
            UpdateOptions()
        }
        .onChange(of: isExpandedGroups){
            _ in
            UpdateOptions()
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
        optionsList.removeAll()
        
        let selectedOptions = fieldValues.filter({$0.value}).keys
        optionsList.append(contentsOf: selectedOptions)
        
        let groupedOptionsSorted = Array(groupedOptions.keys).sorted(by: {$0 < $1})
        for key in groupedOptionsSorted{
            if !optionsList.contains(where:{$0 == key}){
                optionsList.append(key)
            }
        }
    }
}


