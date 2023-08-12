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
            values = vm.ListCoreValues(criteria: vm.filtering.GetFilters())
        }
    }
    
    @ViewBuilder
    func MainContentBuilder() -> some View{
        VStack(alignment:.leading, spacing:0){
            
            
            let intro = vm.GetCoreValue(coreValue: .Introduction) ?? CoreValue()
            let conclusion = vm.GetCoreValue(coreValue: .Conclusion) ?? CoreValue()
            
            Item(caption: intro.title, body: intro.description, id: intro.id)
            ForEach(values){ coreValue in
                
                if coreValue.title != ValueType.Introduction.toString() && coreValue.title != ValueType.Conclusion.toString() {
                    Item(caption: coreValue.title, body: coreValue.description, id: coreValue.id)
                }
            }
            Item(caption: conclusion.title, body: conclusion.description, id: conclusion.id)
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
            .environmentObject(ViewModel())
//            .environmentObject(GlobalModel())
    }
}
