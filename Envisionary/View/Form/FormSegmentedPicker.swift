//
//  FormSegmentedPicker.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/19/23.
//

import SwiftUI

struct FormSegmentedPicker: View {
    @Binding var fieldValue: String
    let fieldName: String
    let options: [String]
    var body: some View {
        
        ZStack(alignment:.leading){
            FormCaption(fieldName: fieldName, fieldValue: "")
                .offset(y:-45)
            ScrollView(.horizontal){
                HStack{
                    ForEach(options, id:\.self){ option in
                        Button{
                            fieldValue = option
                        }
                        
                    label:{
                        Text(option)
                            .font(.specify(style: .caption))
                            .frame(height:38)
                            .foregroundColor(.specify(color: .grey10))
                            .padding([.leading,.trailing],12)
                            .background(Color.specify(color:  fieldValue == option ? .purple : .grey3))
                            .cornerRadius(22)

                    }
                }
//                    .padding()
                    
                }
                .padding([.leading,.trailing])
 
            }
            .scrollIndicators(.hidden)
        }
        .padding(.top,25)
        .padding(.bottom,10)
        .modifier(ModifierForm(color:.grey15))
        
    }
}

struct FormSegmentedPicker_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            FormSegmentedPicker(fieldValue: .constant("Title"), fieldName: "Goal Grouping", options: ["Title", "Aspect", "Priority", "Progress", "Option 5"])
        }
        .frame(maxWidth:.infinity,maxHeight:.infinity)
        .modifier(ModifierCard())
        
    }
}
