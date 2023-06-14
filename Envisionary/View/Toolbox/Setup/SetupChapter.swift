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
    let options = ChapterType.allCases.map({$0.toString()})
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        WrappingHStack(fieldValue: .constant(""), fieldValues: $Chapters, options: .constant(options), isMultiSelector: true)
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
                options.forEach { Chapters[$0] = false }
            }
    }
}

struct SetupChapter_Previews: PreviewProvider {
    static var previews: some View {
        SetupChapter(canProceed: .constant(false), shouldAct: .constant(false))
    }
}
