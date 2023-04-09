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
    var parentId: UUID?
    @State var properties: Properties
    
    let objectType: ObjectType
    let modalType: ModalType
    var status: StatusType?
    @State var shouldAct = false
    @State var title = ""
    @State var description = ""
    @State var aspect = ""
    @State var priority = ""
    @State var coreValue = ""
    @State var timeframeString = ""
    @State var timeframe = TimeframeType.day
    @State var startDate = Date()
    @State var numberOf = 0
    @State var endDate = Date()
    @State var filteredValues = [ValueType]()
    
    @EnvironmentObject var gs: GoalService
    
    var body: some View {
        
        Modal(modalType: modalType, objectType: objectType, isPresenting: $isPresenting, shouldConfirm: $shouldAct, title: title.count > 0 ? title : modalType == .add ? "New "  + objectType.toString() : "Empty " + objectType.toString(), modalContent: {
            VStack(spacing:10){
                if (objectType.hasProperty(property: .title)){
                    FormText(fieldValue: $title, fieldName: PropertyType.title.toString(), axis: .horizontal, iconType: .title)
                }
                
                if(objectType == .value){
                    
                    if modalType == .add {
                        FormStackPicker(fieldValue: $coreValue, fieldName: PropertyType.coreValue.toString(), options: ValueType.allCases.filter({gs.GetCoreValue(value: $0) == nil && $0 != .Introduction && $0 != .Conclusion}).map{$0.toString()}, iconType: .value, isSearchable: true)
                    }
                    else{
                        FormLabel(fieldValue: coreValue, fieldName: PropertyType.coreValue.toString(), iconType: .value, shouldShowLock: true)
                    }

                }
                
                if(objectType == .aspect){
                    FormStackPicker(fieldValue: $aspect, fieldName: PropertyType.aspect.toString(), options: AspectType.allCases.filter({gs.GetAspect(aspect: $0) == nil}).map{$0.toString()}, iconType: .aspect, isSearchable: true)
                }
                
                if (objectType.hasProperty(property: .description)){
                    FormText(fieldValue: $description, fieldName: GetDescriptionFieldName(), axis: .vertical, iconType: .description)
                }
                if (objectType.hasProperty(property: .aspect) && objectType != .aspect){
                    
                    if parentId != nil {
                        FormLabel(fieldValue: timeframeString, fieldName: PropertyType.timeframe.toString(), iconType: .timeframe, shouldShowLock: true)
                    }
                    else{
                        FormStackPicker(fieldValue: $aspect, fieldName: PropertyType.aspect.toString(), options: AspectType.allCases.map({$0.toString()}),iconType: .aspect)
                    }
                    
                }
                if (objectType.hasProperty(property: .priority)){
                    FormStackPicker(fieldValue: $priority, fieldName: PropertyType.priority.toString(), options: PriorityType.allCases.map({$0.toString()}),iconType: .priority)
                }
                if (objectType.hasProperty(property: .timeframe) && modalType != .edit){
                    
                    if parentId != nil {
                        FormLabel(fieldValue: timeframeString, fieldName: PropertyType.timeframe.toString(), iconType: .timeframe, shouldShowLock: true)
                    }
                    else{
                        FormStackPicker(fieldValue: $timeframeString, fieldName: PropertyType.timeframe.toString(), options: TimeframeType.allCases.map({$0.toString()}),iconType: .timeframe)
                    }
                    
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
                SetupFields()
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
                TakeAction()
            }
            .onChange(of: coreValue){ _ in
                if objectType == .value {
                    title = coreValue
                }
            }
            .onChange(of: aspect){ _ in
                if objectType == .aspect {
                    title = aspect
                }
            }
        }, headerContent: {EmptyView()})
    }
    
    func TakeAction(){
        switch objectType {
        case .value:
            if modalType == .add {
                gs.CreateCoreValue(request: CreateCoreValueRequest(properties: properties))
            }
            if modalType == .edit {
                _ = gs.UpdateCoreValue(coreValue: properties.coreValue, request: UpdateCoreValueRequest(properties: properties))
            }
        case .dream:
            if modalType == .add {
                gs.CreateDream(request: CreateDreamRequest(properties: properties))
            }
            if modalType == .edit {
                _ = gs.UpdateDream(id: objectId, request: UpdateDreamRequest(properties: properties))
            }
        case .aspect:
            if modalType == .add {
                gs.CreateAspect(request: CreateAspectRequest(properties: properties))
            }
            if modalType == .edit {
                _ = gs.UpdateAspect(aspect: properties.aspect, request: UpdateAspectRequest(properties: properties))
            }
        case .goal:
            if modalType == .add {
                gs.CreateGoal(request: CreateGoalRequest(properties: properties))
            }
            if modalType == .edit {
                _ = gs.UpdateGoal(id: objectId, request: UpdateGoalRequest(properties: properties))
            }
//        case .session:
//            <#code#>
//        case .task:
//            <#code#>
//        case .habit:
//            <#code#>
//        case .home:
//            <#code#>
//        case .chapter:
//            <#code#>
//        case .entry:
//            <#code#>
//        case .emotion:
//            <#code#>
//        case .stats:
//            <#code#>
        default:
            let _ = "" //do nothing...
        }
        
        isPresenting = false
    }
    
    func SetupFields(){
        
        if modalType == .add{
            properties = Properties()
        }
        
        
        switch objectType {
        case .value:
            if objectId != nil {
                if let coreValue = gs.GetCoreValue(id: objectId ?? UUID()){
                    properties = Properties(value: coreValue)
                }
            }
        case .goal:
            if objectId != nil {
                if let goal = gs.GetGoal(id: objectId ?? UUID()){
                    properties = Properties(goal: goal)
                }
            }
            GetValuesFromParent()
        default:
            let _ = "why" //do nothing
        }
        
        title = properties.title ?? ""
        description = properties.description ?? ""
        aspect = properties.aspect?.toString() ?? ""
        timeframeString = properties.timeframe?.toString() ?? ""
        startDate = properties.startDate ?? Date()
        numberOf = 0
        endDate = properties.endDate ?? Date()
        coreValue = properties.coreValue?.toString() ?? ""
    }
    
    func UpdateProperties(){
//        if objectType == .goal {
            
        if modalType == .add {
            properties.parent = parentId
        }
        
        properties.coreValue = ValueType.allCases.first(where:{$0.toString() == coreValue})
        properties.title = title
        properties.description = description
        properties.aspect = AspectType.allCases.first(where:{$0.toString() == aspect})
        properties.timeframe = timeframe
        properties.startDate = startDate
        properties.endDate = endDate
        properties.priority = PriorityType.allCases.first(where:{$0.toString() == priority})
        
        if modalType == .add {
            properties.progress = status?.toInt() ?? 0
        }
//        }
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
    
    func GetValuesFromParent() {
        if parentId != nil {
            if let goal = gs.GetGoal(id: parentId!){
                timeframe = goal.timeframe.toChildTimeframe()
                timeframeString = timeframe.toString()
                startDate = goal.startDate
                endDate = startDate
                priority = goal.priority.toString()
                aspect = goal.aspect.toString()
            }
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
