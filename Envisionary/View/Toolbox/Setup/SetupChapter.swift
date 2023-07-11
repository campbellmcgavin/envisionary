//
//  SetupChapter.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/7/23.
//

import SwiftUI

struct SetupChapter: View {
    @Binding var canProceed: Bool
    @Binding var shouldAct: Bool
    @State var Chapters: [String:Bool] = [String:Bool]()
    @State var options = [String]()
    @State var isExpressSetup = false
    
    let expressOptions: [String] = [ChapterType.gratitude, ChapterType.businessIdeas, ChapterType.myInternalMusings, ChapterType.neitherHereNorThere].map({$0.toString()})
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        VStack{
            
            ExpressSetupButton(isExpressSetup: $isExpressSetup)
            WrappingHStack(fieldValue: .constant(""), fieldValues: $Chapters, options: $options, isMultiSelector: true)
                .padding(.top,22)
                .disabled(isExpressSetup)
                .opacity(isExpressSetup ? 0.87 : 1.0)
        }
            .padding(8)
            .onChange(of: Chapters, perform: { _ in
                let count = Chapters.values.filter({$0}).count
                canProceed = count > 2 && count < 6
            })
            .onChange(of: shouldAct){
                _ in
                let currentlySavedChapters = vm.ListChapters()
                
                for savedChapter in currentlySavedChapters{
                    _ = vm.DeleteChapter(id: savedChapter.id)
                }
                
                for chapterString in Chapters.filter({$0.value}).keys{
                    let request = ChapterType.fromString(from: chapterString).toRequest()
                    _ = vm.CreateChapter(request: request)
                }
            }
            .onAppear{
                SetupChapters()
            }
            .onChange(of: isExpressSetup){
                _ in
                SetupChapters()
            }
    }
    
    func SetupChapters(){
        if isExpressSetup{
            Chapters = [String:Bool]()
            options = expressOptions.sorted()
            options.forEach { Chapters[$0] = true}
        }
        else{
            Chapters = [String:Bool]()
            options = ChapterType.allCases.map({$0.toString()})
            options.forEach { Chapters[$0] = false }
        }
    }
}

struct SetupChapter_Previews: PreviewProvider {
    static var previews: some View {
        SetupChapter(canProceed: .constant(false), shouldAct: .constant(false))
    }
}
