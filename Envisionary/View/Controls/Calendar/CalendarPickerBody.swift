//
//  Calendar.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/20/23.
//

import SwiftUI

struct CalendarPickerBody: View {
    @EnvironmentObject var vm: ViewModel
    @Binding var date: Date
    @Binding var timeframe: TimeframeType
    @Binding var dateStatuses: [DateValue]
    @State var dates: [DateValue] = [DateValue]()
    @State var datesWithContent: [DatePair] = []
    @State var dateValuesWithContent: [Int] = [Int]()
    let localized: Bool
    
    
    var body: some View {
        VStack(spacing: 15){

            if(timeframe == .day || timeframe == .week){
                let columnDays = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
                HStack(spacing: 0){
                    ForEach(columnDays,id: \.self){day in
                        
                        Text(day)
                            .font(.specify(style: .h6))
                            .frame(maxWidth: .infinity)
                    }
                }
                
                // Dates....
                // Lazy Grid..
                let columns = Array(repeating: GridItem(.flexible()), count: 7)
                
                LazyVGrid(columns: columns,spacing: 15) {
                    ForEach(dates){ value in
                        
                        let dateStatus = GetDateStatus(date: value.date)
                        
                        CalendarPickerCard(date: $date, filterTimeframe: $timeframe, localized: localized, isSelected: GetIsSelected(value: value), containsGoal: dateValuesWithContent.contains(where:{$0 == value.day}), shouldComplete: dateStatus != nil, completionStatus: dateStatus?.day ?? 0, value: value)
                    }
                    
                }
            }
            else{
                
                let columnOther = Array(repeating: GridItem(.flexible()), count: 3)
                
                LazyVGrid(columns: columnOther,spacing: 25) {
                    
                    
                    switch timeframe{
                    case .month:
                        ForEach(dates){ value in

                            CalendarPickerCard(date: $date, filterTimeframe: $timeframe, localized: localized, isSelected: GetIsSelected(value: value), containsGoal: dateValuesWithContent.contains(where:{$0 == value.day}), value: value)
                        }
                    case .year:
                        ForEach(dates){ value in

                            CalendarPickerCard(date: $date, filterTimeframe: $timeframe, localized: localized, isSelected: GetIsSelected(value: value), containsGoal: dateValuesWithContent.contains(where:{$0 == value.day}), value: value)
                        }
                    case .decade:
                        ForEach(dates){ value in

                            CalendarPickerCard(date: $date, filterTimeframe: $timeframe, localized: localized, isSelected: GetIsSelected(value: value), containsGoal: dateValuesWithContent.contains(where:{$0 == value.day}), value: value)
                        }
                    default:
                        let _ = "why"
                    }

                    
                }
            }
        }
        .onChange(of: timeframe){ _ in
            GetDateValuesArray(timeframeType: timeframe)
        }
        .onChange(of:date){ _ in
            GetDateValuesArray(timeframeType: timeframe)
        }
        .onAppear{
            GetDateValuesArray(timeframeType: timeframe)
//            DispatchQueue.global(qos:.userInteractive).async{
//                GetDateValuesHaveContent()
//            }

        }
//        .onChange(of: vm.dictionaryFiltered){ _ in
//            DispatchQueue.global(qos:.userInteractive).async{
//                GetDateValuesHaveContent()
//            }
//        }
//        .onChange(of: dates){ _ in
//            DispatchQueue.global(qos:.userInteractive).async{
//                GetDateValuesHaveContent()
//            }
//        }
    }
    
    func GetDateStatus(date: Date) -> DateValue?{
        return dateStatuses.first(where: {$0.date.isInSameDay(as: date)})
    }
    
    
    func GetDateValuesArray(timeframeType: TimeframeType){
        switch timeframeType {
        case .decade:
            dates = date.toDecadesArray()
        case .year:
            dates = date.toYearsArray()
        case .month:
            dates = date.toMonthsArray()
        case .week:
            dates = date.toDaysArray()
        case .day:
            dates = date.toDaysArray()
        }
    }
    
//    func GetDateValuesHaveContent(){
//
//        datesWithContent  = vm.GetDatesWithContent(objectType: objectType, filterTimeframe: vm.filterTimeframe, viewMenu: viewMenu)
//
//        dateValuesWithContent.removeAll()
//
//        for dateValue in dates {
//            if GetDateContainsContent(cardDate: dateValue.date, timeframeType: vm.filterTimeframe){
//                dateValuesWithContent.append(dateValue.day)
//            }
//        }
//    }
    
    func GetDateContainsContent(cardDate: Date, timeframeType: TimeframeType) -> Bool{
        
        switch timeframeType{
        case .decade:
            return datesWithContent.contains(where: {$0.date1.isInSameDecade(as: cardDate) || $0.date2.isInSameDecade(as: cardDate) || cardDate.isBetween(datePair: $0)})
        case .year:
            return datesWithContent.contains(where: {$0.date1.isInSameYear(as: cardDate) || $0.date2.isInSameYear(as: cardDate) || cardDate.isBetween(datePair: $0)})
        case .month:
            return datesWithContent.contains(where: {$0.date1.isInSameMonth(as: cardDate) || $0.date2.isInSameMonth(as: cardDate) || cardDate.isBetween(datePair: $0)})
        case .week:
            return datesWithContent.contains(where: {$0.date1.isInSameWeek(as: cardDate) || $0.date2.isInSameWeek(as: cardDate) || cardDate.isBetween(datePair: $0)})
        case .day:
            return datesWithContent.contains(where: {$0.date1.isInSameDay(as: cardDate) || $0.date2.isInSameDay(as: cardDate) || cardDate.isBetween(datePair: $0)})
        }
    }
    
    
    
    func GetIsSelected(value: DateValue) -> Bool{
        switch vm.filtering.filterTimeframe{
        case .decade:
            return  date.isInSameDecade(as: value.date)
        case .year:
            return  date.isInSameYear(as: value.date)
        case .month:
            return  date.isInSameMonth(as: value.date)
        case .week:
            return  date.isInSameWeek(as:value.date)
        case .day:
            return  date.isInSameDay(as: value.date)
        }
    }
}

struct CalendarPickerBody_Previews: PreviewProvider {
    static var previews: some View {
        CalendarPickerBody(date: .constant(Date()), timeframe: .constant(.day), dateStatuses: .constant([DateValue]()), localized: true)
    }
}

struct CalendarPickerCard: View {
    @Binding var date: Date
    @Binding var filterTimeframe: TimeframeType
    let localized: Bool
    var isSelected: Bool
    var containsGoal: Bool
    var shouldComplete: Bool = false
    var completionStatus: Int = 0
    
    @EnvironmentObject var vm: ViewModel
    var value: DateValue
    
    
    var body: some View {
        
        if value.day != -1{
            
            ZStack{
                
                VStack{
                    if shouldComplete{
                        switch completionStatus{
                        case 0:
                            Circle()
                                .strokeBorder(Color.specify(color: .grey5), lineWidth: 3)
                        case 1:
                            if value.date > Date(){
                                Circle()
                                    .strokeBorder(Color.specify(color: .grey5), lineWidth: 3)
                            }
                            else{
                                Circle()
                                    .strokeBorder(Color.specify(color: .red), lineWidth: 3)
                            }
                        case 2:
                            Circle()
                                .strokeBorder(Color.specify(color: .green), lineWidth: 3)
                        case 3:
                            Circle()
                                .strokeBorder(Color.specify(color: .blue), lineWidth: 3)
                        default:
                            let _ = "why"
                        }
                    }
                }
                .frame(width:40,height:40)
                .offset(y:3)
                
                VStack{
                    CalendarPickerCardText(timeframe: $filterTimeframe, value: value, isSelected: isSelected)
                    if !localized{
                        CalendarPickerCardCircle(containsGoal: containsGoal, filterTimeframe: filterTimeframe, dateValue: value, selectionDate: $date)
                    }
                }
                .foregroundColor(.specify(color: .grey8))
                .frame(height: 30,alignment: .top)
                .onTapGesture {
                    date = value.date
                }
            }
        }
        else{
            Spacer()
                .frame(maxWidth:.infinity)
                .frame(height:30)
        }
        
    }
}

struct CalendarPickerCardText: View {
    @Binding var timeframe: TimeframeType
    var value: DateValue
    var isSelected: Bool
    
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: (timeframe == .decade || timeframe == .year || timeframe == .month) ? SizeType.minimumTouchTarget.ToSize() + 5 : SizeType.minimumTouchTarget.ToSize() - 10, height:SizeType.minimumTouchTarget.ToSize() - 10)
                .opacity(isSelected ? 0.1 : 0.0)
                .foregroundColor(.specify(color: .grey10))
                .cornerRadius(SizeType.cornerRadiusExtraSmall.ToSize())
            
            switch timeframe{
            case .day:
                Text("\(value.day)")
                    .font(.specify(style: .h6))
                    .frame(maxWidth: .infinity)
                    .opacity(isSelected ? 1.0 : 0.3)
            case .week:
                Text("\(value.day)")
                    .font(.specify(style: .h6))
                    .opacity(isSelected ? 1.0 : 0.3)
            case .month:
                Text("\(value.date.toMonth())")
                    .font(.specify(style: .h6))
                    .opacity(isSelected ? 1.0 : 0.3)
                    .frame(maxWidth: .infinity)
            case .year:
                Text("\(value.date.toYear())")
                    .font(.specify(style: .h6))
                    .opacity(isSelected ? 1.0 : 0.3)
                    .frame(maxWidth: .infinity)
            case .decade:
                Text("\(value.date.StartOfDecade().toYear())'s")
                    .font(.specify(style: .h6))
                    .opacity(isSelected ? 1.0 : 0.3)
                    .frame(maxWidth: .infinity)

            }
        }


        
    }
}

struct CalendarPickerCardCircle: View {
    
    var containsGoal: Bool
    var filterTimeframe: TimeframeType
    var dateValue: DateValue
    @Binding var selectionDate: Date
    
    var body: some View {
        if(containsGoal){
            Circle()
                .fill(Color.specify(color: .grey10))
                .frame(width: 8,height: 8)
                .padding(.top, -7)
                .opacity(containsGoal ? (IsSelected() ? 0.4 : 0.15) : 0)
        }
    }
    
    
    func IsSelected() -> Bool{
        switch filterTimeframe{
        case .year:
            return dateValue.date.isInSameYear(as: selectionDate)
        case .decade:
            return dateValue.date.isInSameDecade(as: selectionDate)
        default:
            return dateValue.date == selectionDate
        }

    }
    

}
