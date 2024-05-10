//
//  ScrollingHStack.swift
//  Envisionary
//
//  Created by Campbell McGavin on 8/10/23.
//

import SwiftUI

struct SelectableHStack: View {
    @Binding var fieldValue: String
    @Binding var options: [String]
    var fontSize: CustomFont = .caption
    var shouldScroll: Bool = false
    var iconType: IconType? = nil
    var color: CustomColor = .purple
    var body: some View {
        
        if shouldScroll{
            ScrollView(.horizontal){
                HStack(spacing:10){
                    BuildView()
                }
            }
        }
        else{
            HStack{
                BuildView()
            }
            .frame(maxWidth:.infinity)
            .modifier(ModifierCard(color:.grey2, padding:0))
        }
    }
    
    @ViewBuilder
    func BuildView() -> some View{
        ForEach(options, id:\.self){
            option in
            Button{
                withAnimation{
                    fieldValue = option
                }
                
            }
        label:{
            TextIconLabel(text: option, color: .grey10, backgroundColor: GetColor(text: option), fontSize: fontSize, shouldFillWidth: shouldScroll ? false : true)
        }
        }
    }
    
    private func GetColor(text: String) -> CustomColor{
        if fieldValue == text {
            return color
        }
        else{
            return .clear
        }
    }
}




struct ScrollingHStack_Previews: PreviewProvider {
    static var previews: some View {
        SelectableHStack(fieldValue:.constant(ViewType.goalValueAlignment.toString()),options:.constant(Array(ViewType.allCases.map({$0.toString()}))))
            .padding(8)
            .modifier(ModifierCard())
    }
}
