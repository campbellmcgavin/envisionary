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
    var properties: Properties
    
    @State var isExpanded: Bool = true
    @EnvironmentObject var vm: ViewModel
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
                if objectType.hasProperty(property: property){
                    BuildPropertyRow(property: property)
                }
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
                PropertyRow(propertyType: .endDate, date:properties.endDate)
            }
        case .date:
            if properties.date != nil {
                PropertyRow(propertyType: .date, date:properties.date, timeframe: properties.timeframe)
            }
        case .dateCompleted:
            if properties.dateCompleted != nil {
                PropertyRow(propertyType: .dateCompleted, date:properties.dateCompleted)
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
        case .edited:
            PropertyRow(propertyType: .edited, int: GetEvaluationDicitonaryItem(evaluation: .editDetails))
        case .leftAsIs:
            PropertyRow(propertyType: .leftAsIs, int: GetEvaluationDicitonaryItem(evaluation: .keepAsIs))
        case .pushedOff:
            PropertyRow(propertyType: .pushedOff, int: GetEvaluationDicitonaryItem(evaluation: .pushOffTillNext))
        case .deleted:
            PropertyRow(propertyType: .deleted, int: GetEvaluationDicitonaryItem(evaluation: .deleteIt))
        case .start:
            if properties.start != nil {
                PropertyRow(propertyType: .start, text:properties.start)
            }
        case .end:
            if properties.end != nil {
                PropertyRow(propertyType: .end, text:properties.end)
            }
        case .parentId:
            if properties.parentGoalId != nil {
                PropertyRow(propertyType: .parentId, text: vm.GetGoal(id: properties.parentGoalId!)?.title ?? "")
            }
        
        case .chapter:
            if properties.chapterId != nil {
                PropertyRow(propertyType: .chapter, text: vm.GetChapter(id: properties.chapterId!)?.title ?? "")
            }
        case .images:
            if properties.parentGoalId != nil {
                PropertyRow(propertyType: .images, int: properties.images!.count)
            }
        case .image:
            let _ = "why"
        case .promptType:
            let _ = "why"
        case .scheduleType:
            if properties.scheduleType != nil {
                PropertyRow(propertyType: .scheduleType, schedule: properties.scheduleType)
            }
        case .amount:
            if properties.amount != nil && properties.scheduleType != nil && properties.scheduleType!.shouldShowAmount() {
                PropertyRow(propertyType: .amount, int: properties.amount)
            }
        case .unit:
            if properties.unitOfMeasure != nil && properties.scheduleType != nil && properties.scheduleType!.shouldShowAmount() {
                PropertyRow(propertyType: .unit, unit: properties.unitOfMeasure)
            }
        case .emotions:
            if properties.emotionList != nil {
                PropertyRow(propertyType: .emotions, text: properties.emotionList!.map({$0.toString()}).toCsvString())
            }
        case .activities:
            if properties.activityList != nil {
                PropertyRow(propertyType: .activities, text: properties.activityList!.toCsvString())
            }
        case .emotionalState:
            if properties.emotionalState != nil{
                PropertyRow(propertyType: .emotionalState, text: properties.emotionalState?.toEmotionalState() ?? "")
            }
        default:
            let _ = "why"
        }
    }
    
    func GetEvaluationDicitonaryItem(evaluation: EvaluationType) -> Int{
        if let evaluationDictionary = properties.evaluationDictionary{
            return evaluationDictionary.values.filter({$0 == evaluation}).count
        }
        return 0
    }
}

struct DetailProperties_Previews: PreviewProvider {
    static var previews: some View {
        DetailProperties(shouldExpand: .constant(true), objectType: .goal, properties: Properties(objectType: .goal))
            .modifier(ModifierCard())
    }
}
