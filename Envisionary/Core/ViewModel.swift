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
    @Published var convertDreamToGoalId: UUID? = nil
    
    var archetype: ArchetypeType = ArchetypeType.fromString(from: UserDefaults.standard.string(forKey: SettingsKeyType.archetype_type.toString()) ?? "")
    
    // MARK: - GLOBAL STATE
    
    // DATES
    @Published var pushToToday = false
    
    
    // MARK: - KEYS
    
    func UpdateSetupStep(){
        UserDefaults.standard.set(self.tutorialStep.toString(), forKey: SettingsKeyType.tutorial_step.toString())
    }
    
    func UpdateArchetype(archetype: ArchetypeType){
        self.archetype = archetype
        UserDefaults.standard.set(self.archetype.toString(), forKey: SettingsKeyType.archetype_type.toString())
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
        
    func ListChildGoals(id: UUID) -> [Goal]{
        
        return dataService.ListChildGoals(id: id)
    }
    
    func ListAffectedGoals(id: UUID) -> [Goal]{
        
        return dataService.ListAffectedGoals(id: id)
    }
    
    func GroupGoals(criteria: Criteria = Criteria(), grouping: GroupingType) -> [String:[Goal]]{
                
        return dataService.GroupGoals(criteria: criteria, grouping: grouping)
    }
    
    func UpdateGoal(id: UUID, request: UpdateGoalRequest) -> Bool {
        GoalsDidChange()
        return dataService.UpdateGoal(id: id, request: request)
    }
    
    func UpdateGoalProgress(id: UUID, progress: Int) -> Bool{
        
        // update the status of the goal in question and all sub goals.
        
        let affectedGoals = ListAffectedGoals(id: id)
        for goal in affectedGoals{
            var request = UpdateGoalRequest(goal: goal)
            request.progress = progress
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
                    _ = dataService.UpdateGoal(id: parentIdLocal, request: UpdateGoalRequest(goal: goal))
                    parentId = goal.parentId
                }
            }
        }
        
        GoalsDidChange()
        return true
    }
    
    func DeleteGoal(id: UUID) -> Bool{
        GoalsDidChange()
        return dataService.DeleteGoal(id: id)
    }
    
    private func GoalsDidChange(){
        updates.goal.toggle() }

// MARK: - TASKS

//    func CreateTask(request: CreateTaskRequest) -> UUID{
//        TasksDidChange()
//        return dataService.CreateTask(request: request)
//    }
//
//    func GetTask(id: UUID) -> Task?{
//        TasksDidChange()
//        return dataService.GetTask(id: id)
//    }
//
//    func ListTasks(criteria: Criteria = Criteria(), limit: Int = 50) -> [Task] {
//        return dataService.ListTasks(criteria: criteria, limit: limit)
//    }
//
//    func GroupTasks(criteria: Criteria = Criteria(), grouping: GroupingType) -> [String : [Task]] {
//        return dataService.GroupTasks(criteria: criteria, grouping: grouping)
//    }
//
//    func UpdateTask(id: UUID, request: UpdateTaskRequest) -> Bool {
//        TasksDidChange()
//        return dataService.UpdateTask(id: id, request: request)
//    }
//
//    func DeleteTask(id: UUID) -> Bool {
//        TasksDidChange()
//        return dataService.DeleteTask(id: id)
//    }
//
//    private func TasksDidChange(){ updates.task.toggle() }
    // MARK: - OBJECT WIDE OPERATIONS
    func WipeDate() -> Bool{
        
        let values = ListCoreValues()
        values.forEach({
            _ = DeleteCoreValue(id: $0.id)
        })
        
        let dreams = ListDreams()
        dreams.forEach({
            _ = DeleteDream(id: $0.id)
        })
        
        let aspects = ListAspects()
        aspects.forEach({
            _ = DeleteAspect(id: $0.id)
        })
        
        let habits = ListHabits()
        habits.forEach({
            _ = DeleteHabit(id: $0.id)
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
        
        let prompts = ListPrompts()
        prompts.forEach({
            _ = DeletePrompt(id: $0.id)
        })
        
        return true
    }
    
    func CheckDataModelHasContent() -> Bool{
        
        if ListCoreValues().count > 0 || ListDreams().count > 0 || ListAspects().count > 0 || ListGoals().count > 0 || ListHabits().count > 0 || ListChapters().count > 0 || ListEntries().count > 0 {
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
    
    
// MARK: - DREAM

    func CreateDream(request: CreateDreamRequest) -> UUID{
        DreamsDidChange()
        return dataService.CreateDream(request: request)
    }

    func GetDream(id: UUID) -> Dream?{
        return dataService.GetDream(id: id)
    }

    func ListDreams(criteria: Criteria = Criteria(), limit: Int = 50) -> [Dream] {
        return dataService.ListDreams(criteria: criteria)
    }
    
    func GroupDreams(criteria: Criteria = Criteria(), grouping: GroupingType) -> [String : [Dream]] {
        return dataService.GroupDreams(criteria: criteria, grouping: grouping)
    }
    
    func UpdateDream(id: UUID, request: UpdateDreamRequest) -> Bool {
        DreamsDidChange()
        return dataService.UpdateDream(id: id, request: request)
    }

    func DeleteDream(id: UUID) -> Bool {
        DreamsDidChange()
        return dataService.DeleteDream(id: id)
    }
    
    private func DreamsDidChange(){ updates.dream.toggle() }
    
    
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
    
// MARK: - SESSION

    func CreateSession(request: CreateSessionRequest) -> UUID{
        SessionsDidChange()
        return dataService.CreateSession(request: request)
    }

    func GetSession(id: UUID) -> Session?{
        return dataService.GetSession(id: id)
    }

    func ListSessions(criteria: Criteria = Criteria(), limit: Int = 50) -> [Session] {
        return dataService.ListSessions(criteria: criteria)
    }

    func DeleteSession(id: UUID) -> Bool {
        SessionsDidChange()
        return dataService.DeleteSession(id: id)
    }
    
    private func SessionsDidChange(){ updates.session.toggle() }
    
// MARK: - PROMPT

    func CreatePrompt(request: CreatePromptRequest) -> UUID{
        PromptsDidChange()
        return dataService.CreatePrompt(request: request)
    }

    func GetPrompt(id: UUID) -> Prompt?{
        return dataService.GetPrompt(id: id)
    }

    func ListPrompts(criteria: Criteria = Criteria(), limit: Int = 50) -> [Prompt] {
        return dataService.ListPrompts(criteria: criteria)
    }

    func DeletePrompt(id: UUID) -> Bool {
        PromptsDidChange()
        return dataService.DeletePrompt(id: id)
    }
    
    private func PromptsDidChange(){ updates.prompt.toggle() }

    // MARK: - HABITS
    
    func CreateHabit(request: CreateHabitRequest) -> UUID{
        HabitsDidChange()
        return dataService.CreateHabit(request: request)
    }
    
    func GetHabit(id: UUID) -> Habit?{
        
        return dataService.GetHabit(id: id)
    }
    
    func ListHabits(criteria: Criteria = Criteria(), limit: Int = 50) -> [Habit] {
        
        return dataService.ListHabits(criteria: criteria, limit: limit)
    }
    
    func GroupHabits(criteria: Criteria = Criteria(), grouping: GroupingType) -> [String:[Habit]]{
                
        return dataService.GroupHabits(criteria: criteria, grouping: grouping)
    }
    
    func UpdateHabit(id: UUID, request: UpdateHabitRequest) -> Bool {
        HabitsDidChange()
        return dataService.UpdateHabit(id: id, request: request)
    }
    
    func DeleteHabit(id: UUID) -> Bool{
        HabitsDidChange()
        return dataService.DeleteHabit(id: id)
    }
    
    private func HabitsDidChange(){
        updates.habit.toggle() }
    
    // MARK: - RECURRENCE
    
    func CreateRecurrence(request: CreateRecurrenceRequest) -> UUID{
        
        let response = dataService.CreateRecurrence(request: request)
        RecurrencesDidChange()
        return response
    }
    
    func GetRecurrence(id: UUID) -> Recurrence?{
        
        return dataService.GetRecurrence(id: id)
    }
    
    func ListRecurrences(criteria: Criteria = Criteria(), limit: Int = 50) -> [Recurrence] {
        
        return dataService.ListRecurrences(criteria: criteria, limit: limit)
    }
    
    func GroupRecurrences(criteria: Criteria = Criteria(), grouping: GroupingType) -> [String:[Recurrence]]{
                
        return dataService.GroupRecurrences(criteria: criteria, grouping: grouping)
    }
    
    func UpdateRecurrence(id: UUID, request: UpdateRecurrenceRequest) -> Bool {
        let response = dataService.UpdateRecurrence(id: id, request: request)
        RecurrencesDidChange()
        return response
    }
    
    func DeleteRecurrence(id: UUID) -> Bool{
        RecurrencesDidChange()
        return dataService.DeleteRecurrence(id: id)
    }
    
    private func RecurrencesDidChange(){
        updates.recurrence.toggle() }
    
    // MARK: - EMOTION

        func CreateEmotion(request: CreateEmotionRequest) -> UUID{
            EmotionsDidChange()
            return dataService.CreateEmotion(request: request)
        }

        func GetEmotion(id: UUID) -> Emotion?{
            return dataService.GetEmotion(id: id)
        }

        func ListEmotions(criteria: Criteria = Criteria(), limit: Int = 50) -> [Emotion] {
            return dataService.ListEmotions(criteria: criteria)
        }

        func DeleteEmotion(id: UUID) -> Bool {
            EmotionsDidChange()
            return dataService.DeleteEmotion(id: id)
        }
    func GroupEmotions(criteria: Criteria = Criteria()) -> [String:[Emotion]]{
        return dataService.GroupEmotions(criteria: criteria)
    }
        
        private func EmotionsDidChange(){ updates.emotion.toggle() }
    
    // MARK: - ACTIVITY

    func CreateActivity(request: CreateActivityRequest) -> UUID{
        ActivitiesDidChange()
        return dataService.CreateActivity(request: request)
    }

    func GetActivity(id: UUID) -> Activity?{
        return dataService.GetActivity(id: id)
    }

    func ListActivities(limit: Int = 50) -> [Activity] {
        return dataService.ListActivities(limit: limit)
    }

    func DeleteActivity(id: UUID) -> Bool {
        ActivitiesDidChange()
        return dataService.DeleteActivity(id: id)
    }
    
    private func ActivitiesDidChange(){ updates.activity.toggle() }
}
