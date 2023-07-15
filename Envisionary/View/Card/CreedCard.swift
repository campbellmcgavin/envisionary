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

    }
    
    @ViewBuilder
    func MainContentBuilder() -> some View{
        VStack(alignment:.leading, spacing:0){
            
            if shouldShowCard{
                PhotoCard(objectType: .creed, objectId: UUID(), properties: Properties(creed: true, valueCount: vm.ListCoreValues().count), shouldHidePadding: false)
            }

            CreedCardList()
        }
        .frame(maxWidth:.infinity)
        .modifier(ModifierCard())
    }
}

struct CreedCardList: View{
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View{
        VStack(alignment:.leading){
            Item(caption: "Introduction", body: vm.GetCoreValue(coreValue: .Introduction)?.description ?? "")
//                .padding(.top)
            let coreValues = vm.ListCoreValues()
            ForEach(coreValues){ coreValue in
                if coreValue.title != ValueType.Introduction.toString() && coreValue.title != ValueType.Conclusion.toString() {
                    Item(caption: coreValue.title, body: coreValue.description)
                }
            }
            
            Item(caption: "Conclusion", body: vm.GetCoreValue(coreValue: .Conclusion)?.description ?? "")
        }
        .multilineTextAlignment(.leading)
        .frame(maxWidth:.infinity)
        .frame(alignment:.leading)
        .padding()
        .modifier(ModifierForm(color: .grey15))
        .padding(10)
    }
    
    @ViewBuilder
    func Item(caption: String, body: String) -> some View {
        HStack{
            VStack(alignment:.leading, spacing:0){
                Text(caption)
                    .font(.specify(style: .caption))
                    .foregroundColor(.specify(color: .grey5))
                    .frame(alignment:.leading)

                Text(body)
                    .font(.specify(style: .body1))
                    .foregroundColor(.specify(color: .grey10))
                    .frame(alignment:.leading)
            }
            Spacer()
        }
        .frame(alignment:.leading)
        .frame(maxWidth:.infinity)
//        .padding()
        
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
