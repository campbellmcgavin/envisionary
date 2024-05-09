//
//  AppService.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/9/23.
//

import SwiftUI
import CoreData

class DataService: DataServiceProtocol {
    var container: NSPersistentCloudKitContainer
    
    let lock = NSLock()
    init(){
        self.container = NSPersistentCloudKitContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: {(description, error) in
            if let error = error {
                print("ERROR LOADING TASK DATA. \(error)")
            }
            else{
                print("SUCCESSFULLY LOADED TASK DATA.")
            }
        })
        
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func saveData() {
        
        lock.lock()
        do {
            try container.viewContext.save()
        } catch let error {
            print ("ERROR SAVING DATA. \(error)")
        }
        lock.unlock()
    }
    
    // MARK: - Duplicate Cleanup
    
    func CleanupDuplicates(){
        CleanupDuplicateValues()
        CleanupDuplicateAspects()
    }
    
    private func CleanupDuplicateAspects(){
        let aspects = self.ListAspects()
        var aspectsDictionary: Dictionary<String,[UUID]> = [String:[UUID]]()
        aspects.forEach({
            aspect in
            
            if aspectsDictionary[aspect.title] == nil {
                aspectsDictionary[aspect.title] = [UUID]()
            }
            
            aspectsDictionary[aspect.title]?.append(aspect.id)
        })
        
        aspectsDictionary.keys.forEach({
            aspectTitle in
            
            if let aspects = aspectsDictionary[aspectTitle]{
                if aspects.count > 1 {
                    for index in 1 ... aspects.count - 1 {
                        _ = self.DeleteAspect(id: aspects[index])
                    }
                }
            }
        }
        )
    }
    
    private func CleanupDuplicateValues(){
        let coreValues = self.ListCoreValues(criteria: Criteria())
        var coreValuesDictionary: Dictionary<String,[UUID]> = [String:[UUID]]()
        coreValues.forEach({
            coreValue in
            
            if coreValuesDictionary[coreValue.title] == nil {
                coreValuesDictionary[coreValue.title] = [UUID]()
            }
            
            coreValuesDictionary[coreValue.title]?.append(coreValue.id)
        })
        
        coreValuesDictionary.keys.forEach({
            coreValueTitle in
            
            if let coreValues = coreValuesDictionary[coreValueTitle]{
                if coreValues.count > 1 {
                    for index in 1 ... coreValues.count - 1 {
                        _ = self.DeleteCoreValue(id: coreValues[index])
                    }
                }
            }
        }
        )
    }
    // MARK: - ProgressPoint
    func CreateProgressPoint(request: CreateProgressPointRequest) -> UUID{
        let id = UUID()
        let newProgressPoint = ProgressPointEntity(context: container.viewContext)
        
        newProgressPoint.parentId = request.parentId
        newProgressPoint.id = id
        newProgressPoint.date = request.date
        newProgressPoint.amount = Int16(request.amount)
        newProgressPoint.progress = Int16(request.progress)
        
        saveData()
        
        return id
    }
    
    func ListProgressPoints(parentId: UUID) -> [ProgressPoint] {
        do {
            let request = NSFetchRequest<ProgressPointEntity>(entityName: "ProgressPointEntity")
            var criteria = Criteria()
            criteria.parentId = parentId
            
            request.predicate = NSCompoundPredicate.PredicateBuilder(criteria: criteria, object:.progressPoint)
            request.fetchLimit = 150
            
            let progressPointList = try container.viewContext.fetch(request)
            return progressPointList.map({ProgressPoint(from: $0)})
        } catch let error {
            print ("ERROR FETCHING TASK. \(error)")
        }
        return [ProgressPoint]()
    }
    
    // MARK: - IMAGE
    func CreateImage(image: UIImage) -> UUID{
        let data = image.jpegData(compressionQuality: 0.1)
        let newImage = ImageEntity(context: container.viewContext)
        newImage.data = data
        let id = UUID()
        newImage.id = id
        saveData()
        
        let image = GetImage(id: id, newContext: false)
        
        return id
    }
    
    func DeleteImage(id: UUID) -> Bool{
        if let imageToDelete = GetImageEntity(id: id, newContext: false){
            container.viewContext.delete(imageToDelete)
            saveData()
            return true
        }
        return false
    }
    
    func GetImage(id: UUID, newContext: Bool) -> UIImage? {
        let imageEntity = GetImageEntity(id: id, newContext: newContext)
        
        if let imageEntity{
            if imageEntity.data != nil {
                return UIImage(data: imageEntity.data!)
            }
            return nil
        }
        return nil
    }
    
    private func GetImageEntity(id: UUID, newContext: Bool) -> ImageEntity? {
        
        let request = NSFetchRequest<ImageEntity>(entityName: "ImageEntity")
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.predicate = predicate
        
        do {
            if newContext{
                let context = container.newBackgroundContext()
                
                let imageEntityList = try context.fetch(request)
                
                return imageEntityList.first
            }
            else{
                let imageEntityList = try container.viewContext.fetch(request)
                return imageEntityList.first
            }
        } catch let error {
            print ("ERROR FETCHING IMAGE. \(error)")
        }
        return nil
    }
    
    // MARK: - GOALS
    func CreateGoalKit(request: GoalKit, startDate: Date) -> UUID {
            
        var idDictionary = [Int: UUID]()
        
        let superId = UUID()
        idDictionary[0] = superId
        
        request.items.forEach({ item in
            idDictionary[item.id] = UUID()
        })
        
        var localImageId: UUID? = nil
        
        if let image = UIImage(named: request.image.toImageString()){
            localImageId = self.CreateImage(image: image)
        }
        
        var requests = [CreateGoalRequest]()
        
        request.items.forEach({
            item in
            
            let id = UUID()
            
            idDictionary[item.id] = id
            
            let localStartDate = startDate.AdvanceDay(forward: true, count: GoalKit.GetDayOffset(id: item.id, items: request.items))
            let request = CreateGoalRequest(title: item.title, description: "", priority: request.priority, startDate: localStartDate, endDate: localStartDate.AdvanceDay(forward: true, count: item.end), percentComplete: 0, image: localImageId, aspect: request.aspect, parent: idDictionary[item.parentId], superId: superId)
            requests.append(request)
            _ = self.CreateGoal(request: request, id: id)
        })
        
        let superRequest = CreateGoalRequest(title: request.superItem.title, description: request.superItem.description, priority: request.priority, startDate: startDate, endDate: requests.filter({$0.startDate != nil && $0.endDate != nil}).max(by: {$0.endDate! < $1.endDate!})?.endDate ?? Date(), percentComplete: 0, image: localImageId, aspect: request.aspect, parent: nil, superId: nil)
        
        _ = self.CreateGoal(request: superRequest, id: superId)
        return superId
    }
    
    func CreateGoal(request: CreateGoalRequest, id: UUID) -> UUID{
        let newGoal = GoalEntity(context: container.viewContext)
        
        newGoal.position = ComputeLexoRank(parentId: request.parentId, referenceId: request.previousGoalId, referencePlacement: .below)?.string
        newGoal.title = request.title
        newGoal.desc = request.description
        newGoal.priority = request.priority.toString()
        newGoal.startDate = request.startDate
        newGoal.endDate = request.endDate
        newGoal.progress = 0
        newGoal.aspect = request.aspect
        newGoal.image = request.image
        newGoal.parentId = request.parentId
        newGoal.archived = false
        newGoal.id = id
        newGoal.superId = request.superId
        
        saveData()
        
        return newGoal.id!
    }
    
    func CreateGoal(request: CreateGoalRequest) -> UUID{
        let id = UUID()
        let newGoal = GoalEntity(context: container.viewContext)
        
        newGoal.position = ComputeLexoRank(parentId: request.parentId, referenceId: request.previousGoalId, referencePlacement: .below)?.string
        newGoal.title = request.title
        newGoal.desc = request.description
        newGoal.priority = request.priority.toString()
        newGoal.startDate = request.startDate
        newGoal.endDate = request.endDate
        newGoal.progress = 0
        newGoal.aspect = request.aspect
        newGoal.image = request.image
        newGoal.parentId = request.parentId
        newGoal.archived = false
        newGoal.id = id
        newGoal.superId = request.superId
        
        saveData()
        
        return newGoal.id!
    }
    
    private func ComputeLexoRank(abovePosition: String?, belowPosition: String?) -> LexoRank?{
        // if this is a child goal
        do{
            var lexoRank1: LexoRank? = nil
            var lexoRank2: LexoRank? = nil
            
            if abovePosition != nil && abovePosition!.count > 0 {
                lexoRank1 = try LexoRank(abovePosition!)
            }
            
            if belowPosition != nil && belowPosition!.count > 0 {
                lexoRank2 = try LexoRank(belowPosition!)
            }
            
            if let lexoRank1{
                if let lexoRank2{
                    return try lexoRank1.between(other: lexoRank2)
                }
                return try lexoRank1.next()
            }
            return try LexoRank.first()
        }
        catch{}
        return nil
    }
    
    private func ComputeLexoRank(parentId: UUID?, referenceId: UUID?, referencePlacement: PlacementType?) -> LexoRank?{
        // if this is a child goal
        do{
            if let parentId{
                
                let siblingGoals = ListChildGoals(id: parentId)
                
                // if this is the first child
                if siblingGoals.count == 0 {
                    return try LexoRank.first()
                }
                // if there is a reference goal marker
                if let goal1Index = siblingGoals.firstIndex(where:{$0.id == referenceId}){
                    
                    let lexoRank1 = try LexoRank(siblingGoals[goal1Index].position)
                    var goal2Index = 0
                    
                    if let referencePlacement{
                        switch referencePlacement{
                        case .above:
                            goal2Index = goal1Index-1
                            
                            if goal1Index == 0{
                                return try lexoRank1.prev()
                            }
                            let lexoRank2 = try LexoRank(siblingGoals[goal2Index].position)
                            return try lexoRank1.between(other: lexoRank2)
                        case .below:
                            goal2Index = goal1Index+1
                            
                            if siblingGoals.count - 1 == goal1Index{
                                return try lexoRank1.next()
                            }
                            let lexoRank2 = try LexoRank(siblingGoals[goal2Index].position)
                            return try lexoRank1.between(other: lexoRank2)
                            
                        case .on:
                            return try LexoRank(siblingGoals.first!.position).prev()
                        }
                    }
                    
                    else if goal2Index > -1 && goal1Index != goal2Index{
                        let lexoRank2 = try LexoRank(siblingGoals[goal2Index].position)
                        return try lexoRank1.between(other: lexoRank2)
                    }
                }
                
                // else throw it at the end of the children
                else{
                    let lastGoalPosition = siblingGoals.last!.position
                    return try LexoRank(lastGoalPosition).next()
                }
                
                return try LexoRank.first()
            }
        }
        catch{}
        return nil
    }
    
    func GetGoal(id: UUID) -> Goal?{
        
        let goalEntity = GetGoalEntity(id: id)
        
        if let goalEntity{
            return Goal(from: goalEntity)
        }
        return nil
    }
    
    private func GetGoalEntity(id: UUID) -> GoalEntity?{
        let request = NSFetchRequest<GoalEntity>(entityName: "GoalEntity")
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.predicate = predicate
        
        do {
            let goalsEntityList = try container.viewContext.fetch(request)
            
            return goalsEntityList.first
            
        } catch let error {
            print ("ERROR FETCHING GOAL. \(error)")
        }
        return nil
    }
    
    func ComputeGoalPosition(parentId: UUID, siblingAbove: UUID?) -> String {
        let childGoals = self.ListChildGoals(id: parentId).sorted(by: {$0.position < $1.position})
        
        if childGoals.count == 0 {
            return "a"
        }
        
        if siblingAbove == nil {
            return String.toPosition(positionAbove: childGoals.last?.position, positionBelow: nil)
        }
        else{
            if let siblingAboveGoal = childGoals.first(where: {$0.id == siblingAbove!}){
                if siblingAboveGoal == childGoals.last {
                    return String.toPosition(positionAbove: siblingAboveGoal.position, positionBelow: nil)
                }
                else{
                    let indexOfNext = childGoals.index(after: childGoals.firstIndex(of: siblingAboveGoal) ?? childGoals.count-1)
                    
                    return String.toPosition(positionAbove: siblingAboveGoal.position, positionBelow: childGoals[indexOfNext].position)
                }
            }
        }
        return "a"
    }
    
    func ListGoals(criteria: Criteria, limit: Int = 50) -> [Goal]{
        
        
        do {
            let request = NSFetchRequest<GoalEntity>(entityName: "GoalEntity")
            
            request.predicate = NSCompoundPredicate.PredicateBuilder(criteria: criteria, object:.goal)
            request.fetchLimit = limit
            
            let goalsEntityList = try container.viewContext.fetch(request)
            return goalsEntityList.map({Goal(from: $0)})
        } catch let error {
            print ("ERROR FETCHING TASK. \(error)")
        }
        return [Goal]()
    }
    
    func UpdateGoal(id: UUID, request: UpdateGoalRequest) -> Bool {
        
        _ = UpdateGoalHelper(id: id, request: request)
        
        return true
    }
    
    func UpdateGoalParentsHelper(id: UUID) -> Bool{
        if var goal = GetGoal(id: id){
            let parentGoals = ListParentGoals(id: id)
            
            parentGoals.forEach{
                parentGoal in
                if var parentGoalEntity = self.GetGoalEntity(id: parentGoal.id){
                    
                    if  parentGoal.startDate != nil && goal.startDate != nil && parentGoal.startDate! > goal.startDate! {
                        parentGoalEntity.startDate = goal.startDate
                    }
                    if parentGoal.endDate != nil && goal.endDate != nil && parentGoal.endDate! < goal.endDate! {
                        parentGoalEntity.endDate = goal.endDate
                    }
                    
                    saveData()
                }
            }
        }
        
        return true
    }
    
    func UpdateGoalHelper(id: UUID, request: UpdateGoalRequest) -> Bool{
        if var entityToUpdate = GetGoalEntity(id: id) {
            
            if request.reorderGoalId != nil && request.reorderPlacement != nil{
                
                let affectedGoals = ListAffectedGoals(id: id)
                if !affectedGoals.contains(where: {$0.id == request.reorderGoalId}){
                    
                    if let reorderGoal = GetGoal(id:request.reorderGoalId!){
                        switch request.reorderPlacement!{
                        case .above:
                            entityToUpdate.parentId = reorderGoal.parentId
                        case .on:
                            entityToUpdate.parentId = reorderGoal.id
                        case .below:
                            entityToUpdate.parentId = reorderGoal.parentId
                        }
                        
                        entityToUpdate.position = ComputeLexoRank(parentId: entityToUpdate.parentId, referenceId: request.reorderGoalId, referencePlacement: request.reorderPlacement)?.string ?? ""
                    }
                }
                else{
                    entityToUpdate.parentId = request.parent
                }
                
                
            }
            else{
                entityToUpdate.parentId = request.parent
            }
            
            var shouldUpdateParentDates = entityToUpdate.startDate != request.startDate || entityToUpdate.endDate != request.endDate
            
            entityToUpdate.title = request.title
            entityToUpdate.desc = request.description
            entityToUpdate.startDate = request.startDate
            entityToUpdate.endDate = request.endDate
            entityToUpdate.progress = Int16(request.progress)
            entityToUpdate.image = request.image
            entityToUpdate.priority = request.priority.toString()
            entityToUpdate.aspect = request.aspect
            entityToUpdate.archived = request.archived
            entityToUpdate.completedDate = request.completedDate
            entityToUpdate.superId = request.superId
            saveData()
            
            if shouldUpdateParentDates {
                _ = UpdateGoalParentsHelper(id: id)
            }
            
            
        }
        return true
    }
    
    func DeleteGoal(id: UUID) -> Bool{
        if let goalToDelete = GetGoalEntity(id: id){
            
            
            for goal in ListChildGoals(id: id){
                _ = DeleteGoal(id: goal.id)
            }
            container.viewContext.delete(goalToDelete)
            saveData()
            return true
        }
        return false
    }
    
    func GroupGoals(criteria: Criteria, grouping: GroupingType) -> [String : [Goal]] {
        
        var goals = ListGoals(criteria: criteria)
        
        var goalsDictionary: Dictionary<String,[Goal]> = [String:[Goal]]()
        
        for goal in goals {
            switch grouping {
                
            case .title:
                if  goalsDictionary[String(goal.title.prefix(1))] == nil {
                    goalsDictionary[String(goal.title.prefix(1))] = [Goal]()
                }
                goalsDictionary[String(goal.title.prefix(1))]!.append(goal)
            case .aspect:
                if  goalsDictionary[goal.aspect] == nil {
                    goalsDictionary[goal.aspect] = [Goal]()
                }
                goalsDictionary[goal.aspect]!.append(goal)
            case .priority:
                if  goalsDictionary[goal.priority.toString()] == nil {
                    goalsDictionary[goal.priority.toString()] = [Goal]()
                }
                goalsDictionary[goal.priority.toString()]!.append(goal)
            case .progress:
                if  goalsDictionary[StatusType.getStatusFromProgress(progress: goal.progress).toString()] == nil {
                    goalsDictionary[StatusType.getStatusFromProgress(progress: goal.progress).toString()] = [Goal]()
                }
                goalsDictionary[StatusType.getStatusFromProgress(progress: goal.progress).toString()]!.append(goal)
            default:
                let _ = "why"
            }
        }
        return goalsDictionary
    }
    
    func ListParentGoals(id: UUID) -> [Goal] {
        var goals = [Goal]()
        var focusId: UUID? = id
        
        while let nextId = focusId{
            if let goal = GetGoal(id: nextId){
                goals.append(goal)
                focusId = goal.parentId
            }
            else{
                focusId = nil
            }
        }
        
        return goals
    }
    
    func ListChildGoals(id: UUID) -> [Goal] {
        var criteria = Criteria()
        criteria.parentId = id
        return self.ListGoals(criteria: criteria).sorted(by: {$0.position < $1.position})
    }
    
    func ListAffectedGoals(id: UUID) -> [Goal] {
        
        var goalList = [Goal]()
        
        // base case
        if ListChildGoals(id: id).count == 0 {
            
            if let goal = GetGoal(id: id){
                goalList.append(goal)
                return goalList
            }
            return goalList
        }
        
        // recursive call
        let request = NSFetchRequest<GoalEntity>(entityName: "GoalEntity")
        let predicate = NSPredicate(format: "parentId == %@", id as CVarArg)
        request.predicate = predicate
        do {
            let entityList = try container.viewContext.fetch(request)
            goalList.append(contentsOf: entityList.map({Goal(from: $0)}))
            
            for goal in goalList {
                if goal.id != id {
                    goalList.append(contentsOf: ListAffectedGoals(id: goal.id))
                }
            }
            
            if let goal = GetGoal(id: id){
                goalList.append(goal)
            }
            
            return Array(Set(goalList))
            
        } catch let error {
            print ("ERROR FETCHING GOAL. \(error)")
        }
        return [Goal]()
    }
    
    // MARK: - ASPECTS
    
    func CreateAspect(request: CreateAspectRequest) -> UUID{
        
        let newAspect = AspectEntity(context: container.viewContext)
        newAspect.title = request.title
        newAspect.desc = request.description
        newAspect.image = request.image
        newAspect.id = UUID()
        saveData()
        
        return newAspect.id ?? UUID()
    }
    
    func GetAspect(id: UUID) -> Aspect?{
        
        let AspectEntity = GetAspectEntity(id: id)
        
        if let AspectEntity{
            return Aspect(from: AspectEntity)
        }
        return nil
    }
    
    private func GetAspectEntity(id: UUID) -> AspectEntity?{
        let request = NSFetchRequest<AspectEntity>(entityName: "AspectEntity")
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.predicate = predicate
        
        do {
            let AspectsEntityList = try container.viewContext.fetch(request)
            
            return AspectsEntityList.first
            
        } catch let error {
            print ("ERROR FETCHING Aspect. \(error)")
        }
        return nil
    }
    
    func ListAspects(criteria: Criteria = Criteria(), limit: Int = 50) -> [Aspect]{
        
        
        do {
            let request = NSFetchRequest<AspectEntity>(entityName: "AspectEntity")
            
            request.predicate = NSCompoundPredicate.PredicateBuilder(criteria: criteria, object:.aspect)
            request.fetchLimit = limit
            
            let AspectsEntityList = try container.viewContext.fetch(request)
            return AspectsEntityList.map({Aspect(from: $0)})
        } catch let error {
            print ("ERROR FETCHING Aspect. \(error)")
        }
        return [Aspect]()
    }
    
    
    
    func UpdateAspect(id: UUID, request: UpdateAspectRequest) -> Bool {
        
        if var entityToUpdate = GetAspectEntity(id: id) {
            entityToUpdate.desc = request.description
            entityToUpdate.image = request.image
            entityToUpdate.title = request.title
            saveData()
            return true
        }
        
        return false
    }
    
    func DeleteAspect(id: UUID) -> Bool{
        if let AspectToDelete = GetAspectEntity(id: id){
            container.viewContext.delete(AspectToDelete)
            saveData()
            return true
        }
        return false
    }
    
    // MARK: - CORE VALUE
    
    func CreateCoreValue(request: CreateCoreValueRequest) -> UUID{
        
        let newCoreValue = CoreValueEntity(context: container.viewContext)
        newCoreValue.title = request.title
        newCoreValue.desc = request.description
        newCoreValue.image = request.image
        newCoreValue.id = UUID()
        newCoreValue.position = ComputeLexoRank(abovePosition: nil, belowPosition: nil)?.string ?? ""
        saveData()
        
        return newCoreValue.id ?? UUID()
    }
    
    func GetCoreValue(id: UUID) -> CoreValue?{
        
        let CoreValueEntity = GetCoreValueEntity(id: id)
        
        if let CoreValueEntity{
            return CoreValue(from: CoreValueEntity)
        }
        return nil
    }
    
    func GetCoreValue(coreValue: ValueType) -> CoreValue?{
        
        let CoreValueEntity = GetCoreValueEntity(coreValue: coreValue)
        
        if let CoreValueEntity{
            return CoreValue(from: CoreValueEntity)
        }
        return nil
    }
    
    private func GetCoreValueEntity(id: UUID) -> CoreValueEntity?{
        let request = NSFetchRequest<CoreValueEntity>(entityName: "CoreValueEntity")
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.predicate = predicate
        
        do {
            let CoreValuesEntityList = try container.viewContext.fetch(request)
            
            return CoreValuesEntityList.first
            
        } catch let error {
            print ("ERROR FETCHING CoreValue. \(error)")
        }
        return nil
    }
    
    private func GetCoreValueEntity(coreValue: ValueType) -> CoreValueEntity?{
        let request = NSFetchRequest<CoreValueEntity>(entityName: "CoreValueEntity")
        let predicate = NSPredicate(format: "title == %@", coreValue.toString() as CVarArg)
        request.predicate = predicate
        
        do {
            let CoreValuesEntityList = try container.viewContext.fetch(request)
            
            return CoreValuesEntityList.first
            
        } catch let error {
            print ("ERROR FETCHING CoreValue. \(error)")
        }
        return nil
    }
    
    func ListCoreValues(criteria: Criteria, limit: Int = 50, filterIntroConc: Bool = true) -> [CoreValue]{
        
        do {
            let request = NSFetchRequest<CoreValueEntity>(entityName: "CoreValueEntity")
            
            request.predicate = NSCompoundPredicate.PredicateBuilder(criteria: criteria, object:.value)
            request.fetchLimit = limit
            
            let CoreValuesEntityList = try container.viewContext.fetch(request)
            
            if filterIntroConc {
                return CoreValuesEntityList.map({CoreValue(from: $0)}).filter({$0.title != ValueType.Introduction.toString() && $0.title != ValueType.Conclusion.toString()}).sorted(by: {$0.position < $1.position})
            }
            else{
                return CoreValuesEntityList.map({CoreValue(from: $0)}).sorted(by: {$0.position < $1.position})
            }
        } catch let error {
            print ("ERROR FETCHING CoreValue. \(error)")
        }
        return [CoreValue]()
    }
    
    func UpdateCoreValue(id: UUID, request: UpdateCoreValueRequest) -> Bool {
        
        if var entityToUpdate = GetCoreValueEntity(id: id) {
            entityToUpdate.desc = request.description
            entityToUpdate.image = request.image
            
            if let valueIdAbove = request.reorderCoreValueId{
                
                let values = ListCoreValues(criteria: Criteria()).sorted(by: {$0.position < $1.position})
                
                if let valueAboveIndex = values.firstIndex(where: {$0.id == valueIdAbove}){
                    let valueAbove = values[valueAboveIndex]
                    var valueBelow: CoreValue? = nil
                    
                    if valueAboveIndex < values.count - 1 {
                        valueBelow = values[valueAboveIndex + 1]
                    }
                    
                    entityToUpdate.position = ComputeLexoRank(abovePosition: valueAbove.position, belowPosition: valueBelow?.position)?.string ?? ""
                }
                
            }
            
            saveData()
            return true
        }
        
        return false
    }
    
    func DeleteCoreValue(id: UUID) -> Bool{
        if let CoreValueToDelete = GetCoreValueEntity(id: id){
            container.viewContext.delete(CoreValueToDelete)
            saveData()
            return true
        }
        return false
    }
    
    // MARK: - CHAPTERS
    
    func CreateChapter(request: CreateChapterRequest) -> UUID{
        
        let newChapter = ChapterEntity(context: container.viewContext)
        newChapter.title = request.title
        newChapter.desc = request.description
        newChapter.aspect = request.aspect
        newChapter.image = request.image
        newChapter.archived = false
        newChapter.id = UUID()
        saveData()
        
        return newChapter.id ?? UUID()
    }
    
    func GetChapter(id: UUID) -> Chapter?{
        
        let ChapterEntity = GetChapterEntity(id: id)
        
        if let ChapterEntity{
            return Chapter(from: ChapterEntity)
        }
        return nil
    }
    
    private func GetChapterEntity(id: UUID) -> ChapterEntity?{
        let request = NSFetchRequest<ChapterEntity>(entityName: "ChapterEntity")
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.predicate = predicate
        
        do {
            let ChaptersEntityList = try container.viewContext.fetch(request)
            
            return ChaptersEntityList.first
            
        } catch let error {
            print ("ERROR FETCHING Chapter. \(error)")
        }
        return nil
    }
    
    func ListChapters(criteria: Criteria, limit: Int = 50) -> [Chapter]{
        
        do {
            let request = NSFetchRequest<ChapterEntity>(entityName: "ChapterEntity")
            
            request.predicate = NSCompoundPredicate.PredicateBuilder(criteria: criteria, object:.journal)
            request.fetchLimit = limit
            
            let ChaptersEntityList = try container.viewContext.fetch(request)
            return ChaptersEntityList.map({Chapter(from: $0)})
        } catch let error {
            print ("ERROR FETCHING Chapter. \(error)")
        }
        return [Chapter]()
    }
    
    func GroupChapters(criteria: Criteria, grouping: GroupingType) -> [String : [Chapter]] {
        
        let chapters = ListChapters(criteria: criteria)
        var chaptersDictionary: Dictionary<String,[Chapter]> = [String:[Chapter]]()
        
        for chapter in chapters {
            switch grouping {
                
            case .title:
                if  chaptersDictionary[String(chapter.title.prefix(1))] == nil {
                    chaptersDictionary[String(chapter.title.prefix(1))] = [Chapter]()
                }
                chaptersDictionary[String(chapter.title.prefix(1))]!.append(chapter)
            case .aspect:
                if  chaptersDictionary[chapter.aspect] == nil {
                    chaptersDictionary[chapter.aspect] = [Chapter]()
                }
                chaptersDictionary[chapter.aspect]!.append(chapter)
            default:
                let _ = "why"
            }
        }
        return chaptersDictionary
    }
    
    func UpdateChapter(id: UUID, request: UpdateChapterRequest) -> Bool {
        
        if var entityToUpdate = GetChapterEntity(id: id) {
            entityToUpdate.desc = request.description
            entityToUpdate.title = request.title
            entityToUpdate.aspect = request.aspect
            entityToUpdate.image = request.image
            entityToUpdate.archived = request.archived
            saveData()
            return true
        }
        
        return false
    }
    
    func DeleteChapter(id: UUID) -> Bool{
        if let ChapterToDelete = GetChapterEntity(id: id){
            container.viewContext.delete(ChapterToDelete)
            saveData()
            return true
        }
        return false
    }
    
    // MARK: - ENTRIES
    
    func CreateEntry(request: CreateEntryRequest) -> UUID{
        
        let newEntry = EntryEntity(context: container.viewContext)
        newEntry.title = request.title
        newEntry.desc = request.description
        newEntry.startDate = request.startDate
        newEntry.chapterId = request.chapterId
        newEntry.images = request.images.toCsvString()
        newEntry.archived = false
        newEntry.id = UUID()
        
        saveData()
        
        return newEntry.id ?? UUID()
    }
    
    func GetEntry(id: UUID) -> Entry?{
        
        let EntryEntity = GetEntryEntity(id: id)
        
        if let EntryEntity{
            return Entry(from: EntryEntity)
        }
        return nil
    }
    
    private func GetEntryEntity(id: UUID) -> EntryEntity?{
        let request = NSFetchRequest<EntryEntity>(entityName: "EntryEntity")
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.predicate = predicate
        
        do {
            let EntriesEntityList = try container.viewContext.fetch(request)
            
            return EntriesEntityList.first
            
        } catch let error {
            print ("ERROR FETCHING Entry. \(error)")
        }
        return nil
    }
    
    func ListEntries(criteria: Criteria, limit: Int = 50) -> [Entry]{
        
        do {
            let request = NSFetchRequest<EntryEntity>(entityName: "EntryEntity")
            
            request.predicate = NSCompoundPredicate.PredicateBuilder(criteria: criteria, object:.entry)
            request.fetchLimit = limit
            
            let EntriesEntityList = try container.viewContext.fetch(request)
            return EntriesEntityList.map({Entry(from: $0)})
        } catch let error {
            print ("ERROR FETCHING Entry. \(error)")
        }
        return [Entry]()
    }
    
    func GroupEntries(criteria: Criteria, grouping: GroupingType) -> [String : [Entry]] {
        
        let Entries = ListEntries(criteria: criteria)
        var EntriesDictionary: Dictionary<String,[Entry]> = [String:[Entry]]()
        var chapters = ListChapters(criteria: Criteria())
        
        for entry in Entries {
            switch grouping {
                
            case .title:
                if  EntriesDictionary[String(entry.title.prefix(1))] == nil {
                    EntriesDictionary[String(entry.title.prefix(1))] = [Entry]()
                }
                EntriesDictionary[String(entry.title.prefix(1))]!.append(entry)
            case .chapter:
                if  EntriesDictionary[chapters.first(where: {$0.id == entry.chapterId})?.title ?? "Unassociated"] == nil {
                    EntriesDictionary[chapters.first(where: {$0.id == entry.chapterId})?.title ?? "Unassociated"] = [Entry]()
                }
                EntriesDictionary[chapters.first(where: {$0.id == entry.chapterId})?.title ?? "Unassociated"]!.append(entry)
            default:
                let _ = "why"
            }
        }
        return EntriesDictionary
    }
    
    func UpdateEntry(id: UUID, request: UpdateEntryRequest) -> Bool {
        
        if var entityToUpdate = GetEntryEntity(id: id) {
            entityToUpdate.desc = request.description
            entityToUpdate.title = request.title
            entityToUpdate.images = request.images.toCsvString()
            entityToUpdate.chapterId = request.chapterId
            entityToUpdate.archived = request.archived
            saveData()
            return true
        }
        
        return false
    }
    
    func DeleteEntry(id: UUID) -> Bool{
        if let EntryToDelete = GetEntryEntity(id: id){
            container.viewContext.delete(EntryToDelete)
            saveData()
            return true
        }
        return false
    }
    
    
    
    // MARK: - CREATE CORE VALUE
    
    func CreateCoreValueRating(request: CreateCoreValueRatingRequest) -> UUID{
        
        let newCoreValueRating = CoreValueRatingEntity(context: container.viewContext)
        let id = UUID()
        newCoreValueRating.id = id
        newCoreValueRating.parentId = request.parentGoalId
        newCoreValueRating.coreValueId = request.valueId
        newCoreValueRating.amount = Int16(request.amount)
        
        saveData()
        
        return id
    }
    
    func GetCoreValueRating(id: UUID) -> CoreValueRating?{
        
        let CoreValueRatingEntity = GetCoreValueRatingEntity(id: id)
        
        if let CoreValueRatingEntity{
            return CoreValueRating(entity: CoreValueRatingEntity)
        }
        return nil
    }
    
    private func GetCoreValueRatingEntity(id: UUID) -> CoreValueRatingEntity?{
        let request = NSFetchRequest<CoreValueRatingEntity>(entityName: "CoreValueRatingEntity")
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.predicate = predicate
        
        do {
            let CoreValueRatingsEntityList = try container.viewContext.fetch(request)
            
            return CoreValueRatingsEntityList.first
            
        } catch let error {
            print ("ERROR FETCHING CoreValueRating. \(error)")
        }
        return nil
    }
    
    func ListCoreValueRatings(criteria: Criteria, limit: Int = 50) -> [CoreValueRating]{
        
        do {
            let request = NSFetchRequest<CoreValueRatingEntity>(entityName: "CoreValueRatingEntity")
            request.fetchLimit = limit
            request.predicate = NSCompoundPredicate.PredicateBuilder(criteria: criteria, object:.valueRating)
            let CoreValueRatingsList = try container.viewContext.fetch(request)
            return CoreValueRatingsList.map({CoreValueRating(entity: $0)})
        } catch let error {
            print ("ERROR FETCHING CoreValueRating. \(error)")
        }
        return [CoreValueRating]()
    }
    
    func UpdateCoreValueRating(id: UUID, request: UpdateCoreValueRatingRequest) -> Bool {
        
        if var entityToUpdate = GetCoreValueRatingEntity(id: id) {
            
            entityToUpdate.amount = Int16(request.amount)
            saveData()
            return true
        }
        
        return false
    }
    
    func DeleteCoreValueRating(id: UUID) -> Bool{
        if let CoreValueRatingToDelete = GetCoreValueRatingEntity(id: id){
            container.viewContext.delete(CoreValueRatingToDelete)
            saveData()
            return true
        }
        return false
    }
}
