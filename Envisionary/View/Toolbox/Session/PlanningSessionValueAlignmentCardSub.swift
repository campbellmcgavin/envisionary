////
////  PlanningSessionValueAlignmentCardSub.swift
////  Visionary
////
////  Created by Campbell McGavin on 8/15/22.
////
//
//import SwiftUI
//
//struct PlanningSessionValueAlignmentCardSub: View {
//
//    @Binding var alignment: AlignmentType
//    @State var alignmentString: String = ""
//
//    var body: some View {
//        FormControlRadioButtonGroup(caption: "", isLight: true, pickerSelection: $alignmentString, options: AlignmentType.allCases.map({$0.rawValue}))
//            .onAppear{
//                alignmentString = alignment.rawValue
//            }
//            .onChange(of: alignmentString){
//                _ in
//                alignment = AlignmentType.allCases.first(where:{$0.rawValue  == alignmentString}) ?? AlignmentType.aligns
//            }
//    }
//}
//
//struct PlanningSessionValueAlignmentCardSub_Previews: PreviewProvider {
//    static var previews: some View {
//        PlanningSessionValueAlignmentCardSub(alignment: .constant(.aligns))
//    }
//}
