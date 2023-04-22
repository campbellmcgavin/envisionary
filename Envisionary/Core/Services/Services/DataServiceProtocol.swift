//
//  AppServiceProtocol.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/9/23.
//

import SwiftUI

protocol DataServiceProtocol {
    
    // MARK: - IMAGE
    func CreateImage(image: UIImage) -> UUID
    func GetImage(id: UUID) -> UIImage?
    func DeleteImage(id: UUID) -> Bool
    
    // MARK: - GOALS
    func CreateGoal(request: CreateGoalRequest) -> UUID
    func GetGoal(id: UUID) -> Goal?
    func ListGoals(criteria: Criteria, limit: Int) -> [Goal]
    func ListChildGoals(id: UUID) -> [Goal]
    func UpdateGoal(id: UUID, request: UpdateGoalRequest) -> Bool
    func DeleteGoal(id: UUID) -> Bool
    func GroupGoals(criteria: Criteria, grouping: GroupingType) -> [String:[Goal]]
    func ListAffectedGoals(id: UUID) -> [Goal]

    // MARK: - TASKS
    func GetTask(id: UUID) -> Task?
    func CreateTask(request: CreateTaskRequest) -> UUID
    func UpdateTask(id: UUID, request: UpdateTaskRequest) -> Bool
    func ListTasks(criteria: Criteria, limit: Int) -> [Task]
    func DeleteTask(id: UUID) -> Bool
    func GroupTasks(criteria: Criteria, grouping: GroupingType) -> [String:[Task]]
    
    // MARK: - ASPECT
    func CreateAspect(request: CreateAspectRequest) -> UUID
    func GetAspect(id: UUID) -> Aspect?
    func ListAspects(criteria: Criteria, limit: Int) -> [Aspect]
    func UpdateAspect(id: UUID, request: UpdateAspectRequest) -> Bool
    func DeleteAspect(id: UUID) -> Bool
    
    // MARK: - DREAM
    func CreateDream(request: CreateDreamRequest) -> UUID
    func GetDream(id: UUID) -> Dream?
    func ListDreams(criteria: Criteria, limit: Int) -> [Dream]
    func UpdateDream(id: UUID, request: UpdateDreamRequest) -> Bool
    func DeleteDream(id: UUID) -> Bool
    func GroupDreams(criteria: Criteria, grouping: GroupingType) -> [String:[Dream]]
    
    // MARK: - CORE VALUE
    func CreateCoreValue(request: CreateCoreValueRequest) -> UUID
    func GetCoreValue(id: UUID) -> CoreValue?
    func ListCoreValues(criteria: Criteria, limit: Int) -> [CoreValue]
    func UpdateCoreValue(id: UUID, request: UpdateCoreValueRequest) -> Bool
    func DeleteCoreValue(id: UUID) -> Bool
    
    // MARK: - CHAPTER
    func CreateChapter(request: CreateChapterRequest) -> UUID
    func GetChapter(id: UUID) -> Chapter?
    func ListChapters(criteria: Criteria, limit: Int) -> [Chapter]
    func GroupChapters(criteria: Criteria, grouping: GroupingType) -> [String:[Chapter]]
    func UpdateChapter(id: UUID, request: UpdateChapterRequest) -> Bool
    func DeleteChapter(id: UUID) -> Bool
    
    // MARK: - ENTRY
    func CreateEntry(request: CreateEntryRequest) -> UUID
    func GetEntry(id: UUID) -> Entry?
    func ListEntries(criteria: Criteria, limit: Int) -> [Entry]
    func GroupEntries(criteria: Criteria, grouping: GroupingType) -> [String:[Entry]]
    func UpdateEntry(id: UUID, request: UpdateEntryRequest) -> Bool
    func DeleteEntry(id: UUID) -> Bool
}