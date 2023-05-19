////
////  PlanningSessionSaveCheckpoint.swift
////  Visionary
////
////  Created by Campbell McGavin on 8/17/22.
////
//
//import SwiftUI
//
//struct PlanningSessionSaveCheckpoint: View {
//    @Binding var shouldSave: Bool
//
//    var body: some View {
//
//            HStack{
//                Spacer()
//                Text("Save my work")
//                ButtonComplete(shouldComplete: $shouldSave)
//                    .disabled(shouldSave)
//            }
//            .if(!shouldSave){view in
//                view.modifier(ModifierFormControl())
//            }
//            .if(shouldSave){view in
//                view.modifier(ModifierFormControlInvalidEntry())
//            }
//
//
//
//    }
//}
//
//struct PlanningSessionSaveCheckpoint_Previews: PreviewProvider {
//    static var previews: some View {
//        PlanningSessionSaveCheckpoint(shouldSave: .constant(false))
//    }
//}
