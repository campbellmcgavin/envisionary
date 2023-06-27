//
//  SetupGoalIntro.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/8/23.
//

import SwiftUI

struct SetupGoalIntro: View {
    @Binding var canProceed: Bool
    @State var shouldWiggle: Bool = false
    
    var body: some View {
        let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
        
        VStack{
            ZStack{
                ForEach(0...6, id:\.self){
                    number in
                    BuildCircle(item: number, shouldWiggle: shouldWiggle)
                }
            }
            .frame(maxWidth:.infinity)
            Spacer()
        }
        .offset(y:25)
        .frame(height:400)
        .padding([.top,.bottom],8)
        .onReceive(timer, perform: { _ in
            if !shouldWiggle {
                shouldWiggle = true
            }
        })
        .onAppear(){
            canProceed = true
        }
    }
    
    @ViewBuilder
    func BuildCircle(item: Int, shouldWiggle: Bool) -> some View{
        let offset = GetOffset(item: item)
        let size = GetSize(item: item)
        
        ZStack{
            Circle()
                .foregroundColor(.specify(color: .purple))
                .frame(width:size.ToSize(), height: size.ToSize())
            
            Circle()
                .foregroundColor(.specify(color: .grey10))
                .frame(width: size.ToSize() - size.ToSize()*0.24)
            
            GetImageString(item: item).ToImage(imageSize: size.ToSize())
                .foregroundColor(.specify(color: .purple))
        }
        .offset(x: offset.x, y: offset.y)
        .wiggling(shouldWiggle: shouldWiggle, intensity: 0.9)
    }
    
    func GetImageString(item: Int) -> String{
        switch item{
        case 0:
            return "Icon_Timeframe_Decade"
        case 1:
            return "Icon_Timeframe_Year"
        case 2:
            return "Icon_Timeframe_Year"
        case 3:
            return "Icon_Timeframe_Month"
        case 4:
            return "Icon_Timeframe_Month"
        case 5:
            return "Icon_Timeframe_Month"
        case 6:
            return "Icon_Timeframe_Month"
        case 7:
            return "Icon_Timeframe_Week"
        case 8:
            return "Icon_Timeframe_Week"
        case 9:
            return "Icon_Timeframe_Week"
        case 10:
            return "Icon_Timeframe_Week"
        case 11:
            return "Icon_Timeframe_Week"
        case 12:
            return "Icon_Timeframe_Week"
        default:
            return "Icon_Timeframe_Day"
        }
    }
    
    func GetOffset(item: Int) -> Position{
        switch item{
        case 0:
            return Position(x: 0, y: 0)
        case 1:
            return Position(x: -65, y: 130)
        case 2:
            return Position(x: 65, y: 130)
        case 3:
            return Position(x: -115, y: 230)
        case 4:
            return Position(x: -40, y: 230)
        case 5:
            return Position(x: 115, y: 230)
        case 6:
            return Position(x: 40, y: 230)
//        case 7:
//            return Position(x: -125, y: 305)
//        case 8:
//            return Position(x: -75, y: 305)
//        case 9:
//            return Position(x: -25, y: 305)
//        case 10:
//            return Position(x: 25, y: 305)
//        case 11:
//            return Position(x: 75, y: 305)
//        case 12:
//            return Position(x: 125, y: 305)
//
//        case 13:
//            return Position(x: -125, y: 365)
//        case 14:
//            return Position(x: -75, y: 365)
//        case 15:
//            return Position(x: -25, y: 365)
//        case 16:
//            return Position(x: 25, y: 365)
//        case 17:
//            return Position(x: 75, y: 365)
//        case 18:
//            return Position(x: 125, y: 365)
//        case 19:
//            return Position(x: 125, y: 365)
//        case 20:
//            return Position(x: 125, y: 365)
        default:
            return Position(x: 0, y: 0)
        }
    }
    
    func GetSize(item: Int) -> SizeType{
        switch item{
        case 0:
            return .extralarge
        case 1:
            return .larger
        case 2:
            return .larger
        case 3:
            return .large
        case 4:
            return .large
        case 5:
            return .large
        case 6:
            return .large
//        case 7:
//            return .medium
//        case 8:
//            return .medium
//        case 9:
//            return .medium
//        case 10:
//            return .medium
//        case 11:
//            return .medium
//        case 12:
//            return .medium
        default:
            return .small
        }
    }
}

struct SetupGoalIntro_Previews: PreviewProvider {
    static var previews: some View {
        SetupGoalIntro(canProceed: .constant(false))
    }
}
