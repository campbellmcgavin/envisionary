//
//  TextIconButton.swift
//  Envisionary
//
//  Created by Campbell McGavin on 8/5/23.
//

import SwiftUI

struct TextIconButton: View {
    @Binding var isPressed: Bool
    let text: String
    let color: CustomColor
    let backgroundColor: CustomColor
    let fontSize: CustomFont
    let shouldFillWidth: Bool
    var iconType: IconType? = nil
    var hasAnimation: Bool = false
    var addHeight: CGFloat = 0
    var iconPositionRight: Bool = true
    var body: some View {
        Button{
            
            if hasAnimation{
                withAnimation{
                    isPressed.toggle()
                }
            }
            else{
                isPressed.toggle()
            }

        }
    label:{
        TextIconLabel(text: text, color: color, backgroundColor: backgroundColor, fontSize: fontSize, shouldFillWidth: shouldFillWidth, iconType: iconType, addHeight: addHeight, iconPositionRight: iconPositionRight)
    }
    }

}

struct TextIconButton_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView{
            VStack{
                ForEach(CustomFont.allCases, id:\.self){
                    font in
                    TextIconButton(isPressed: .constant(false), text: "Title " + font.toString(), color: .grey10, backgroundColor: .grey2, fontSize: font, shouldFillWidth: true)
                }
                
                ForEach(CustomFont.allCases, id:\.self){
                    font in
                    TextIconButton(isPressed: .constant(false), text: "Title " + font.toString(), color: .grey10, backgroundColor: .purple, fontSize: font, shouldFillWidth: true, iconType: IconType.allCases.randomElement())
                }
                
                ForEach(CustomFont.allCases, id:\.self){
                    font in
                    TextIconButton(isPressed: .constant(false), text: "Title " + font.toString(), color: .grey3, backgroundColor: .grey10, fontSize: font, shouldFillWidth: false, iconType: IconType.allCases.randomElement())
                }
                
                ForEach(CustomFont.allCases, id:\.self){
                    font in
                    TextIconButton(isPressed: .constant(false), text: "Title " + font.toString(), color: .grey10, backgroundColor: .purple, fontSize: font, shouldFillWidth: false)
                }
                
                ForEach(CustomFont.allCases, id:\.self){
                    font in
                    TextIconButton(isPressed: .constant(false), text: "Title " + font.toString(), color: .grey3, backgroundColor: .grey10, fontSize: font, shouldFillWidth: false, iconType: IconType.allCases.randomElement(), iconPositionRight: false)
                }
            }
        }


    }
}




struct TextIconLabel: View {
    let text: String
    let color: CustomColor
    let backgroundColor: CustomColor
    let fontSize: CustomFont
    let shouldFillWidth: Bool
    var iconType: IconType? = nil
    var iconColor: CustomColor?
    var addHeight: CGFloat = 0
    var iconPositionRight: Bool = true
    var iconOpacity: CGFloat = 1.0
    @State var height = CGFloat.zero
    
    var body: some View {
        HStack{
            
            if !iconPositionRight{
                BuildIcon()
            }
            if shouldFillWidth && iconType == nil {
                Spacer()
            }
            Text(text)
                .font(.specify(style: fontSize))
                .multilineTextAlignment(iconType == nil ? .center : .leading)
                .foregroundColor(.specify(color: color))
                .padding([.leading], height * 0.4)
                .padding(.trailing, height * 0.4)
                .padding([.top,.bottom], iconType != nil ? 0 : height * 0.2)
            if shouldFillWidth {
                Spacer()
            }
            
            if iconPositionRight{
                BuildIcon()
            }

        }
        .modifier(ModifierMaxWidth(infinity: false))
        .padding([.top,.bottom], height * 0.15 + addHeight)
        .background(
            Capsule()
                .foregroundColor(.specify(color: backgroundColor))
                )
        .onAppear{
            height = fontSize.GetHeight()
        }
    }
    
    @ViewBuilder
    func BuildIcon() -> some View{
        if let iconType{
            ZStack{
                Circle()
                    .frame(width:height, height: height)
                    .foregroundColor(Color.specify(color: color))
                    .frame(alignment:.trailing)
                    .opacity(iconOpacity)
                iconType.ToIconString().ToImage(imageSize: height)
                    .foregroundColor(.specify(color: iconColor != nil ? iconColor! : backgroundColor))
                    .frame(alignment:.trailing)
            }
            .frame(alignment:.trailing)
            .padding(height * 0.05)
            .padding(iconPositionRight ? .trailing : .leading, height * 0.16)
        }
    }
}
