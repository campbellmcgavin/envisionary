//
//  WrappingVStack.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/19/23.
//

import SwiftUI
struct WrappingHStack: View {
    @Binding var fieldValue: String
    @Binding var fieldValues: [String: Bool]
    @Binding var options: [String]
    @Binding var isEditing: Bool
    @Binding var deleteMe: String
    var isMultiSelector = false
    var isRestrictingOptions = false
    var maxCount = 20
    var fontSize: CustomFont = .caption
    @State private var totalHeight
          = CGFloat.zero       // << variant for ScrollView/List
    //    = CGFloat.infinity   // << variant for VStack

    var body: some View {
        VStack {
            GeometryReader { geometry in
                
                if isRestrictingOptions {
                    Text("Options exceed maximum amount. Search to narrow results.")
                        .multilineTextAlignment(.leading)
                        .font(.specify(style: .caption))
                        .foregroundColor(.specify(color: .grey5))
                        .padding()
                        .padding(.top,totalHeight)
                }
                
                self.generateContent(in: geometry)
                    .padding(.bottom, isRestrictingOptions ? 40 : 0)
                

            }
        }
        .frame(height: totalHeight)
        .padding(.bottom, isRestrictingOptions ? 25 : 0)
        
//         << variant for ScrollView/List
//        .frame(maxHeight: totalHeight) // << variant for VStack
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
                ForEach(self.options, id: \.self) { tag in
                    self.item(for: tag)
                        .padding([.horizontal, .vertical], 4)
                        .alignmentGuide(.leading, computeValue: { d in
                            if (abs(width - d.width) > g.size.width)
                            {
                                width = 0
                                height -= d.height
                            }
                            let result = width
                            if tag == self.options.last! {
                                width = 0 //last item
                            } else {
                                width -= d.width
                            }
                            return result
                        })
                        .alignmentGuide(.top, computeValue: {d in
                            let result = height
                            if tag == self.options.last! {
                                height = 0 // last item
                            }
                            return result
                        })
                }
            }.background(viewHeightReader($totalHeight))

    }

    private func item(for text: String) -> some View {
        
        Button{
            if isMultiSelector{
                if fieldValues[text] != nil{
                    if fieldValues[text]!{
                        fieldValues[text]! = false
                    }
                    else{
                        fieldValues[text]! = true
                    }
                }
            }
            else{

                
                if isEditing{
                    deleteMe = text
                }
                else{
                    fieldValue = ""
                    fieldValue = text
                }
            }
        }
        label:{
            TextIconLabel(text: text, color: .grey10, backgroundColor: GetColor(text:text), fontSize: .caption, shouldFillWidth: false)
                .if(isEditing){
                    view in
                    view
                        .overlay(alignment:.topTrailing){
                            
                            IconLabel(size: .extraSmall, iconType: .cancel, iconColor: .grey10, circleColor: .grey4)
                                .offset(x:15,y:-15)
                            .wiggling(intensity:0.5)}
                        
                    
                }
        }
    }
    
    private func GetColor(text: String) -> CustomColor{
        
        if isMultiSelector{
            if fieldValues[text] == true{
                return .purple
            }
            else{
                return .grey3
            }
        }
        else{
            if fieldValue == text {
                return .purple
            }
            else{
                return .grey3
            }
        }
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

struct WrappingHStack_Previews : PreviewProvider {
    static var previews: some View {
        VStack {
//            Text("Header").font(.largeTitle)
            WrappingHStack(fieldValue: .constant("Children"), fieldValues: .constant([String:Bool]()), options: .constant(AspectType.allCases.map({$0.toString()})), isEditing: .constant(true), deleteMe: .constant(""))

        }
        .frame(maxWidth:.infinity,maxHeight:.infinity)
        .modifier(ModifierCard())
    }
}

