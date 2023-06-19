//
//  PhotoCard.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/11/23.
//

import SwiftUI

struct PhotoCard: View {
    var objectType: ObjectType
    var objectId: UUID
    var properties: Properties
    var shouldHidePadding = false
    var imageSize: SizeType = .mediumLarge
    var shouldHaveLink: Bool = true
    
    @State var image: UIImage? = nil
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        if shouldHaveLink{
            NavigationLink(destination: Detail(objectType: objectType, objectId: objectId, properties: properties), label:{
                BuildCard()
            })
        }
        else{
            BuildCard()
        }
    }
    
    @ViewBuilder
    func BuildCard() -> some View{
        HStack(alignment:.center, spacing:0){
            
            ImageCircle(imageSize: imageSize.ToSize(), image: image, iconSize: .medium, icon: objectType.toIcon())

            VStack(alignment:.leading, spacing:0){
                Text(GetHeader())
                    .font(.specify(style: .h4))
                    .foregroundColor(.specify(color: .grey10))
                if let subheader = GetSubheader(){
                    
                    if !subheader.isEmpty {
                        Text(subheader)
                            .font(.specify(style: .body2))
                            .lineLimit(1)
                            .foregroundColor(.specify(color: .grey6))
                    }
                }
                if let caption = GetCaption() {
                    if !caption.isEmpty {
                        Text(caption)
                            .font(.specify(style: .subCaption))
                            .textCase(.uppercase)
                            .foregroundColor(.specify(color: .grey3))
                            .padding(.top,3)
                    }
                }
            }
            .padding(.leading)
            Spacer()
            IconButton(isPressed: .constant(true), size: .small, iconType: .right, iconColor: .grey5)
                .disabled(true)
        }
        .padding(shouldHidePadding ? 0 : 15)
        .frame(maxWidth:.infinity)
        .frame(height:75)
        .onAppear{
            
            if properties.image != nil {
                DispatchQueue.global(qos:.userInitiated).async{
                    image = vm.GetImage(id: properties.image!)
                }
            }
        }
    }
    
    func GetHeader() -> String{
        switch objectType {
        case .value:
            return properties.coreValue?.toString() ?? ""
        case .creed:
            return "Creed"
        case .aspect:
            return properties.aspect?.toString() ?? ""
        case .session:
            return properties.date?.toString(timeframeType: properties.timeframe ?? .day) ?? Date().toString(timeframeType: .day)
        default:
            return properties.title ?? ""
        }
    }
    
    func GetSubheader() -> String{
        switch objectType {
        case .creed:
            return "Your life's mission statement"
        case .session:
            return "Completed on " + (properties.dateCompleted?.toString(timeframeType: .day) ?? Date().toString(timeframeType: .day))
        case .habit:
            if let schedule = properties.scheduleType{
                switch schedule {
                case .aCertainAmountOverTime:
                    return "\(properties.amount ?? 0) \(properties.unitOfMeasure ?? .hours) over time"
                case .aCertainAmountPerDay:
                    return "\(properties.amount ?? 0) \(properties.unitOfMeasure ?? .hours) per day"
                case .aCertainAmountPerWeek:
                    return "\(properties.amount ?? 0) \(properties.unitOfMeasure ?? .hours) per week"
                default:
                    return schedule.toString()
                }
            }
            return properties.description ?? ""
//        case .task:
//            return properties.startDate?.toString(timeframeType: .day) ?? ""
        default:
            return properties.description ?? ""
        }
    }
    
    func GetCaption() -> String?{
        switch objectType {
        
        case .goal:
            return properties.aspect?.toString()
        case .habit:
            if let habit = vm.GetHabit(id: properties.habitId ?? UUID()){
                return "\(habit.startDate.toString(timeframeType: .day)) - \(habit.endDate.toString(timeframeType: .day))"
            }
            return nil
        default:
            return nil
        }
    }
}

struct PhotoCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing:0){
            ScrollView{
                PhotoCard(objectType: .goal, objectId: UUID(), properties: Properties())
                PhotoCard(objectType: .goal, objectId: UUID(), properties: Properties())
                PhotoCard(objectType: .goal, objectId: UUID(), properties: Properties())
                PhotoCard(objectType: .goal, objectId: UUID(), properties: Properties())
                PhotoCard(objectType: .goal, objectId: UUID(), properties: Properties())
            }
        }
        
        
        .background(Color.specify(color: .grey0))
        
    }
}
