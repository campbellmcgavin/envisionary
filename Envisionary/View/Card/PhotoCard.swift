//
//  PhotoCard.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/11/23.
//

import SwiftUI

struct PhotoCard: View {
    var objectType: ObjectType
    var objectId: UUID
    var properties: Properties
    var header: String
    var subheader: String
    var caption: String?
    var imageString: String?
    
    var body: some View {
//        Button
        NavigationLink(destination: Detail(objectType: .goal, objectId: objectId, properties: properties))
        {
            HStack(alignment:.center, spacing:0){
                
                ZStack{
                    Circle()
                        .frame(width:50,height:50)
                        .foregroundColor(.specify(color: .grey2))
                    IconLabel(size: .small, iconType: objectType.toIcon(), iconColor: .grey0)
                }

    //            ActionButton(isPressed: .constant(true), size: .medium, iconType: .value, iconColor: .grey5)
    //                .disabled(true)
    //                .foregroundColor(.specify(color: .grey5))
                VStack(alignment:.leading, spacing:0){
                    Text(header)
                        .font(.specify(style: .h4))
                        .foregroundColor(.specify(color: .grey10))
                    if subheader.count > 0 {
                        Text(subheader)
                            .font(.specify(style: .body2))
                            .lineLimit(1)
                            .foregroundColor(.specify(color: .grey6))
                    }
                    if caption != nil {
                        Text(caption!)
                            .font(.specify(style: .caption))
                            .textCase(.uppercase)
                            .foregroundColor(.specify(color: .grey3))
                            .padding(.top,3)
                    }
                }

                .padding(.leading)
                Spacer()
                IconButton(isPressed: .constant(true), size: .small, iconType: .right, iconColor: .grey5)
                    .disabled(true)
            }
            .padding()
            .frame(maxWidth:.infinity)
            .frame(height:75)
        }

        
            
    

    }
    
}

struct PhotoCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing:0){
            ScrollView{
                PhotoCard(objectType: .goal, objectId: UUID(), properties: Properties(), header: "Study for AWS exam", subheader: "May, 2021 - June, 2021", caption: "In Progress")
                PhotoCard(objectType: .goal, objectId: UUID(), properties: Properties(), header: "Study for AWS exam", subheader: "May, 2021 - June, 2021", caption: "In Progress")
                PhotoCard(objectType: .goal, objectId: UUID(), properties: Properties(), header: "Study for AWS exam", subheader: "May, 2021 - June, 2021", caption: "In Progress")
                PhotoCard(objectType: .goal, objectId: UUID(), properties: Properties(), header: "Study for AWS exam", subheader: "May, 2021 - June, 2021", caption: "In Progress")
                PhotoCard(objectType: .goal, objectId: UUID(), properties: Properties(), header: "Study for AWS exam", subheader: "May, 2021 - June, 2021", caption: "In Progress")
            }
        }
        
        
        .background(Color.specify(color: .grey0))
        
    }
}
