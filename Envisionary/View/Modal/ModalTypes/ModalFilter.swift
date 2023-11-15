//
//  ModalFilter.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/20/23.
//

import SwiftUI

struct ModalFilter: View {
    @Binding var isPresenting: Bool
    @EnvironmentObject var vm: ViewModel
    
    @State var aspectString = ""
    @State var priorityString = ""
    @State var coreValue = ""
    @State var progress = 0
    @State var activeFiltersIsExpanded = true
    @State var inactiveFiltersIsExpanded = false
    @State var shouldClearFilters = false
    @State var shouldConfirm = false
    var body: some View {
        
        Modal(modalType: .filter, objectType: .home, isPresenting: $isPresenting, shouldConfirm: $isPresenting, isPresentingImageSheet: .constant(false), allowConfirm: true, title: "Filters", modalContent: {
            VStack(alignment: .leading, spacing:10){
                GetActiveFilters()
                HeaderWithContent(shouldExpand: $inactiveFiltersIsExpanded, headerColor: .grey10, header: "Inactive Filters", isExpanded: inactiveFiltersIsExpanded, content: { GetInactiveFilters() })
                    .padding(.bottom)
                
            }
            .frame(alignment:.leading)
            .onChange(of: progress){
                _ in
                vm.filtering.filterProgress = progress
            }
            .onChange(of: aspectString){
                _ in
                vm.filtering.filterAspect = AspectType.allCases.first(where:{$0.toString() == aspectString})?.toString() ?? ""
            }
            .onChange(of: coreValue){
                _ in
                vm.filtering.filterCoreValue = ValueType.allCases.first(where:{$0.toString() == coreValue})?.toString() ?? ""
            }
            .onChange(of:shouldClearFilters){
                _ in
                
                vm.filtering.filterProgress = 0
                vm.filtering.filterTitle = ""
                vm.filtering.filterDescription = ""
                vm.filtering.filterAspect = ""
                vm.filtering.filterChapter = ""
                vm.filtering.filterProgress = 0
                vm.filtering.filterPriority = ""
                vm.filtering.filterCoreValue = ""
                aspectString = ""
                priorityString = ""
                coreValue = ""
//                _ = vm.UpdateFilteredGoals(criteria: vm.filtering.GetFilters())
            }
        }, headerContent: {EmptyView()}, bottomContent: {EmptyView()}, betweenContent: {
            HStack{
                TextIconButton(isPressed: $shouldClearFilters, text: "Clear all", color: vm.filtering.filterCount > 0 ? .grey10 : .grey4, backgroundColor: vm.filtering.filterCount > 0 ? .purple : .grey1, fontSize: .caption, shouldFillWidth: false, iconType: .delete)
                        .disabled(vm.filtering.filterCount == 0)
                        .padding(.leading)
                Spacer()
            }

        })
        
        
    }
    
    @ViewBuilder
    func GetActiveFilters() -> some View {
        VStack{
            
            if vm.filtering.filterObject.hasProperty(property: .title){
                FormText(fieldValue: $vm.filtering.filterTitle, fieldName: PropertyType.title.toString(), axis: .horizontal, iconType: .title)
            }
            if vm.filtering.filterObject.hasProperty(property: .description) {
                FormText(fieldValue: $vm.filtering.filterDescription, fieldName: PropertyType.description.toString(), axis: .vertical, iconType: .description)
            }
            if vm.filtering.filterObject.hasProperty(property: .aspect)   {
                FormStackPicker(fieldValue: $aspectString, fieldName: PropertyType.aspect.toString(), options: .constant(vm.ListAspects().map({$0.title})),iconType: .aspect)
            }
            if vm.filtering.filterObject.hasProperty(property: .priority) {
                FormStackPicker(fieldValue: $priorityString, fieldName: PropertyType.priority.toString(), options: .constant(PriorityType.allCases.map({$0.toString()})),iconType: .priority)
            }
            if vm.filtering.filterObject.hasProperty(property: .progress) {
                FormSlider(fieldValue: $progress, fieldName: PropertyType.progress.toString() + " more than", iconType: .progress)
            }
        }
        .padding(8)
    }
    
    
    
    
    @ViewBuilder
    func GetInactiveFilters() -> some View {
        VStack{
            
            if (vm.filtering.filterObject.hasProperty(property: .description) && vm.filtering.filterObject.hasProperty(property: .aspect) && vm.filtering.filterObject.hasProperty(property: .progress)) {
                Text("No inactive filters")
                    .font(.specify(style: .caption))
                    .padding(.top)
                    .opacity(0.5)
            }
            else{
                
                if !vm.filtering.filterObject.hasProperty(property: .title){
                    FormText(fieldValue: $vm.filtering.filterTitle, fieldName: PropertyType.title.toString(), axis: .horizontal, iconType: .title)
                }
                
                if !vm.filtering.filterObject.hasProperty(property: .description) {
                    FormText(fieldValue: $vm.filtering.filterDescription, fieldName: PropertyType.description.toString(), axis: .vertical, iconType: .description)
                }
                
                if !vm.filtering.filterObject.hasProperty(property: .aspect)   {
                    FormStackPicker(fieldValue: $aspectString, fieldName: PropertyType.aspect.toString(), options: .constant(vm.ListAspects().map({$0.title})),iconType: .aspect)
                }
                if !vm.filtering.filterObject.hasProperty(property: .progress) {
                    FormSlider(fieldValue: $progress, fieldName: PropertyType.progress.toString() + " more than", iconType: .progress)
                }
            }

        }
        .padding(8)
    }
}

struct ModalFilter_Previews: PreviewProvider {
    static var previews: some View {
        ModalFilter(isPresenting: .constant(true))
    }
}
