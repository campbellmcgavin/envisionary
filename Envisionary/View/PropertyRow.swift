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
    var int: Int?
    var priority: PriorityType?
    var text: String?
    var coreValue: ValueType?
    var schedule: ScheduleType?
    var unit: UnitType?
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
        
        BuildLabel()
    }
    
//    @ViewBuilder
//    func BuildNavButton(aspect: Aspect) -> some View{
//        NavigationLink(destination: {Detail(objectType: .aspect, objectId: aspect.id)}, label: {
//            ZStack{
//                BuildLabel()
//                HStack{
//                    Spacer()
//                    IconLabel(size: .extraSmall, iconType: .right, iconColor: .grey3)
//                }
//            }
//        })
//        .id(UUID())
//    }
    
    @ViewBuilder
    func BuildLabel() -> some View{
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
                


            }
            .frame(alignment:.leading)
            .frame(maxWidth:.infinity)
            Divider()
                .overlay(Color.specify(color: .grey2))
                .padding(.leading,50)
        }
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
            return text ?? AspectType.academic.toString()
        case .priority:
            return priority?.toString() ?? PriorityType.high.toString()
        case .progress:
            return String(int ?? 0)
        case .title:
            return text ?? ""
        case .description:
            
            if let text{
                if text.count > 0
                {
                    return text
                    
                    
                }
                else
                {
                    return "No description"
                }
            }
            return ""
            
//            return (text ?? "").count >= 0 ? (text ?? "") : "No description"
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
