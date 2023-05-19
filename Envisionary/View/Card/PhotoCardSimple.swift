//
//  PhotoCardSimple.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/5/23.
//

import SwiftUI

struct PhotoCardSimple: View {
    var objectType: ObjectType
    var properties: Properties
    var imageSize: SizeType = .large
    @State var image: UIImage? = nil
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        HStack(alignment:.center, spacing:0){
            
            
            ImageCircle(imageSize: imageSize.ToSize(), image: image, iconSize: .small, icon: objectType.toIcon())

            VStack(alignment:.leading, spacing:0){
                Text(properties.title ?? "")
                    .font(.specify(style: .h4))
                    .foregroundColor(.specify(color: .grey10))
                if let desc = properties.description{
                    if desc.count > 0 {
                        Text(desc)
                            .font(.specify(style: .body2))
                            .lineLimit(1)
                            .foregroundColor(.specify(color: .grey6))
                    }
                }
            }

            .padding(.leading)
            Spacer()
        }
        .frame(maxWidth:.infinity)
        .frame(height:55)
        .onAppear{
            
            if properties.image != nil {
                DispatchQueue.global(qos:.userInitiated).async{
                    image = vm.GetImage(id: properties.image!)
                }
            }
        }
    }
}

struct PhotoCardSimple_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCardSimple(objectType: .goal, properties: Properties(goal: Goal()))
    }
}
