//
//  PickerWheelTextView.swift
//  Visionary
//
//  Created by Campbell McGavin on 3/24/22.
//

import SwiftUI

struct ScrollPickerObjectText: View {
    
    let object: ObjectType
    let width: CGFloat
    @Binding var selectionObject: ObjectType
//    @Binding var setupStep: SetupStepType
    var unlocked: Bool
    
    @State var isGlowing = false
    @State var timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    var body: some View {

        ZStack{
//            ScrollPickerSelectedRectangle(color: .grey10)
//                .opacity(isGlowing ? 1.0 : 0.0)
//                .offset(y:3)
            
            Circle()
                .frame(width: 9, height:9)
                .foregroundColor(.specify(color: .red))
                .opacity(unlocked ? 0.0 : GetOpacity())
                .offset(x:27,y:-8)
            
            Text(object.toPluralString())
                .foregroundColor(.specify(color: .grey10))
                .font(.specify(style: .h6))
                .frame(width:width)
                .opacity(GetOpacity())
                .padding(.top,3)
//                .onAppear{
//                    if (setupStep.toObject() ?? .value) != object {
//                        stopTimer()
//                    }
//                }
//                .onReceive(timer, perform: {_ in
//                    withAnimation{
//                        isGlowing.toggle()
//                    }
//                })
//                .onChange(of: setupStep){
//                    _ in
//
//                    if (setupStep.toObject() ?? .value) != object {
//                        stopTimer()
//                        isGlowing = false
//                    }
//
//                }
        }

    }
    
    func IsSelected() -> Bool{
        if object.rawValue == selectionObject.rawValue{
            return true
        }
        else{
            return false
        }
    }
    
    func GetOpacity() -> CGFloat{

        if IsSelected() || isGlowing{
            return 1
        }
        else{
            return 0.5
        }
    }
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
}

struct ScrollPickerObjectText_Previews: PreviewProvider {
    static var previews: some View {
        ScrollPickerObjectText(object: ObjectType.home, width: SizeType.scrollPickerWidth.ToSize(), selectionObject: .constant(.home), unlocked: false)
    }
}
