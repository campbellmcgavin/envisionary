////
////  PlanningSessionReviewUpcomingCard.swift
////  Visionary
////
////  Created by Campbell McGavin on 8/14/22.
////
//
//import SwiftUI
//
//struct PlanningSessionReviewUpcomingCard: View {
//    @Binding var goal: Goal
//    @Binding var evaluation: EvaluationType
//    @Binding var localizedAlignmentDictionary: [Generic: AlignmentType]
//    @Binding var propertyTypeMenu: [Bool]
//    @Binding var localizedPushOff: Int
//    @State var evaluationString: String = ""
//    @State var editableData = Goal.EditableData()
//    @State var isShowingExpandedModal = false
//    @State var warningText = ""
//    @State var resolved = false
//    var body: some View {
//        VStack{
//            CardView(goal: $goal, propertyTypeMenu: $propertyTypeMenu, shouldShowNavButton: false, isModal: true, isSmall: false)
//            if localizedAlignmentDictionary.values.filter({$0 == .detracts}).count > 0 || resolved{
//                LabelWarning(labelValue: warningText, resolved: $resolved)
//            }
//
//            FormControlRadioButtonGroup(caption: "", isLight: true, pickerSelection: $evaluationString, options: EvaluationType.allCases.map({$0.rawValue}))
//            SetupAdditionalOptions()
//        }
//        .modifier(ModifierCard())
//        .onAppear{
//            evaluationString = evaluation.rawValue
//            editableData = goal.editableData
//            warningText =  SetupWarningText()
//        }
//        .onChange(of: evaluationString){ _ in
//            evaluation = EvaluationType.allCases.first(where:{$0.rawValue == evaluationString}) ?? EvaluationType.keepAsIs
//            if evaluation !=  .pushOffTillNext{
//                localizedPushOff = 0
//            }
//        }
//        .onChange(of: resolved){ _ in
//            withAnimation{
//                for value in localizedAlignmentDictionary.keys{
//                    if localizedAlignmentDictionary[value] == .detracts{
//                        localizedAlignmentDictionary[value] = .aligns
//                    }
//                }
//            }
//        }
//        .onChange(of: editableData){
//            _ in
//            goal.update(from:editableData)
//        }
//    }
//
//    func SetupWarningText() -> String{
//        var detractingValuesString = "You marked this goal as detracting from the following values: "
////        let detractingValuesList = localizedAlignmentDictionary.keys.filter({$0 == .detracts}).map({$0.title})
//        var isFirst = true
//
//        for detractingValue in localizedAlignmentDictionary.keys{
//            if localizedAlignmentDictionary[detractingValue] == .detracts{
//                if isFirst{
//                    detractingValuesString.append(detractingValue.title)
//                    isFirst = false
//                }
//                else{
//                    detractingValuesString.append(", " + detractingValue.title)
//                }
//            }
//        }
//        detractingValuesString.append(". Marking as resolved will align these values.")
//        return detractingValuesString
//    }
//    @ViewBuilder
//    func SetupAdditionalOptions() -> some View{
//        switch evaluation {
//        case .editDetails:
//            DetailGoalEditStackCondensed(editableData: $editableData, isShowingExpandedModal: $isShowingExpandedModal)
//        case .pushOffTillNext:
//
//            FormControlStepper(fieldName: "Number of " + editableData.timeframe.toTitle() + "s", isLight: true, min: 0, max: 8, fieldItem: $editableData.timeframe, fieldValue: $localizedPushOff,  pickerType: .timeframe)
//                .frame(maxWidth: .infinity)
//
//            Text("Note: pushing off this goal will push off all goals beneath it as well.")
//                .font(.specify(style: .caption))
//                .frame(maxWidth:.infinity)
//                .foregroundColor(.specify(color: .textForegroundTertiary))
//                .opacity(0.5)
//                .frame(maxWidth: .infinity, alignment:.leading)
//                .padding([.leading, .trailing, .bottom])
//        default:
//            EmptyView()
//        }
//    }
//
//
//}
//
////struct PlanningSessionReviewUpcomingCard_Previews: PreviewProvider {
////    static var previews: some View {
////        PlanningSessionReviewUpcomingCard(goal: .constant(Goal.sampleGoals[0]), evaluation: .constant(.keepAsIs), localizedAlignmentDictionary: .constant([Generic:AlignmentType]()), propertyTypeMenu: .constant([Bool]()))
////    }
////}
