////
////  PlanningSessionReviewUpcoming.swift
////  Visionary
////
////  Created by Campbell McGavin on 8/14/22.
////
//
//import SwiftUI
//
//struct PlanningSessionReviewUpcoming: View {
//    @Binding var goals: [Goal]
//    @Binding var evaluationDictionary: [UUID: EvaluationType]
//    @Binding var alignmentDictionary: [UUID: [Generic:AlignmentType]]
//    @Binding var pushOffDictionary:  [UUID: Int]
//    @Binding var propertyTypeMenu: [Bool]
//    var body: some View {
//
//        ForEach($goals){ goal in
//            PlanningSessionReviewUpcomingCard(goal: goal, evaluation: BindingEvaluationType(for: goal.id), localizedAlignmentDictionary: BindingLocalizedAlignmentDictionary(for: goal.id), propertyTypeMenu: $propertyTypeMenu, localizedPushOff: BindingLocalizedPushOffValue(for: goal.id))
//        }
//    }
//
//    func BindingEvaluationType(for key: UUID) -> Binding<EvaluationType>{
//
//        return Binding(get: { return evaluationDictionary[key] ?? EvaluationType.keepAsIs},
//                       set: { evaluationDictionary[key] = $0 })
//    }
//
//    func BindingLocalizedAlignmentDictionary(for key: UUID) -> Binding<[Generic:AlignmentType]>{
//
//        return Binding(get: { return alignmentDictionary[key] ?? [Generic:AlignmentType]()},
//                       set: { alignmentDictionary[key] = $0 })
//    }
//
//    func BindingLocalizedPushOffValue(for key: UUID) -> Binding<Int>{
//
//        return Binding(get: { return pushOffDictionary[key] ?? 0},
//                       set: { pushOffDictionary[key] = $0 })
//    }
//}
//
//
//
////struct PlanningSessionReviewUpcoming_Previews: PreviewProvider {
////    static var previews: some View {
////        PlanningSessionReviewUpcoming(goals: .constant([Goal]()), evaluationDictionary: .constant([UUID:EvaluationType]()), alignmentDictionary: .constant([UUID:[Generic:AlignmentType]]()), propertyTypeMenu: .constant([Bool]()))
////    }
////}
