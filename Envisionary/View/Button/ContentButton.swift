//
//  ContentButton.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/8/23.
//

import SwiftUI

struct ContentButton: View {
    @Binding var selectedContentView: ContentViewType
    let contentView: ContentViewType
//    var setupStep: SetupStepType
//    @State var timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    @State var isGlowing: Bool = false
    
    var body: some View {
        
        Button(action: {
            selectedContentView = contentView
            
        }) {
            ZStack{
                
                VStack{
                    if contentView == selectedContentView {
                        IconLabel(size: .medium, iconType: contentView.toFilledIcon(), iconColor: GetColor())
                    }
                    else{
                        IconLabel(size: .medium, iconType: contentView.toIcon(), iconColor: GetColor())
                    }
                        
                    Text(contentView.toString()).font(.specify(style: .subCaption))
                        .foregroundColor(.specify(color: GetColor()))
                        .padding(.top,-12)
                    
                }
//                .opacity(GetOpacity())
                .frame(height:SizeType.medium.ToSize()+10)
//                .onReceive(timer){ _ in
////                    if setupStep != .garduated{
////                        withAnimation(.easeInOut(duration: 0.4)){
////                            self.isGlowing.toggle()
////                        }
////                    }
//                }

            }
            .frame(height:SizeType.medium.ToSize() + 10)
        }
//        .disabled(GetIsDisabled())
    }
    
//    func GetIsGlowing() -> Bool{
//        return isGlowing && GetShouldGlow()
//    }
//
//    func GetShouldGlow() -> Bool {
//        let contentType = setupStep.toObject().toContentType()
//        return  contentType == contentView && contentView != selectedContentView
//    }
    
    func GetColor() -> CustomColor{
        if contentView == selectedContentView{
            return .purple
        }
//        else if GetIsGlowing(){
//            return .grey6
//        }
        return .grey4
    }
    
//    func GetOpacity() -> CGFloat{
//
//        if (!GetIsDisabled()){
//            return 1.0
//        }
//        else{
//            return 0.2
//        }
//    }
    
//    func GetIsDisabled() -> Bool{
//        return !((setupStep.toObject() ?? .value).toContentType().toInt() >= contentView.toInt())
//    }
    
}

//struct ContentButton_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack{
//            Spacer()
//            HStack(spacing:27){
//                ContentButton(selectedContentView: .constant(.envision), contentView: .envision)
//                ContentButton(selectedContentView: .constant(.plan), contentView: .plan)
//                ContentButton(selectedContentView: .constant(.execute), contentView: .execute)
//                ContentButton(selectedContentView: .constant(.journal), contentView: .journal)
//                ContentButton(selectedContentView: .constant(.evaluate), contentView: .evaluate)
//            }
//            .padding(.bottom)
//            .frame(maxWidth:.infinity)
//            .background(Color.specify(color: .grey1))
//            Spacer()
//            HStack(spacing:27){
//                ContentButton(selectedContentView: .constant(.envision), contentView: .envision)
//                ContentButton(selectedContentView: .constant(.envision), contentView: .plan)
//                ContentButton(selectedContentView: .constant(.plan), contentView: .execute)
//                ContentButton(selectedContentView: .constant(.plan), contentView: .journal)
//                ContentButton(selectedContentView: .constant(.plan), contentView: .evaluate)
//            }
//            .frame(maxWidth:.infinity)
//            .background(Color.specify(color: .grey1))
//
//        }
//        .frame(maxWidth:.infinity)
//        .background(Color.specify(color: .grey0))
//
//    }
//}
