//
//  DetailStack.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/17/23.
//

import SwiftUI

struct DetailStack: View {
    @Binding var focusObjectId: UUID
    @Binding var isPresentingModal: Bool
    @Binding var modalType: ModalType
    @Binding var statusToAdd: StatusType
    @Binding var isPresentingSourceType: Bool
    @Binding var shouldConvertToGoal: Bool
    @Binding var selectedImage: UIImage?
    @State var properties: Properties
    let objectId: UUID
    let objectType: ObjectType
    let proxy: ScrollViewProxy
    
    @State var superGoal: Goal = Goal()
    @State var shouldExpandAll: Bool = true
    
    let navLinkId = UUID()
    @EnvironmentObject var vm: ViewModel
    

    var body: some View {
        VStack(alignment:.center, spacing:0){
            ForEach(DetailStackType.allCases){
                detailStack in
                if objectType.hasDetailStack(detailStack: detailStack) && (properties.archived != true || detailStack == .archived){
                        BuildStack(detailStack: detailStack)
                    
                }
            }
        }
        .frame(alignment:.leading)
        .offset(y:100)
        .onAppear(){
            if objectType == .goal {
                if let goal = vm.GetGoal(id: objectId){
                    superGoal = GetSuperGoal(superGoal: goal)
                    superGoal.description = "Super Goal"
                    superGoal.image = nil
                }
            }
        }
//        .onChange(of: vm.updates){
//            _ in
//            
//            if objectType == .goal {
//                properties = Properties(goal: (vm.GetGoal(id: objectId) ?? Goal()))
//            }
//            else if objectType == .value {
//                properties = Properties(value: (vm.GetCoreValue(id: objectId) ?? CoreValue()))
//            }
//            else if objectType == .journal {
//                properties = Properties(chapter: (vm.GetChapter(id: objectId) ?? Chapter()))
//            }
//            else if objectType == .entry {
//                properties = Properties(entry: (vm.GetEntry(id: objectId) ?? Entry()))
//            }
//        }
    }
    
    func GetSuperGoal(superGoal: Goal) -> Goal{
        if(superGoal.parentId == nil){
            return superGoal
        }
        else{
            if let candidateGoal = vm.GetGoal(id: superGoal.parentId!){
                return GetSuperGoal(superGoal: candidateGoal)
            }
        }
        return superGoal
    }
    
    @ViewBuilder
    func BuildSuperCard() -> some View{

        NavigationLink(
            destination:
                Detail(objectType: .goal, objectId: superGoal.id),
                       label: {
                           PhotoCard(objectType: .goal, objectId: objectId, properties: Properties(goal: superGoal), shouldHaveLink: false)
                               .frame(maxWidth:.infinity)
                               .modifier(ModifierCard())
//                               .padding([.top,.bottom])
        })
        .id(navLinkId)
    }
    
    @ViewBuilder
    func BuildStack(detailStack: DetailStackType) -> some View{
        switch detailStack {
        case .superCard:
            if properties.parentGoalId != nil{
                BuildSuperCard()
                    .padding(.top)
            }
        case .finishUp:
            if properties.archived != true {
                DetailFinishUp(objectId: objectId)
            }
        case .archived:
            if properties.archived == true{
                DetailArchived(objectType: objectType)
            }
        case .convertToGoal:
            if properties.archived != true{
                TextIconButton(isPressed: $shouldConvertToGoal, text: "Convert to goal", color: .grey0, backgroundColor: .grey10, fontSize: .h3, shouldFillWidth: true)
                    .padding(.top,35)
            }
        case .parentHeader:
            ParentHeaderButton(shouldExpandAll: $shouldExpandAll, color: .purple, header: "Expand All", headerCollapsed: "Collapse All")
        case .properties:
            DetailProperties(shouldExpand: $shouldExpandAll, objectType: objectType, properties: properties)
                .frame(maxWidth:.infinity)
        case .creed:
            DetailCreed(shouldExpand: $shouldExpandAll, isPresentingModal: $isPresentingModal, modalType: $modalType, focusValue: $focusObjectId)
        case .goalValueAlignment:
            if properties.parentGoalId == nil {
                DetailGoalValueAlignmentView(shouldExpand: $shouldExpandAll, goalId: objectId)
            }
        case .valueGoalAlignment:
            DetailValueGoalAlignmentView(shouldExpand: $shouldExpandAll, valueId: objectId)
        case .images:
            DetailImages(shouldExpand: $shouldExpandAll, selectedImage: $selectedImage, objectId: objectId, objectType: objectType)
        case .children:
            DetailChildren(shouldExpand: $shouldExpandAll, objectId: objectId, objectType: .journal, shouldAllowNavigation: true)
        case .toolbox:
            if properties.parentGoalId == nil {
                DetailGoalToolbox(shouldExpand: $shouldExpandAll, isPresentingModal: $isPresentingModal, isPresentingSourceType: $isPresentingSourceType, modalType: $modalType, focusGoal: $focusObjectId, goalId: objectId, proxy: proxy)
            }
        case .affectedGoals:
            DetailAffectedGoals(shouldExpand: $shouldExpandAll, sessionProperties: properties)
        case .habitProgress:
            DetailHabitProgress(shouldExpand: $shouldExpandAll, goalId: objectId)
        default:
            EmptyView()
        }
        
    }
}

struct DetailStack_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewReader{
            proxy in
            DetailStack(focusObjectId: .constant(UUID()), isPresentingModal: .constant(false) , modalType: .constant(.add), statusToAdd: .constant(.notStarted), isPresentingSourceType: .constant(false), shouldConvertToGoal: .constant(false), selectedImage: .constant(nil) , properties: Properties() , objectId: UUID() ,objectType: .goal, proxy: proxy)
                .environmentObject(ViewModel())
        }

    }
}
