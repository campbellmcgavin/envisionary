//
//  Header.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/17/23.
//

import SwiftUI

struct Header<Content: View>: View {
    @State var offset: CGPoint = CGPoint()
    var title: String
    var subtitle: String
    var objectType: ObjectType
    let color: CustomColor
    @Binding var headerFrame: CGSize
    @Binding var isPresentingImageSheet: Bool
    var modalType: ModalType?
    var image: UIImage?
    
    @ViewBuilder var content: Content
    private let coordinateSpaceName = UUID()
    
    var body: some View {
        
        PositionObservingView(
            coordinateSpace: .named(coordinateSpaceName),
            position: Binding(
                get: { offset },
                set: { newOffset in
                    offset = CGPoint(
                        x: -newOffset.x,
                        y: -newOffset.y
                    )
                }
            ),
            content: {BuildHeader()}
        )
    }
    
    @ViewBuilder
    func BuildHeader() -> some View{
        ZStack{
            VStack(alignment:.leading, spacing:0){
                HStack(alignment:.top, spacing:0){
                    VStack(alignment:.leading, spacing:0){
                        Text(subtitle)
                        .textCase(.uppercase)
                        .font(.specify(style: .caption))
                        .foregroundColor(.specify(color: .grey10))
                        .opacity(0.5)
                        .padding(.bottom,-6)

                    Text(title)
                        .font(.specify(style: .h2))
                        .lineLimit(1)
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
            .padding(.bottom, objectType.ShouldShowImage() && (modalType != .search) ? 100 : 15)
            .saveSize(in: $headerFrame)
            .padding(.top, 85)
            .padding(.bottom, objectType.ShouldShowImage() && (modalType != .search) ? 70 : 0)
            .background(
                Color.specify(color: color)
                    .modifier(ModifierRoundedCorners(radius: GetRadius()))
                    .edgesIgnoringSafeArea(.all)
                    .padding(.top,-1000)
                    .frame(maxHeight:.infinity)
                    .offset(y: objectType.ShouldShowImage() && (modalType != .search) ? 0 : 65))
            .frame(maxWidth:.infinity,maxHeight:.infinity)
            
            if(ShouldShowImage()){
                HeaderImage(offset: offset, headerFrame: headerFrame, modalType: modalType, image: image, isPresentingImageSheet: $isPresentingImageSheet)
                
            }
//            if modalType == nil && objectType.hasDetailMenuButton(button: .favorite){
//                VStack(){
//                    Spacer()
//                    HStack{
//                        Spacer()
//                        IconButton(isPressed: .constant(false), size: .medium, iconType: .favorite, iconColor: .grey10, circleColor: .grey0, opacity: 0.5, circleOpacity: 0.2)
//                    }
//                }
//
//                .padding()
////                .offset(y: ShouldShowImage() ? 100 : 50)
//            }
        }
    }
    
    func ShouldShowImage() -> Bool{
        return modalType == nil ? objectType.ShouldShowImage() : modalType!.ShouldShowImage(objectType: objectType)
    }
    
    func GetOpacity() -> CGFloat{
            return  (1.0 - ((1.0 * offset.y/headerFrame.height*2)))
    }
    
    func GetRadius() -> CGFloat{
        if offset.y > 0 {
            return abs( 36 - ((36 * offset.y/(headerFrame.height + (ShouldShowImage() ? 0 : 24)))))
        }
        return 36
    }
}

//struct Header_Previews: PreviewProvider {
//    static var previews: some View {
//        Header(offset: .constant(.zero), title: "VIEW GOAL", subtitle: "Learn Spanish", objectType: .goal, modalType: .add, color: .red, headerFrame: .constant(.zero), content: {EmptyView()})
//    }
//}
