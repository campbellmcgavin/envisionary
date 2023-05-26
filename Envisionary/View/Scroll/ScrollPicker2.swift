//
//  ScrollPicker2.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/25/23.
//

import SwiftUI

struct ScrollPicker2: View {
    
    var width: SizeType = SizeType.minimumTouchTarget
    var axes: Axis.Set = [.horizontal]
    var shouldHavePadding: Bool = true
    @State var index: Int = 0 //binding
    @State var items = Array(1...30)
    @State var size: CGSize = .zero
    @State var offset: CGPoint = .zero
    @State var isFinished = false
    
    var body: some View {
        
        let dragGesture = DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onEnded { _ in
                withAnimation {
                    offset = .zero
                    isFinished = true
                }
            }
        
        ScrollViewReader{
            proxy in
            
            ZStack{
                VStack{
                    HStack{
                        Text(isFinished ? "Finished" : "Not")
                            .offset(y:-50)
                        Spacer()
                    }
                    HStack{
                        Text(offset.x.formatted())
                            .offset(y:-50)
                        Spacer()
                    }
                }


                ObservableScrollView(axes: axes, offset: $offset){
                    HStack{
                        if axes == .horizontal {
                            HStack{
                                ForEach(items, id:\.self){
                                    item in
                                    SetupButton(item: item)
                                        .contentShape(Rectangle())
                                        .id(item)
                                        .gesture(
                                            dragGesture
                                        )
                                }
                                .frame(height:100)
                                .frame(maxWidth:.infinity)
 
                            }
                            .padding([.leading,.trailing], shouldHavePadding ? size.width/2 : 0)



                        }
                        else{
                            VStack{
                                ForEach(items, id:\.self){
                                    item in
                                    SetupButton(item: item)
                                        .id(item)
                                }
                            }
                            .padding([.top,.bottom], shouldHavePadding ? size.height/2 : 0)
 
                        }
                    }

                    .onChange(of: index){ _ in
                        withAnimation{
                            proxy.scrollTo(index, anchor:.center)
                        }
                    }
   
                    .contentShape(Rectangle())

                }
                

            }
        }
        .saveSize(in: $size)

    }
    
    func ComputeIndex(){
        let _ = "why"
        isFinished.toggle()
    }
    
    @ViewBuilder
    func SetupButton(item: Int) -> some View{
        Button(){
            index = item
        }
    label:{
        ZStack{
            Circle()
                .frame(width:30, height:30)
                .foregroundColor(.specify(color: .grey8))
            Text(String(item))
                .font(.specify(style: .h6))
        }
        .frame(width: width.ToSize())
    }
    }
}

struct ScrollPicker2_Previews: PreviewProvider {
    static var previews: some View {
        ScrollPicker2()
    }
}
