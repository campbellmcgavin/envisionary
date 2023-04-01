//
//  WrappingVStack.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/19/23.
//

import SwiftUI
struct WrappingHStack: View {
    @Binding var fieldValue: String
    @Binding var options: [String]

    @State private var totalHeight
          = CGFloat.zero       // << variant for ScrollView/List
    //    = CGFloat.infinity   // << variant for VStack

    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)
        
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
            fieldValue = ""
            fieldValue = text
        }
        label:{
            Text(text)
                .font(.specify(style: .caption))
                .frame(height:38)
                .foregroundColor(.specify(color: .grey10))
                .padding([.leading,.trailing],12)
                .background(Color.specify(color:  fieldValue == text ? .purple : .grey3))
                .cornerRadius(22)
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
            WrappingHStack(fieldValue: .constant("Children"), options: .constant(AspectType.allCases.map({$0.toString()})))

        }
        .frame(maxWidth:.infinity,maxHeight:.infinity)
        .modifier(ModifierCard())
    }
}

