//
//  SetupValue.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/7/23.
//

import SwiftUI

struct SetupValue: View {
    @Binding var canProceed: Bool
    @Binding var shouldAct: Bool
    @State var values: [String:Bool] = [String:Bool]()
    let options = ValueType.allCases.filter({$0.isCommon()}).map({$0.toString()})
    @EnvironmentObject var vm: ViewModel
    var body: some View {
        WrappingHStack(fieldValue: .constant(""), fieldValues: $values, options: .constant(options), isMultiSelector: true)
            .padding(8)
            .modifier(ModifierForm())
            .onChange(of: values, perform: { _ in
                let count = values.values.filter({$0}).count
                canProceed = count > 4 && count < 11
            })
            .onChange(of: shouldAct){
                _ in
                let currentlySavedValues = vm.ListCoreValues(filterIntroConc: false)
                
                for savedValue in currentlySavedValues{
                    _ = vm.DeleteCoreValue(id: savedValue.id)
                }
                
                for valueString in values.filter({$0.value}).keys{
                    let value = ValueType.fromString(input: valueString)
                    let request = CreateCoreValueRequest(coreValue: value, description: value.toDescription())
                    _ = vm.CreateCoreValue(request: request)
                }
                
                _ = vm.CreateCoreValue(request: CreateCoreValueRequest(coreValue: .Introduction, description: ValueType.Introduction.toDescription()))
                
                _ = vm.CreateCoreValue(request: CreateCoreValueRequest(coreValue: .Conclusion, description: ValueType.Conclusion.toDescription()))
            }
            .onAppear{
                options.forEach { values[$0] = false }
            }
    }
    
}

struct SetupValue_Previews: PreviewProvider {
    static var previews: some View {
        SetupValue(canProceed: .constant(false), shouldAct: .constant(false))
    }
}
