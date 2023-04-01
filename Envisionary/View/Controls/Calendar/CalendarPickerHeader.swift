//
//  CalendarPickerHeader.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/20/23.
//

import SwiftUI

struct CalendarPickerHeader: View {
    @Binding var date: Date
    @Binding var timeframeType: TimeframeType
    var localized: Bool
    
    @State var shouldMoveDateForward = false
    @State var shouldMoveDateBackward = false
    
    var body: some View {

            HStack(spacing: 0){
                
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(GetHeadline(timeframe: timeframeType))
                        .font(.specify(style:.h3))
                    Text(GetSubHeadline(timeframe: timeframeType))
                        .font(.specify(style:.caption))
                        .fontWeight(.semibold)
                    
                 }
                
                Spacer(minLength: 0)
                
                if timeframeType != .decade{
                    IconButton(isPressed: $shouldMoveDateBackward, size: .small, iconType: .left, iconColor: .grey10)
                    IconButton(isPressed: $shouldMoveDateForward, size: .small, iconType: .right, iconColor: .grey10)
                }

                

            }
            .onChange(of:shouldMoveDateForward){
                _ in
                if shouldMoveDateForward{
                    date = date.AdvanceDate(timeframe: GetTimeframeAdvance(), forward: true)
                }
                shouldMoveDateForward = false
            }
            .onChange(of:shouldMoveDateBackward){
                _ in
                if shouldMoveDateBackward{
                    date = date.AdvanceDate(timeframe: GetTimeframeAdvance(), forward: false)
                }
                shouldMoveDateBackward = false
            }
            .padding(.bottom,10)
        
    }
    
    func GetTimeframeAdvance() -> TimeframeType {
        switch timeframeType {
        case .decade:
            return .decade
        case .year:
            return .decade
        case .month:
            return .year
        case .week:
            return .month
        case .day:
            return .month
        }
    }
    
    func GetHeadline(timeframe: TimeframeType)-> String{
        switch timeframe{
        case .day:
            return date.toMonth()
        case .week:
            return date.toMonth()
        case .month:
            return date.toYear()
        case .year:
            return "\(date.StartOfDecade().toString(timeframeType: .decade))'s"
        case .decade:
            return "XXI's"
        }
    }
    
    func GetSubHeadline(timeframe: TimeframeType) -> String{
        switch timeframe{
        case .day:
            return date.toYear()
        case.week:
            return date.toYear()
        default:
            return ""
        }
    }
}
