//
//  PlanningSessionValueAlignment.swift
//  Visionary
//
//  Created by Campbell McGavin on 8/15/22.
//

import SwiftUI

struct SessionValueAlignment: View {
    @Binding var goalProperties: [Properties]
    @Binding var alignmentDictionary: [UUID: [String:Bool]]
    @EnvironmentObject var vm: ViewModel
    @State var changeId: UUID? = nil
    
    var body: some View {

        VStack(spacing:15){
            ForEach($goalProperties){ $goalProperty in
                SessionValueAlignmentCard(goalProperty: $goalProperty, alignmentDictionary: BindingDictionary(for: goalProperty.id))
        }
        }
    }
    
    
    func BindingDictionary(for key: UUID) ->Binding<[String:Bool]>{
        return Binding(get: {
            return self.alignmentDictionary[key] ?? [String:Bool]()},
                       set: {
            changeId = key
            self.alignmentDictionary[key]! = $0
            
        })
    }

}
//
//
//struct PlanningSessionValueAlignment_Previews: PreviewProvider {
//    static var previews: some View {
//        PlanningSessionValueAlignment()
//    }
//}
