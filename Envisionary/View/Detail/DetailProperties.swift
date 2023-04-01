//
//  DetailProperties.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/11/23.
//

import SwiftUI

struct DetailProperties: View {
    @Binding var shouldExpand: Bool
    let objectType: ObjectType
    let properties: Properties
    
    @State var isExpanded: Bool = true
    
    var body: some View {
        
        VStack(spacing:0){
            HeaderButton(isExpanded: $isExpanded, color: .grey10, header: "Details")
            
            if isExpanded {
                    
                BuildView()
                .frame(maxWidth:.infinity)
                .frame(alignment:.leading)
                .modifier(ModifierCard())

            }
        }
        .onChange(of:shouldExpand){
            _ in
            withAnimation{
                if shouldExpand{
                    isExpanded = true
                }
                else{
                    isExpanded = false
                }
            }
        }


    }
    
    @ViewBuilder
    func BuildView() -> some View {
        VStack(alignment:.leading){

            if properties.title != nil {
                PropertyRow(propertyType: .title, text:properties.title)
            }

            if properties.description != nil {
                PropertyRow(propertyType: .description, text:properties.description)
            }

            if properties.timeframe != nil {
                PropertyRow(propertyType: .timeframe, timeframe:properties.timeframe)
            }
            
            if properties.startDate != nil {
                PropertyRow(propertyType: .startDate, date:properties.startDate)
            }
            
            if properties.endDate != nil {
                PropertyRow(propertyType: .endDate, date:properties.endDate)
            }
            
            if properties.aspect != nil {
                PropertyRow(propertyType: .aspect, aspect: properties.aspect)
            }
            
            if properties.progress != nil {
                PropertyRow(propertyType: .progress, int:properties.progress)
            }
            
            if properties.priority != nil {
                PropertyRow(propertyType: .priority, priority:properties.priority)
            }
            if properties.progress != nil {
                PropertyRow(propertyType: .progress, int:properties.progress)
            }
        }
        .frame(alignment:.leading)
        .padding([.top,.bottom],25)
    }
}

struct DetailProperties_Previews: PreviewProvider {
    static var previews: some View {
        DetailProperties(shouldExpand: .constant(true), objectType: .goal, properties: Properties(objectType: .goal))
            .modifier(ModifierCard())
    }
}
