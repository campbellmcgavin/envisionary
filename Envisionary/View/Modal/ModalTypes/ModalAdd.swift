//
//  ModalAdd.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/20/23.
//

import SwiftUI

struct ModalAdd: View {
    @Binding var isPresenting: Bool
    let objectId: UUID?
    @State var properties: Properties
    
    let objectType: ObjectType
    let modalType: ModalType

    @State var shouldAct = false
    @State var title = ""
    @State var description = ""
    @State var aspect = ""
    @State var priority = ""
    @State var timeframeString = ""
    @State var timeframe = TimeframeType.day
    @State var startDate = Date()
    @State var numberOf = 0
    @State var endDate = Date()
    
    @EnvironmentObject var gs: GoalService
    
    var body: some View {
        
        Modal(modalType: modalType, objectType: objectType, isPresenting: $isPresenting, shouldConfirm: $shouldAct, title: title.count > 0 ? title : modalType == .add ? "New "  + objectType.toString() : "Empty " + objectType.toString(), modalContent: {
            VStack(spacing:10){
                if (objectType.hasProperty(property: .title)){
                    FormText(fieldValue: $title, fieldName: PropertyType.title.toString(), axis: .horizontal, iconType: .title)
                }
                if (objectType.hasProperty(property: .description)){
                    FormText(fieldValue: $description, fieldName: GetDescriptionFieldName(), axis: .vertical, iconType: .description)
                }
                if (objectType.hasProperty(property: .aspect)){
                    FormStackPicker(fieldValue: $aspect, fieldName: PropertyType.aspect.toString(), options: AspectType.allCases.map({$0.toString()}),iconType: .aspect)
                }
                if (objectType.hasProperty(property: .priority)){
                    FormStackPicker(fieldValue: $priority, fieldName: PropertyType.priority.toString(), options: PriorityType.allCases.map({$0.toString()}),iconType: .priority)
                }
                if (objectType.hasProperty(property: .timeframe) && modalType != .edit){
                    FormStackPicker(fieldValue: $timeframeString, fieldName: PropertyType.timeframe.toString(), options: TimeframeType.allCases.map({$0.toString()}),iconType: .timeframe)
                }
                if (objectType.hasProperty(property: .startDate)){
                    FormCalendarPicker(fieldValue: $startDate, fieldName: GetStartDateFieldName(), timeframeType: $timeframe, iconType: .dates, isStartDate: true)
                }
                if (objectType.hasProperty(property: .endDate)){
                    FormCounter(fieldValue: $numberOf, fieldName: GetNumberOfFieldName(), iconType: .dates, maxValue: ComputeMaxValue())
                    FormLabel(fieldValue: endDate.toString(timeframeType: timeframe, isStartDate: false), fieldName: PropertyType.endDate.toString(), iconType: .dates, shouldShowLock: true)
                    
                }
            }
            .onAppear{
                
                title = properties.title ?? ""
                description = properties.description ?? ""
                aspect = properties.aspect?.toString() ?? ""
                timeframeString = properties.timeframe?.toString() ?? ""
                timeframe = properties.timeframe ?? TimeframeType.day
                startDate = properties.startDate ?? Date()
                numberOf = 0
                endDate = properties.endDate ?? Date()
            }
            .padding(8)
            .onChange(of:timeframeString){ _ in
                GetTimeframeFromString()
            }
            .onChange(of: timeframe){
                _ in
                numberOf = 0
                endDate = startDate.AdvanceDate(timeframe: timeframe, forward: true)
            }
            .onChange(of: numberOf){
                _ in
                endDate = startDate.ComputeEndDate(timeframeType: timeframe, numberOfDates: numberOf)
            }
            .onChange(of: startDate){
                _ in
                endDate = startDate.ComputeEndDate(timeframeType: timeframe, numberOfDates: numberOf)
            }
            .onChange(of: shouldAct){ _ in
                UpdateProperties()
                
                if modalType == .add {
                    
                    gs.CreateGoal(request: CreateGoalRequest(properties: properties))
                }
                if modalType == .edit {
                    _ = gs.UpdateGoal(id: objectId, request: UpdateGoalRequest(properties: properties))
                }
                isPresenting = false
            }
        }, headerContent: {EmptyView()})

    }
    
    func UpdateProperties(){
        if objectType == .goal {
            
            if modalType == .add {
                properties.parent = objectId
            }

            properties.title = title
            properties.description = description
            properties.aspect = AspectType.allCases.first(where:{$0.toString() == aspect})
            properties.timeframe = timeframe
            properties.startDate = startDate
            properties.endDate = endDate
            properties.priority = PriorityType.allCases.first(where:{$0.toString() == aspect})
        }
    }
                
    func ComputeMaxValue() -> Int{
        switch timeframe {
        case .decade:
            return 4
        case .year:
            return 10
        case .month:
            return 12
        case .week:
            return 4
        case .day:
            return 7
        }
    }
    
    func GetDescriptionFieldName() -> String{
        if objectType == .entry {
            return "Entry"
        }
        else {return "Description"}
    }
    
    func GetStartDateFieldName() -> String{
        if objectType.hasProperty(property: .endDate){
            return PropertyType.startDate.toString()
        }
        else {
            return "Date"
        }
    }
    
    func GetNumberOfFieldName() -> String {
        return "Number of " + timeframe.toString() + "s"
    }
    
    func GetTimeframeFromString() {
        timeframe = TimeframeType.allCases.first(where:{$0.toString() == timeframeString}) ?? .day
    }
}

struct ModalAdd_Previews: PreviewProvider {
    static var previews: some View {
        ModalAdd(isPresenting: .constant(true), objectId: UUID(), properties: Properties(), objectType: .goal, modalType: .add)
    }
}
