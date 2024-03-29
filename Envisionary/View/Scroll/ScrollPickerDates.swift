//
//  ScrollPickerTimeframe.swift
//  Visionary
//
//  Created by Campbell McGavin on 4/14/22.
//

import SwiftUI

struct ScrollPickerDates: View {
    @EnvironmentObject var vm: ViewModel
    @State var contentOffset = CGPoint(x:0,y:0)
    @State var buttonIsChangingTimeframe = false
    @State var dateDisplay = Date()
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var animationDuration: TimeInterval = 0.65
    @State var stopScrolling: Bool = false
    @State var datesWithContent: [DatePair] = []
    @State var dateValuesWithContent: [Int] = [Int]()
    @State var dates: [DateValue] = [DateValue]()
    @State var startingIndexDate = 0
    
    let bufferOffCenter = 41
    let weirdOffset = CGFloat(8)

    var body: some View {

        ZStack{
            ScrollPickerSelectedRectangle()
            
            GeometryReader{
                geometry in
                        ScrollPicker(frame: .constant(SizeType.scrollPickerWidth.ToSize()), weirdOffset: weirdOffset, $contentOffset, animationDuration: $animationDuration, maxIndex: CGFloat(82), axis:.horizontal, oneStop:false, content:{
                                HStack{
                                    ForEach(dates){dateValue in
                                        
                                        
                                        Button {
                                            contentOffset.x = CGFloat(dateValue.day) * (SizeType.scrollPickerWidth.ToSize() + weirdOffset)
                                            withAnimation{
                                                dateDisplay = dateValue.date
                                            }
                                        } label: {
                                            VStack{
                                                ScrollPickerDateText(dateValue: dateValue, frameWidth: SizeType.scrollPickerWidth.ToSize(), filterTimeframe: vm.filtering.filterTimeframe, selectionDate: $dateDisplay, isLight: true, showBubble: true)
                                                    .frame(height:50)
                                            }
                                        }
                                        .frame(height:50)
                                    }
                                }
                                .frame(height:50)
                                .padding(.leading, abs(geometry.size.width/2 - SizeType.scrollPickerWidth.ToSize()/2))
                                .padding(.trailing, abs(geometry.size.width/2 - SizeType.scrollPickerWidth.ToSize()/2))

                    })
                .onChange(of: contentOffset.x){ _ in
                    dateDisplay = GetDateFromOffset()

                    if(contentOffset.x < geometry.size.width/2){
                        PrepareForPickerWheelTime(timeframe: vm.filtering.filterTimeframe)
                        contentOffset.x = CGFloat(startingIndexDate)*(SizeType.scrollPickerWidth.ToSize() + weirdOffset)
                        
                        DispatchQueue.main.async{
                            withAnimation{
                            vm.filtering.filterDate = dateDisplay
                            }
                        }
                    }
                    else if(contentOffset.x > (SizeType.scrollPickerWidth.ToSize() * CGFloat(bufferOffCenter)*2 - geometry.size.width/2)){
                        PrepareForPickerWheelTime(timeframe: vm.filtering.filterTimeframe)
                        contentOffset.x = CGFloat(startingIndexDate)*(SizeType.scrollPickerWidth.ToSize() + weirdOffset)
                        DispatchQueue.main.async{
                            withAnimation{
                            vm.filtering.filterDate = dateDisplay
                            }
                        }

                    }
                    else{
                        self.stopTimer()
                        self.startTimer()
                    }
                }
    //            .onChange(of: vm.contentView){
    //                _ in
    //                DispatchQueue.global(qos: .userInteractive).async{
    //                    GetDateValuesHaveContent()
    //                }
    //            }
                .onChange(of: dates){ _ in
                    contentOffset.x = CGFloat(startingIndexDate)*(SizeType.scrollPickerWidth.ToSize() + weirdOffset)
    //                DispatchQueue.global(qos: .userInteractive).async{
    //                    GetDateValuesHaveContent()
    //                }

                }
                .onChange(of: dateDisplay){
                    _ in
                    let impact = UIImpactFeedbackGenerator(style: .light)
                          impact.impactOccurred()
                }
                .onAppear{
                    RefreshView()
                }
                .onReceive(timer){ _ in
                    self.stopTimer()
                    DispatchQueue.main.async{
                            withAnimation{
                                vm.filtering.filterDate = dateDisplay
                                vm.pushToToday = false
                            }
                        }
                }
                .onChange(of: vm.filtering.filterTimeframe){ _ in
                    PrepareForPickerWheelTime(timeframe: vm.filtering.filterTimeframe)
                    vm.filtering.filterDate = dateDisplay
                }
                .onChange(of: vm.filtering.filterDate){ _ in
                    if vm.pushToToday == true{
                        DispatchQueue.global(qos: .userInteractive).async{
                            var dateValue = dates.first(where:{$0.date.isInSameTimeframe(as: vm.filtering.filterDate, timeframeType: vm.filtering.filterTimeframe)})
                            contentOffset.x = CGFloat(dateValue == nil ? 0 : dateValue!.day) * (SizeType.scrollPickerWidth.ToSize() + weirdOffset)
                        }
                    }
                    vm.pushToToday = false
                }
            }
        }
        .onRotate{
            _ in
            RefreshView()
        }
        .frame(height:SizeType.minimumTouchTarget.ToSize())
        

    }
    
    func PrepareForPickerWheelTime(timeframe: TimeframeType){
        DispatchQueue.global(qos: .userInteractive).async{
            self.dates = vm.filtering.filterDate.GetDatesArray(timeframeType: timeframe, bufferForwardBackward: bufferOffCenter)
            self.SetStartingIndex(timeframe: timeframe)
        }
    }
    
    func SetDates(timeframe: TimeframeType) -> Void {
        dates = vm.filtering.filterDate.GetDatesArray(timeframeType: timeframe, bufferForwardBackward: bufferOffCenter)
    }
    
    func SetStartingIndex(timeframe: TimeframeType) {
        
        switch timeframe{
        case .decade:
            startingIndexDate = dates.firstIndex(where: {vm.filtering.filterDate.isInSameDecade(as: $0.date)}) ?? bufferOffCenter
        
        case .year:
            startingIndexDate =  dates.firstIndex(where: {vm.filtering.filterDate.isInSameYear(as: $0.date)}) ?? bufferOffCenter
        
        default:
            startingIndexDate =  dates.firstIndex(where: {vm.filtering.filterDate == $0.date}) ?? bufferOffCenter
        }
    }
    
    func RefreshView(){
        PrepareForPickerWheelTime(timeframe: vm.filtering.filterTimeframe)
        contentOffset.x = CGFloat(startingIndexDate)*(SizeType.scrollPickerWidth.ToSize() + weirdOffset)
        dateDisplay = vm.filtering.filterDate
        self.stopTimer()
    }
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    func startTimer() {
        self.timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    }
    
    func GetDateFromOffset() -> Date {
        let offset = contentOffset.x
        let index = (offset) / (SizeType.scrollPickerWidth.ToSize() + self.weirdOffset)
        let indexRounded = index.rounded(.toNearestOrAwayFromZero)
        
//        let index: Int = Int((contentOffset.x / (SizeType.scrollPickerWidth.ToSize() + weirdOffset)).rounded(.toNearestOrAwayFromZero))
        if(dates.count > 0){
            return dates[Int(indexRounded)].date
        }
        else{
            return Date()
        }

    }

//    func GetDateValuesHaveContent(){
//
//        FilterDictionaryToTimeframe(contentViewType: vm.contentView, timeframeType: vm.filterTimeframe)
//        let datesTemp = vm.filtering.filterDates
//        dateValuesWithContent.removeAll()
//
//        for dateValue in datesTemp {
//            if GetDateContainsContent(cardDate: dateValue.date, timeframeType: vm.filterTimeframe){
//                dateValuesWithContent.append(dateValue.day)
//            }
//        }
//
//        contentOffset.x = contentOffset.x + 1
//        contentOffset.x = contentOffset.x - 1
//    }
    
    func GetDateContainsContent(cardDate: Date, timeframeType: TimeframeType) -> Bool{
        
        switch timeframeType{
        case .decade:
            return datesWithContent.contains(where: {$0.date1.isInSameDecade(as: cardDate) || $0.date2.isInSameDecade(as: cardDate) || cardDate.isBetween(datePair: $0)})
        case .year:
            return datesWithContent.contains(where: {$0.date1.isInSameYear(as: cardDate) || $0.date2.isInSameYear(as: cardDate) || cardDate.isBetween(datePair: $0)})
        case .month:
            return datesWithContent.contains(where: {$0.date1.isInSameMonth(as: cardDate) || $0.date2.isInSameMonth(as: cardDate) || cardDate.isBetween(datePair: $0)})
        case .week:
            return datesWithContent.contains(where: {$0.date1.isInSameWeek(as: cardDate) || $0.date2.isInSameWeek(as: cardDate) || cardDate.isBetween(datePair: $0)})
        case .day:
            return datesWithContent.contains(where: {$0.date1.isInSameDay(as: cardDate) || $0.date2.isInSameDay(as: cardDate) || cardDate.isBetween(datePair: $0)})
        }
    }
    
//    func FilterDictionaryToTimeframe(contentViewType: ContentViewType, timeframeType: TimeframeType){
//
//        switch contentViewType {
//        case .envision:
//            let _ = "why"
//        case .plan:
//            datesWithContent  = vm.GetDatesWithContent(objectType: .goal, filterTimeframe: vm.filterTimeframe, viewMenu: viewMenu)
//        case .execute:
//            datesWithContent  = vm.GetDatesWithContent(objectType: .goal, filterTimeframe: vm.filterTimeframe, viewMenu: viewMenu)
//        case .journal:
//            datesWithContent  = vm.GetDatesWithContent(objectType: .journalEntry, filterTimeframe: vm.filterTimeframe, viewMenu: viewMenu)
//        case .evaluate:
//            datesWithContent  = vm.GetDatesWithContent(objectType: .session, filterTimeframe: vm.filterTimeframe, viewMenu: viewMenu)
//
//        }
//    }
    
    
    
    func GetIsSelected(value: DateValue) -> Bool{
        switch vm.filtering.filterTimeframe{
        case .decade:
            return  vm.filtering.filterDate.isInSameDecade(as: value.date)
        case .year:
            return  vm.filtering.filterDate.isInSameYear(as: value.date)
        case .month:
            return  vm.filtering.filterDate.isInSameMonth(as: value.date)
        case .week:
            return  vm.filtering.filterDate.isInSameWeek(as:value.date)
        case .day:
            return  vm.filtering.filterDate.isInSameDay(as: value.date)
        }
    }
    

}

struct ScrollPickerDates_Previews: PreviewProvider {
    static var previews: some View {
        ScrollPickerTimeframe()
            .environmentObject(ViewModel())
    }
}
