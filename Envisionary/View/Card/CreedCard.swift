//
//  CreedCard.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/8/23.
//

import SwiftUI

struct CreedCard: View {
    
    var shouldShowCard = true
    
    @EnvironmentObject var vm: ViewModel
    var body: some View {
        
        MainContentBuilder()
            .padding()
            .frame(alignment:.leading)
            .modifier(ModifierCard())
    }
    
    @ViewBuilder
    func MainContentBuilder() -> some View{
        VStack(alignment:.leading, spacing:0){
            
            if shouldShowCard{
                PhotoCard(objectType: .creed, objectId: UUID(), properties: Properties(creed: true, valueCount: vm.ListCoreValues().count), header: "Creed", subheader: "", shouldHidePadding: true)
                    .padding(.top,-15)
                    .padding(.bottom,8)
            }
            
            VStack(alignment:.leading, spacing:0){
                Item(caption: "Introduction", body: vm.GetCoreValue(coreValue: .Introduction)?.description ?? "")
                
                ForEach(vm.ListCoreValues()){ coreValue in
                    if coreValue.coreValue != .Introduction && coreValue.coreValue != .Conclusion {
                        Item(caption: coreValue.coreValue.toString(), body: coreValue.description)
                    }
                }
                
                Item(caption: "Conclusion", body: vm.GetCoreValue(coreValue: .Conclusion)?.description ?? "")
            }
            .padding(.top,5)
            .frame(alignment:.leading)
            .modifier(ModifierCard(color: .grey15,radius:SizeType.cornerRadiusSmall.ToSize()))
        }
    }
    
    @ViewBuilder
    func Item(caption: String, body: String) -> some View {
        VStack(alignment:.leading, spacing:3){
            Text(caption)
                .font(.specify(style: .caption))
                .foregroundColor(.specify(color: .grey5))
            Text(body)
                .font(.specify(style: .body1))
                .foregroundColor(.specify(color: .grey10))
        }
        .padding([.top,.bottom],10)
        .frame(alignment:.leading)
        .padding([.leading,.trailing])
        
        if caption != "Conclusion" {
            StackDivider(shouldIndent: false)
        }
    }
}

struct CreedCard_Previews: PreviewProvider {
    static var previews: some View {
        CreedCard()
            .environmentObject(ViewModel())
    }
}
