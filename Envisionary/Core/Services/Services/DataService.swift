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
            return true
        }
        
        return false
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
    
    func ListAspects(criteria: Criteria, limit: Int = 50) -> [Aspect]{
        
        
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
    
    // MARK: - TASKS
    
//    func CreateTask(request: CreateTaskRequest) -> UUID{
//
//        let newTask = TaskEntity(context: container.viewContext)
//        newTask.title = request.title
//        newTask.desc = request.description
//        newTask.startDate = request.startDate
//        newTask.endDate = request.endDate
//        newTask.progress = 0
//
//        newTask.id = UUID()
//        saveData()
//
//        return newTask.id ?? UUID()
//    }
//
//    func GetTask(id: UUID) -> Task?{
//
//        let taskEntity = GetTaskEntity(id: id)
//
//        if let taskEntity{
//            return Task(from: taskEntity)
//        }
//        return nil
//    }
//
//    private func GetTaskEntity(id: UUID) -> TaskEntity?{
//        let request = NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
//        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
//        request.predicate = predicate
//
//        do {
//            let tasksEntityList = try container.viewContext.fetch(request)
//
//            return tasksEntityList.first
//
//        } catch let error {
//            print ("ERROR FETCHING TASK. \(error)")
//        }
//        return nil
//    }
//
//    func ListTasks(criteria: Criteria, limit: Int = 50) -> [Task]{
//
//
//        do {
//            let request = NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
//
//            request.predicate = NSCompoundPredicate.PredicateBuilder(criteria: criteria, object:.task)
//            request.fetchLimit = limit
//
//            let tasksEntityList = try container.viewContext.fetch(request)
//            return tasksEntityList.map({Task(from: $0)})
//        } catch let error {
//            print ("ERROR FETCHING TASK. \(error)")
//        }
//        return [Task]()
//    }
//
//    func UpdateTask(id: UUID, request: UpdateTaskRequest) -> Bool {
//
//        if var entityToUpdate = GetTaskEntity(id: id) {
//
//            entityToUpdate.title = request.title
//            entityToUpdate.desc = request.description
//            entityToUpdate.startDate = request.startDate
//            entityToUpdate.endDate = request.endDate
//            entityToUpdate.progress = Int64(request.progress)
//
//            saveData()
//            return true
//        }
//
//        return false
//    }
//
//    func DeleteTask(id: UUID) -> Bool{
//        if let taskToDelete = GetTaskEntity(id: id){
//            container.viewContext.delete(taskToDelete)
//            saveData()
//            return true
//        }
//        return false
//    }
//
//    func GroupTasks(criteria: Criteria, grouping: GroupingType) -> [String : [Task]] {
//
//        let tasks = ListTasks(criteria: criteria)
//        var tasksDictionary: Dictionary<String,[Task]> = [String:[Task]]()
//
//        for task in tasks {
//            switch grouping {
//
//            case .title:
//                if  tasksDictionary[String(task.title.prefix(1))] == nil {
//                    tasksDictionary[String(task.title.prefix(1))] = [Task]()
//                }
//                tasksDictionary[String(task.title.prefix(1))]!.append(task)
//            case .progress:
//                if  tasksDictionary[StatusType.getStatusFromProgress(progress: task.progress).toString()] == nil {
//                    tasksDictionary[StatusType.getStatusFromProgress(progress: task.progress).toString()] = [Task]()
//                }
//                tasksDictionary[StatusType.getStatusFromProgress(progress: task.progress).toString()]!.append(task)
//            default:
//                let _ = "why"
//            }
//        }
//        return tasksDictionary
//    }
    
    // MARK: - DREAMS
    
    func CreateDream(request: CreateDreamRequest) -> UUID{
        
        let newDream = DreamEntity(context: container.viewContext)
        newDream.title = request.title
        newDream.desc = request.description
        newDream.aspect = request.aspect
        newDream.archived = false
        newDream.image = request.image
        newDream.id = UUID()
        saveData()
        
        return newDream.id ?? UUID()
    }
    
    func GetDream(id: UUID) -> Dream?{
        
        let DreamEntity = GetDreamEntity(id: id)
        
        if let DreamEntity{
            return Dream(from: DreamEntity)
        }
        return nil
    }
    
    private func GetDreamEntity(id: UUID) -> DreamEntity?{
        let request = NSFetchRequest<DreamEntity>(entityName: "DreamEntity")
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.predicate = predicate
        
        do {
            let DreamsEntityList = try container.viewContext.fetch(request)
            
            return DreamsEntityList.first
            
        } catch let error {
            print ("ERROR FETCHING Dream. \(error)")
        }
        return nil
    }
    
    func ListDreams(criteria: Criteria, limit: Int = 50) -> [Dream]{
        
        
        do {
            let request = NSFetchRequest<DreamEntity>(entityName: "DreamEntity")
            
            request.predicate = NSCompoundPredicate.PredicateBuilder(criteria: criteria, object:.dream)
            request.fetchLimit = limit
            
            let DreamsEntityList = try container.viewContext.fetch(request)
            return DreamsEntityList.map({Dream(from: $0)})
        } catch let error {
            print ("ERROR FETCHING Dream. \(error)")
        }
        return [Dream]()
    }
    
    func UpdateDream(id: UUID, request: UpdateDreamRequest) -> Bool {
        
        if var entityToUpdate = GetDreamEntity(id: id) {
            entityToUpdate.desc = request.description
            entityToUpdate.archived = request.archived
            entityToUpdate.title = request.title
            entityToUpdate.image = request.image
            saveData()
            return true
        }
        
        return false
    }
    
    func DeleteDream(id: UUID) -> Bool{
        if let DreamToDelete = GetDreamEntity(id: id){
            container.viewContext.delete(DreamToDelete)
            saveData()
            return true
        }
        return false
    }
    
    func GroupDreams(criteria: Criteria, grouping: GroupingType) -> [String : [Dream]] {
        let dreams = ListDreams(criteria: criteria)
        var dreamsDictionary: Dictionary<String,[Dream]> = [String:[Dream]]()
                
        for dream in dreams {
            switch grouping {
                
            case .title:
                if  dreamsDictionary[String(dream.title.prefix(1))] == nil {
                    dreamsDictionary[String(dream.title.prefix(1))] = [Dream]()
                }
                dreamsDictionary[String(dream.title.prefix(1))]!.append(dream)
            case .aspect:
                if  dreamsDictionary[dream.aspect] == nil {
                    dreamsDictionary[dream.aspect] = [Dream]()
                }
                dreamsDictionary[dream.aspect]!.append(dream)
            default:
                let _ = "why"
            }
        }
        return dreamsDictionary
    }
    
    // MARK: - CORE VALUE
        
    func CreateCoreValue(request: CreateCoreValueRequest) -> UUID{
        
        let newCoreValue = CoreValueEntity(context: container.viewContext)
        newCoreValue.title = request.title
        newCoreValue.desc = request.description
        newCoreValue.image = request.image
        newCoreValue.id = UUID()
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
                return CoreValuesEntityList.map({CoreValue(from: $0)}).filter({$0.title != ValueType.Introduction.toString() && $0.title != ValueType.Conclusion.toString()})
            }
            else{
                return CoreValuesEntityList.map({CoreValue(from: $0)})       
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
            
            request.predicate = NSCompoundPredicate.PredicateBuilder(criteria: criteria, object:.chapter)
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
    
    // MARK: - SESSIONS
    
    func CreateSession(request: CreateSessionRequest) -> UUID{
        
        let newSession = SessionEntity(context: container.viewContext)
        let id = UUID()
        newSession.date = request.date
        newSession.id = id
        newSession.dateCompleted = request.dateCompleted
        newSession.timeframe = request.timeframe.toString()
        newSession.title = request.title
        do {
//            let evaluationDictionary = ConvertFromUUIDToStringDictionary(uuidDictionary: request.evaluationDictionary)
//            let alignmentDictionary = ConvertFromUUIDToStringDictionary(uuidDictionary: request.alignmentDictionary)
            let encoder = JSONEncoder()
            newSession.evaluationDictionary = try encoder.encode(request.evaluationDictionary)
            newSession.goalProperties = try encoder.encode(request.goalProperties)
            newSession.alignmentDictionary = try encoder.encode(request.alignmentDictionary)
        } catch {
            print(error.localizedDescription)
        }
        saveData()
        
        return id
    }
    
    private func ConvertFromUUIDToStringDictionary<T>(uuidDictionary: [UUID: T]) -> [String: T]{
        var stringDictionary = [String: T]()
        
        for id in uuidDictionary.keys{
            stringDictionary[id.uuidString] = uuidDictionary[id]
        }
        return stringDictionary
    }
    
    func GetSession(id: UUID) -> Session?{
        
        let SessionEntity = GetSessionEntity(id: id)
        
        if let SessionEntity{
            return Session(from: SessionEntity)
        }
        return nil
    }
    
    private func GetSessionEntity(id: UUID) -> SessionEntity?{
        let request = NSFetchRequest<SessionEntity>(entityName: "SessionEntity")
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.predicate = predicate
        
        do {
            let SessionsEntityList = try container.viewContext.fetch(request)
            
            return SessionsEntityList.first
            
        } catch let error {
            print ("ERROR FETCHING Session. \(error)")
        }
        return nil
    }
    
    func ListSessions(criteria: Criteria, limit: Int = 50) -> [Session]{
        
        do {
            let request = NSFetchRequest<SessionEntity>(entityName: "SessionEntity")
            
            request.predicate = NSCompoundPredicate.PredicateBuilder(criteria: criteria, object:.session)
            request.fetchLimit = limit
            
            let SessionsEntityList = try container.viewContext.fetch(request)
            return SessionsEntityList.map({Session(from: $0)})
        } catch let error {
            print ("ERROR FETCHING Session. \(error)")
        }
        return [Session]()
    }
    
    func DeleteSession(id: UUID) -> Bool{
        if let SessionToDelete = GetSessionEntity(id: id){
            container.viewContext.delete(SessionToDelete)
            saveData()
            return true
        }
        return false
    }
    
    // MARK: - PROMPT
    
    func CreatePrompt(request: CreatePromptRequest) -> UUID{
        
        let newPrompt = PromptEntity(context: container.viewContext)
        let id = UUID()
        newPrompt.id = id
        newPrompt.date = request.date
        newPrompt.type = request.type.toString()
        newPrompt.title = request.title
        newPrompt.objectType = request.objectType.toString()
        newPrompt.objectId = request.objectId
        saveData()
        
        return id
    }
    
    func GetPrompt(id: UUID) -> Prompt?{
        
        let PromptEntity = GetPromptEntity(id: id)
        
        if let PromptEntity{
            return Prompt(from: PromptEntity)
        }
        return nil
    }
    
    private func GetPromptEntity(id: UUID) -> PromptEntity?{
        let request = NSFetchRequest<PromptEntity>(entityName: "PromptEntity")
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.predicate = predicate
        
        do {
            let PromptsEntityList = try container.viewContext.fetch(request)
            
            return PromptsEntityList.first
            
        } catch let error {
            print ("ERROR FETCHING Prompt. \(error)")
        }
        return nil
    }
    
    func ListPrompts(criteria: Criteria, limit: Int = 50) -> [Prompt]{
        
        do {
            let request = NSFetchRequest<PromptEntity>(entityName: "PromptEntity")
            
            request.predicate = NSCompoundPredicate.PredicateBuilder(criteria: criteria, object:.prompt)
            request.fetchLimit = limit
            
            let PromptsEntityList = try container.viewContext.fetch(request)
            return PromptsEntityList.map({Prompt(from: $0)})
        } catch let error {
            print ("ERROR FETCHING Prompt. \(error)")
        }
        return [Prompt]()
    }
    
    func DeletePrompt(id: UUID) -> Bool{
        if let PromptToDelete = GetPromptEntity(id: id){
            container.viewContext.delete(PromptToDelete)
            saveData()
            return true
        }
        return false
    }
    
    // MARK: - HABITS
    
    func CreateHabit(request: CreateHabitRequest) -> UUID{
        
        let habitId = CreateHabitHelper(request: request)
        if let habit = GetHabit(id: habitId){
            let recurrenceRequests = HabitHelper().CreateRecurrences(habit: habit)
            
            for recurrenceRequest in recurrenceRequests {
                _ = CreateRecurrence(request: recurrenceRequest)
            }
        }
        return habitId
    }
    
    func CreateHabitHelper(request: CreateHabitRequest) -> UUID{
        let newHabit = HabitEntity(context: container.viewContext)
        newHabit.title = request.title
        newHabit.desc = request.description
        newHabit.priority = request.priority.toString()
        newHabit.startDate = request.startDate
        newHabit.endDate = request.endDate
        newHabit.aspect = request.aspect
        newHabit.timeframe = request.timeframe.toString()
        newHabit.image = request.image
        newHabit.schedule = request.schedule.toString()
        newHabit.amount = Int16(request.amount)
        newHabit.unitOfMeasure = request.unitOfMeasure.toString()
        newHabit.archived = false
        newHabit.id = UUID()
        saveData()
        
        return newHabit.id!
    }
    
    func GetHabit(id: UUID) -> Habit?{
        
        let habitEntity = GetHabitEntity(id: id)
        
        if let habitEntity{
            return Habit(from: habitEntity)
        }
        return nil
    }
    
    private func GetHabitEntity(id: UUID) -> HabitEntity?{
        let request = NSFetchRequest<HabitEntity>(entityName: "HabitEntity")
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.predicate = predicate
        
        do {
            let habitsEntityList = try container.viewContext.fetch(request)
            
            return habitsEntityList.first
            
        } catch let error {
            print ("ERROR FETCHING GOAL. \(error)")
        }
        return nil
    }
    
    func ListHabits(criteria: Criteria, limit: Int = 50) -> [Habit]{
        
        
        do {
            let request = NSFetchRequest<HabitEntity>(entityName: "HabitEntity")
            
            request.predicate = NSCompoundPredicate.PredicateBuilder(criteria: criteria, object:.habit)
            request.fetchLimit = limit
            
            let habitsEntityList = try container.viewContext.fetch(request)
            return habitsEntityList.map({Habit(from: $0)})
        } catch let error {
            print ("ERROR FETCHING TASK. \(error)")
        }
        return [Habit]()
    }
    
    func UpdateHabit(id: UUID, request: UpdateHabitRequest) -> Bool {
        
        if var entityToUpdate = GetHabitEntity(id: id) {
            
            entityToUpdate.title = request.title
            entityToUpdate.desc = request.description
            entityToUpdate.priority = request.priority.toString()
            entityToUpdate.aspect = request.aspect
            entityToUpdate.image = request.image
            entityToUpdate.archived = request.archived
            
            var criteria = Criteria()
            criteria.habitId = id
            
            let recurrences = self.ListRecurrences(criteria: criteria)
            recurrences.forEach({
                self.UpdateRecurrence(id: $0.id, request: UpdateRecurrenceRequest(amount: $0.amount, isComplete: $0.isComplete, archived: request.archived))
            })
            
            saveData()
            return true
        }
        
        return false
    }
    
    func DeleteHabit(id: UUID) -> Bool{
        var criteria = Criteria()
        criteria.habitId = id
        let recurrences = ListRecurrences(criteria: criteria)
        
        for recurrence in recurrences {
            _ = DeleteRecurrence(id: recurrence.id)
        }
        return DeleteHabitHelper(id: id)
    }
    
    func DeleteHabitHelper(id: UUID) -> Bool{
        if let habitToDelete = GetHabitEntity(id: id){
            
            container.viewContext.delete(habitToDelete)
            saveData()
            return true
        }
        return false
    }
    
    func GroupHabits(criteria: Criteria, grouping: GroupingType) -> [String : [Habit]] {
        
        let habits = ListHabits(criteria: criteria)
        var habitsDictionary: Dictionary<String,[Habit]> = [String:[Habit]]()
                
        for habit in habits {
            switch grouping {
                
            case .title:
                if  habitsDictionary[String(habit.title.prefix(1))] == nil {
                    habitsDictionary[String(habit.title.prefix(1))] = [Habit]()
                }
                habitsDictionary[String(habit.title.prefix(1))]!.append(habit)
            case .aspect:
                if  habitsDictionary[habit.aspect] == nil {
                    habitsDictionary[habit.aspect] = [Habit]()
                }
                habitsDictionary[habit.aspect]!.append(habit)
            case .priority:
                if  habitsDictionary[habit.priority.toString()] == nil {
                    habitsDictionary[habit.priority.toString()] = [Habit]()
                }
                habitsDictionary[habit.priority.toString()]!.append(habit)
            case .schedule:
                if  habitsDictionary[habit.schedule.toString()] == nil {
                    habitsDictionary[habit.schedule.toString()] = [Habit]()
                }
                habitsDictionary[habit.schedule.toString()]!.append(habit)
            default:
                let _ = "why"
            }
        }
        return habitsDictionary
    }
    
    // MARK: - RECURRENCES
    
    func CreateRecurrence(request: CreateRecurrenceRequest) -> UUID{
        
        let newRecurrence = RecurrenceEntity(context: container.viewContext)
        newRecurrence.habitId = request.habitId
        newRecurrence.isComplete = false
        newRecurrence.scheduleType = request.scheduleType.toString()
        newRecurrence.startDate = request.startDate
        newRecurrence.endDate = request.endDate
        newRecurrence.amount = 0
        newRecurrence.timeOfDay = request.timeOfDay.toString()
        newRecurrence.archived = false
        newRecurrence.id = UUID()
        
        
        saveData()
        
        return newRecurrence.id!
    }
    
    func GetRecurrence(id: UUID) -> Recurrence?{
        
        let recurrenceEntity = GetRecurrenceEntity(id: id)
        
        if let recurrenceEntity{
            return Recurrence(from: recurrenceEntity)
        }
        return nil
    }
    
    private func GetRecurrenceEntity(id: UUID) -> RecurrenceEntity?{
        let request = NSFetchRequest<RecurrenceEntity>(entityName: "RecurrenceEntity")
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.predicate = predicate
        
        do {
            let recurrencesEntityList = try container.viewContext.fetch(request)
            
            return recurrencesEntityList.first
            
        } catch let error {
            print ("ERROR FETCHING GOAL. \(error)")
        }
        return nil
    }
    
    func ListRecurrences(criteria: Criteria, limit: Int = 50) -> [Recurrence]{
        
        do {
            let request = NSFetchRequest<RecurrenceEntity>(entityName: "RecurrenceEntity")
            
            request.predicate = NSCompoundPredicate.PredicateBuilder(criteria: criteria, object:.recurrence)
            request.fetchLimit = limit
            
            let recurrencesEntityList = try container.viewContext.fetch(request)
            return recurrencesEntityList.map({Recurrence(from: $0)})
        } catch let error {
            print ("ERROR FETCHING TASK. \(error)")
        }
        return [Recurrence]()
    }
    
    func UpdateRecurrence(id: UUID, request: UpdateRecurrenceRequest) -> Bool {
        
        if var entityToUpdate = GetRecurrenceEntity(id: id) {
            
            entityToUpdate.isComplete = request.isComplete
            entityToUpdate.amount = Int16(request.amount < 1000 ? request.amount : 1000)
            entityToUpdate.archived = request.archived
            saveData()
            return true
        }
        
        return false
    }
    
    func DeleteRecurrence(id: UUID) -> Bool{
        if let recurrenceToDelete = GetRecurrenceEntity(id: id){
            
            container.viewContext.delete(recurrenceToDelete)
            saveData()
            return true
        }
        return false
    }
    
    func GroupRecurrences(criteria: Criteria, grouping: GroupingType) -> [String : [Recurrence]] {
        
        let recurrences = ListRecurrences(criteria: criteria)
        var recurrencesDictionary: Dictionary<String,[Recurrence]> = [String:[Recurrence]]()
                
//        for recurrence in recurrences {
//            switch grouping {
//
//            case .title:
//                if  recurrencesDictionary[String(recurrence.title.prefix(1))] == nil {
//                    recurrencesDictionary[String(recurrence.title.prefix(1))] = [Recurrence]()
//                }
//                recurrencesDictionary[String(recurrence.title.prefix(1))]!.append(recurrence)
//            case .aspect:
//                if  recurrencesDictionary[recurrence.aspect] == nil {
//                    recurrencesDictionary[recurrence.aspect] = [Recurrence]()
//                }
//                recurrencesDictionary[recurrence.aspect]!.append(recurrence)
//            case .priority:
//                if  recurrencesDictionary[recurrence.priority.toString()] == nil {
//                    recurrencesDictionary[recurrence.priority.toString()] = [Recurrence]()
//                }
//                recurrencesDictionary[recurrence.priority.toString()]!.append(recurrence)
//
//            default:
//                let _ = "why"
//            }
//        }
        return recurrencesDictionary
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
    
    // MARK: - ACTIVITY
    
    func CreateActivity(request: CreateActivityRequest) -> UUID{
        
        let newActivity = ActivityEntity(context: container.viewContext)
        let id = UUID()
        newActivity.id = id
        newActivity.keyword = request.keyword
        saveData()
        
        return id
    }
    
    func GetActivity(id: UUID) -> Activity?{
        
        let ActivityEntity = GetActivityEntity(id: id)
        
        if let ActivityEntity{
            return Activity(from: ActivityEntity)
        }
        return nil
    }
    
    private func GetActivityEntity(id: UUID) -> ActivityEntity?{
        let request = NSFetchRequest<ActivityEntity>(entityName: "ActivityEntity")
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.predicate = predicate
        
        do {
            let ActivitysEntityList = try container.viewContext.fetch(request)
            
            return ActivitysEntityList.first
            
        } catch let error {
            print ("ERROR FETCHING Activity. \(error)")
        }
        return nil
    }
    
    func ListActivities(limit: Int = 50) -> [Activity]{
        do {
            let request = NSFetchRequest<ActivityEntity>(entityName: "ActivityEntity")
            request.fetchLimit = limit
            
            let ActivitiesEntityList = try container.viewContext.fetch(request)
            return ActivitiesEntityList.map({Activity(from: $0)})
        } catch let error {
            print ("ERROR FETCHING Activity. \(error)")
        }
        return [Activity]()
    }
    
    func DeleteActivity(id: UUID) -> Bool{
        if let ActivityToDelete = GetActivityEntity(id: id){
            container.viewContext.delete(ActivityToDelete)
            saveData()
            return true
        }
        return false
    }
}
