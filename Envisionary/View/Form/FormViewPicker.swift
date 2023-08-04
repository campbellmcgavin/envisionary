//
//  FormViewPicker.swift
//  Envisionary
//
//  Created by Campbell McGavin on 8/2/23.
//

import SwiftUI

struct FormViewPicker: View {
    @Binding var fieldValue: String
    let fieldName: String
    var options: [String:String]
    var iconType: IconType?
    
    @State var isExpanded = false
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        VStack{
            FormDropdown(fieldValue: $fieldValue, isExpanded: $isExpanded, fieldName: fieldName, iconType: iconType)
            
            if isExpanded{
                
                ScrollView(.horizontal){
                    HStack{
                        ForEach(options.keys.map({String($0)}).sorted(), id:\.self){ optionString in
                            
                            Button{
                                fieldValue = optionString
                            }
                        label:{
                            VStack{
                                Text(optionString)
                                    .font(.specify(style: .h6))
                                    .foregroundColor(.specify(color: .grey7))
                                if let imageString = options[optionString]{
                                    Image(imageString)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 200, alignment: .center)
                                        .cornerRadius(8)
                                }
                            }
                            .padding(8)
                            .modifier(ModifierSmallCard(color: fieldValue == optionString ? .purple : .grey2, opacity: fieldValue == optionString ? 0.7 : 1.0))
                            
                        }
                        }
                    }
                    .padding([.leading,.trailing],8)
                    .padding(.bottom,5)
                }
            }
        }
        .transition(.move(edge:.bottom))
        .onChange(of: fieldValue){
            _ in
            
            if options.contains(where:{$0.key == fieldValue}){
                isExpanded = false
            }
        }
        .modifier(ModifierForm(color:.grey15))
        .animation(.easeInOut)
    }
}

struct FormViewPicker_Previews: PreviewProvider {
    static var previews: some View {
        FormViewPicker(fieldValue: .constant("helloooo"), fieldName: "Which option fits best", options: [String:String]())
    }
}
