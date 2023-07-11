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
    @State var isExpressSetup: Bool = false
    
    @State var options = [String]()
    let expressOptions = [ValueType.Achievement, ValueType.Balance, ValueType.Entrepreneurship, ValueType.Compassion, ValueType.Dependability, ValueType.GrowthMindset, ValueType.Honesty, ValueType.PositiveAttitude, ValueType.WorkEthic, ValueType.Happiness].map({$0.toString()})
    
    @EnvironmentObject var vm: ViewModel
    var body: some View {

        VStack{
            ExpressSetupButton(isExpressSetup: $isExpressSetup)
//                .padding([.leading,.trailing],4)
//                .padding(.top,8)
                
            WrappingHStack(fieldValue: .constant(""), fieldValues: $values, options: $options, isMultiSelector: true)
                .padding(.top,22)
                .disabled(isExpressSetup)
                .opacity(isExpressSetup ? 0.87 : 1.0)
        }
        .padding(8)

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
                    let request = CreateCoreValueRequest(title: valueString, description: value.toDescription())
                    _ = vm.CreateCoreValue(request: request)
                }
                
                _ = vm.CreateCoreValue(request: CreateCoreValueRequest(title: ValueType.Introduction.toString(), description: ValueType.Introduction.toDescription()))
                
                _ = vm.CreateCoreValue(request: CreateCoreValueRequest(title: ValueType.Conclusion.toString(), description: ValueType.Conclusion.toDescription()))
            }
            .onChange(of: isExpressSetup){
                _ in
                withAnimation(.easeInOut){
                    SetupValues()
                }
            }
            .onAppear{
                SetupValues()
            }
    }
    func SetupValues(){
        if isExpressSetup{
            values = [String:Bool]()
            options = expressOptions.sorted()
            options.forEach { values[$0] = true}
        }
        else{
            values = [String:Bool]()
            options = ValueType.allCases.filter({$0.isCommon()}).map({$0.toString()})
            options.forEach { values[$0] = false }
        }
    }
}




struct SetupValue_Previews: PreviewProvider {
    static var previews: some View {
        SetupValue(canProceed: .constant(false), shouldAct: .constant(false))
    }
}
