//
//  ModalFilter.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/20/23.
//

import SwiftUI

struct ModalFilter: View {
    @Binding var isPresenting: Bool
    
    @EnvironmentObject var dm: DataModel
    @EnvironmentObject var gs: GoalService
    
    @State var aspectString = ""
    @State var priorityString = ""
    @State var progress = 0
    @State var activeFiltersIsExpanded = true
    @State var inactiveFiltersIsExpanded = false
    @State var shouldClearFilters = false
    @State var shouldConfirm = false
    var body: some View {
        
        
        
        Modal(modalType: .filter, objectType: .home, isPresenting: $isPresenting, shouldConfirm: $isPresenting, title: "Filters", modalContent: {
            VStack(spacing:10){
                
                TextButton(isPressed: $shouldClearFilters, text: "Clear all", color: dm.filterCount > 0 ? .purple : .grey3)
                        .padding(.top)
                        .disabled(dm.filterCount == 0)
                

                GetActiveFilters()
                HeaderWithContent(shouldExpand: $inactiveFiltersIsExpanded, headerColor: .grey10, header: "Inactive Filters", isExpanded: inactiveFiltersIsExpanded, content: { GetInactiveFilters() })
                
                
            }
            .onChange(of:aspectString){ _ in
                dm.filterAspect = AspectType.allCases.first(where:{$0.toString() == aspectString})
                gs.UpdateFilteredGoals(criteria: dm.GetFilterCriteria())
            }
            .onChange(of:priorityString){ _ in
                dm.filterPriority = PriorityType.allCases.first(where:{$0.toString() == priorityString})
                gs.UpdateFilteredGoals(criteria: dm.GetFilterCriteria())
            }
            .onChange(of: dm.filterTitle){ _ in
                GetFilterCount()
                gs.UpdateFilteredGoals(criteria: dm.GetFilterCriteria())
            }
            .onChange(of: dm.filterDescription){ _ in
                GetFilterCount()
                gs.UpdateFilteredGoals(criteria: dm.GetFilterCriteria())
            }
            .onChange(of: dm.filterAspect){ _ in
                GetFilterCount()
                gs.UpdateFilteredGoals(criteria: dm.GetFilterCriteria())
            }
            .onChange(of: dm.filterProgress){ _ in
                GetFilterCount()
                gs.UpdateFilteredGoals(criteria: dm.GetFilterCriteria())
            }
            .onChange(of: progress){
                _ in
                dm.filterProgress = progress
            }
            .onChange(of:shouldClearFilters){
                _ in
                
                dm.filterProgress = nil
                dm.filterTitle = ""
                dm.filterDescription = ""
                dm.filterAspect = nil
                dm.filterChapter = ""
                dm.filterProgress = 0
                dm.filterPriority = nil
                aspectString = ""
                priorityString = ""
                
                gs.UpdateFilteredGoals(criteria: dm.GetFilterCriteria())
            }
        }, headerContent: {EmptyView()})
        
        
    }
    
    func GetFilterCount(){
        
        var filterCount = 0
        if dm.filterTitle.count > 0 {
            filterCount += 1
        }
        if dm.filterAspect != nil && dm.objectType.hasProperty(property: .aspect) {
            filterCount += 1
        }
        if dm.filterDescription.count > 0 && dm.objectType.hasProperty(property: .description) {
            filterCount += 1
        }
        if dm.filterProgress != nil && dm.filterProgress != 0 && dm.objectType.hasProperty(property: .progress) {
            filterCount += 1
        }
        withAnimation{
            dm.filterCount = filterCount
        }

    }
    
    @ViewBuilder
    func GetActiveFilters() -> some View {
        VStack{
            FormText(fieldValue: $dm.filterTitle, fieldName: PropertyType.title.toString(), axis: .horizontal, iconType: .title)
            
            if dm.objectType.hasProperty(property: .description) {
                FormText(fieldValue: $dm.filterDescription, fieldName: PropertyType.description.toString(), axis: .vertical, iconType: .description)
            }
            
            if dm.objectType.hasProperty(property: .aspect)   {
                FormStackPicker(fieldValue: $aspectString, fieldName: PropertyType.aspect.toString(), options: AspectType.allCases.map({$0.toString()}),iconType: .aspect)
            }

            if dm.objectType.hasProperty(property: .priority) {
                FormStackPicker(fieldValue: $priorityString, fieldName: PropertyType.priority.toString(), options: PriorityType.allCases.map({$0.toString()}),iconType: .priority)
            }
            
            if dm.objectType.hasProperty(property: .progress) {
                FormSlider(fieldValue: $progress, fieldName: PropertyType.progress.toString() + " more than", iconType: .progress)
            }
        }
        .padding(8)
    }
    
    
    
    
    @ViewBuilder
    func GetInactiveFilters() -> some View {
        VStack{
            
            if (dm.objectType.hasProperty(property: .description) && dm.objectType.hasProperty(property: .aspect) && dm.objectType.hasProperty(property: .progress)) {
                Text("No inactive filters")
                    .font(.specify(style: .caption))
                    .padding(.top)
                    .opacity(0.5)
            }
            else{
                if !dm.objectType.hasProperty(property: .description) {
                    FormText(fieldValue: $dm.filterDescription, fieldName: PropertyType.description.toString(), axis: .vertical, iconType: .description)
                }
                
                if !dm.objectType.hasProperty(property: .aspect)   {
                    FormStackPicker(fieldValue: $aspectString, fieldName: PropertyType.aspect.toString(), options: AspectType.allCases.map({$0.toString()}),iconType: .aspect)
                }
                if !dm.objectType.hasProperty(property: .progress) {
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
