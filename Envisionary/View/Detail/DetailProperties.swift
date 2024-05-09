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
    let objectId: UUID
    @State var properties: Properties = Properties()
    
    @State var isExpanded: Bool = true
    @EnvironmentObject var vm: ViewModel
    var body: some View {
        
        LazyVStack(spacing:0){
            HeaderButton(isExpanded: $isExpanded, color: .grey10, header: "Details")
            
            if isExpanded {
                VStack(alignment:.leading){
                    ForEach(PropertyType.allCases.filter({objectType.hasProperty(property: $0)})){
                        property in
                            BuildPropertyRow(property: property)
                    }
                }
                .frame(alignment:.leading)
                .padding([.top,.bottom],25)
                .frame(maxWidth:.infinity)
                .frame(alignment:.leading)
                .modifier(ModifierCard())

            }
        }
        .onAppear(){
            RefreshProperties()
        }
        .onChange(of: vm.updates.goal){
            _ in
            
            RefreshProperties()
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
    
    func RefreshProperties(){
        switch objectType {
        case .value:
            properties = Properties(value: vm.GetCoreValue(id: objectId))
        case .creed:
            let values = vm.ListCoreValues()
            properties = Properties(creed: true, valueCount: values.count)
        case .aspect:
            properties = Properties(aspect: vm.GetAspect(id: objectId))
        case .goal:
            properties = Properties(goal: vm.GetGoal(id: objectId))
        case .journal:
            properties = Properties(chapter: vm.GetChapter(id: objectId))
        case .entry:
            properties = Properties(entry: vm.GetEntry(id: objectId))
        default:
            let _ = ""
        }
    }
    
    @ViewBuilder
    func BuildPropertyRow(property: PropertyType) -> some View {
        switch property {
        case .title:
            if let title = properties.title {
                PropertyRow(propertyType: .title, value: title)
            }
        case .description:
            if let desc = properties.description {
                PropertyRow(propertyType: .description, value:desc)
            }
        case .timeframe:
            if let timeframe = properties.timeframe {
                PropertyRow(propertyType: .timeframe, value:timeframe.toString())
            }
        case .startDate:
            if let startDate = properties.startDate {
                PropertyRow(propertyType: .startDate, value:startDate.toString(timeframeType: .day))
            }
        case .endDate:
            if let endDate = properties.endDate {
                PropertyRow(propertyType: .endDate, value:endDate.toString(timeframeType: .day))
            }
        case .date:
            if let date = properties.date {
                PropertyRow(propertyType: .date, value: date.toString(timeframeType: .day))
            }
        case .dateCompleted:
            if let completedDate = properties.completedDate {
                PropertyRow(propertyType: .dateCompleted, value:completedDate.toString(timeframeType: .day))
            }
        case .aspect:
            if let aspect = properties.aspect {
                PropertyRow(propertyType: .aspect, value:aspect)
            }
        case .priority:
            if let priority = properties.priority {
                PropertyRow(propertyType: .priority, value:priority.toString())
            }
        case .progress:
            if let progress = properties.progress {
                PropertyRow(propertyType: .progress, value: String(progress))
            }
//        case .start:
//            if properties.start != nil {
//                PropertyRow(propertyType: .start, value:properties.start)
//            }
//        case .end:
//            if properties.end != nil {
//                PropertyRow(propertyType: .end, value:properties.end)
//            }
//        case .parentId:
//            if properties.parentGoalId != nil {
//                PropertyRow(propertyType: .parentId, value: vm.GetGoal(id: properties.parentGoalId!)?.title ?? "")
//            }
//        
        case .chapter:
            if let chapter = properties.chapterId {
                PropertyRow(propertyType: .chapter, value: vm.GetChapter(id: properties.chapterId!)?.title ?? "")
            }
        case .images:
            if let parentGoalId = properties.parentGoalId {
                if let imageCount = properties.images?.count {
                    PropertyRow(propertyType: .images, value: String(imageCount))
                }
            }
//        case .image:
//            let _ = "why"
//        case .promptType:
//            let _ = "why"
//        case .scheduleType:
//            if properties.schedule != nil {
//                PropertyRow(propertyType: .scheduleType, value: properties.schedule)
//            }
//        case .amount:
//            if properties.amount != nil && properties.schedule != nil && properties.schedule!.shouldShowAmount() {
//                PropertyRow(propertyType: .amount, value: properties.amount)
//            }
//        case .unit:
//            if properties.unitOfMeasure != nil && properties.schedule != nil && properties.schedule!.shouldShowAmount() {
//                PropertyRow(propertyType: .unit, unit: properties.unitOfMeasure)
//            }
        default:
            let _ = "why"
        }
    }
}

struct DetailProperties_Previews: PreviewProvider {
    static var previews: some View {
        DetailProperties(shouldExpand: .constant(true), objectType: .goal, objectId: UUID())
            .modifier(ModifierCard())
    }
}
