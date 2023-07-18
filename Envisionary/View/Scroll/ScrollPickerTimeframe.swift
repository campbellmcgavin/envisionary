//
//  ScrollPickerTimeframe.swift
//  Visionary
//
//  Created by Campbell McGavin on 4/14/22.
//

import SwiftUI

struct ScrollPickerTimeframe: View {
    @EnvironmentObject var vm: ViewModel
    @State var contentOffset = CGPoint(x:0,y:0)
    @State var buttonIsChangingTimeframe = false
    @State var timeframeDisplay: TimeframeType = .day
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var timeframeList = [TimeframeType]()
    
    let weirdOffset = CGFloat(8)
    
    var body: some View {
        ZStack(){

            ScrollPickerSelectedRectangle()

            
            GeometryReader{
                geometry in
                ScrollPicker(frame: .constant(SizeType.scrollPickerWidth.ToSize()), weirdOffset: weirdOffset, $contentOffset, animationDuration: .constant(0.65), maxIndex: CGFloat(timeframeList.count - 1), axis: .horizontal, oneStop: false, content:{
                    HStack(alignment:.center){
                        
                        ForEach(timeframeList, id:\.self){timeframe in
                            Button {
                                contentOffset.x =  CGFloat(timeframeList.firstIndex(of: timeframe) ?? 0) * (SizeType.scrollPickerWidth.ToSize() + weirdOffset)
                                withAnimation{
                                    timeframeDisplay = timeframe
                                }
                            } label: {
                                ScrollPickerTimeframeText(timeframe: timeframe, width: SizeType.scrollPickerWidth.ToSize(), selectionTimeframe: $timeframeDisplay)
                                    
                            }.offset(y:-3)
                        }
                    }
                    .frame(height:50)
                    .padding(.leading, abs(geometry.size.width/2 - SizeType.scrollPickerWidth.ToSize()/2))
                    .padding(.trailing, abs(geometry.size.width/2 - SizeType.scrollPickerWidth.ToSize()/2))

                })
            }
            .onChange(of: contentOffset.x){ _ in
                timeframeDisplay = GetTimeframeFromOffset()
                self.startTimer()
            }
            .onChange(of: vm.filtering.filterContent){ _ in
                LoadTimeframes()
            }
            .onChange(of: timeframeDisplay){
                _ in
                let impact = UIImpactFeedbackGenerator(style: .light)
                      impact.impactOccurred()
            }
            .onAppear{
                RefreshView()
            }
            .onChange(of: timeframeList){
                _ in
                contentOffset.x = CGFloat(timeframeList.count - 1) * (SizeType.scrollPickerWidth.ToSize() + weirdOffset)
            }
            .onReceive(timer){ _ in
                    DispatchQueue.main.async{
                        withAnimation{
                        self.stopTimer()
//                        vm.PrepareForPickerWheelTime(timeframe: timeframeDisplay)
                        vm.filtering.filterTimeframe = timeframeDisplay
                        }
                    }
            }
            .onRotate(perform: {
                _ in
                RefreshView()
            })
        }
        .frame(height:SizeType.minimumTouchTarget.ToSize())
    }
    
    
    func RefreshView(){
        LoadTimeframes()
        timeframeDisplay = vm.filtering.filterTimeframe
        contentOffset.x = CGFloat(vm.filtering.filterTimeframe.rawValue)*(SizeType.scrollPickerWidth.ToSize() + weirdOffset)
        self.startTimer()
    }
    
    func LoadTimeframes() {
        timeframeList.removeAll()
        
        for timeframe in TimeframeType.allCases {
            
            if TimeframeShouldShow(timeframe: timeframe){
                timeframeList.append(timeframe)
            }
        }
    }
    
    func TimeframeShouldShow(timeframe: TimeframeType) -> Bool{
        
        switch timeframe{
        case .day:
//            return vm.filtering.filterContent  != .evaluate
            return vm.filtering.filterObject != .session
        case .week:
            return true
        case .month:
            return true
        case .year:
            return vm.filtering.filterContent != .execute
        case .decade:
            return vm.filtering.filterContent != .execute
        }
    }
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    func startTimer() {
        self.timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    }
    
    func GetTimeframeFromOffset() -> TimeframeType {
        let offset = contentOffset.x
        let index = (offset) / (SizeType.scrollPickerWidth.ToSize() + self.weirdOffset)
        let indexRounded = Int(index.rounded(.toNearestOrAwayFromZero))
        if indexRounded < 0{
            return timeframeList.first  ?? .decade
        }
        else if indexRounded > timeframeList.count - 1 {
            return (timeframeList.last ?? .day)
        }
        else{
            return timeframeList[indexRounded]
        }
    }
    
    func GetOpacity(timeframe: TimeframeType)-> CGFloat{
        
        return timeframeDisplay == timeframe ? 1.0 : 0.5
    }
}

struct ScrollPickerTimeframe_Previews: PreviewProvider {
    static var previews: some View {
        ScrollPickerTimeframe()
            .environmentObject(ViewModel())
            .background(Color.specify(color: .grey0))
    }
}


