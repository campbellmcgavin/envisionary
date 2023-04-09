import Foundation
import SwiftUI

class GoalService: ObservableObject
{
    // MARK: - Initializers
    init(){
        for goal in Goal.sampleGoals{
            goalsDictionary[goal.id] = goal
        }
        for goal in Goal.sampleGoals{
            goalsDictionary[goal.id] = goal
        }
        for goal in Goal.sampleGoals{
            goalsDictionary[goal.id] = goal
        }
        for goal in Goal.sampleGoals{
            goalsDictionary[goal.id] = goal
        }
        for goal in Goal.sampleGoals{
            goalsDictionary[goal.id] = goal
        }
        
        for value in CoreValue.samples{
            coreValuesList.append(value)
        }
    }
    
    // MARK: - GOALS
    
    @Published
    var goalsDictionary: Dictionary<UUID,Goal> = [UUID:Goal]()
    @Published
    var goalsGrouping: GroupingType = .title
    
    func CreateGoal(request: CreateGoalRequest){
        let newGoal = Goal(request: request)
        
        goalsDictionary[newGoal.id] = newGoal
        
        if(newGoal.parent != nil){
            if let parentGoal = goalsDictionary[newGoal.parent!]{
                
                var updateRequest = UpdateGoalRequest(goal: parentGoal)
                updateRequest.children.append(newGoal.id)
                _ = UpdateGoal(id: parentGoal.id, request: updateRequest)
            }
        }
    }
    
    func GetGoal(id: UUID) -> Goal?{
        
        if let goal = goalsDictionary[id]{
            return goal
        }
        return nil
    }
        
    func ListsChildGoalsByParentId(id: UUID) -> [UUID]{
        var children = [UUID]()
        
        if let goal = goalsDictionary[id] {
            
            children.append(contentsOf: goal.children)
        }
        
        return children
    }
    
    func ListAffectedGoalIdsByParentId(id: UUID) -> [UUID]{
        let affectedGoalIds = ListAffectedGoalIdsByParentIdHelper(id: id, affected: [UUID]())
        return Array(Set(affectedGoalIds))
    }
    
    private func ListAffectedGoalIdsByParentIdHelper(id: UUID, affected: [UUID]) -> [UUID]{
        
        var affectedIds = affected
        
        if let parentGoal = goalsDictionary[id]{
            affectedIds.append(parentGoal.id)
            
            if parentGoal.children.count == 0{
                return affectedIds
            }
            else{
                for childId in parentGoal.children{
                    affectedIds.append(contentsOf: ListAffectedGoalIdsByParentIdHelper(id: childId, affected: affectedIds))
                }
            }
        }
        
        return affectedIds
    }
    
    func ListGoalIdsByCriteria(criteria: Criteria) -> [UUID]{
        return self.goalsDictionary.values.filter({
            
            var title = true
            var description = true
            var timeframe = true
            var dates = true
            var aspect = true
            var priority = true
            var progress = true
            
            if criteria.title?.count ?? 0 > 0 {
                title = $0.title.localizedCaseInsensitiveContains(criteria.title!)
            }
            
            if criteria.description?.count ?? 0 > 0 {
                description = $0.description.localizedCaseInsensitiveContains(criteria.description!)
            }
            
            if criteria.timeframe != nil {
                timeframe = $0.timeframe == criteria.timeframe!
                
                if criteria.date != nil {
                    dates = criteria.date!.matchesDates(datePair: DatePair(date1: $0.startDate, date2: $0.endDate), timeframe: criteria.timeframe!)
                }
            }
            
            if criteria.aspect != nil {
                aspect = $0.aspect == criteria.aspect!
            }
            
            if criteria.priority != nil {
                priority = $0.priority == criteria.priority!
            }
            
            if criteria.progress != nil {
                progress = $0.progress >= criteria.progress!
            }
            
            return title && description && timeframe && dates && aspect && priority && progress
            
        }).map({$0.id})
    }
    
    func UpdateFilteredGoals(criteria: Criteria) -> [String:[UUID]]{
                
        let filteredGoals = ListGoalIdsByCriteria(criteria: criteria)
        var goalsDictionaryFiltered: Dictionary<String,[UUID]> = [String:[UUID]]()
                
        for goalId in filteredGoals {
            
            if let goal = goalsDictionary[goalId] {
                switch goalsGrouping {
                    
                case .title:
                    if  goalsDictionaryFiltered[String(goal.title.prefix(1))] == nil {
                        goalsDictionaryFiltered[String(goal.title.prefix(1))] = [UUID]()
                    }
                    goalsDictionaryFiltered[String(goal.title.prefix(1))]!.append(goal.id)
                case .aspect:
                    if  goalsDictionaryFiltered[goal.aspect.toString()] == nil {
                        goalsDictionaryFiltered[goal.aspect.toString()] = [UUID]()
                    }
                    goalsDictionaryFiltered[goal.aspect.toString()]!.append(goal.id)
                case .priority:
                    if  goalsDictionaryFiltered[goal.priority.toString()] == nil {
                        goalsDictionaryFiltered[goal.priority.toString()] = [UUID]()
                    }
                    goalsDictionaryFiltered[goal.priority.toString()]!.append(goal.id)

                default:
                    let _ = "why"
                }
            }

        }
        
        return goalsDictionaryFiltered
    }
    
    func UpdateGoal(id: UUID?, request: UpdateGoalRequest) -> Goal? {
        
        if id != nil {
            if var goalToUpdate = goalsDictionary[id!] {
                goalToUpdate.update(from: request)
                goalsDictionary.updateValue(goalToUpdate, forKey: id!)
                return goalsDictionary[id!]
            }
        }

        return nil
    }
    
    func DeleteGoal(id: UUID){
        
        let goal = GetGoal(id: id)
        let parentGoal = GetGoal(id: goal?.parent ?? UUID()) ?? Goal()
        var updateRequest = UpdateGoalRequest(goal: parentGoal)
        updateRequest.children.removeAll(where:{$0 == id})
        
        _ = UpdateGoal(id: parentGoal.id, request: updateRequest)
        
        let affectedGoalIds = ListAffectedGoalIdsByParentId(id: id)
        
        for affectedGoalId in affectedGoalIds {
            
            goalsDictionary.removeValue(forKey: affectedGoalId)
        }
    }
    
    // MARK: - VALUES
    @Published
    var coreValuesList: [CoreValue] =
    [
        CoreValue(coreValue: .Introduction, description: "I am a flawed human being with a desire to better myself every day."),
        CoreValue(coreValue: .Conclusion, description: "I will strive each day to more fully align my life with these principles.")
    ]
    @Published
    var coreValuesGrouping: GroupingType = .title
    
    func CreateCoreValue(request: CreateCoreValueRequest){
        let newCoreValue = CoreValue(request: request)
        
        coreValuesList.append(newCoreValue)
    }
    
    func GetCoreValue(value: ValueType) -> CoreValue?{
        
        if let coreValue = coreValuesList.first(where: {$0.coreValue == value}){
            return coreValue
        }
        return nil
    }
    
    func GetCoreValue(id: UUID) -> CoreValue?{
        
        if let coreValue = coreValuesList.first(where: {$0.id == id}){
            return coreValue
        }
        return nil
    }
    
    func ListCoreValueIdsByCriteria(criteria: Criteria) -> [UUID]{
        return self.coreValuesList.filter({
            
            var description = true
            var value = true
            
            if criteria.description?.count ?? 0 > 0 {
                description = $0.description.localizedCaseInsensitiveContains(criteria.description!)
            }
            
            if criteria.coreValue != nil {
                value = $0.coreValue == criteria.coreValue!
            }
            
            return description && value
            
        }).map({$0.id})
    }
    
    func ListCoreValuesByCriteria(criteria: Criteria) -> [CoreValue]{
        return self.coreValuesList.filter({
            
            var description = true
            var value = true
            
            if criteria.description?.count ?? 0 > 0 {
                description = $0.description.localizedCaseInsensitiveContains(criteria.description!)
            }
            
            if criteria.coreValue != nil {
                value = $0.coreValue == criteria.coreValue!
            }
            
            return description && value
            
        })
    }
    
    
    func UpdateCoreValue(coreValue: ValueType?, request: UpdateCoreValueRequest) -> CoreValue? {
        
        if coreValue != nil {
            if var coreValueToUpdate = coreValuesList.first(where: {$0.coreValue == coreValue}) {
                coreValueToUpdate.update(from: request)
                let index = coreValuesList.firstIndex(where: {$0.coreValue == coreValue})!
                coreValuesList[index] = coreValueToUpdate
                return coreValueToUpdate
            }
        }

        return nil
    }
    
    func DeleteCoreValue(coreValue: ValueType){
        
        coreValuesList.removeAll(where: {$0.coreValue == coreValue})
    }
    
    func DeleteCoreValue(id: UUID){
        
        coreValuesList.removeAll(where: {$0.id == id && $0.coreValue != .Introduction && $0.coreValue != .Conclusion})
    }
    
    
    // MARK: - ASPECTS
    @Published
    var aspectsList = [Aspect]()

    @Published
    var aspectsGrouping: GroupingType = .title

    func CreateAspect(request: CreateAspectRequest){
        let newAspect = Aspect(request: request)
        
        aspectsList.append(newAspect)
    }

    func GetAspect(aspect: AspectType) -> Aspect?{
        
        if let aspect = aspectsList.first(where: {$0.aspect == aspect}){
            return aspect
        }
        return nil
    }

    func GetAspect(id: UUID) -> Aspect?{
        
        if let aspect = aspectsList.first(where: {$0.id == id}){
            return aspect
        }
        return nil
    }

    func ListAspectsByCriteria(criteria: Criteria) -> [UUID]{
        return self.aspectsList.filter({
            
            var description = true
            var value = true
            
            if criteria.description?.count ?? 0 > 0 {
                description = $0.description.localizedCaseInsensitiveContains(criteria.description!)
            }
            
            if criteria.aspect != nil {
                value = $0.aspect == criteria.aspect!
            }
            
            return description && value
            
        }).map({$0.id})
    }

    func UpdateAspect(aspect: AspectType?, request: UpdateAspectRequest) -> Aspect? {
        
        if aspect != nil {
            if var aspectToUpdate = aspectsList.first(where: {$0.aspect == aspect}) {
                aspectToUpdate.update(from: request)
                let index = aspectsList.firstIndex(where: {$0.aspect == aspect})!
                aspectsList[index] = aspectToUpdate
                return aspectToUpdate
            }
        }

        return nil
    }

    func DeleteAspect(aspect: AspectType){
        
        aspectsList.removeAll(where: {$0.aspect == aspect})
    }
    
    func DeleteAspect(id: UUID){
        
        aspectsList.removeAll(where: {$0.id == id})
    }

    
    // MARK: - GOALS

    @Published
    var dreamsDictionary: Dictionary<UUID,Dream> = [UUID:Dream]()
    @Published
    var dreamsGrouping: GroupingType = .title

    func CreateDream(request: CreateDreamRequest){
        let newDream = Dream(request: request)
        
        dreamsDictionary[newDream.id] = newDream
    }

    func GetDream(id: UUID) -> Dream?{
        
        if let goal = dreamsDictionary[id]{
            return goal
        }
        return nil
    }

    func ListDreamIdsByCriteria(criteria: Criteria) -> [UUID]{
        return self.dreamsDictionary.values.filter({
            
            var title = true
            var description = true
            var aspect = true
            
            if criteria.title?.count ?? 0 > 0 {
                title = $0.title.localizedCaseInsensitiveContains(criteria.title!)
            }
            
            if criteria.description?.count ?? 0 > 0 {
                description = $0.description.localizedCaseInsensitiveContains(criteria.description!)
            }
            
            if criteria.aspect != nil {
                aspect = $0.aspect == criteria.aspect!
            }
            
            return title && description && aspect
            
        }).map({$0.id})
    }

    func UpdateFilteredDreams(criteria: Criteria) -> [String:[UUID]]{
                
        let filteredDreams = ListDreamIdsByCriteria(criteria: criteria)
        var dreamsDictionaryFiltered: Dictionary<String,[UUID]> = [String:[UUID]]()
                
        for goalId in filteredDreams {
            
            if let goal = dreamsDictionary[goalId] {
                switch dreamsGrouping {
                    
                case .title:
                    if  dreamsDictionaryFiltered[String(goal.title.prefix(1))] == nil {
                        dreamsDictionaryFiltered[String(goal.title.prefix(1))] = [UUID]()
                    }
                    dreamsDictionaryFiltered[String(goal.title.prefix(1))]!.append(goal.id)
                case .aspect:
                    if  dreamsDictionaryFiltered[goal.aspect.toString()] == nil {
                        dreamsDictionaryFiltered[goal.aspect.toString()] = [UUID]()
                    }
                    dreamsDictionaryFiltered[goal.aspect.toString()]!.append(goal.id)
                default:
                    let _ = "why"
                }
            }

        }
        
        return dreamsDictionaryFiltered
    }

    func UpdateDream(id: UUID?, request: UpdateDreamRequest) -> Dream? {
        
        if id != nil {
            if var goalToUpdate = dreamsDictionary[id!] {
                goalToUpdate.update(from: request)
                dreamsDictionary.updateValue(goalToUpdate, forKey: id!)
                return dreamsDictionary[id!]
            }
        }

        return nil
    }

    func DeleteDream(id: UUID){
        
        dreamsDictionary[id] = nil
    }

}
