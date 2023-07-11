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
    @State var isExpressSetup: Bool = false
    
    @State var options = AspectType.allCases.map({$0.toString()})
    let expressOptions: [String] = [AspectType.academic, AspectType.career, AspectType.family, AspectType.emotional, AspectType.financial, AspectType.health, AspectType.lifestyle, AspectType.philanthropy, AspectType.personal, AspectType.romantic, AspectType.travel].map({$0.toString()})
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        VStack{
            ExpressSetupButton(isExpressSetup: $isExpressSetup)
            WrappingHStack(fieldValue: .constant(""), fieldValues: $Aspects, options: .constant(options), isMultiSelector: true)
                .padding(.top,22)
                .disabled(isExpressSetup)
                .opacity(isExpressSetup ? 0.87 : 1.0)
        }
            .padding(8)
            .onChange(of: Aspects, perform: { _ in
                let count = Aspects.values.filter({$0}).count
                canProceed = count > 4 && count < 16
            })
            .onChange(of: shouldAct){
                _ in
                let currentlySavedAspects = vm.ListAspects()
                
                for savedAspect in currentlySavedAspects{
                    _ = vm.DeleteAspect(id: savedAspect.id)
                }
                
                for aspectString in Aspects.filter({$0.value}).keys{
                    let request = CreateAspectRequest(title: aspectString, description: "")
                    _ = vm.CreateAspect(request: request)
                }
            }
            .onAppear{
                SetupAspects()
            }
            .onChange(of: isExpressSetup){
                _ in
                SetupAspects()
            }
    }
    
    func SetupAspects(){
        if isExpressSetup{
            Aspects = [String:Bool]()
            options = expressOptions.sorted()
            options.forEach { Aspects[$0] = true}
        }
        else{
            Aspects = [String:Bool]()
            options = AspectType.allCases.map({$0.toString()})
            options.forEach { Aspects[$0] = false }
        }
    }
}

struct SetupAspect_Previews: PreviewProvider {
    static var previews: some View {
        SetupAspect(canProceed: .constant(false), shouldAct: .constant(false))
    }
}
