//
//  PropertyRow.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/16/23.
//

import SwiftUI

struct PropertyRow: View {
    let propertyType: PropertyType
    var value: String
    
    var body: some View {
        VStack(alignment:.leading){
            HStack(alignment:.center, spacing:0){
                
                IconLabel(size: .medium, iconType: propertyType.toIcon(), iconColor: .grey4)
                    .padding(.leading,6)
                    .padding(.trailing,7)
                
//                propertyType.toIcon().ToIconString().ToImage(imageSize: SizeType.medium.ToSize())
//                    .foregroundColor(.specify(color: .grey4))
//                    .padding(.leading,6)
//                    .padding(.trailing,7)
                
                VStack(alignment:.leading, spacing:0){
                    Text(propertyType.toString())
                        .font(.specify(style: .caption))
                        .foregroundColor(.specify(color: .grey4))
                    
                    Text(value)
                        .font(.specify(style: .body1))
                        .foregroundColor(.specify(color: .grey10))
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                }
                .frame(alignment:.leading)
                .padding(.trailing)
                Spacer()
            }
            .frame(alignment:.leading)
            .frame(maxWidth:.infinity)
            Divider()
                .overlay(Color.specify(color: .grey2))
                .padding(.leading,50)
        }
    }
    
//    @ViewBuilder
//    func BuildLabel() -> some View{
//        VStack(alignment:.leading){
//            HStack(alignment:.center, spacing:0){
//                
//                propertyType.toIcon().ToIconString().ToImage(imageSize: SizeType.medium.ToSize())
//                    .foregroundColor(.specify(color: .grey4))
//                    .padding(.leading,6)
//                    .padding(.trailing,7)
//                
//                VStack(alignment:.leading, spacing:0){
//                    Text(propertyType.toString())
//                        .font(.specify(style: .caption))
//                        .foregroundColor(.specify(color: .grey4))
//                    
//                    Text(value)
//                        .font(.specify(style: .body1))
//                        .foregroundColor(.specify(color: .grey10))
//                        .fixedSize(horizontal: false, vertical: true)
//                        .multilineTextAlignment(.leading)
//                }
//                .frame(alignment:.leading)
//                .padding(.trailing)
//                Spacer()
//            }
//            .frame(alignment:.leading)
//            .frame(maxWidth:.infinity)
//            Divider()
//                .overlay(Color.specify(color: .grey2))
//                .padding(.leading,50)
//        }
//    }
}

struct PropertyRow_Previews: PreviewProvider {
    static var previews: some View {
        PropertyRow(propertyType: .progress, value: "5")
    }
}
