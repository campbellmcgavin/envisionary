//
//  PickerWheelTextView.swift
//  Visionary
//
//  Created by Campbell McGavin on 3/24/22.
//

import SwiftUI

struct ScrollPickerDateText: View {

    let dateValue: DateValue
    let frameWidth: CGFloat
    let filterTimeframe: TimeframeType
    @Binding var selectionDate: Date
    let isLight: Bool
    let showBubble: Bool

    
    var body: some View {
        
        let headline = GetHeadline(timeframe: filterTimeframe)
        let subheadline = GetSubHeadline(timeframe: filterTimeframe)
        
        VStack(alignment: .center) {
            if(headline.count > 0){
            Text(headline)
                .font(.specify(style: .h6))
            }
            if(subheadline.count > 0){
                Text(GetSubHeadline(timeframe:filterTimeframe))
                    .font(GetFont())
                    .padding(.top,-14)
            }
         }
        .foregroundColor(.specify(color: .grey10))
        .frame(width: frameWidth)
        .opacity(GetOpacity())
    }
    
    func GetHeadline(timeframe: TimeframeType)-> String{
        
        switch timeframe{
        case .day:
            return dateValue.date.DayOfWeek()
        case .week:
            let dayNumber = Calendar(identifier: .gregorian).ordinality(of: .day, in: .year, for: dateValue.date)!
            let weekNumber = Int(dayNumber / 7) + 1
            
            return "W" + String(weekNumber)

            
        case .month:
            return String(dateValue.date.toYearAndMonth()[1].prefix(3))
        
        case .year:
            return dateValue.date.toYearAndMonth()[0]
        case .decade:
            return dateValue.date.StartOfDecade().toYearAndMonth()[0] + "'s"
        }
    }
    

    
    func GetSubHeadline(timeframe: TimeframeType) -> String{
        
        switch timeframe{
        case .day:
            return dateValue.date.DayOfMonth()
        case .week:
            let startOfWeek = dateValue.date.StartOfWeek()
            let startOfWeekMonth = String(startOfWeek.toYearAndMonth()[1].prefix(3))
            return startOfWeekMonth
        case .month:
            return dateValue.date.toYearAndMonth()[0]
        case .year:
            return ""
        case .decade:
            return ""
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
    
    func GetFont() -> Font{
        switch filterTimeframe{
        case .decade:
            return Font.specify(style: .h4)
        case .year:
            return Font.specify(style: .h4)
        case .month:
            return Font.specify(style: .body3)
        case .week:
            return Font.specify(style: .body3)
        case .day:
            return Font.specify(style: .body3)
        }
    }
    
    func GetOpacity() -> CGFloat{

        if IsSelected(){
            return 1
        }
        else{
            return 0.5
        }
    }

}
