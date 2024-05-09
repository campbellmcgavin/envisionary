//
//  HeaderText.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/26/24.
//

import SwiftUI

struct DetailHeaderText<Content: View>: View {
    var title: String
    var subtitle: String
    let color: CustomColor
    var modalType: ModalType?
    let objectType: ObjectType

    @ViewBuilder var content: Content
    @State var offset: CGPoint = .zero
    let headerFrame: CGFloat = 150
    let coordinateSpaceName = "HeaderText" + UUID().uuidString
    var body: some View {
        

        
        VStack(alignment:.leading, spacing:0){
            HStack(alignment:.top, spacing:0){
                VStack(alignment:.leading, spacing:0){
                    Text(subtitle)
                    .textCase(.uppercase)
                    .font(.specify(style: .caption))
                    .foregroundColor(.specify(color: .grey10))
                    .opacity(0.5)
                    .padding(.bottom,-6)

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
                        content: {                    Text(title)
                                .font(.specify(style: .h2))
                                .lineLimit(1)
                                .foregroundColor(.specify(color: .grey10))
                                .padding(.bottom,10)    }
                    )
                    

                    
            }
                .opacity(GetOpacity())
                .offset(y:65)
                .frame(maxHeight:.infinity)
                .padding(.leading)
                .scaleEffect(GetScaleEffect(), anchor: .bottomLeading)

            Spacer()
        }

            content
                .frame(alignment:.center)
                .opacity(GetOpacity())
        }
        .padding(.bottom, objectType.ShouldShowImage() && (modalType != .search) ? 100 : 15)
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
    }
    
    func GetScaleEffect() -> CGFloat {
    //        let scale = modalType == nil ? (offset.y > 0 ?  1.0 : 1.0 - 0.0015 * offset.y) : 1
        let scale = modalType?.GetIsMini() ?? false ? 1 : (offset.y + 163.2 > 0 ?  1.0 : 1.0 - 0.0015 * (offset.y + 163.2))
        return scale
    }

    func GetOffset() -> CGFloat {
        let offset = modalType?.GetIsMini() ?? false ? 0 : (modalType == nil ? (offset.y + 163.2 < 0 ? (offset.y + 163.2) * 0.5 : 0) : 0)
        return offset
    }

    func ShouldShowImage() -> Bool{
        return modalType?.GetIsMini() ?? false ? true : (modalType == nil ? objectType.ShouldShowImage() : modalType!.ShouldShowImage(objectType: objectType))
    }

    func GetOpacity() -> CGFloat{
        let opacity = modalType == nil ? (1.0 - ((1.0 * (offset.y + 163.2)/headerFrame*2))) : 1.0
        return opacity
    }

    func GetRadius() -> CGFloat{
        if offset.y + 163.2 > 0 {
            let radius = abs( 36 - ((36 * (offset.y + 163.2)/(headerFrame + (ShouldShowImage() ? 0 : 24)))))
            return radius
        }
        return 36
    }
}



#Preview {
    DetailHeaderText(title: "New goal", subtitle: "A description", color: .blue, objectType: .goal, content: {EmptyView()})
}
