//
//  BoardListView.swift
//  TrelloClone
//
//  Created by Alfian Losari on 11/30/21.
//

import SwiftUI

struct BoardListView: View {

    let statusType: StatusType
    let objectId: UUID
    @Binding var selectedObjectId: UUID
    @Binding var isPresentingModal: Bool
    @Binding var modalType: ModalType
    @Binding var statusToAdd: StatusType
    
    @EnvironmentObject var vm: ViewModel
    @State var childObjectList: [UUID] = [UUID]()
    
    @Binding var draggingObject: IdItem?
    @Binding var shouldUpdateGoal: Bool
    @Binding var shouldHideElements: Bool
    @Binding var currentPlaceToDrop: StatusType?
    @State var shouldAdd = false
    @State var timer = Timer.publish(every: 2.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack(alignment:.bottomTrailing){
            VStack(alignment: .leading) {
                
                
                headerView
                    .padding(shouldHideElements ? 5 : 10)
                    .padding([.top,.leading], shouldHideElements ? 5 : 0)
                
                SetupTaskList()
                    .padding(.leading,8)

                Spacer()
            }
            .padding(.bottom,50)
            IconButton(isPressed: $shouldAdd, size: .medium, iconType: .add, iconColor: .grey10, circleColor: .grey3)
                .padding(5)
                .opacity(shouldHideElements ? 0.0 : 1.0)
        }

        .frame(minHeight:150)
        .frame(width: shouldHideElements ? 90 : 210)
        .modifier(ModifierCard(color: GetColor(), radius:SizeType.cornerRadiusSmall.ToSize()))
        .padding(.trailing,shouldHideElements ? 3 : 8)
        
        .onAppear{
            childObjectList = vm.ListChildGoals(id: objectId).map({$0.id})
        }
        .onReceive(timer){ _ in
            withAnimation{
                shouldHideElements = false
                timer.upstream.connect().cancel()
            }
        }
        .onChange(of: shouldHideElements){
            _ in
            timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
        }
        .onChange(of:vm.updates.goal){ _ in
            childObjectList = vm.ListChildGoals(id: objectId).map({$0.id})
        }
        .onChange(of: shouldAdd){ _ in
            selectedObjectId = objectId
            statusToAdd = statusType
            print(statusToAdd)
            modalType = .add
            isPresentingModal = true
        }

    }
    
    func GetColor() -> CustomColor {
        if currentPlaceToDrop == statusType {
            return .darkPurple
        }
        return .grey2
    }
    
    @ViewBuilder
    func SetupTaskList() -> some View {

        VStack(spacing:0){
            ForEach(childObjectList, id:\.self){ childObjectId in
                
                if let object = vm.GetGoal(id: childObjectId){
                    if statusType.hasObject(progress: object.progress){
                        BubbleView(goalId: childObjectId, focusGoal: $selectedObjectId, width: shouldHideElements ? 50 : 180)
                            .frame(maxHeight: shouldHideElements ? 0 : 100)
                            .padding(5)
                            .onDrag{
                                withAnimation{
                                    self.draggingObject = IdItem(id: childObjectId)
                                    shouldHideElements = true
                                }
                                return NSItemProvider()
                            }
                            .opacity(shouldHideElements ? 0 : 1.0)
                    }
                }
            }
            
            Spacer()
        }

    }

    private var headerView: some View {
        HStack {
            Text(statusType.toString())
                .font(.specify(style:.caption))
                .frame(alignment:.leading)
            Spacer()
        }
    }
}
