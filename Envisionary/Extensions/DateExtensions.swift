//
//  DateExtensions.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/9/23.
//

import SwiftUI

extension Date{
    func StartOfDay() -> Date{
        let startDaySeconds = Calendar.current.component(.second, from: self)
        return self.addingTimeInterval(-Double(startDaySeconds))
    }
    
    func EndOfDay() -> Date{
        let startDaySeconds = Calendar.current.component(.second, from: self)
        return self.addingTimeInterval(Double(86400-startDaySeconds))
    }

    func StartOfWeek() -> Date{
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return Date() }
        return gregorian.date(byAdding: .day, value: 1, to: sunday) ?? Date()
    }
    
    func EndOfWeek() -> Date{
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return Date() }
        return gregorian.date(byAdding: .day, value: 7, to: sunday) ?? Date()
    }
    
    func StartOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
    }
    
    func EndOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.StartOfMonth())!
    }
    
    func StartOfYear() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year], from: self))!
    }

    func EndOfYear() -> Date {
        return Calendar.current.date(byAdding: DateComponents(year: 1, day: -1), to: self.StartOfYear())!
    }
    
    func StartOfDecade() -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .year, value: -calendar.dateComponents([.year], from: self).year! % 10,  to: self)!
    }

    func EndOfDecade() -> Date {
        return Calendar.current.date(byAdding: DateComponents(year: 10, day: -1), to: self.StartOfDecade())!
    }
    
    func AdvanceDate(timeframe:TimeframeType, forward: Bool) -> Date{
        
        switch timeframe{
        case .day:
            return self.AdvanceDay(forward: forward)
        case .week:
            return self.AdvanceWeek(forward: forward)
        case .month:
            return self.AdvanceMonth(forward: forward)
        case .year:
            return self.AdvanceYear(forward: forward)
        case .decade:
            return self.AdvanceDecade(forward: forward)
        }
    }
    
    func AdvanceDay(forward: Bool) -> Date{
        if(forward){
            return Calendar.current.date(byAdding: DateComponents(day: 1), to: self)!
        }
        else{
            return Calendar.current.date(byAdding: DateComponents(day: -1), to: self)!
        }
    }
    
    func AdvanceWeek(forward: Bool) -> Date{
        if(forward){
            return Calendar.current.date(byAdding: DateComponents(day: 7), to: self)!
        }
        else{
            return Calendar.current.date(byAdding: DateComponents(day: -7), to: self)!
        }
    }

    func AdvanceMonth(forward: Bool) -> Date{
        if(forward){
            return Calendar.current.date(byAdding: DateComponents(month: 1), to: self)!
        }
        else{
            return Calendar.current.date(byAdding: DateComponents(month: -1), to: self)!
        }
    }
    
    func AdvanceYear(forward: Bool) -> Date{
        if(forward){
            return Calendar.current.date(byAdding: DateComponents(year: 1), to: self)!
        }
        else{
            return Calendar.current.date(byAdding: DateComponents(year: -1), to: self)!
        }
    }
    
    func AdvanceDecade(forward: Bool) -> Date{
        if(forward){
            return Calendar.current.date(byAdding: DateComponents(year: 10), to: self)!
        }
        else{
            return Calendar.current.date(byAdding: DateComponents(year: -10), to: self)!
        }
    }
        
    func AdvanceCentury(forward: Bool) -> Date{
        if(forward){
            return Calendar.current.date(byAdding: DateComponents(year: 100), to: self)!
        }
        else{
            return Calendar.current.date(byAdding: DateComponents(year: -100), to: self)!
        }
    }
    
    func toString(timeframeType: TimeframeType, isStartDate: Bool? = nil) -> String
    {
        let formatter = DateFormatter()
        let formatter2 = DateFormatter()
    
        switch timeframeType{
        case .day:
            formatter.dateStyle = .medium
        case .week:
            formatter.dateStyle = .medium
            formatter2.dateFormat = "MMM d"
            let startOfWeek = self.StartOfWeek()
            let endOfWeek = self.EndOfWeek()
            
            if isStartDate != nil && isStartDate! {
                return formatter.string(from:startOfWeek)
            }
            else if isStartDate != nil && !isStartDate!{
                return formatter.string(from:endOfWeek)
            }
            else{
                return formatter2.string(from: startOfWeek) + "-" + formatter.string(from: endOfWeek)
            }
        case .month:
            formatter.dateFormat = "LLLL y"
        case .year:
            formatter.dateFormat = "y"
        case .decade:
            formatter.dateFormat = "y"
            let decadeString =  formatter.string(from: self)
            return String(decadeString.prefix(3)) + "0's"
        }
        return formatter.string(from: self)
    }
    
    func ComputeEndDate(timeframeType: TimeframeType, numberOfDates: Int) -> Date{
        
        var dateComponent = DateComponents()
        
        switch timeframeType{
        case .day:
            dateComponent.day = numberOfDates
            return Calendar.current.date(byAdding: dateComponent, to:self)!
        case .week:
            dateComponent.day = 6 * numberOfDates
            return Calendar.current.date(byAdding: dateComponent, to:self)!
        case .month:
            dateComponent.month = 1 * numberOfDates
            return Calendar.current.date(byAdding: dateComponent, to:self)!
        case .year:
            dateComponent.year = 1 * numberOfDates
            return Calendar.current.date(byAdding: dateComponent, to:self)!
        case .decade:
            dateComponent.year = 10 * numberOfDates
            return Calendar.current.date(byAdding: dateComponent, to:self)!
            
        }
    }
    
    func GetDateDifferenceAsDecimal(to: Date, timeframeType: TimeframeType) -> Double {
        let calendar = Calendar.current
        
        let dateComponents: DateComponents
        let calculatedNumberOfUnits: Double
        let indexOfRemainderUnits: Int

            switch timeframeType{
                
            case .decade:
                dateComponents = Calendar.current.dateComponents([.year, .day], from: self, to: to)
                let preCalculated = Double(dateComponents.year ?? 0) * 365 + Double(dateComponents.day ?? 0)
                calculatedNumberOfUnits = preCalculated / Double(365*10)

                
            case .year:
                dateComponents = Calendar.current.dateComponents([.year, .day], from: self, to: to)
                indexOfRemainderUnits = dateComponents.year ?? 0 + 1
                let  preCalculated  = Double(dateComponents.year ?? 0) * 365 + Double(dateComponents.day ?? 0)
                calculatedNumberOfUnits = preCalculated / Double(365)
                
            case .month:
                dateComponents = Calendar.current.dateComponents([.month, .day], from: self, to: to)
                indexOfRemainderUnits = dateComponents.month ?? 0 + 1

                let range = calendar.range(of: .day, in: .month, for: to)!
                let numDays = range.count
                
                calculatedNumberOfUnits = Double(dateComponents.month ?? 0) + Double(dateComponents.day ?? 0) / Double(range.count)
  
                
            case .week:
                let daysInGoal = Double(calendar.dateComponents([.day], from: self, to: to).day!)
                calculatedNumberOfUnits = daysInGoal / 7.0
                
            case .day:
                let daysInGoal = Double(calendar.dateComponents([.day], from: self, to: to).day!)
                calculatedNumberOfUnits = daysInGoal / 1.0
            }
        

        return calculatedNumberOfUnits
        

    }
    
    func getAllDates()->[Date]{
        
        let calendar = Calendar.current
        
        // getting start Date...
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        // getting date...
        return range.compactMap { day -> Date in
            
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
    
    func getAllMonths() ->[Date]{
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year], from: self))!
        
        let range = calendar.range(of: .month, in: .year, for: startDate)!
        
        return range.compactMap { month -> Date in
            return calendar.date(byAdding: .month, value: month - 1, to: startDate)!
        }
    }
    
    func getAllYears() ->[Date]{
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year], from: self))!
        
        let startYear = calendar.date(byAdding: .year, value: -calendar.dateComponents([.year], from: startDate).year! % 10,  to: startDate)!
//        let endYear = calendar.date(byAdding: .year, value: 10, to: startYear)!
        
        var years = [Date]()
        
        //concern with leap year.
//        let yearDurationInSeconds: TimeInterval = 60*60*24*365
        var tempYear = startYear
        
        for _ in 0...9{
            years.append(tempYear)
            tempYear = calendar.date(byAdding: .year, value: 1, to: tempYear)!
        }
        
        return years
    }
    
    func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
        calendar.isDate(self, equalTo: date, toGranularity: component)
    }
    
    func isInSameDecade(as date: Date) -> Bool {
        let calendar = Calendar.current
        let otherStartDecade = calendar.date(byAdding: .year, value: -calendar.dateComponents([.year], from: date).year! % 10,  to: date)!
        let selfStartDecade = calendar.date(byAdding: .year, value: -calendar.dateComponents([.year], from: self).year! % 10,  to: self)!
        
        return otherStartDecade.isEqual(to: selfStartDecade, toGranularity: .year)
    }
    
    func isInSameYear(as date: Date) -> Bool { isEqual(to: date, toGranularity: .year) }
    func isInSameMonth(as date: Date) -> Bool { isEqual(to: date, toGranularity: .month) }
    func isInSameWeek(as date: Date) -> Bool { isEqual(to: date, toGranularity: .weekOfYear) }
    func isInSameDay(as date: Date) -> Bool { Calendar.current.isDate(self, inSameDayAs: date) }

    func isInSameTimeframe(as date: Date, timeframeType: TimeframeType) -> Bool {
        switch timeframeType {
        case .decade:
            return isInSameDecade(as:date)
        case .year:
            return isInSameYear(as:date)
        case .month:
            return isInSameMonth(as:date)
        case .week:
            return isInSameWeek(as:date)
        case .day:
            return isInSameDay(as:date)
        }
    }
    
    func matchesDates(datePair: DatePair, timeframe: TimeframeType) -> Bool {
        
        switch timeframe{
        case .day:
            return datePair.date1.isInSameDay(as: self) || datePair.date2.isInSameDay(as: self) || self.isBetween(datePair: datePair)
        case .week:
            return datePair.date1.isInSameWeek(as: self) || datePair.date2.isInSameWeek(as: self) || self.isBetween(datePair: datePair)
        case .month:
            return datePair.date1.isInSameMonth(as: self) || datePair.date2.isInSameMonth(as: self) || self.isBetween(datePair: datePair)
        case .year:
            return datePair.date1.isInSameYear(as: self) || datePair.date2.isInSameYear(as: self) || self.isBetween(datePair: datePair)
        case .decade:
            return ComputeOverlapOfMultiYearSegment(datePair: datePair, timeframe: timeframe)

        }
    }
    
    func ComputeOverlapOfMultiYearSegment(datePair: DatePair, timeframe: TimeframeType) -> Bool{
        var filterDateStart = Date()
        var filterDateEnd = Date()
        let calendar = Calendar.current
        let minDate = Calendar.current.date(from: DateComponents(year: 1900, month: 1, day: 1))
        let maxDate = Calendar.current.date(from: DateComponents(year: 2150, month: 12, day: 30))

        switch timeframe{
        case .decade:
            filterDateStart = calendar.date(byAdding: .year, value: -calendar.dateComponents([.year], from: self).year! % 10,  to: self)!
            filterDateEnd = calendar.date(byAdding: .year, value: 10,  to: self)!
        default: // day
            filterDateStart = minDate!
            filterDateEnd = maxDate!
        }
        
        let filterDateRange = filterDateStart...filterDateEnd
        return filterDateRange.overlaps(datePair.date1...datePair.date2)
    }
    
    func isInThisTimeframe(timeframe: TimeframeType) -> Bool{
        switch timeframe {
        case .decade:
            return self.isInSameDecade(as: Date())
        case .year:
            return self.isInSameYear(as: Date())
        case .month:
            return self.isInSameMonth(as: Date())
        case .week:
            return self.isInSameWeek(as: Date())
        case .day:
            return self.isInSameDay(as: Date())
        }
    }
    var isInThisYear:  Bool { isInSameYear(as: Date()) }
    var isInThisMonth: Bool { isInSameMonth(as: Date()) }
    var isInThisWeek:  Bool { isInSameWeek(as: Date()) }

    var isInYesterday: Bool { Calendar.current.isDateInYesterday(self) }
    var isInToday:     Bool { Calendar.current.isDateInToday(self) }
    var isInTomorrow:  Bool { Calendar.current.isDateInTomorrow(self) }

    var isInTheFuture: Bool { self > Date() }
    var isInThePast:   Bool { self < Date() }
    
    
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
    
    func isAfter(date: Date) -> Bool{
        return self < date
    }
    
    func isBefore(date: Date) -> Bool{
        return self > date
    }

    func isBetween(datePair: DatePair) -> Bool {
        return (datePair.date1...datePair.date2).contains(self)
    }
    

        
    static func randomBetween(start: String, end: String, format: String = "yyyy-MM-dd") -> String {
        let date1 = Date.parse(start, format: format)
        let date2 = Date.parse(end, format: format)
        return Date.randomBetween(start: date1, end: date2).dateString(format)
    }

    static func randomBetween(start: Date, end: Date) -> Date {
        var date1 = start
        var date2 = end
        if date2 < date1 {
            let temp = date1
            date1 = date2
            date2 = temp
        }
        if Calendar.current.dateComponents([.day], from: start, to: end).day! <= 1{
            return start
        }
        let span = TimeInterval.random(in: date1.timeIntervalSinceNow...date2.timeIntervalSinceNow)
        return Date(timeIntervalSinceNow: span)
    }

    func dateString(_ format: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    static func parse(_ string: String, format: String = "yyyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.default
        dateFormatter.dateFormat = format

        let date = dateFormatter.date(from: string)!
        return date
    }
    
    func toYearAndMonth()->[String]{
        
        let calendar = Calendar.current
        let month = calendar.component(.month, from: self) - 1
        let year = calendar.component(.year, from: self)
        
        return ["\(year)",calendar.monthSymbols[month]]
    }
    
    func toMonth() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: self)
    }
    
    func toYear() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        return dateFormatter.string(from: self)
    }
    
    func DayOfWeek() -> String{
        let dateFormatter = DateFormatter()
        let weekday = dateFormatter.shortWeekdaySymbols[Calendar.current.component(.weekday, from: self) - 1]
        
        return weekday
    }
    
    func DayOfMonth() -> String{
        let day = Calendar.current.dateComponents([.day], from: self).day
        
        return "\(day!)"
    }   
    
    func StartYearToDecade() -> String{
        let calendar = Calendar.current
        let startYear = calendar.date(byAdding: .year, value: -calendar.dateComponents([.year], from: self).year! % 10,  to: self)!
        return String(calendar.component(.year, from: startYear))

    }
    
    func GetDatesArray(timeframeType: TimeframeType, bufferForwardBackward: Int) -> [DateValue]{
        var dates = [DateValue]()
        var startDate = self.GetStartDate(timeframeType: timeframeType, bufferForwardBackward: bufferForwardBackward)
        var index = 0;
        
        while(index < bufferForwardBackward*2){
            let dateValue = DateValue(day: index, date: startDate)
            dates.append(dateValue)
            startDate = startDate.GetNextDate(timeframeType: timeframeType)
            index = index+1
        }
        
        return dates
    }
    
    func GetDatesArray(endDate: Date, timeframeType: TimeframeType) -> [DateValue]{
        var dates = [DateValue]()
        var index = 0
        var currentDate = self
        
        while(currentDate <= endDate){
            let dateValue = DateValue(day: self.GetNumberOfDaysInTimeframe(timeframeType: timeframeType), date: currentDate)
            dates.append(dateValue)
            currentDate = currentDate.GetNextDate(timeframeType: timeframeType)
            index = index + 1
        }
        let dateValue = DateValue(day: self.GetNumberOfDaysInTimeframe(timeframeType: timeframeType), date: currentDate)
        dates.append(dateValue)
        currentDate = currentDate.GetNextDate(timeframeType: timeframeType)
        
        let dateValue1 = DateValue(day: self.GetNumberOfDaysInTimeframe(timeframeType: timeframeType), date: currentDate)
        dates.append(dateValue1)
        
        return dates
    }
    
    func GetNumberOfDaysInTimeframe(timeframeType: TimeframeType) -> Int{
        switch timeframeType {
        case .decade:
            return 10 * 365
        case .year:
            return 365
        case .month:
            let range = Calendar.current.range(of: .day, in: .month, for: self)!
            return range.count
        case .week:
            return 7
        case .day:
            return 1
        }
    }
    
    func toDecadesArray() -> [DateValue] {
        
        let calendar = Calendar.current
        var decade = Calendar.current.date(from: DateComponents(year: 2000, month: 1, day: 1))!
        var decadeValues = [DateValue]()
        
        for _ in 1...10{
            
            let day_AkaDecade = calendar.dateComponents([.year], from: decade)
            decadeValues.append( DateValue(day: day_AkaDecade.year!, date: decade))
            decade = calendar.date(byAdding: .year, value: 10,  to: decade)!
        }
        
        return decadeValues
    }
    
    func toYearsArray() -> [DateValue]{
        
        let calendar = Calendar.current
        
        let years = self.getAllYears().compactMap { date -> DateValue in
            
            // getting day...
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        
        return years
    }
    
    func toDaysArray()->[DateValue]{
        
        let calendar = Calendar.current
        
        // Getting Current Month Date....
        
        var days = self.getAllDates().compactMap { date -> DateValue in
            
            // getting day...
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        
        // adding offset days to get exact week day...
        let firstWeekday = calendar.component(.weekday, from: days.first!.date)
        
        for _ in 0..<firstWeekday - 1{
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
    
    func toWeeksArray(dayValues: [DateValue]) -> [DateValue]{
        
        let dayValueCount = Double(dayValues.count) * 1.0
        let maxWeekValue = dayValueCount / 7.0
        let maxWeekValueRoundedUp = Int(ceil(maxWeekValue))
        let numberOfWeeks = 1...maxWeekValueRoundedUp
        var weekValues = [DateValue]()
        for weekNumber in numberOfWeeks{
            var dayValuesIndex = (weekNumber-1) * 7
            while(dayValues[dayValuesIndex].day == -1 ){ dayValuesIndex += 1}
            
            weekValues.append( DateValue(day: weekNumber, date: dayValues[dayValuesIndex].date))
            
        }
        
        return weekValues
    }

    func toMonthsArray() -> [DateValue]{
        
        let calendar = Calendar.current
        
        let months = self.getAllMonths().compactMap { date -> DateValue in
            
            // getting day...
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        
        return months
    }
    
    func GetStartDate(timeframeType: TimeframeType, bufferForwardBackward: Int) -> Date{
        switch timeframeType {
        case .day:
            return Calendar.current.date(byAdding: .day, value: -bufferForwardBackward, to: self)!
        case .week:
            return Calendar.current.date(byAdding: .day, value: -bufferForwardBackward*7, to: self)!
        case .month:
            return Calendar.current.date(byAdding: .month, value: -bufferForwardBackward, to: self)!
        case .year:
            return Calendar.current.date(byAdding: .year, value: -bufferForwardBackward, to: self)!
        case .decade:
            return Calendar.current.date(byAdding: .year, value: -bufferForwardBackward * 10, to: self)!
        }
    }
    
    func GetNextDate(timeframeType: TimeframeType) -> Date{
        
        switch timeframeType {
        case .day:
            return Calendar.current.date(byAdding: .day, value: 1, to: self)!
        case .week:
            return Calendar.current.date(byAdding: .day, value: 7, to: self)!
        case .month:
            return Calendar.current.date(byAdding: .month, value: 1, to: self)!
        case .year:
            return Calendar.current.date(byAdding: .year, value: 1, to: self)!
        case .decade:
            return Calendar.current.date(byAdding: .year, value: 10, to: self)!
        }
    }
}
