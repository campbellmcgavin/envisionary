//
//  FormCalendarPicker.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/19/23.
//

import SwiftUI

struct FormCalendarPicker: View {
    @Binding var fieldValue: Date
    let fieldName: String
    @Binding var timeframeType: TimeframeType
    var iconType: IconType?
    @State var isExpanded: Bool = false
    @State var fieldValueString = ""
    var isStartDate: Bool?
    var body: some View {
        ZStack(alignment:.topLeading){
            
            VStack{
                FormDropdown(fieldValue: $fieldValueString, isExpanded: $isExpanded, fieldName: fieldName, iconType: iconType)
                if isExpanded{
                    CalendarPicker(date: $fieldValue, timeframeType: $timeframeType, dateStatuses: .constant([DateValue]()), localized: true)
                        .padding()
                        .padding(.bottom)
                }
            }
            .transition(.move(edge:.bottom))
            .modifier(ModifierForm(color:.grey15))
            
        }
        .onAppear{
            fieldValueString = fieldValue.toString(timeframeType: timeframeType, isStartDate: isStartDate)
        }
        .onChange(of: fieldValue){
            _ in
            fieldValueString = fieldValue.toString(timeframeType: timeframeType, isStartDate: isStartDate)
        }
        .onChange(of: timeframeType){
            _ in
            fieldValueString = fieldValue.toString(timeframeType: timeframeType, isStartDate: isStartDate)
        }
        .animation(.easeInOut)
    }
}

struct FormCalendarPicker_Previews: PreviewProvider {
    static var previews: some View {

            ScrollView{
                VStack(spacing:10){
                    FormText(fieldValue: .constant(Properties(objectType: .goal).title!), fieldName: "Title", axis: .horizontal, iconType: .title)
                    FormText(fieldValue: .constant(Properties(objectType: .goal).description!), fieldName: "Description", axis: .vertical, iconType: .description)
                    FormCalendarPicker(fieldValue: .constant(Date()), fieldName: "Start Date", timeframeType: .constant(.week), iconType: .aspect)
                    FormCalendarPicker(fieldValue: .constant(Date()), fieldName: "End Date", timeframeType: .constant(.week), iconType: .timeframe)
            }

        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .modifier(ModifierCard())


    }
}
