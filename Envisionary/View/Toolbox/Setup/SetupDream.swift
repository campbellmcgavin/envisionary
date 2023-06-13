//
//  SetupDream.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/7/23.
//

import SwiftUI

struct SetupDream: View {
    @Binding var canProceed: Bool
    @Binding var shouldAct: Bool
    @State var Dreams: [String:Bool] = [String:Bool]()
    let options = DreamType.allCases.map({$0.toString()})
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        WrappingHStack(fieldValue: .constant(""), fieldValues: $Dreams, options: .constant(options), isMultiSelector: true)
            .padding(8)
            .modifier(ModifierForm())
            .onChange(of: Dreams, perform: { _ in
                let count = Dreams.values.filter({$0}).count
                canProceed = count > 3 && count < 11
            })
            .onChange(of: shouldAct){
                _ in
                let currentlySavedDreams = vm.ListDreams()
                
                for savedDream in currentlySavedDreams{
                    _ = vm.DeleteDream(id: savedDream.id)
                }
                
                for dreamString in Dreams.filter({$0.value}).keys{
                    let dream = DreamType.fromString(from: dreamString)
                    let request = CreateDreamRequest(title: dream.toString(), description: "", aspect: dream.toAspect())
                    _ = vm.CreateDream(request: request)
                }
            }
            .onAppear{
                options.forEach { Dreams[$0] = false }
            }
    }
}

struct SetupDream_Previews: PreviewProvider {
    static var previews: some View {
        SetupDream(canProceed: .constant(false), shouldAct: .constant(false))
    }
}
