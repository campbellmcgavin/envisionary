////
////  TaskCard.swift
////  Envisionary
////
////  Created by Campbell McGavin on 5/18/23.
////
//
//import SwiftUI
//
//struct TaskCard: View {
//    let taskId: UUID
//    @State var properties: Properties = Properties()
//    @State var isSelected: Bool = false
//    @State var isLoaded: Bool = false
//    @EnvironmentObject var vm: ViewModel
//
//    var body: some View {
//
//        HStack{
//            SelectedButton(isSelected: $isSelected)
//                .padding(.trailing,12)
//            NavigationLink(destination: Detail(objectType: .task, objectId: taskId, properties: properties))
//            {
//                VStack(alignment:.leading, spacing:2){
//                    Text(properties.title ?? "")
//                        .font(.specify(style: .h4))
//                        .foregroundColor(.specify(color: .grey10))
//
//                    if let startDate = properties.startDate{
//                        Text(startDate.toString(timeframeType: .day))
//                            .font(.specify(style: .body4))
//                            .textCase(.uppercase)
//                            .foregroundColor(.specify(color: .grey4))
//                    }
//                }
//                .frame(alignment:.leading)
//
//                Spacer()
//                IconLabel(size: .small, iconType: .right, iconColor: .grey5)
//            }
//            .opacity(isSelected ? 0.5 : 1.0)
//        }
//        .padding(15)
//        .padding(.leading,-5)
//        .frame(height:60)
//        .frame(maxWidth:.infinity)
//        .onAppear(){
//            properties = Properties(task:vm.GetTask(id: taskId) ?? Task())
//            isSelected = properties.progress ?? 0 > 99
//            isLoaded = true
//        }
//        .onChange(of: isSelected){
//            _ in
//            if isLoaded{
//                var request = UpdateTaskRequest(properties: properties)
//                request.progress = isSelected ? 100 : 0
//                vm.UpdateTask(id: taskId, request: request)
//            }
//        }
//    }
//}
//
//struct TaskCard_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskCard(taskId: Task.sampleTasks[0].id, properties: Properties(task: Task.sampleTasks[0]))
//            .environmentObject(ViewModel())
//    }
//}
