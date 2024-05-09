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
    @State var values = [CoreValue]()
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
        DetailView(viewType: .creed, objectId: UUID(), selectedObjectId: $focusValue, selectedObjectType: .constant(.value), shouldExpandAll: $shouldExpand, expandedObjects: .constant([UUID]()), isPresentingModal: $isPresentingModal, modalType: $modalType, isPresentingSourceType: .constant(false), didEditPrimaryGoal: .constant(false), currentTimeframe: .day, content: {
        
            MainContentBuilder()

        }, aboveContent: {EmptyView()})
        .onAppear(){
            properties.title = "Life's Creed"
            values = vm.ListCoreValues(criteria: vm.filtering.GetFilters())
        }
        .frame(alignment:.leading)
        .onChange(of: vm.updates.value){
            _ in
            withAnimation{
                values = vm.ListCoreValues(criteria: vm.filtering.GetFilters())
            }
        }
    }
    
    @ViewBuilder
    func MainContentBuilder() -> some View{
        LazyVStack(alignment:.leading){
            
                let intro = vm.GetCoreValue(coreValue: .Introduction) ?? CoreValue()
                let conclusion = vm.GetCoreValue(coreValue: .Conclusion) ?? CoreValue()
                
                CreedItem(coreValueId: intro.id, draggingObject: $draggingObject, currentPlaceToDrop: $currentPlaceToDrop, shouldUpdateValue: $shouldUpdateValue)
                ForEach(values){ coreValue in
                    
                    if coreValue.title != ValueType.Introduction.toString() && coreValue.title != ValueType.Conclusion.toString() {
                        CreedItem(coreValueId: coreValue.id, draggingObject: $draggingObject, currentPlaceToDrop: $currentPlaceToDrop, shouldUpdateValue: $shouldUpdateValue)
                            .addButtonActions(leadingButtons: [CellButtonType](),
                                              trailingButton:  [.delete], outerPadding: 8, id: coreValue.id, selectedId: .constant(coreValue.id), onClick: { button in
                                deleteItems(id: coreValue.id)})
                    }
                }
                CreedItem(coreValueId: conclusion.id, draggingObject: $draggingObject, currentPlaceToDrop: $currentPlaceToDrop, shouldUpdateValue: $shouldUpdateValue)
            
        }
        .onChange(of: shouldUpdateValue){
            _ in
            if draggingObject?.id != nil && currentPlaceToDrop?.id != nil && currentPlaceToDrop?.id != draggingObject?.id{
                if let coreValue = values.first(where: {$0.id == draggingObject!.id}){
                    let request = UpdateCoreValueRequest(description: coreValue.description, image: coreValue.image, reorderCoreValueId: currentPlaceToDrop?.id)
                    _ = vm.UpdateCoreValue(id: coreValue.id, request: request)
                }
                
            }
        }
        

    }
    
    func deleteItems(id: UUID) {
        _ = vm.DeleteCoreValue(id: id)
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
        currentPlaceToDrop = nil
        return true
    }
    
    func dropExited(info: DropInfo) {
    }
    
    func dropEntered(info: DropInfo) {
        currentPlaceToDrop = destinationItem
        shouldUpdateValue.toggle()
    }
}

struct CreedItem: View {
    let coreValueId: UUID
    @Binding var draggingObject: IdItem?
    @Binding var currentPlaceToDrop: IdItem?
    @Binding var shouldUpdateValue: Bool
    @State var coreValue: CoreValue = CoreValue()
    @FocusState private var isFocused: Bool
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        FormText(fieldValue: $coreValue.description, fieldName: coreValue.title, axis: .vertical, color: isFocused ? .grey2 : .grey15)
            .focused($isFocused)
    //            .modifier(ModifierCard(color: focusValue == id ? .purple : .grey2, radius: SizeType.cornerRadiusSmall.ToSize()))
            .if(IsDraggable(title: coreValue.title), transform: {
                view in
                view
                .onDrag{
                    withAnimation{
                        self.draggingObject = IdItem(id: coreValueId)
                    }
                    return NSItemProvider()
                }
                .onDrop(of: [.text],
                        delegate:
                            DropViewDelegate(destinationItem: IdItem(id: coreValueId), currentPlaceToDrop: $currentPlaceToDrop, draggingObject: $draggingObject, shouldUpdateValue: $shouldUpdateValue)
                )
            })

            .onAppear{
                coreValue = vm.GetCoreValue(id: coreValueId) ?? CoreValue()
            }
            .onChange(of: coreValue){ _ in
                let request = UpdateCoreValueRequest(description: coreValue.description, image: coreValue.image, reorderCoreValueId: nil)
                _ = vm.UpdateCoreValue(id: coreValueId, request: request)
            }
    }

    func IsDraggable(title: String) -> Bool{
        return coreValue.title != ValueType.Conclusion.toString() && coreValue.title != ValueType.Introduction.toString()
    }

}

struct DetailCreed_Previews: PreviewProvider {
    static var previews: some View {
        DetailCreed(shouldExpand: .constant(false), isPresentingModal: .constant(false), modalType: .constant(.add), focusValue: .constant(UUID()))
            .environmentObject(ViewModel())
//            .environmentObject(GlobalModel())
    }
}
