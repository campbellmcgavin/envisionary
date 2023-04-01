//
//  ModalSearch.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/20/23.
//

import SwiftUI

struct ModalSearch: View {
    @Binding var isPresenting: Bool
//    let objectType: ObjectType
    
    
    @State var searchString = ""
    @State var objectType: ObjectType
    @State var aspectsFiltered = AspectType.allCases
    @State var shouldShowObject = false
    @EnvironmentObject var dm: DataModel
    var body: some View {
        
        Modal(modalType: .search, objectType: objectType, isPresenting: $isPresenting, shouldConfirm: .constant(false), modalContent: {
            GetContent()

        }, headerContent: {
            let timer = Timer.publish(every: 0.6, on: .main, in: .common).autoconnect()
            
            VStack{
                if(shouldShowObject){
                    ScrollPickerObject(objectType: $objectType, isSearch: true)
                        .frame(maxWidth:.infinity).padding([.leading,.trailing])
                        .offset(y:60)
                }
            }
            .onAppear{
                objectType = dm.objectType
                shouldShowObject = false
            }
            .onReceive(timer){ _ in
                withAnimation{
                    shouldShowObject = true
                    timer.upstream.connect().cancel()
                }
            }

        }
        )
        .onChange(of:searchString){ _ in
            if searchString.count == 0 {
                aspectsFiltered = AspectType.allCases
            }
            else{
                aspectsFiltered = AspectType.allCases.filter({$0.toString().localizedCaseInsensitiveContains(searchString)})
            }

        }
//        .onChange(of: dm.objectType){ _ in
//            objectType = dm.objectType
//        }
        
    }
    
    @ViewBuilder
    func GetContent() -> some View {
        VStack(spacing:10){
            
            FormText(fieldValue: $searchString, fieldName: "Search", axis: .horizontal, iconType: .search)
                .padding(8)
            
            ForEach(aspectsFiltered, id: \.self){
                aspect in
                PhotoCard(objectType: .aspect, objectId: UUID(), properties: Properties(), header: aspect.toString(), subheader: objectType.toString())
            }
        }
    }
}

struct ModalSearch_Previews: PreviewProvider {
    static var previews: some View {
        ModalSearch(isPresenting: .constant(true), objectType: .goal)
            .environmentObject(DataModel())
    }
}
