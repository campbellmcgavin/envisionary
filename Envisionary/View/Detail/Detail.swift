//
//  DetailHeader.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/11/23.
//

import SwiftUI

struct DetailHeader: View {
    
    let objectType: ObjectType
    let header: String
    let shouldShowImage: Bool
    @State var shouldGoBack: Bool = false
    @State var shouldExpandAll: Bool = true
    @State var isPresentingDelete: Bool = false
    @State var isPresentingHelp: Bool = false
    @State var isPresentingEdit: Bool = false
    @State var isPresentingAdd: Bool = false
    @State var offset: CGPoint = .zero
    
    @State var headerFrame: CGSize = .zero
    @State var properties = Properties()
    @State var shouldPop = false
    
    @Environment(\.presentationMode) private var dismiss
    
    var body: some View {
        
        ZStack(alignment:.top){
            
            
            VStack(spacing:0){
                    ObservableScrollView(offset: $offset, content:{
                                
                                //header
                                ZStack(alignment:.top){
                                    VStack{
                                        VStack(alignment:.leading, spacing:0){
                                            HStack(alignment:.top, spacing:0){
                                                VStack(alignment:.leading, spacing:0){
                                                    Text(header + " " + objectType.toString())
                                                    .textCase(.uppercase)
                                                    .font(.specify(style: .caption))
                                                    .foregroundColor(.specify(color: .grey10))
                                                    .opacity(0.5)
                                                    .padding(.bottom,-8)

                                                Text(properties.title ?? "")
                                                    .font(.specify(style: .h2))
                                                    .foregroundColor(.specify(color: .grey10))
                                                    .padding(.bottom,10)
                                                    
                                            }
                                                .opacity(GetOpacity())
                                                .offset(y:65)
                                                .frame(maxHeight:.infinity)
                                            .padding(.leading)

                                                
                                            Spacer()
                                        }
                                            .padding(.bottom,shouldShowImage ? 100 : 0)
                                            .saveSize(in: $headerFrame)
                                            .padding(.top,85)
                                            .padding(.bottom,shouldShowImage ? 70 : 0)
                                            .background(
                                                Color.specify(color: .purple)
                                                    .modifier(ModifierRoundedCorners(radius: GetRadius()))
                                                    .edgesIgnoringSafeArea(.all)
                                                    .padding(.top,-1000)
                                                    .frame(maxHeight:.infinity)
                                                    .offset(y:shouldShowImage ? 0 : 65))
        

                                        }
                                        .frame(maxWidth:.infinity,maxHeight:.infinity)
                                        
                                        VStack{
                                            
                                            if(shouldShowImage){
                                                Button{
                                                    shouldPop.toggle()
                                                }
                                            label:{
                                                    Ellipse()
                                                        .frame(width:200, height:GetCircleHeight())
                                                        .frame(alignment: .center)
                                                        .foregroundColor(.specify(color: .grey2))
                                                        .opacity(GetOpacity())
                                                        .offset(y:offset.y > 0 ? -offset.y/2 : -offset.y/3)
                                                        
                                                }
         
                                                
                                            }
                                            
                                            VStack{
                                                ParentHeaderButton(shouldExpandAll: $shouldExpandAll, color: .purple, header: "Expand All", headerCollapsed: "Collapse All")
                                                DetailProperties(shouldExpand: $shouldExpandAll, objectType: .goal, properties: GetProperties())
                                                    .frame(maxWidth:.infinity)
                                                    .padding(.bottom,15)
                                                DetailProperties(shouldExpand: $shouldExpandAll, objectType: .goal, properties: GetProperties())
                                                    .frame(maxWidth:.infinity)
                                                    .padding(.bottom,15)
                                                    
                                            }
                                            .modifier(ModifierCard())
                                                .offset(y:offset.y < 150 ? -offset.y/1.5 : -100)
                                        }
                                        .frame(alignment:.leading)
                                        .offset(y:-110)
                                    }
         




                                }
                                .frame(alignment:.top)

                        
                        Spacer()
                                .frame(height:200)

                        })
                
               
                    

                }
            .ignoresSafeArea()

                
            DetailMenu(dismiss: dismiss, isPresentingDelete: $isPresentingDelete, isPresentingHelp: $isPresentingHelp, isPresentingEdit: $isPresentingEdit, isPresentingAdd: $isPresentingAdd)
                .frame(alignment:.top)
        }
        .background(Color.specify(color: .grey1))
        .navigationBarHidden(true)

    }
    
    func GetCircleHeight() -> CGFloat{
        if offset.y < 0 {
            return 200 - offset.y * 0.2
        }
        return 200
    }
    
    func GetProperties() -> Properties {
        return Properties()
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

struct DetailHeader_Previews: PreviewProvider {
    static var previews: some View {
        DetailHeader(objectType: .goal, header: "view", shouldShowImage: true)
    }
}
