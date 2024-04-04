//
//  TutorialObjects.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/5/23.
//

import SwiftUI

struct TutorialArchetype: View {
    @Binding var canProceed: Bool
    @Binding var selectedArchetype: ArchetypeType?
    @State var goalsAdded: [ExampleGoalEnum: UUID] = [ExampleGoalEnum: UUID]()
    @EnvironmentObject var vm: ViewModel
    
    @State var nextGoal = CreateGoalRequest(properties: Properties())
    @State var imageId: UUID? = nil
    @State var nextGoalStep = ExampleGoalEnum.decade
    @State var goalParentId: UUID? = nil
    var body: some View {
        
        SetupView()
            .onChange(of: selectedArchetype){
                _ in
                canProceed = true
            }
            .onDisappear{
                _ = vm.WipeDate()
                vm.UpdateArchetype(archetype: selectedArchetype ?? .Achiever)
                CreateObjects()
            }
    }
    
    func CreateObjects(){
        if let selectedArchetype{
            
            let requestIntro = CreateCoreValueRequest(title: ValueType.Introduction.toString(), description: ValueType.Introduction.toDescription(), image: nil)
            _ = vm.CreateCoreValue(request: requestIntro)
        
            let requestConclusion = CreateCoreValueRequest(title: ValueType.Conclusion.toString(), description: ValueType.Conclusion.toDescription(), image: nil)
            _ = vm.CreateCoreValue(request: requestConclusion)
    
            ValueType.allCases.filter({selectedArchetype.hasValue(value: $0)}).forEach{
                let request = CreateCoreValueRequest(title: $0.toString(), description: $0.toDescription(), image: nil)
                _ = vm.CreateCoreValue(request: request)}
            
            DreamType.allCases.filter({selectedArchetype.hasDream(dream: $0)}).forEach{
                let request = CreateDreamRequest(title: $0.toString(), description: "", aspect: $0.toAspect(), image: nil)
                _ = vm.CreateDream(request: request)}
            
            AspectType.allCases.filter({selectedArchetype.hasAspect(aspect: $0)}).forEach{
                let request = CreateAspectRequest(title: $0.toString(), description: "", image: nil)
                _ = vm.CreateAspect(request: request)}
            
            HabitType.allCases.filter({selectedArchetype.hasHabit(habit: $0)}).forEach{
                
                var request = $0.toRequest()
                var localImageId: UUID? = nil
                
                if let image = UIImage(named: $0.toImageString()){
                    localImageId = vm.CreateImage(image: image)
                }
                
                request.image = localImageId
                
                _ = vm.CreateHabit(request: request)
            }
            
            if let image = UIImage(named: selectedArchetype.toImageString()){
                imageId = vm.CreateImage(image: image)
            }
            
            
            var firstPass = true
            
            ExampleGoalEnum.allCases.sorted(by: {$0.rawValue < $1.rawValue}).forEach{
                
                let parentId: UUID? = goalsAdded[$0.toParent()]
                var request = $0.toGoal(parentId: parentId, superId: goalParentId, imageId: imageId, archetype: selectedArchetype)
                
                
                goalsAdded[$0] = vm.CreateGoal(request: request)
                
                if firstPass{
                    self.goalParentId = goalsAdded[$0]
                    firstPass = false
                }
            }
            
            if let goalParentId{
                let promptRequest = CreatePromptRequest(type: .favorite, title: "", description: "", date: Date(), objectType: .goal, objectId: goalParentId)
                _ = vm.CreatePrompt(request: promptRequest)
            }
            
            let values = vm.ListCoreValues()
            
            if values.count > 0{
                let value = values.first!
                let promptRequest = CreatePromptRequest(type: .favorite, title: "", description: "", date: Date(), objectType: .value, objectId: value.id)
                _ = vm.CreatePrompt(request: promptRequest)
            }
            
            ChapterType.allCases.filter({selectedArchetype.hasChapter(chapter: $0)}).forEach{
                
                var request = $0.toRequest()
                var localImageId: UUID? = nil
                
                if let image = UIImage(named: $0.toImageString()){
                    localImageId = vm.CreateImage(image: image)
                }
                
                request.image = localImageId
                
                _ = vm.CreateChapter(request: request)
            }
            
            let chapterId = vm.ListChapters().first?.id ?? UUID()
            
            let entryRequest = CreateEntryRequest(title: "A day to remember!", description: "Today is the day I downloaded Envisionary! I was able to learn some impressive tools that I am going to put into practice. I'm really excited because this is all going to contribute to me becoming the beautiful person that I know I can become.", startDate: Date(), chapterId: chapterId, images: [UUID]())
            
            _ = vm.CreateEntry(request: entryRequest)
        }
    }
    
    @ViewBuilder
    func SetupView() -> some View{
        VStack{
            ForEach(ArchetypeType.allCases.sorted(by: {$0.toString() < $1.toString()}), id:\.self){
                archetype in
                ArchetypeCard(selectedArchetype: $selectedArchetype, archetype: archetype)
                
                if archetype != ArchetypeType.allCases.last!{
                    StackDivider(color: .grey3)
                }
            }
        }
        .padding(8)
    }
}

struct TutorialArchetype_Previews: PreviewProvider {
    static var previews: some View {
        TutorialArchetype(canProceed: .constant(true), selectedArchetype: .constant(nil))
    }
}



