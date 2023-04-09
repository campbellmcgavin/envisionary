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

            ForEach(PropertyType.allCases, id:\.self){
                property in
                BuildPropertyRow(property: property)
            }
        }
        .frame(alignment:.leading)
        .padding([.top,.bottom],25)
    }
    
    @ViewBuilder
    func BuildPropertyRow(property: PropertyType) -> some View {
        switch property {
        case .title:
            if properties.title != nil {
                PropertyRow(propertyType: .title, text:properties.title)
            }
        case .description:
            if properties.description != nil {
                PropertyRow(propertyType: .description, text:properties.description)
            }
        case .timeframe:
            if properties.timeframe != nil {
                PropertyRow(propertyType: .timeframe, timeframe:properties.timeframe)
            }
        case .startDate:
            if properties.startDate != nil {
                PropertyRow(propertyType: .startDate, date:properties.startDate)
            }
        case .endDate:
            if properties.endDate != nil {
                PropertyRow(propertyType: .title, text:properties.title)
            }
        case .aspect:
            if properties.aspect != nil {
                PropertyRow(propertyType: .aspect, aspect:properties.aspect)
            }
        case .priority:
            if properties.priority != nil {
                PropertyRow(propertyType: .priority, priority:properties.priority)
            }
        case .progress:
            if properties.progress != nil {
                PropertyRow(propertyType: .progress, int:properties.progress)
            }
        case .coreValue:
            if properties.coreValue != nil {
                PropertyRow(propertyType: .coreValue, coreValue: properties.coreValue)
            }
        case .edited:
            if properties.edited != nil {
                PropertyRow(propertyType: .edited, int:properties.edited)
            }
        case .leftAsIs:
            if properties.leftAsIs != nil {
                PropertyRow(propertyType: .leftAsIs, int:properties.leftAsIs)
            }
        case .pushedOff:
            if properties.pushedOff != nil {
                PropertyRow(propertyType: .pushedOff, int:properties.pushedOff)
            }
        case .deleted:
            if properties.deleted != nil {
                PropertyRow(propertyType: .deleted, int:properties.deleted)
            }
        case .start:
            if properties.start != nil {
                PropertyRow(propertyType: .start, text:properties.start)
            }
        case .end:
            if properties.end != nil {
                PropertyRow(propertyType: .end, text:properties.end)
            }
        }
    }
}

struct DetailProperties_Previews: PreviewProvider {
    static var previews: some View {
        DetailProperties(shouldExpand: .constant(true), objectType: .goal, properties: Properties(objectType: .goal))
            .modifier(ModifierCard())
    }
}
