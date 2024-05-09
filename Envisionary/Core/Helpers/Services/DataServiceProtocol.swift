//
//  AppServiceProtocol.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/9/23.
//

import SwiftUI

protocol DataServiceProtocol {
    
    // MARK: - CLEANUP
    func CleanupDuplicates()
    
    // MARK: - PROGRESS
    func CreateProgressPoint(request: CreateProgressPointRequest) -> UUID
    func ListProgressPoints(parentId: UUID) -> [ProgressPoint]
    
    // MARK: - IMAGE
    func CreateImage(image: UIImage) -> UUID
    func GetImage(id: UUID, newContext: Bool) -> UIImage?
    func DeleteImage(id: UUID) -> Bool
    
    // MARK: - GOALS
    func CreateGoalKit(request: GoalKit, startDate: Date) -> UUID
    func CreateGoal(request: CreateGoalRequest) -> UUID
    func GetGoal(id: UUID) -> Goal?
    func ListGoals(criteria: Criteria, limit: Int) -> [Goal]
    func ListChildGoals(id: UUID) -> [Goal]
    func UpdateGoal(id: UUID, request: UpdateGoalRequest) -> Bool
    func DeleteGoal(id: UUID) -> Bool
    func GroupGoals(criteria: Criteria, grouping: GroupingType) -> [String:[Goal]]
    func ListAffectedGoals(id: UUID) -> [Goal]
    func ListParentGoals(id: UUID) -> [Goal]

    // MARK: - ASPECT
    func CreateAspect(request: CreateAspectRequest) -> UUID
    func GetAspect(id: UUID) -> Aspect?
    func ListAspects(criteria: Criteria, limit: Int) -> [Aspect]
    func UpdateAspect(id: UUID, request: UpdateAspectRequest) -> Bool
    func DeleteAspect(id: UUID) -> Bool
    
    // MARK: - CORE VALUE
    func CreateCoreValue(request: CreateCoreValueRequest) -> UUID
    func GetCoreValue(id: UUID) -> CoreValue?
    func ListCoreValues(criteria: Criteria, limit: Int, filterIntroConc: Bool) -> [CoreValue]
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
    
    // MARK: - CORE VALUE RATING
    func CreateCoreValueRating(request: CreateCoreValueRatingRequest) -> UUID
    func GetCoreValueRating(id: UUID) -> CoreValueRating?
    func ListCoreValueRatings(criteria: Criteria, limit: Int) -> [CoreValueRating]
    func UpdateCoreValueRating(id: UUID, request: UpdateCoreValueRatingRequest) -> Bool
    func DeleteCoreValueRating(id: UUID) -> Bool
}
