//
//  TutorialLoadPreviousData.swift
//  Envisionary
//
//  Created by Campbell McGavin on 8/3/23.
//

import SwiftUI

struct TutorialLoadPreviousData: View {
    @Binding var canProceed: Bool
    @Binding var didUsePreviousData: Bool
    
    @State var shouldUsePreviousData: Bool = false
    @State var shouldUseNewData: Bool = false
    
    @EnvironmentObject var vm: ViewModel
    var body: some View {
        VStack{
            
            if !shouldUseNewData{
                TextButton(isPressed: $shouldUsePreviousData, text: "Use existing data", color: .grey0, backgroundColor: .grey10, style:.h3, shouldHaveBackground: true, shouldFill: true)
                    .padding(.bottom, canProceed ? 0 : 20)
            }

            if !shouldUsePreviousData{
                TextButton(isPressed: $shouldUseNewData, text: "Delete and start fresh", color: .grey10, backgroundColor: .red, style:.h3, shouldHaveBackground: true, shouldFill: true)
                
                Spacer()
                
                if !canProceed{
                    Text("Deleting and starting fresh will permanently erase iCloud data for Envisionary from all previous sessions on any device with this Apple ID. This action is not reversible.")
                        .multilineTextAlignment(.leading)
                        .font(.specify(style: .caption))
                        .foregroundColor(.specify(color: .grey5))
                        .padding([.leading,.trailing],14)
                        .padding(.top)
                        .padding(.bottom,8)
                }
            }

            
        }
        .disabled(canProceed)
        .opacity(canProceed ? 0.35 : 1.0)
        .onChange(of: shouldUsePreviousData){
            _ in
            didUsePreviousData = true
            canProceed = true
            
            ObjectType.allCases.forEach({
                vm.unlockedObjects.unlockObject(object: $0)
            })
            
        }
        .padding([.top,.bottom],8)
        .onChange(of: shouldUseNewData){
            _ in
            didUsePreviousData = false
            canProceed = true
        }
        .onChange(of: canProceed){
            _ in
            
            if didUsePreviousData{
                UserDefaults.standard.set(SetupStepType.loadPreviousData.GetNext().toString(), forKey: SettingsKeyType.tutorial_step.toString())
            }
            else{
                UserDefaults.standard.set(SetupStepType.envisionary.toString(), forKey: SettingsKeyType.tutorial_step.toString())
            }
            
            
        }
        .frame(maxWidth:.infinity)
    }
}

struct TutorialLoadPreviousData_Previews: PreviewProvider {
    static var previews: some View {
        TutorialLoadPreviousData(canProceed: .constant(true), didUsePreviousData: .constant(true))
    }
}
