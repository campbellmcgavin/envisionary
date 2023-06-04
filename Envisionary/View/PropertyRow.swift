//
//  PropertyRow.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/16/23.
//

import SwiftUI

struct PropertyRow: View {
    
    let propertyType: PropertyType
    var date: Date?
    var timeframe: TimeframeType?
    var aspect: AspectType?
    var int: Int?
    var priority: PriorityType?
    var text: String?
    var coreValue: ValueType?
    var schedule: ScheduleType?
    var unit: UnitType?
    var body: some View {
        
        Button{
            
            
        }
    label:{
        VStack(alignment:.leading){
            HStack(alignment:.center, spacing:0){
                
                propertyType.toIcon().ToIconString().ToImage(imageSize: SizeType.medium.ToSize())
                    .foregroundColor(.specify(color: .grey4))
                    .padding(.leading,6)
                    .padding(.trailing,7)
                
                VStack(alignment:.leading, spacing:0){
                    Text(propertyType.toString())
                        .font(.specify(style: .caption))
                        .foregroundColor(.specify(color: .grey4))
                    Text(String(describing: GetPropertyAsString()))
                        .font(.specify(style: .body1))
                        .foregroundColor(.specify(color: .grey10))
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                }
                .frame(alignment:.leading)
                .padding(.trailing)
                Spacer()
                
                if propertyType != .title && propertyType != .description{
                    IconLabel(size: .extraSmall, iconType: .right, iconColor: .grey3)
                }

            }
            .frame(alignment:.leading)
            .frame(maxWidth:.infinity)
            Divider()
                .overlay(Color.specify(color: .grey2))
                .padding(.leading,50)
        }
    }
    .disabled(propertyType == .title || propertyType == .description)

    }
    
    func GetPropertyAsString() -> String{
        switch propertyType {
        case .timeframe:
            return timeframe?.toString() ?? TimeframeType.day.toString()
        case .startDate:
            return date?.toString(timeframeType: timeframe ?? .day) ?? Date().toString(timeframeType: .day)
        case .endDate:
            return date?.toString(timeframeType: timeframe ?? .day) ?? Date().toString(timeframeType: .day)
        case .date:
            return date?.toString(timeframeType: timeframe ?? .day) ?? Date().toString(timeframeType: .day)
        case .dateCompleted:
            return date?.toString(timeframeType: .day) ?? Date().toString(timeframeType: .day)
        case .aspect:
            return aspect?.toString() ?? AspectType.academic.toString()
        case .priority:
            return priority?.toString() ?? PriorityType.high.toString()
        case .progress:
            return String(int ?? 0)
        case .title:
            return text ?? ""
        case .description:
            return text ?? ""
        case .coreValue:
            return coreValue?.toString() ?? ""
        case .start:
            return text ?? ""
        case .end:
            return text ?? ""
        case .leftAsIs:
            return String(int ?? 0)
        case .deleted:
            return String(int ?? 0)
        case .edited:
            return String(int ?? 0)
        case .pushedOff:
            return String(int ?? 0)
        case .scheduleType:
            return schedule?.toString() ?? ScheduleType.aCertainAmountOverTime.toString()
        case .amount:
            return String(int ?? 0)
        case .unit:
            return unit?.toString() ?? UnitType.minutes.toString()
        case .chapter:
            return text ?? ""
        default:
            return ""
        }
    }
}

struct PropertyRow_Previews: PreviewProvider {
    static var previews: some View {
        PropertyRow(propertyType: .progress, int: 5)
    }
}
