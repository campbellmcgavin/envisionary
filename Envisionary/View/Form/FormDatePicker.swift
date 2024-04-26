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
    @State var timeframeType: TimeframeType = .day
    @State var shouldShowCalendarPicker: Bool = false
    var iconType: IconType?
    @State var shouldExpand: Bool = false
    @State var isExpanded: Bool = false
    @State var fieldValueString = ""
    @State
    var isStartDate: Bool?
    var body: some View {
        ZStack(alignment:.topLeading){
            
            VStack{
                FormDropdown(fieldValue: $fieldValueString, isExpanded: $shouldExpand, fieldName: fieldName, iconType: iconType)
                if isExpanded{
                    
                    HStack{
                        Spacer()
                        DateComponentButton(date: fieldValue, timeframe: .day)
                        DateComponentButton(date: fieldValue, timeframe: .year)
                        Spacer()
                    }
                    .padding()
                    
                    if shouldShowCalendarPicker{
                        CalendarPicker(date: $fieldValue, timeframeType: $timeframeType, dateStatuses: .constant([DateValue]()), localized: true)
                            .padding()
                            .padding(.bottom)
                    }

                }
            }
            .modifier(ModifierForm(color:.grey15))

        }
        .onChange(of: shouldExpand){
            _ in
            
            withAnimation(.spring){
                isExpanded = shouldExpand
            }
        }
        .onAppear{
            fieldValueString = fieldValue.toString(timeframeType: .day, isStartDate: isStartDate)
        }
        .onChange(of: fieldValue){
            _ in
            fieldValueString = fieldValue.toString(timeframeType: .day, isStartDate: isStartDate)
        }
        .onChange(of: timeframeType){
            _ in
            fieldValueString = fieldValue.toString(timeframeType: .day, isStartDate: isStartDate)
        }

    }
    
    @ViewBuilder
    func DateComponentButton(date: Date, timeframe: TimeframeType) -> some View{
        
        Button{
            withAnimation(.spring){
                if self.timeframeType == timeframe && shouldShowCalendarPicker {
                    self.shouldShowCalendarPicker = false
                }
                else{
                    self.shouldShowCalendarPicker = true
                }
                self.timeframeType = timeframe
            }
        }
        label:{
            Text(GetTitle(timeframe: timeframe))
                .foregroundColor(.specify(color: .grey10))
                .font(.specify(style: .h6))
                .padding(11)
                .frame(minWidth:80)
                .background(
                    Rectangle()
                        .opacity(self.timeframeType == timeframe && shouldShowCalendarPicker ? 0.2 : 0.07)
                        .foregroundColor(.specify(color: .grey10))
                        .cornerRadius(10)
                )
        }
    }
    
    func GetTitle(timeframe: TimeframeType)-> String{
        
        switch timeframe{
        case .day:
            return fieldValue.LongDayOfWeek() + ", " + fieldValue.toMonth() + " " + fieldValue.DayOfMonth()
        
        case .year:
            return fieldValue.toYear()
        default:
            return ""
        }
    }
}

struct FormCalendarPicker_Previews: PreviewProvider {
    static var previews: some View {

            ScrollView{
                VStack(spacing:10){
                    FormText(fieldValue: .constant(Properties(objectType: .goal).title!), fieldName: "Title", axis: .horizontal, iconType: .title)
                    FormText(fieldValue: .constant(Properties(objectType: .goal).description!), fieldName: "Description", axis: .vertical, iconType: .description)
                    FormCalendarPicker(fieldValue: .constant(Date()), fieldName: "Start Date", iconType: .aspect)
                    FormCalendarPicker(fieldValue: .constant(Date()), fieldName: "End Date", iconType: .timeframe)
            }

        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .modifier(ModifierCard())


    }
}
