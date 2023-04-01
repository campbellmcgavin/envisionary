//
//  Header.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/17/23.
//

import SwiftUI

struct Header<Content: View>: View {
    @Binding var offset: CGPoint
    var title: String
    var subtitle: String
    var objectType: ObjectType
    let shouldShowImage: Bool
    let color: CustomColor
    @Binding var headerFrame: CGSize
    @ViewBuilder var content: Content
    
    var body: some View {
        
        ZStack{
            VStack(alignment:.leading, spacing:0){
                HStack(alignment:.top, spacing:0){
                    VStack(alignment:.leading, spacing:0){
                        Text(subtitle)
                        .textCase(.uppercase)
                        .font(.specify(style: .caption))
                        .foregroundColor(.specify(color: .grey10))
                        .opacity(0.5)
                        .padding(.bottom,-8)

                    Text(title)
                        .font(.specify(style: .h2))
                        .lineLimit(2)
                        .foregroundColor(.specify(color: .grey10))
                        .padding(.bottom,10)
                        
                }
                    .opacity(GetOpacity())
                    .offset(y:65)
                    .frame(maxHeight:.infinity)
                    .padding(.leading)
                    .scaleEffect(offset.y > 0 ?  1.0 : 1.0 - 0.0015 * offset.y, anchor: .bottomLeading)

                Spacer()
            }

                content
                    .frame(alignment:.center)
                    .opacity(GetOpacity())
            }
            .padding(.bottom,shouldShowImage ? 100 : 15)
            .saveSize(in: $headerFrame)
            .padding(.top,85)
            .padding(.bottom,shouldShowImage ? 70 : 0)
            .background(
                Color.specify(color: color)
                    .modifier(ModifierRoundedCorners(radius: GetRadius()))
                    .edgesIgnoringSafeArea(.all)
                    .padding(.top,-1000)
                    .frame(maxHeight:.infinity)
                    .offset(y:shouldShowImage ? 0 : 65))
            .frame(maxWidth:.infinity,maxHeight:.infinity)
            
            if(shouldShowImage){
                Ellipse()
                    .frame(width:SizeType.headerCircle.ToSize(), height:GetCircleHeight())
                    .frame(alignment: .center)
                    .foregroundColor(.specify(color: .grey1))
                    .opacity(GetOpacity())
                    .offset(y:offset.y > 0 ? headerFrame.height-offset.y/2 : headerFrame.height-offset.y/3)
            }
        }
        

    }
    
    func GetCircleHeight() -> CGFloat{
        if offset.y < 0 {
            return SizeType.headerCircle.ToSize() - offset.y * 0.2
        }
        return SizeType.headerCircle.ToSize()
    }
    
    func GetOpacity() -> CGFloat{
//        if offset.y > 0 {
            return  (1.0 - ((1.0 * offset.y/headerFrame.height*2)))
//            if num < 0 {
//                return 0
//            }
//            return num
//        }
//        return 1.0
    }
    
    func GetRadius() -> CGFloat{
        if offset.y > 0 {
            return abs( 36 - ((36 * offset.y/headerFrame.height)))
        }
        return 36
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header(offset: .constant(.zero), title: "VIEW GOAL", subtitle: "Learn Spanish", objectType: .goal, shouldShowImage: true, color: .red, headerFrame: .constant(.zero), content: {EmptyView()})
    }
}
