import Foundation
import SwiftUI
import CoreData

class ViewModel: ObservableObject, DataServiceProtocol
{
    // MARK: - DATA SERVICE
    private let dataService = DataService()
    
    // MARK: - GROUPING, FILTERING, UPDATES
    @Published var grouping = ObjectGrouping()
    @Published var filtering = ObjectFiltering()
    @Published var updates = ObjectUpdates()
    @Published var triggers = InterfaceTriggers()
    @Published var tutorialStep: SetupStepType = SetupStepType.fromString(from: UserDefaults.standard.string(forKey: SettingsKeyType.tutorial_step.toString()) ?? "")
    @Published var unlockedObjects = UnlockedObjects()
    @Published var helpPrompts = HelpPrompts()
    @Published var notifications = NotificationPreferences()
    @Published var convertDreamToGoalId: UUID? = nil
    @Published var goalToolboxView: ViewType = .tree
    var archetype: ArchetypeType = ArchetypeType.fromString(from: UserDefaults.standard.string(forKey: SettingsKeyType.archetype_type.toString()) ?? "")
    
    // MARK: - GLOBAL STATE
    
    // DATES
    @Published var pushToToday = false
    
    // MARK: - CLEANUP
    func CleanupDuplicates() {
        dataService.CleanupDuplicates()
    }
    
    // MARK: - KEYS
    
    func UpdateSetupStep(){
        UserDefaults.standard.set(self.tutorialStep.toString(), forKey: SettingsKeyType.tutorial_step.toString())
    }
    
    func UpdateArchetype(archetype: ArchetypeType){
        self.archetype = archetype
        UserDefaults.standard.set(self.archetype.toString(), forKey: SettingsKeyType.archetype_type.toString())
    }
    
    // MARK: - PROGRESS POINT
    func CreateProgressPoint(request: CreateProgressPointRequest) -> UUID {
        return dataService.CreateProgressPoint(request: request)
    }
    
    func ListProgressPoints(parentId: UUID) -> [ProgressPoint] {
        return dataService.ListProgressPoints(parentId: parentId)
    }
    
    // MARK: - IMAGE
    
    func CreateImage(image: UIImage) -> UUID{
        ImagesDidChange()
        return dataService.CreateImage(image: image)
    }
    
    func GetImage(id: UUID, newContext: Bool = true) -> UIImage? {
        return dataService.GetImage(id: id, newContext: newContext)
    }
    
    func DeleteImage(id: UUID) -> Bool {
        ImagesDidChange()
        return dataService.DeleteImage(id: id)
    }
    
    private func ImagesDidChange(){ updates.image.toggle() }
    
    // MARK: - GOALS
    func CreateGoalKit(request: GoalKit, startDate: Date = Date()) -> UUID {
        return dataService.CreateGoalKit(request: request, startDate: startDate)
    }
    
    func CreateGoal(request: CreateGoalRequest, silenceUpdates: Bool) -> UUID{
        if !silenceUpdates{
            GoalsDidChange()
        }
        return dataService.CreateGoal(request: request)
    }
    
    func CreateGoal(request: CreateGoalRequest) -> UUID{
        GoalsDidChange()
        return dataService.CreateGoal(request: request)
    }
    
    func GetGoal(id: UUID) -> Goal?{
        
        return dataService.GetGoal(id: id)
    }
    
    func ListGoals(criteria: Criteria = Criteria(), limit: Int = 50) -> [Goal] {
        
        return dataService.ListGoals(criteria: criteria, limit: limit)
    }
    
    func ListParentGoals(id: UUID) -> [Goal] {
        
        return dataService.ListParentGoals(id: id)
    }
    
    func ListChildGoals(id: UUID) -> [Goal]{
        
        return dataService.ListChildGoals(id: id)
    }
    
    func ListAffectedGoals(id: UUID) -> [Goal]{
        
        return dataService.ListAffectedGoals(id: id)
    }
    
    func ComputeGoalPosition(parentId: UUID, siblingAbove: UUID?) -> String {
        return dataService.ComputeGoalPosition(parentId: parentId, siblingAbove: siblingAbove)
    }
    
    func GroupGoals(criteria: Criteria = Criteria(), grouping: GroupingType) -> [String:[Goal]]{
        
        return dataService.GroupGoals(criteria: criteria, grouping: grouping)
    }
    
    func UpdateGoals(requestDictionary: [UUID: UpdateGoalRequest], updatePositionPreviousId: UUID? = nil) -> Bool {
        
        requestDictionary.forEach({ id, request in
            _ = dataService.UpdateGoal(id: id, request: request)
        })
        
        GoalsDidChange()
        
        return true
    }
    
    func UpdateGoalFromDragAndDrop(focusId: UUID?, selectedId: UUID?, selectedPlacement: PlacementType?, shouldOutdent: Bool = false){
        if let goalIdToUpdate = focusId{
            if let goal = GetGoal(id: goalIdToUpdate){
                var request = UpdateGoalRequest(goal: goal)
                
                
                
                if let placement = selectedPlacement {
                    if let reorderGoalId = selectedId{
                        
                        if shouldOutdent{
                            let childGoals = ListChildGoals(id: goal.parentId ?? UUID())
                            
                            if let focusGoalIndex = childGoals.firstIndex(of: goal){
                                if focusGoalIndex + 1 <= childGoals.count - 1 {
                                    for index in focusGoalIndex + 1...childGoals.count - 1{
                                        let childGoal = childGoals[index]
                                        var childRequest = UpdateGoalRequest(goal: childGoal)
                                        childRequest.parent = goal.id
                                        _ = UpdateGoal(id: childGoal.id, request: childRequest, notify: false)
                                    }
                                }
                            }
                        }
                        
                        request.reorderPlacement = placement
                        request.reorderGoalId = reorderGoalId
                        _ = UpdateGoal(id: goal.id, request: request, notify: false)
                        
                        GoalsDidChange()
                    }
                }
            }
        }
    }
    
    func UpdateGoal(id: UUID, request: UpdateGoalRequest) -> Bool {
        let returnVal = dataService.UpdateGoal(id: id, request: request)
        GoalsDidChange()
        return returnVal
    }
    
    func UpdateGoal(id: UUID, request: UpdateGoalRequest, notify: Bool = true) -> Bool {
        let returnVal = dataService.UpdateGoal(id: id, request: request)
        
        if notify{
            GoalsDidChange()
        }
        return returnVal
    }
    
    func ArchiveGoal(id: UUID, shouldArchive: Bool) -> Bool {
        
        if let parentGoal = self.GetParentGoal(id: id){
            let affectedGoals = self.ListAffectedGoals(id: parentGoal.id)
            
            var affectedGoalsDictionary = [UUID:UpdateGoalRequest]()
            affectedGoals.forEach({
                var request = UpdateGoalRequest(goal: $0)
                request.archived = shouldArchive
                
                affectedGoalsDictionary[$0.id] = request
            })
            
            let returnVal = UpdateGoals(requestDictionary: affectedGoalsDictionary)
            return returnVal
        }
        return false
    }
    
    func UpdateGoalProgress(id: UUID, progress: Int) -> Bool{
        
        // update the status of the goal in question and all sub goals.
        
        let affectedGoals = ListAffectedGoals(id: id)
        for goal in affectedGoals{
            var request = UpdateGoalRequest(goal: goal)
            request.progress = progress
            request.completedDate = progress >= 100 ? Date() : nil
            _ = dataService.UpdateGoal(id: goal.id, request: request)
        }
        
        // update the goals above it.
        
        var parentId: UUID? = GetGoal(id: id)?.parentId
        
        while parentId != nil {
            if let parentIdLocal = parentId{
                if var goal = GetGoal(id: parentIdLocal){
                    let childGoals = ListChildGoals(id: parentIdLocal)
                    let progressNumerator = Double(childGoals.map({$0.progress}).reduce(0,+))
                    let progressDenominator = Double(childGoals.count <= 0 ? 1 : childGoals.count)
                    let progress = Int(progressNumerator/progressDenominator)
                    goal.progress = progress
                    goal.completedDate = progress >= 100 ? Date() : nil
                    _ = dataService.UpdateGoal(id: parentIdLocal, request: UpdateGoalRequest(goal: goal))
                    parentId = goal.parentId
                }
            }
        }
        let goalInQuestion = dataService.GetGoal(id: id)
        
        if let goalInQuestion{
            let parentId = goalInQuestion.superId ?? goalInQuestion.id
            _ = UpdateGoalProgressPoint(id: parentId)
        }
        
        GoalsDidChange()
        return true
    }
    
    func UpdateGoalProgressPoint(id: UUID) -> UUID{
        var childGoalCount = dataService.ListAffectedGoals(id: id).count
        var goal = dataService.GetGoal(id: id)
        var request = CreateProgressPointRequest(parentId: id, date: Date(), amount: childGoalCount, progress: goal?.progress ?? 0)
        return self.CreateProgressPoint(request: request)
    }
    
    func ListGoalDescendency(id: UUID) -> [Goal]{
        var descendency = [Goal]()
        var parentGoal = dataService.GetGoal(id: id)
        
        if let parentGoal {
            descendency.append(parentGoal)
        }
        while parentGoal != nil {
            if let parentId = parentGoal?.parentId{
                parentGoal = dataService.GetGoal(id: parentId)
                
                if let parentGoal{
                    descendency.append(parentGoal)
                }
            }
            else{
                return descendency
            }
        }
        return descendency
    }
    
    func GetParentGoal(id: UUID) -> Goal?{
        var parentGoal = dataService.GetGoal(id: id)
        
        while parentGoal?.parentId != nil {
            if let parentId = parentGoal?.parentId{
                parentGoal = dataService.GetGoal(id: parentId)
            }
            else{
                return nil
            }
        }
        return parentGoal
    }
    
    func DeleteGoal(id: UUID) -> Bool{
        let didDelete = dataService.DeleteGoal(id: id)
        
        GoalsDidChange()
        return didDelete
    }
    
    func GoalsDidChange(){
        updates.goal.toggle()
    }
    
    // MARK: - OBJECT WIDE OPERATIONS
    func WipeData() -> Bool{
        
        let values = ListCoreValues()
        values.forEach({
            _ = DeleteCoreValue(id: $0.id)
        })
        
        let aspects = ListAspects()
        aspects.forEach({
            _ = DeleteAspect(id: $0.id)
        })
        
        let goals = ListGoals()
        goals.forEach({
            _ = DeleteGoal(id: $0.id)
        })
        
        let chapters = ListChapters()
        chapters.forEach({
            _ = DeleteChapter(id: $0.id)
        })
        
        let entries = ListEntries()
        entries.forEach({
            _ = DeleteEntry(id: $0.id)
        })
        
        return true
    }
    
    func CheckDataModelHasContent() -> Bool{
        
        if ListCoreValues().count > 0 || ListAspects().count > 0 || ListGoals().count > 0 || ListChapters().count > 0 || ListEntries().count > 0 {
            return true
        }
        
        return false
    }
    
    // MARK: - ASPECTS
    
    func CreateAspect(request: CreateAspectRequest) -> UUID{
        AspectsDidChange()
        return dataService.CreateAspect(request: request)
    }
    
    func GetAspect(id: UUID) -> Aspect?{
        return dataService.GetAspect(id: id)
    }
    
    func ListAspects(criteria: Criteria = Criteria(), limit: Int = 50) -> [Aspect]{
        return dataService.ListAspects(criteria: criteria, limit: limit)
    }
    
    func UpdateAspect(id: UUID, request: UpdateAspectRequest) -> Bool {
        AspectsDidChange()
        
        return dataService.UpdateAspect(id: id, request: request)
    }
    
    func DeleteAspect(id: UUID) -> Bool {
        AspectsDidChange()
        return dataService.DeleteAspect(id: id)
    }
    
    private func AspectsDidChange(){ updates.aspect.toggle() }
    
    
    // MARK: - CORE VALUE
    
    func CreateCoreValue(request: CreateCoreValueRequest) -> UUID{
        CoreValuesDidChange()
        return dataService.CreateCoreValue(request: request)
    }
    
    func GetCoreValue(id: UUID) -> CoreValue?{
        return dataService.GetCoreValue(id: id)
    }
    
    func GetCoreValue(coreValue: ValueType) -> CoreValue?{
        return dataService.GetCoreValue(coreValue: coreValue)
    }
    
    func ListCoreValues(criteria: Criteria = Criteria(), limit: Int = 50, filterIntroConc: Bool = true) -> [CoreValue]{
        let list = dataService.ListCoreValues(criteria: criteria, limit: limit, filterIntroConc: filterIntroConc)
        return list
    }
    func UpdateCoreValue(id: UUID, request: UpdateCoreValueRequest) -> Bool {
        CoreValuesDidChange()
        return dataService.UpdateCoreValue(id: id, request: request)
    }
    
    func DeleteCoreValue(id: UUID) -> Bool {
        CoreValuesDidChange()
        return dataService.DeleteCoreValue(id: id)
    }
    
    private func CoreValuesDidChange(){ updates.value.toggle() }
    
    // MARK: - CHAPTER
    
    func CreateChapter(request: CreateChapterRequest) -> UUID{
        ChaptersDidChange()
        return dataService.CreateChapter(request: request)
    }
    
    func GetChapter(id: UUID) -> Chapter?{
        return dataService.GetChapter(id: id)
    }
    
    func ListChapters(criteria: Criteria = Criteria(), limit: Int = 50) -> [Chapter] {
        return dataService.ListChapters(criteria: criteria)
    }
    
    func GroupChapters(criteria: Criteria = Criteria(), grouping: GroupingType) -> [String : [Chapter]] {
        return dataService.GroupChapters(criteria: criteria, grouping: grouping)
    }
    
    func UpdateChapter(id: UUID, request: UpdateChapterRequest) -> Bool {
        ChaptersDidChange()
        return dataService.UpdateChapter(id: id, request: request)
    }
    
    func DeleteChapter(id: UUID) -> Bool {
        ChaptersDidChange()
        return dataService.DeleteChapter(id: id)
    }
    
    private func ChaptersDidChange(){ updates.chapter.toggle() }
    
    // MARK: - Entry
    
    func CreateEntry(request: CreateEntryRequest) -> UUID{
        EntriesDidChange()
        return dataService.CreateEntry(request: request)
    }
    
    func GetEntry(id: UUID) -> Entry?{
        return dataService.GetEntry(id: id)
    }
    
    func ListEntries(criteria: Criteria = Criteria(), limit: Int = 50) -> [Entry] {
        return dataService.ListEntries(criteria: criteria)
    }
    
    func GroupEntries(criteria: Criteria = Criteria(), grouping: GroupingType) -> [String : [Entry]] {
        return dataService.GroupEntries(criteria: criteria, grouping: grouping)
    }
    
    func UpdateEntry(id: UUID, request: UpdateEntryRequest) -> Bool {
        EntriesDidChange()
        return dataService.UpdateEntry(id: id, request: request)
    }
    
    func DeleteEntry(id: UUID) -> Bool {
        EntriesDidChange()
        return dataService.DeleteEntry(id: id)
    }
    
    private func EntriesDidChange(){ updates.entry.toggle() }
    

    // MARK: - NOTIFICATIONS
    func CreateNotifications() -> Bool{
        UNUserNotificationCenter.current().removeAllDeliveredNotifications() // For removing all delivered notification
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests() // For removing all pending notifications which are not delivered yet but scheduled.
        
        if notifications.digest{
            let content = UNMutableNotificationContent()
            content.title = PromptType.digest.toString()
            content.body = PromptType.digest.toDescription()
            content.sound = UNNotificationSound.default
            content.badge = 1

            var dateComponents = DateComponents()
            dateComponents.hour = 9
            dateComponents.minute = 0
            // show this notification five seconds from now
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

            // choose a random identifier
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            // add our notification request
            UNUserNotificationCenter.current().add(request)
        }

        if (notifications.entry){
            let content = UNMutableNotificationContent()
            content.title = PromptType.entry.toString()
            content.body = PromptType.entry.toDescription()
            content.sound = UNNotificationSound.default
            content.badge = 1

            var dateComponents = DateComponents()
            dateComponents.hour = 21
            dateComponents.minute = 0
            // show this notification five seconds from now
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

            // choose a random identifier
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            // add our notification request
            UNUserNotificationCenter.current().add(request)
        }

        if notifications.valueAlignment{
            let content = UNMutableNotificationContent()
            content.title = PromptType.valueAlignment.toString()
            content.body = PromptType.valueAlignment.toDescription()
            content.sound = UNNotificationSound.default
            content.badge = 1
            
            var dateComponents = DateComponents()
            dateComponents.hour = 20
            dateComponents.minute = 0
            dateComponents.weekday = 1
            // show this notification five seconds from now
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

            // choose a random identifier
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            // add our notification request
            UNUserNotificationCenter.current().add(request)
        }
        
        return true
    }
    
    // MARK: - CORE VALUE RATING
    
    func CreateCoreValueRating(request: CreateCoreValueRatingRequest) -> UUID{
        CoreValueRatingDidChange()
        return dataService.CreateCoreValueRating(request: request)
    }
    
    func GetCoreValueRating(id: UUID) -> CoreValueRating?{
        return dataService.GetCoreValueRating(id: id)
    }
    
    func ListCoreValueRatings(criteria: Criteria = Criteria(), limit: Int = 50) -> [CoreValueRating] {
        return dataService.ListCoreValueRatings(criteria: criteria, limit: limit)
    }
    
    func UpdateCoreValueRating(id: UUID, request: UpdateCoreValueRatingRequest) -> Bool {
        CoreValueRatingDidChange()
        return dataService.UpdateCoreValueRating(id: id, request: request)
    }
    
    func DeleteCoreValueRating(id: UUID) -> Bool {
        CoreValueRatingDidChange()
        return dataService.DeleteCoreValueRating(id: id)
    }
    
    private func CoreValueRatingDidChange(){ updates.valueRating.toggle() }
}
