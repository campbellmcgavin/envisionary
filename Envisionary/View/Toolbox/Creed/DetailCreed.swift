//
//  DetailCreed.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/8/23.
//

import SwiftUI

struct DetailCreed: View {
    
    @Binding var shouldExpand: Bool
    @Binding var isPresentingModal: Bool
    @Binding var modalType: ModalType
    @Binding var focusValue: UUID
    
    @State var isExpanded: Bool = true

    
    @State var draggingObject: IdItem? = nil
    @State var shouldUpdateValue = false
    @State var currentPlaceToDrop: IdItem? = nil
    
    @State var isShowingEditor: Bool = false
    
    @State var properties = Properties()
    @EnvironmentObject var dm: DataModel
    @EnvironmentObject var gs: GoalService
    
    var body: some View {
        
        DetailView(viewType: .creed, objectId: UUID(), selectedObjectId: $focusValue, selectedObjectType: .constant(.value), shouldExpandAll: $shouldExpand, expandedObjects: .constant([UUID]()), isPresentingModal: $isPresentingModal, modalType: $modalType, content: {
        
            MainContentBuilder()

        })
        .onAppear(){
            properties.title = "Life's Creed"
        }
        .frame(alignment:.leading)
        .onChange(of: shouldUpdateValue){
            _ in
            
        }
    }
    
    @ViewBuilder
    func MainContentBuilder() -> some View{
        VStack(alignment:.leading, spacing:0){
            
            
            let intro = gs.GetCoreValue(value: .Introduction) ?? CoreValue()
            let conclusion = gs.GetCoreValue(value: .Conclusion) ?? CoreValue()
            
            Item(caption: intro.coreValue.toString(), body: intro.description, id: intro.id)
            ForEach(gs.ListCoreValuesByCriteria(criteria: dm.GetFilterCriteria())){ coreValue in
                
                if coreValue.coreValue != .Introduction && coreValue.coreValue != .Conclusion {
                    Item(caption: coreValue.coreValue.toString(), body: coreValue.description, id: coreValue.id)
                }
            }
            Item(caption: conclusion.coreValue.toString(), body: conclusion.description, id: conclusion.id)
        }

    }
    
    @ViewBuilder
    func Item(caption: String, body: String, id: UUID) -> some View {
        
        Button{
            if focusValue == id {
                focusValue = UUID()
            }
            else{
                focusValue = id
            }
        }label:{
            HStack(spacing:0){
                VStack(alignment:.leading, spacing:3){
                    Text(caption)
                        .font(.specify(style: .caption))
                        .foregroundColor(.specify(color: focusValue == id ? .grey10 : .grey5))
                        .frame(alignment: .leading)
                    Text(body)
                        .font(.specify(style: .body2))
                        .foregroundColor(.specify(color: .grey10))
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer()
            }
            .frame(alignment:.leading)
            .padding(9)
            .padding(.leading,5)
            .frame(maxWidth:.infinity)
            .modifier(ModifierCard(color: focusValue == id ? .purple : .grey2, radius: SizeType.cornerRadiusSmall.ToSize()))
            .onDrag{
                withAnimation{
                    self.draggingObject = IdItem(id: id)
                }
                return NSItemProvider()
            }
            .onDrop(of: [.text],
                    delegate:
                        DropViewDelegate(destinationItem: IdItem(id: id), currentPlaceToDrop: $currentPlaceToDrop, draggingObject: $draggingObject, shouldUpdateValue: $shouldUpdateValue)
            )
        }

    }
    
    
    struct DropViewDelegate: DropDelegate {
        
        let destinationItem: IdItem
        @Binding var currentPlaceToDrop: IdItem?
        @Binding var draggingObject: IdItem?
        @Binding var shouldUpdateValue: Bool
        
        func dropUpdated(info: DropInfo) -> DropProposal? {
            return DropProposal(operation: .move)
        }
        
        func performDrop(info: DropInfo) -> Bool {
            draggingObject = nil

            return true
        }
        
        func dropExited(info: DropInfo) {
        }
        
        func dropEntered(info: DropInfo) {
            currentPlaceToDrop = destinationItem
            shouldUpdateValue.toggle()
        }
    }
}

struct DetailCreed_Previews: PreviewProvider {
    static var previews: some View {
        DetailCreed(shouldExpand: .constant(false), isPresentingModal: .constant(false), modalType: .constant(.add), focusValue: .constant(UUID()))
            .environmentObject(GoalService())
            .environmentObject(DataModel())
    }
}
