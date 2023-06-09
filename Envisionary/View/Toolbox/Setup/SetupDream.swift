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
    @State var isExpressSetup: Bool = false
    @State var options = [String]()
    let expressOptions: [String] = [DreamType.allSevenWonders, DreamType.millionaire, DreamType.retireComfortably, DreamType.buyDreamCar, DreamType.masterSkill, DreamType.liveInForeignCountry, DreamType.becomeDebtFree, DreamType.getMastersDegree, DreamType.marryLoveOfLife, DreamType.happyFamily, DreamType.getPaidForPassion].map({$0.toString()})
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        VStack{
            ExpressSetupButton(isExpressSetup: $isExpressSetup)
            WrappingHStack(fieldValue: .constant(""), fieldValues: $Dreams, options: .constant(options), isMultiSelector: true)
                .padding(.top,22)
                .disabled(isExpressSetup)
                .opacity(isExpressSetup ? 0.87 : 1.0)
        }
        .padding(8)
        .onChange(of: Dreams, perform: { _ in
            let count = Dreams.values.filter({$0}).count
            canProceed = count > 3 && count < 25
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
            SetupDreams()
        }
        .onChange(of: isExpressSetup){
            _ in
            SetupDreams()
        }
    }
    
    func SetupDreams(){
        if isExpressSetup{
            Dreams = [String:Bool]()
            options = expressOptions.sorted()
            options.forEach { Dreams[$0] = true}
        }
        else{
            Dreams = [String:Bool]()
            options = DreamType.allCases.map({$0.toString()})
            options.forEach { Dreams[$0] = false }
//            values[options.first!] = true
        }
    }
}

struct SetupDream_Previews: PreviewProvider {
    static var previews: some View {
        SetupDream(canProceed: .constant(false), shouldAct: .constant(false))
    }
}
