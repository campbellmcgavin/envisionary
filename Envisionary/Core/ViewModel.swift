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
    
    // MARK: - GLOBAL STATE
    
    // DATES
    @Published var pushToToday = false
    
    // MARK: - Initializers
    init(fillData: Bool = false){
        
        if fillData {
            if ListTasks(criteria: Criteria()).count < 10 {
                for i in 1...1000 {
                    var task = Task(title: "Task" + String(i), description: "")
                    let randomDays = Int.random(in: -500...500)
                    let daySeconds = Double(randomDays * 60 * 60 * 24)
                    task.startDate = Date() + daySeconds
                    task.endDate = task.startDate
                    _ = self.CreateTask(request: CreateTaskRequest(properties: Properties(task: task)))
                }
            }

            if ListGoals(criteria: Criteria()).count < 50{
                for _ in 1...10{
                    for goal in Goal.sampleGoals{
                        _ = self.CreateGoal(request: CreateGoalRequest(properties: Properties(goal: goal)))
                    }
                }
            }

            
            if ListCoreValues(criteria: Criteria()).count < 4{
                
                for value in CoreValue.samples{
                    _ = CreateCoreValue(request: CreateCoreValueRequest(coreValue: value.coreValue, description: value.description))
                }
            }
            
            if ListDreams().count < 3 {
                for dream in Dream.samples{
                    _ = CreateDream(request: CreateDreamRequest(title: dream.title, description: dream.description, aspect: dream.aspect))
                }
            }
            
            if ListAspects().count < 5 {
                for aspect in Aspect.samples{
                    _ = CreateAspect(request: CreateAspectRequest(aspect: aspect.aspect, description: aspect.description))
                }
            }
            let promptList = ListPrompts()
            
            for prompt in promptList{
                DeletePrompt(id: prompt.id)
            }
            
            if ListPrompts(criteria: Criteria(type: .favorite)).count < 3{
                let goalList = ListGoals()
                
                for _ in 1...5 {
                    if let goal = goalList.randomElement(){
                        let request = CreatePromptRequest(type: .favorite, title: goal.title, date: Date(), objectType: .goal, objectId: goal.id)
                        _ = CreatePrompt(request: request)
                    }
                }
            }
            
            if ListPrompts(criteria: Criteria(type: .suggestion)).count < 3{
                let request1 = CreatePromptRequest(type: .suggestion, title: ObjectType.session.GetPromptTitle(), date: Date(), objectType: .session, timeframe: TimeframeType.allCases.filter({$0 != .day}).randomElement())
                _ = CreatePrompt(request: request1)
                
                let request2 = CreatePromptRequest(type: .suggestion, title: ObjectType.entry.GetPromptTitle(), date: Date(), objectType: .entry)
                _ = CreatePrompt(request: request2)
                
                let request3 = CreatePromptRequest(type: .suggestion, title: ObjectType.value.GetPromptTitle(), date: Date(), objectType: .value)
                _ = CreatePrompt(request: request3)
            }
        }
    }
    
    // MARK: - IMAGE
    
    func CreateImage(image: UIImage) -> UUID{
        ImagesDidChange()
        return dataService.CreateImage(image: image)
    }
    
    func GetImage(id: UUID) -> UIImage? {
        return dataService.GetImage(id: id)
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
    
    func DeleteGoal(id: UUID) -> Bool{
        GoalsDidChange()
        return dataService.DeleteGoal(id: id)
    }
    
    private func GoalsDidChange(){
        updates.goal.toggle() }

// MARK: - TASKS

    func CreateTask(request: CreateTaskRequest) -> UUID{
        TasksDidChange()
        return dataService.CreateTask(request: request)
    }

    func GetTask(id: UUID) -> Task?{
        TasksDidChange()
        return dataService.GetTask(id: id)
    }

    func ListTasks(criteria: Criteria = Criteria(), limit: Int = 50) -> [Task] {
        return dataService.ListTasks(criteria: criteria, limit: limit)
    }
    
    func GroupTasks(criteria: Criteria = Criteria(), grouping: GroupingType) -> [String : [Task]] {
        return dataService.GroupTasks(criteria: criteria, grouping: grouping)
    }
    
    func UpdateTask(id: UUID, request: UpdateTaskRequest) -> Bool {
        TasksDidChange()
        return dataService.UpdateTask(id: id, request: request)
    }

    func DeleteTask(id: UUID) -> Bool {
        TasksDidChange()
        return dataService.DeleteTask(id: id)
    }
    
    private func TasksDidChange(){ updates.task.toggle() }
    
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

    func ListCoreValues(criteria: Criteria = Criteria(), limit: Int = 50) -> [CoreValue]{
        let list = dataService.ListCoreValues(criteria: criteria, limit: limit)
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
}
