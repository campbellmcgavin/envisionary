////
////  PlanningSessionValueAlignmentCard.swift
////  Visionary
////
////  Created by Campbell McGavin on 8/15/22.
////
//
//import SwiftUI
//
//struct PlanningSessionValueAlignmentCard: View {
//    @Binding var goal: Goal
//    @Binding var alignmentDictionary: [Generic:AlignmentType]
//    @Binding var propertyTypeMenu: [Bool]
//    @State var alignmentString: String = ""
//    @State var shouldAlignAll: Bool = false
//    @State var didAlignAll: Bool = false
//    var body: some View {
//        VStack{
//            CardView(goal: $goal, propertyTypeMenu: $propertyTypeMenu, shouldShowNavButton: false, isModal: true, isSmall: false)
//
//            HStack{
//                Spacer()
//                Text(didAlignAll ? "Values aligned " : "Rapid-align ")
//                    .foregroundColor(.specify(color: .textForegroundPrimary))
//                    .font(.specify(style: .body))
//                ButtonComplete(shouldComplete: $shouldAlignAll)
//                    .foregroundColor(!didAlignAll ? .specify(color: .foregroundSelected) : .specify(color: .backgroundPrimary))
//            }
//            .modifier(ModifierFormControl())
//
//
//            if !didAlignAll {
//                ForEach(Array(alignmentDictionary.keys)){ coreValue in
//                    VStack{
//                        HStack{
//                            coreValue.imageString.ToImage(imageSize: 30)
//                            Text(coreValue.title)
//                                .font(.specify(style: .h5_selected))
//
//                            Spacer()
//                        }
//                        .padding(.leading)
//                        HStack{
//                            Text(coreValue.description)
//                                .font(.specify(style:.body))
//                                .padding(.leading)
//                            Spacer()
//                        }
//
//                        PlanningSessionValueAlignmentCardSub(alignment: BindingAlignmentType(for: coreValue))
//                    }
//                }
//                .padding(.top)
//            }
//
//
//        }
//        .modifier(ModifierCard())
//        .onChange(of: shouldAlignAll){
//            _ in
//
//            if shouldAlignAll{
//                for key in alignmentDictionary.keys {
//                    alignmentDictionary[key]? = .aligns
//                }
//                didAlignAll = true
//            }
//            else{
//                for key in alignmentDictionary.keys {
//                    alignmentDictionary[key]? = .detracts
//                }
//                didAlignAll = false
//            }
//        }
//    }
//
//    func BindingAlignmentType(for key: Generic) -> Binding<AlignmentType>{
//
//        return Binding(get: { return alignmentDictionary[key] ?? AlignmentType.aligns},
//                       set: { alignmentDictionary[key] = $0 })
//    }
//}
//
//struct PlanningSessionValueAlignmentCard_Previews: PreviewProvider {
//    static var previews: some View {
//        PlanningSessionValueAlignmentCard(goal: .constant(Goal.sampleGoals[0]), alignmentDictionary: .constant([Generic:AlignmentType]()), propertyTypeMenu: .constant([Bool]()))
//    }
//}
