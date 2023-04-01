import Foundation
import SwiftUI

class GoalService: ObservableObject
{
    @Published
    var goalsDictionary: Dictionary<UUID,Goal> = [UUID:Goal]()
    
//    @Published
//    var goalsDictionaryFiltered: Dictionary<String,[UUID]> = [String:[UUID]]()
    
    @Published
    var goalsGrouping: GroupingType = .title
    
    
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
        
    }
    
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
    
    func ListAffectedGoalIdsByParentId(uuid: UUID, affected: [UUID]) -> [UUID]{
        
        var affectedIds = affected
        
        if let parentGoal = goalsDictionary[uuid]{
            affectedIds.append(parentGoal.id)
            
            if parentGoal.children.count == 0{
                return affectedIds
            }
            else{
                for childId in parentGoal.children{
                    affectedIds.append(contentsOf: ListAffectedGoalIdsByParentId(uuid: childId, affected: affectedIds)) 
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
        var affectedGoalIds = ListAffectedGoalIdsByParentId(uuid: id, affected: [UUID]())
        
        affectedGoalIds = Array(Set(affectedGoalIds))
        
        for affectedGoalId in affectedGoalIds {
            
            goalsDictionary.removeValue(forKey: affectedGoalId)
        }
    }
}


