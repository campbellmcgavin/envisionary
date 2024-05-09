//
//  TutorialObjects.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/5/23.
//

import SwiftUI

struct TutorialArchetype: View {
    @Binding var canProceed: Bool
    @State var selectedGoals = [GoalKit]()
    @EnvironmentObject var vm: ViewModel
    
    @State var nextGoal = CreateGoalRequest(properties: Properties())
    @State var imageId: UUID? = nil
    @State var goalParentId: UUID? = nil
    var body: some View {
        
        SetupView()
            .onChange(of: selectedGoals){
                _ in
                
                if selectedGoals.count > 0 {
                    canProceed = true
                }
                else{
                    canProceed = false
                }
            }
            .onDisappear{
                _ = vm.WipeData()
                CreateObjects()
            }
    }
    
    func CreateObjects(){
            
            let requestIntro = CreateCoreValueRequest(title: ValueType.Introduction.toString(), description: ValueType.Introduction.toDescription(), image: nil)
            _ = vm.CreateCoreValue(request: requestIntro)
        
            let requestConclusion = CreateCoreValueRequest(title: ValueType.Conclusion.toString(), description: ValueType.Conclusion.toDescription(), image: nil)
            _ = vm.CreateCoreValue(request: requestConclusion)
    
        ValueType.GetDemoValues().forEach{
                let request = CreateCoreValueRequest(title: $0.toString(), description: $0.toDescription(), image: nil)
                _ = vm.CreateCoreValue(request: request)}
            
        AspectType.GetDemoValues().forEach{
                let request = CreateAspectRequest(title: $0.toString(), description: "", image: nil)
                _ = vm.CreateAspect(request: request)}
        
        selectedGoals.forEach({
            goalKit in
            
            _ = vm.CreateGoalKit(request: goalKit)
        })
            
        ChapterType.GetDemoValues().forEach{
                
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
    

    @ViewBuilder
    func SetupView() -> some View{
        LazyVStack{
            ForEach(GoalKits.kits, id:\.self){
                goalKit in
                
                PhotoCardSimpleButton(selectedGoals: $selectedGoals, goalKit: goalKit)
            }
        }
        .padding(8)
    }
}

struct TutorialArchetype_Previews: PreviewProvider {
    static var previews: some View {
        TutorialArchetype(canProceed: .constant(true))
    }
}


struct PhotoCardSimpleButton: View{
    @Binding var selectedGoals: [GoalKit]
    let goalKit: GoalKit
    var body: some View{

        let image = UIImage(named: goalKit.image.toImageString())
                
                Button{
                    if selectedGoals.contains(goalKit){
                        selectedGoals.removeAll(where: {$0 == goalKit})
                    }
                    else{
                        selectedGoals.append(goalKit)
                    }
                }
            label:{
                PhotoCardSimple(objectType: .goal, properties: GetProperties(goalKit: goalKit), image: image)
                    .padding(8)
                    .modifier(ModifierForm(color: selectedGoals.contains(goalKit) ? .purple : .grey2, radius: .cornerRadiusSmall))
            }

    }
    
    func GetProperties(goalKit: GoalKit) -> Properties{
        var properties = Properties()
        properties.title = goalKit.superItem.title
        
        return properties
    }
}



