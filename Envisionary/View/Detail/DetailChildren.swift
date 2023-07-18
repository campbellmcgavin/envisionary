//
//  DetailChildren.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/30/23.
//

import SwiftUI

struct DetailChildren: View {
    @Binding var shouldExpand: Bool
    let objectId: UUID
    let objectType: ObjectType
    var shouldAllowNavigation: Bool = false
    var shouldShowBackground = true
    var shouldShowSearch = true
    @State var isExpanded: Bool = true
    @State var properties: Properties = Properties()
    @State var childProperties: [Properties] = [Properties]()
    @State var childPropertiesFiltered: [Properties] = [Properties]()
    @State var searchString: String = ""
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
        VStack(spacing:0){
            HeaderButton(isExpanded: $isExpanded, color: .grey10, header: GetTitle())
            
            if isExpanded {
                
                VStack{
                    
                    if childProperties.count > 0 && shouldShowSearch {
                        FormText(fieldValue: $searchString, fieldName: "Search", axis: .horizontal, iconType: .search)
                    }
                    
                    ForEach(childPropertiesFiltered){ childProperty in
                        
                            if shouldAllowNavigation{
                                
                                PhotoCard(objectType: GetChildObjectType(), objectId: childProperty.id, properties: childProperty)
                            }
                            else{
                                PhotoCardSimple(objectType: objectType, properties: childProperty)
                            }

                        if childPropertiesFiltered.last != childProperty{
                            Divider()
                                .overlay(Color.specify(color: .grey2))
                                .frame(height:1)
                                .padding(.leading,16+50+16)
                        }
                    }
                    
                    if childProperties.count == 0 {
                        NoObjectsLabel(objectType: objectType == .chapter ? .entry : objectType, labelType: objectType == .session ? .session : .page)
                    }
                }
                .frame(maxWidth:.infinity)
                .frame(alignment:.leading)
                .frame(minHeight: childProperties.count == 0 ? 70 : 0)
                .padding(8)
                .modifier(ModifierCard(color: shouldShowBackground ? .grey1 : .clear ))

            }
        }
        .onAppear{
            LoadProperties()
            FilterList()
        }
        .onChange(of: searchString){ _ in
            FilterList()
        }
        .onChange(of: vm.updates){ _ in
            LoadProperties()
            FilterList()
        }
        .onChange(of:shouldExpand){ _ in
            withAnimation{
                if shouldExpand{
                    isExpanded = true
                }
                else{
                    isExpanded = false
                }
            }
        }
    }
    
    func FilterList(){
        withAnimation{
            childPropertiesFiltered.removeAll()
            let searchStringTrimmed = searchString.trimmingCharacters(in: .whitespacesAndNewlines)
            
            for properties in childProperties{
                if let title = properties.title{
                    
                    if searchStringTrimmed.count == 0 || title.contains(searchStringTrimmed){
                        childPropertiesFiltered.append(properties)
                    }
                }
            }
        }
    }
    
    func LoadProperties(){
        switch objectType {
        case .goal:
            properties = Properties(goal: vm.GetGoal(id: objectId) ?? Goal())
            childProperties = vm.ListChildGoals(id: objectId).map({Properties(goal: $0)})
        case .chapter:
            properties = Properties(chapter: vm.GetChapter(id: objectId) ?? Chapter())
            
            var criteria = Criteria()
            criteria.chapterId = objectId
            let entries = vm.ListEntries(criteria: criteria)
            childProperties = entries.map({Properties(entry: $0)})
        default:
            properties = Properties()
        }
    }
    
    func GetChildObjectType() -> ObjectType{
        switch objectType{
        case .goal:
            return .goal
        case .chapter:
            return .entry
        default:
            return.goal
        }
    }
    
    
    
    func GetTitle() -> String{
        switch objectType{
        case .goal:
             return (properties.timeframe?.toString() ?? TimeframeType.day.toString()) + " " + ObjectType.goal.toPluralString()
        case .chapter:
            return ObjectType.entry.toPluralString()
        default:
            return ""
        }
    }
}

struct DetailChildren_Previews: PreviewProvider {
    static var previews: some View {
        DetailChildren(shouldExpand: .constant(false), objectId: UUID(), objectType: .goal)
    }
}
