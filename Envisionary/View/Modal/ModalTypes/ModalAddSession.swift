//
//  ModalAddsession.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/5/23.
//

import SwiftUI

struct ModalAddSession: View {
    @Binding var isPresenting: Bool
    @State var timeframe: TimeframeType = .month
    @State var date: Date = Date()
    @State var goalProperties: [Properties] = [Properties]()
    @State var evaluationDictionary: [UUID: EvaluationType] = [UUID: EvaluationType]()
    @State var alignmentDictionary: [UUID: [String:Bool]] = [UUID: [String:Bool]]()
    @State var confirmedDictionary: [UUID: Bool] = [UUID: Bool]()
    @State var pushOffDictionary:  [UUID: Int] = [UUID:Int]()
    @State var childrenAddedDictionary: [UUID: [UUID]]  = [UUID: [UUID]]()
    @State var deletionList: [UUID] = [UUID]()
    @State var sessionStep: SessionStepType = .overview
    @State var requestedStepCount = 0
    @State var stepCount = 0
    @State var shouldSave = false
    @State var shouldGoBackward = false
    @State var shouldGoForward = true
    @State var shouldFinish = false
    @State var SessionTitle = ""
    @State var scrollLocation = 0
    @State var shouldAddGoal = false
    @State var properties = Properties()
    @State var valuesTemplateDictionary = [String:Bool]()
    @State var sessionId: UUID? = nil
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        Modal(modalType: .add, objectType: .session, isPresenting: $isPresenting, shouldConfirm: .constant(false), isPresentingImageSheet: .constant(false), allowConfirm: true, title: GetTitle(), subtitle: GetSubtitle(), modalContent: {
            VStack(alignment:.leading, spacing:0){
//                SetupHeader()
                SetupSessionStep()
                    .onAppear{
                        ClearSession()
                        timeframe = vm.filtering.filterTimeframe
                        if timeframe == .day {
                            timeframe = .week
                        }
                        date = vm.filtering.filterDate
                        SetupValues()
                        SetupGoals()
                    }
            }
            .padding(8)
            .frame(maxWidth:.infinity)
        }, headerContent: {EmptyView()}, bottomContent: {SetupButtons()}, betweenContent: {GetBetweenContent()})


        .onChange(of: timeframe){
            _ in
            SetupGoals()
        }
        .onChange(of: date){
            _ in
            SetupGoals()
        }
        .onChange(of: shouldGoForward){
            _ in
            sessionStep = GetForwardsStep()
        }
        .onChange(of: shouldGoBackward){
            _ in
            sessionStep = GetBackwardsStep()
        }
        .onChange(of:shouldAddGoal){
            _ in
            CreateGoal()
        }
        .onChange(of: shouldSave){
            _ in
            SaveSession()
        }
    }
    
    func ClearSession(){
        timeframe = .month
        date = Date()
        goalProperties = [Properties]()
        evaluationDictionary = [UUID: EvaluationType]()
        alignmentDictionary = [UUID: [String:Bool]]()
        confirmedDictionary = [UUID: Bool]()
        pushOffDictionary = [UUID:Int]()
        childrenAddedDictionary  = [UUID: [UUID]]()
        deletionList = [UUID]()
        sessionStep = .overview
        requestedStepCount = 0
        stepCount = 0
        shouldSave = false
        shouldGoBackward = false
        shouldGoForward = true
        shouldFinish = false
        SessionTitle = ""
        scrollLocation = 0
        shouldAddGoal = false
        properties = Properties()
        valuesTemplateDictionary = [String:Bool]()
    }
    
    func SaveSession(){
        RevertEvaluationDictionary()
        CreateSession()
        DeleteGoals()
        UpdateGoals()
    }
    
    func DeleteGoals(){
        for id in evaluationDictionary.keys{
            if evaluationDictionary[id] == .deleteIt{
                _ = vm.DeleteGoal(id: id)
            }
        }
    }
    
    func UpdateGoals(){
        for goalProperty in goalProperties {
            if let goal = vm.GetGoal(id: goalProperty.id){
                var goalProperties = Properties(goal:goal)
                
                goalProperties.valuesDictionary = ConvertInstanceOfAlignmentDictionary(id: goal.id)
                
                if let pushOff = pushOffDictionary[goal.id]{
                    goalProperties.startDate = goalProperties.startDate?.AdvanceDate(timeframe: timeframe, forward: true, count: pushOff)
                    goalProperties.endDate = goalProperties.endDate?.AdvanceDate(timeframe: timeframe, forward: true, count: pushOff)
                }
                
                let updateRequest = UpdateGoalRequest(goal: goal)
                _ = vm.UpdateGoal(id: goalProperty.id, request: updateRequest)
            }
        }
    }
    
    func RevertEvaluationDictionary(){
        for id in confirmedDictionary.keys{
            if !confirmedDictionary[id]!{
                if let item = evaluationDictionary[id]{
                    if item != .keepAsIs{
                        evaluationDictionary[id] = .keepAsIs
                    }
                }
            }
        }
    }
    
    func CreateSession(){
        var sessionProperties = Properties()
        sessionProperties.title = timeframe.toString() + " Sesssion"
        sessionProperties.description = date.toString(timeframeType: timeframe)
        sessionProperties.date = date
        sessionProperties.goalProperties = goalProperties
        sessionProperties.dateCompleted = Date()
        sessionProperties.evaluationDictionary = evaluationDictionary
        sessionProperties.alignmentDictionary = ConvertAlignmentDictionary()
        sessionProperties.childrenAddedDictionary = childrenAddedDictionary
        
        
        let sessionRequest = CreateSessionRequest(properties: sessionProperties)
        
        sessionId = vm.CreateSession(request: sessionRequest)
    }
    
    func ConvertAlignmentDictionary() -> [UUID: [String: Bool]]{
        
        var valueAlignmentDictionary = [UUID: [String: Bool]]()
        let values = vm.ListCoreValues()
        
        var tempValueDictionary = [String:Bool]()
        
        for value in values{
            tempValueDictionary[value.title] = true
        }
        
        for id in alignmentDictionary.keys{
            valueAlignmentDictionary[id] = ConvertInstanceOfAlignmentDictionary(id: id)
        }
        
        return valueAlignmentDictionary
    }
    
    func ConvertInstanceOfAlignmentDictionary(id: UUID) -> [String: Bool]{
        var tempAlignmentDictionary = [String: Bool]()
        
        if let _ = alignmentDictionary[id]{
            for valueString in alignmentDictionary[id]!.keys {
                tempAlignmentDictionary[valueString] = alignmentDictionary[id]![valueString]!
            }
        }
        return tempAlignmentDictionary
    }
    
    func CreateGoal(){
        properties.startDate = date.StartOfTimeframe(timeframe: timeframe)
        properties.endDate = date.EndOfTimeframe(timeframe: timeframe)
        properties.description = "Added in a session."
        properties.timeframe = timeframe
        let goalId = vm.CreateGoal(request: CreateGoalRequest(properties: properties))
        if let goal = vm.GetGoal(id: goalId){
            SetupGoal(goal: goal)
        }
    }
    
    @ViewBuilder
    func GetBetweenContent() -> some View{
        VStack(spacing:5){
            let stepAlert = sessionStep == .overview ?
            Alert(alertType: .info, keyword: sessionStep.toString(), description: sessionStep.toDescription(timeframe: timeframe), timeAmount: 1, isPersistent: true) : Alert(alertType: .info, keyword: "Step " + String(sessionStep.toStepNumber()) + "/" + String(SessionStepType.conclude.toStepNumber()), description: sessionStep.toDescription(timeframe: timeframe), timeAmount: 1, isPersistent: true)
            AlertLabel(alert: stepAlert)
            
            if sessionStep.toStepNumber() < 6 && sessionStep != .overview && !shouldSave {
                let stepAlert1 = Alert(alertType: .warn, keyword: "Unsaved", description: "Closing will result in loss of content.", timeAmount: 1, isPersistent: true)
                AlertLabel(alert: stepAlert1)
            }
            
            if sessionStep == .addContent && NotEnoughContent(){
                let stepAlert2 = Alert(alertType: .error, keyword: "No content", description: "Sessions require at least one goal.", timeAmount: 1, isPersistent: true)
                AlertLabel(alert: stepAlert2)
            }
        }
    }
    
    func GetTitle() -> String {
        
        if sessionStep == .overview {
            return "Overview"
        }
        else{
            return date.toString(timeframeType: timeframe)
        }
    }
    
    func GetSubtitle() -> String{
        if sessionStep == .overview {
            return "Add session"
        }
        else{
            return "Add " + timeframe.toString() + " session"
        }
    }
    
    func ShouldShowBackButton() -> Bool{
        return stepCount > 0 || sessionStep != .overview
    }
    
    func ShouldShowForwardButton() -> Bool{
        return sessionStep != .conclude
    }
    
    @ViewBuilder
    func SetupButtons() -> some View {
        
        HStack(){
            if sessionStep == .conclude {
                Spacer()
                Text("Finish up")
                    .foregroundColor(.specify(color:.grey0))
                    .font(.specify(style:.subCaption))
                    .frame(alignment:.leading)
                    .multilineTextAlignment(.trailing)
                    .frame(width:55)
                    .opacity(ShouldShowForwardButton() ? 1.0 : 0.0)
                    .opacity(NotEnoughContent() ? 0.4 : 1.0)
                
                IconButton(isPressed: $isPresenting, size: .medium, iconType: .arrow_right, iconColor: .grey10, circleColor: .grey0)
                    .disabled(!ShouldShowForwardButton() || NotEnoughContent())
                    .opacity(ShouldShowForwardButton() ? 1.0 : 0.0)
                    .opacity(NotEnoughContent() ? 0.4 : 1.0)
            }
            else{
                IconButton(isPressed: $shouldGoBackward, size: .medium, iconType: .arrow_left, iconColor: .grey10, circleColor: .grey0)
                    .disabled(true)
                    .opacity(ShouldShowBackButton() ? 0.3 : 0.0)
                Text(GetBackwardsStep().toString())
                    .foregroundColor(.specify(color:.grey0))
                    .font(.specify(style:.subCaption))
                    .frame(alignment:.leading)
                    .multilineTextAlignment(.leading)
                    .frame(width:55)
                    .opacity(ShouldShowBackButton() ? 0.3 : 0.0)
                Spacer()
                Text(sessionStep.toString())
                    .multilineTextAlignment(.center)
                    .font(.specify(style:.h6))
                    .padding(3)
                    .padding([.leading,.trailing],3)
                    .foregroundColor(.specify(color: .grey0))
                    .frame(width:85)
                Spacer()
                Text(GetForwardsStep().toString())
                    .foregroundColor(.specify(color:.grey0))
                    .font(.specify(style:.subCaption))
                    .frame(alignment:.leading)
                    .multilineTextAlignment(.trailing)
                    .frame(width:55)
                    .opacity(ShouldShowForwardButton() ? 1.0 : 0.0)
                    .opacity(NotEnoughContent() ? 0.4 : 1.0)
                
                IconButton(isPressed: $shouldGoForward, size: .medium, iconType: .arrow_right, iconColor: .grey10, circleColor: .grey0)
                    .disabled(!ShouldShowForwardButton() || NotEnoughContent())
                    .opacity(ShouldShowForwardButton() ? 1.0 : 0.0)
                    .opacity(NotEnoughContent() ? 0.4 : 1.0)
            }


        }
        .padding(8)
        .modifier(ModifierForm(color: .grey10))
        .shadow(color: .specify(color: .grey0),radius: 50)
        .padding([.leading,.trailing],8)
        .padding(.bottom,35)
    }
            
    func NotEnoughContent() -> Bool{
        return goalProperties.count == 0 && sessionStep == .addContent
    }
    
    @ViewBuilder
    func SetupHeader() -> some View {
        HStack{
            VStack(alignment:.leading){
                Text("Step " + String(stepCount) + ": " + sessionStep.toString())
                    .foregroundColor(.specify(color:.grey10))
                    .font(.specify(style:.h4))
                    .frame(alignment:.leading)
                    .padding(.bottom,5)
                    .padding(.top,15)
                
//                Text(GetStepDescription())
//                    .foregroundColor(.specify(color:.grey6))
//                    .font(.specify(style:.body2))
//                    .frame(alignment:.leading)
//                    .multilineTextAlignment(.leading)
//                    .frame(maxWidth:.infinity)
//                    .padding(.bottom)
            }
            Spacer()
        }

        .padding(.bottom)
    }
    
    func SetupValues(){
        let values = vm.ListCoreValues()
        var tempValueDictionary = [String:Bool]()
        
        for value in values{
            tempValueDictionary[value.title] = true
        }
        
        valuesTemplateDictionary = tempValueDictionary
    }
    
    func SetupTimeframes(){
        timeframe = vm.filtering.filterTimeframe
        date = vm.filtering.filterDate
    }
    
    func GetBackwardsStep() -> SessionStepType{
        switch sessionStep {
        case .overview:
            return SessionStepType.overview
        case .selectTimeframe:
            return SessionStepType.overview
        case .addContent:
            return SessionStepType.selectTimeframe
        case .alignValues:
            return SessionStepType.addContent
        case .reviewUpcoming:
            return SessionStepType.alignValues
        case .saveCheckpoint:
            return SessionStepType.reviewUpcoming
        case .lookingForward:
            return SessionStepType.saveCheckpoint
        case .addJournal:
            return SessionStepType.lookingForward
        case .conclude:
            return SessionStepType.addJournal
        }
    }
    
    func GetForwardsStep() -> SessionStepType{
        switch sessionStep {
        case .overview:
            return SessionStepType.selectTimeframe
        case .selectTimeframe:
            return SessionStepType.addContent
        case .addContent:
            return SessionStepType.alignValues
        case .alignValues:
            return SessionStepType.reviewUpcoming
        case .reviewUpcoming:
            return SessionStepType.saveCheckpoint
        case .saveCheckpoint:
            return SessionStepType.lookingForward
        case .lookingForward:
            return SessionStepType.addJournal
        case .addJournal:
            return SessionStepType.conclude
        case .conclude:
            return SessionStepType.conclude
        }
    }
    
    @ViewBuilder
    func SetupSessionStep()  -> some View {
            switch sessionStep {
            case .overview:
                SessionOverview()
            case .selectTimeframe:
                SessionSelectTimeframe(timeframe: $timeframe, date: $date, isDisabled: false)
                    
            case .alignValues:
                SessionValueAlignment(goalProperties: $goalProperties, alignmentDictionary: $alignmentDictionary)
            case .reviewUpcoming:
                SessionReviewUpcoming(goalProperties: $goalProperties, evaluationDictionary: $evaluationDictionary, pushOffDictionary: $pushOffDictionary, confirmDictionary: $confirmedDictionary, timeframe: timeframe)
            case .addContent:
                SessionAddContent(shouldAddGoal: $shouldAddGoal, properties: $properties, goalProperties: goalProperties, timeframe: timeframe, date: date)
            case .addJournal:
                SessionEntry()
            case .conclude:
                if let sessionId{
                    SessionConclude(sessionId: sessionId)
                }
            case .lookingForward:
                SessionLookingForward(goalProperties: goalProperties)
            case .saveCheckpoint:
                SessionSaveCheckpoint(shouldSave: $shouldSave)
            default:
                let _ = "why"
            }
    }
    
    func SetupGoals(){
        var criteria = Criteria()
        criteria.timeframe = timeframe
        criteria.date = date
        goalProperties.removeAll()
        
        let goals = vm.ListGoals(criteria: criteria).sorted(by: {$0.startDate < $1.startDate})
        
        for goal in goals{
            SetupGoal(goal: goal)
        }
    }
    
    func SetupGoal(goal: Goal){
        goalProperties.append(Properties(goal: goal))
        evaluationDictionary[goal.id] = .keepAsIs
        alignmentDictionary[goal.id] = valuesTemplateDictionary
        pushOffDictionary[goal.id] = 0
        childrenAddedDictionary[goal.id] = [UUID]()
        confirmedDictionary[goal.id] = false
    }
}
