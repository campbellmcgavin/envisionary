//
//  PromptCard.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/15/23.
//

import SwiftUI

struct PromptCard: View {
    let promptProperties: Properties
    @State var properties: Properties = Properties()
    @State var shouldRemove: Bool = false
    @State var shouldJump: Bool = false
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        VStack(alignment:.leading){
            BuildCard()
        }
        .frame(alignment:.leading)
        .frame(maxWidth:.infinity)
        .onAppear(){
            if promptProperties.promptType == .favorite{
                LoadProperties()
            }
        }

        .modifier(ModifierCard())
        .onChange(of: shouldRemove){
            _ in
            withAnimation{
                _ = vm.DeletePrompt(id: promptProperties.id)
            }
        }
        .onChange(of: shouldJump){
            _ in
            withAnimation{
                JumpToTarget()
            }
        }
    }
    
    func JumpToTarget(){
        
        if let promptObjectType = promptProperties.objectType{
            vm.filtering.filterContent = promptObjectType.toContentType()
            vm.filtering.filterObject = promptObjectType
            if promptObjectType == .session || promptObjectType == .entry {
                vm.triggers.shouldPresentModal.toggle()
            }
            if promptObjectType == .session{
                if let timeframe = promptProperties.timeframe {
                    vm.filtering.filterTimeframe = timeframe
                    vm.filtering.filterDate = Date().GetSessionDate(timeframe: timeframe)
                }
            }
        }
        _ = vm.DeletePrompt(id: promptProperties.id)
    }
    
    func LoadProperties(){
        if let objectId = promptProperties.objectId{
            switch promptProperties.objectType {
            case .value:
                let object = vm.GetCoreValue(id: objectId)
                if object != nil{
                    properties = Properties(value: object)
                }
                else{
                    _ = vm.DeletePrompt(id: promptProperties.id)
                }

            case .dream:
                let object = vm.GetDream(id: objectId)
                if object != nil{
                    properties = Properties(dream: object)
                }
                else{
                    _ = vm.DeletePrompt(id: promptProperties.id)
                }
            case .aspect:
                let object = vm.GetAspect(id: objectId)
                if object != nil{
                    properties = Properties(aspect: object)
                }
                else{
                    _ = vm.DeletePrompt(id: promptProperties.id)
                }
            case .goal:
                let object = vm.GetGoal(id: objectId)
                if object != nil{
                    properties = Properties(goal: object)
                }
                else{
                    _ = vm.DeletePrompt(id: promptProperties.id)
                }
            case .session:
                let object = vm.GetSession(id: objectId)
                if object != nil{
                    properties = Properties(session: object)
                }
                else{
                    _ = vm.DeletePrompt(id: promptProperties.id)
                }
            case .creed:
                properties = Properties(creed: true, valueCount: vm.ListCoreValues().count)
//            case .task:
//                properties = Properties(task: vm.GetTask(id: objectId) ?? Task())
            case .habit:
                let object = vm.GetHabit(id: objectId)
                if object != nil{
                    properties = Properties(habit: object)
                }
                else{
                    _ = vm.DeletePrompt(id: promptProperties.id)
                }
            case .chapter:
                let object = vm.GetChapter(id: objectId)
                if object != nil{
                    properties = Properties(chapter: object)
                }
                else{
                    _ = vm.DeletePrompt(id: promptProperties.id)
                }
            case .entry:
                let object = vm.GetEntry(id: objectId)
                if object != nil{
                    properties = Properties(entry: object)
                }
                else{
                    _ = vm.DeletePrompt(id: promptProperties.id)
                }
            default:
                let _ = "why"
            }
            
            if properties.archived == true {
                _ = vm.DeletePrompt(id: promptProperties.id)
            }
        }
    }
    
    @ViewBuilder
    func BuildCard() -> some View{
        switch promptProperties.promptType{
//        case .suggestion:
//            BuildSuggestion()
        case .favorite:
            BuildFavorite()
        default:
            EmptyView()
        }
    }
    
    @ViewBuilder
    func BuildSuggestion() -> some View{
        HStack{
            BuildCaption()
            Spacer()
            IconButton(isPressed: $shouldRemove, size: .medium, iconType: .cancel, iconColor: .grey8, circleColor: .grey2)
                .offset(y:-3)
        }
        .padding(.bottom,1)
            BuildTitle()
        HStack{
            TextIconButton(isPressed: $shouldJump, text: "Create " + ((promptProperties.objectType?.StartsWithVowel() ?? false) ? "an " : "a ") + (promptProperties.objectType?.toString() ?? ""), color: .grey9, backgroundColor: .grey3, fontSize: .h5, shouldFillWidth: true, iconType: .add)
            Spacer()
        }
    }
    
    @ViewBuilder
    func BuildFavorite() -> some View{
        PhotoCard(objectType: promptProperties.objectType ?? .goal, objectId: promptProperties.objectId ?? UUID(), properties: properties, shouldHidePadding: true, imageSize: .mediumLarge)
            .padding([.leading,.trailing])
        BuildFavoriteBadge()
            .padding(.leading,63)
            .padding([.bottom,.trailing],10)
    }
    
    @ViewBuilder
    func BuildFavoriteBadge() -> some View{
        ZStack(alignment:.topLeading){
            FormCaption(fieldName: "Favorite", fieldValue: " ")
            
            HStack{
                Text(String(promptProperties.objectType?.toString() ?? ""))
                    .padding([.leading,.bottom])
                    .padding(.top, 15)
                    .frame(height: SizeType.mediumLarge.ToSize())
                    .font(.specify(style: .body1))
                    .foregroundColor(.specify(color: .grey10))
                    .offset(y: 6)
                
                
                Spacer()
                
                IconButton(isPressed: $shouldRemove, size: .medium, iconType: .favorite, iconColor: .grey10, circleColor: .grey3)
                    .padding(.trailing,6)
            }
        }
        .modifier(ModifierForm(color:.grey2))
    }
    
    @ViewBuilder
    func BuildCaption() -> some View{
        VStack(alignment:.leading){
            Text(promptProperties.promptType?.toString() ?? "")
                .font(.specify(style: .subCaption))
                .foregroundColor(.specify(color: .grey4))
                .textCase(.uppercase)
                .frame(alignment:.leading)
            Text(GetCaption())
                .font(.specify(style: .h4))
                .foregroundColor(.specify(color: .grey4))
                .frame(alignment:.leading)
        }
    }
    
    @ViewBuilder
    func BuildTitle() -> some View{
        Text(GetTitle())
            .font(.specify(style: .h3))
    }
    
    func GetTitle() -> String{
        
        switch promptProperties.promptType {
        case .favorite:
            return properties.title ?? ""
//        case .suggestion:
//            return promptProperties.title ?? ""
        default:
            return ""
        
        }
    }
        
    func GetCaption() -> String{
        var str = ""
        
        if promptProperties.objectType == .session{
            if let timeframe = promptProperties.timeframe{
                str = timeframe.toString()
            }
        }
        
        str += " " + (promptProperties.objectType?.toPluralString() ?? "")
        return str
    }
}

//struct PromptCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ScrollView{
//            PromptCard(promptProperties: Properties(prompt:Prompt.samplePrompts[0]))
//            PromptCard(promptProperties: Properties(prompt:Prompt.samplePrompts[1]))
//            PromptCard(promptProperties: Properties(prompt:Prompt.samplePrompts[2]))
//        }
//        .environmentObject(ViewModel())
//
//    }
//}
