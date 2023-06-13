//
//  SetupAspect.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/7/23.
//

import SwiftUI

struct SetupAspect: View {
    @Binding var canProceed: Bool
    @Binding var shouldAct: Bool
    @State var Aspects: [String:Bool] = [String:Bool]()
    let options = AspectType.allCases.map({$0.toString()})
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        WrappingHStack(fieldValue: .constant(""), fieldValues: $Aspects, options: .constant(options), isMultiSelector: true)
            .padding(8)
            .modifier(ModifierForm())
            .onChange(of: Aspects, perform: { _ in
                let count = Aspects.values.filter({$0}).count
                canProceed = count > 3 && count < 11
            })
            .onChange(of: shouldAct){
                _ in
                let currentlySavedAspects = vm.ListAspects()
                
                for savedAspect in currentlySavedAspects{
                    _ = vm.DeleteAspect(id: savedAspect.id)
                }
                
                for aspectString in Aspects.filter({$0.value}).keys{
                    let aspect = AspectType.fromString(input: aspectString)
                    let request = CreateAspectRequest(aspect: aspect, description: "")
                    _ = vm.CreateAspect(request: request)
                }
            }
            .onAppear{
                options.forEach { Aspects[$0] = false }
            }
    }
}

struct SetupAspect_Previews: PreviewProvider {
    static var previews: some View {
        SetupAspect(canProceed: .constant(false), shouldAct: .constant(false))
    }
}
