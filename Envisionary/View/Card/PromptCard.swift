//
//  PromptCard.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/15/23.
//

import SwiftUI

struct PromptCard: View {
    let prompt: Prompt
    @State var properties: Properties = Properties()
    @State var shouldRemove: Bool = false
    @State var shouldJump: Bool = false
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        VStack(alignment:.leading){
            BuildCard()
        }
        .frame(alignment:.leading)
        .padding([.top,.bottom],5)
        .frame(maxWidth:.infinity)
        .onAppear(){
            if prompt.type == .favorite{
                LoadProperties()
            }
        }
        .padding()
        .modifier(ModifierCard())
        .onChange(of: shouldRemove){
            _ in
            withAnimation{
                _ = vm.DeletePrompt(id: prompt.id)
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
        vm.filtering.filterContent = prompt.objectType.toContentType()
        vm.filtering.filterObject = prompt.objectType
        if prompt.objectType == .session || prompt.objectType == .entry || prompt.objectType == .emotion{
            vm.triggers.shouldPresentModal.toggle()
        }
        if prompt.objectType == .session{
            if let timeframe = prompt.timeframe {
                vm.filtering.filterTimeframe = prompt.timeframe ?? .week
                vm.filtering.filterDate = Date().GetSessionDate(timeframe: timeframe)
            }
        }
        _ = vm.DeletePrompt(id: prompt.id)
    }
    
    func LoadProperties(){
        if let objectId = prompt.objectId{
            switch prompt.objectType {
            case .value:
                let object = vm.GetCoreValue(id: objectId)
                if object != nil{
                    properties = Properties(value: object)
                }
                else{
                    _ = vm.DeletePrompt(id: prompt.id)
                }

            case .dream:
                let object = vm.GetDream(id: objectId)
                if object != nil{
                    properties = Properties(dream: object)
                }
                else{
                    _ = vm.DeletePrompt(id: prompt.id)
                }
            case .aspect:
                let object = vm.GetAspect(id: objectId)
                if object != nil{
                    properties = Properties(aspect: object)
                }
                else{
                    _ = vm.DeletePrompt(id: prompt.id)
                }
            case .goal:
                let object = vm.GetGoal(id: objectId)
                if object != nil{
                    properties = Properties(goal: object)
                }
                else{
                    _ = vm.DeletePrompt(id: prompt.id)
                }
            case .session:
                let object = vm.GetSession(id: objectId)
                if object != nil{
                    properties = Properties(session: object)
                }
                else{
                    _ = vm.DeletePrompt(id: prompt.id)
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
                    _ = vm.DeletePrompt(id: prompt.id)
                }
            case .chapter:
                let object = vm.GetChapter(id: objectId)
                if object != nil{
                    properties = Properties(chapter: object)
                }
                else{
                    _ = vm.DeletePrompt(id: prompt.id)
                }
            case .entry:
                let object = vm.GetEntry(id: objectId)
                if object != nil{
                    properties = Properties(entry: object)
                }
                else{
                    _ = vm.DeletePrompt(id: prompt.id)
                }
//            case .emotion:
//                properties = Properties(emotion: vm.GE(id: objectId) ?? Goal())
//            case .stats:
//                properties = Properties(goal: vm.GetGoal(id: objectId) ?? Goal())
            default:
                let _ = "why"
            }
        }

    }
    
    @ViewBuilder
    func BuildCard() -> some View{
        switch prompt.type{
        case .suggestion:
            BuildSuggestion()
        case .favorite:
            BuildFavorite()
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
            TextButton(isPressed: $shouldJump, text: "Create " + (prompt.objectType.StartsWithVowel() ? "an " : "a ") + prompt.objectType.toString(), color: .grey9, backgroundColor: .grey3, style: .h5, shouldHaveBackground: true, shouldFill: false)
            Spacer()
        }

    }
    
    @ViewBuilder
    func BuildFavorite() -> some View{
        HStack{
            BuildCaption()
            Spacer()
            IconButton(isPressed: $shouldRemove, size: .medium, iconType: .favorite, iconColor: .purple, circleColor: .darkPurple)
                .offset(y:-3)
        }

        BuildTitle()
        
        NavigationLink(destination: Detail(objectType: prompt.objectType, objectId: prompt.objectId ?? UUID(), properties: properties))
        {
            TextButton(isPressed: $shouldJump, text: "Go to your " + prompt.objectType.toString(), color: .grey9, backgroundColor: .grey3, style: .h5, shouldHaveBackground: true, shouldFill: false)
                .disabled((true))
        }
        
    }
    
    @ViewBuilder
    func BuildCaption() -> some View{
        VStack(alignment:.leading){
            Text(prompt.type.toString())
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
        
        switch prompt.type {
        case .favorite:
            return properties.title ?? ""
        case .suggestion:
            return prompt.title
        }
    }
        
    func GetCaption() -> String{
        var str = ""
        
        if prompt.objectType == .session{
            if let timeframe = prompt.timeframe{
                str = timeframe.toString()
            }
        }
        
        str += " " + prompt.objectType.toPluralString()
        return str
    }
}

struct PromptCard_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView{
            PromptCard(prompt: Prompt.samplePrompts[0])
            PromptCard(prompt: Prompt.samplePrompts[1])
            PromptCard(prompt: Prompt.samplePrompts[2])
        }
        .environmentObject(ViewModel())

    }
}
