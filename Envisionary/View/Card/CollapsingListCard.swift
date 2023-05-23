//
//  CollapsingListCard.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/18/23.
//

import SwiftUI

struct CollapsingListCard: View {
    @Binding var propertiesList: [Properties]
    let objectType: ObjectType
    
    @State var isExpanded: Bool = false
    
    var body: some View {
        
        VStack{
            
            if objectType == .recurrence {
                VStack{
                    ForEach(propertiesList) { properties in
                        
                        if isExpanded || propertiesList.firstIndex(of: properties) ?? 0 < 5 {
                                RecurrenceCard(recurrenceId: properties.id)
                                .modifier(ModifierCard())
                        }
                    }
                }
            }
            else{
                VStack{
                    ForEach(propertiesList) { properties in
                        
                        if isExpanded || propertiesList.firstIndex(of: properties) ?? 0 < 5 {
                            if objectType == .task {
                                TaskCard(taskId: properties.id)
                            }
                            else{
                                PhotoCard(objectType: objectType, objectId: properties.id, properties: properties, header: properties.title ?? "", subheader: properties.description ?? "")
                            }
                        }
                    }
                }
                .modifier(ModifierCard())
            }


            if propertiesList.count >= 5 {
                IconButton(isPressed: $isExpanded, size: .small, iconType: isExpanded ? .up : .down, iconColor: .grey6, circleColor: .grey2)
            }
        }

    }
}

struct CollapsingListCard_Previews: PreviewProvider {
    static var previews: some View {
        CollapsingListCard(propertiesList: .constant([Properties]()), objectType: .task)
    }
}
