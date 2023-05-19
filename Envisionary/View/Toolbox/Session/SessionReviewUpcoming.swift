//
//  SessionLookingForward.swift
//  Visionary
//
//  Created by Campbell McGavin on 8/17/22.
//

import SwiftUI

struct SessionReviewUpcoming: View {
    @Binding var goalProperties: [Properties]
    @Binding var evaluationDictionary: [UUID: EvaluationType]
    @Binding var pushOffDictionary: [UUID: Int]
    @Binding var confirmDictionary: [UUID: Bool]
    let timeframe: TimeframeType
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {

        VStack(spacing:15){
            ForEach($goalProperties){ $goalProperty in
                SessionReviewUpcomingCard(goalProperty: $goalProperty, evaluation: BindingDictionaryEvaluation(for: goalProperty.id), pushOff: BindingDictionaryInt(for: goalProperty.id), confirmed: BindingDictionaryConfirm(for: goalProperty.id), timeframe: timeframe)
            }
        }
    }
    
    func BindingDictionaryEvaluation(for key: UUID) -> Binding<EvaluationType>{
        return Binding(get: {
            return self.evaluationDictionary[key] ?? .keepAsIs},
                       set: {
            self.evaluationDictionary[key]! = $0
            
        })
    }
    
    func BindingDictionaryInt(for key: UUID) -> Binding<Int>{
        return Binding(get: {
            return self.pushOffDictionary[key] ?? 0},
                       set: {
            self.pushOffDictionary[key]! = $0
        })
    }
    
    func BindingDictionaryConfirm(for key: UUID) -> Binding<Bool>{
        return Binding(get: {
            return self.confirmDictionary[key] ?? false},
                       set: {
            self.confirmDictionary[key]! = $0
        })
    }
}

//struct SessionLookingForward_Previews: PreviewProvider {
//    static var previews: some View {
//        SessionLookingForward(goals: .constant([Goal]()), evaluationDictionary: .constant()
//    }
//}
