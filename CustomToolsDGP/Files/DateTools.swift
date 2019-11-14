//
//  DateTools.swift
//  CustomToolsDGP
//
//  Created by David Galán on 20/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

/// Date Format type
public enum DateFormatType: String {
    
    /// yyyy-MM-dd HH:mm:ss Z
    case standard = "yyyy-MM-dd HH:mm:ss Z"
    
    /// yyyy-MM-dd
    case date = "yyyy-MM-dd"
    /// EEEE, yyyy-MM-dd
    case dateDay = "EEEE, yyyy-MM-dd"
    /// EEEE, yyyy-MM-dd HH:mm
    case dateCompleteDay = "EEEE, yyyy-MM-dd HH:mm"
    /// yyyy-MM-dd HH:mm
    case dateComplete = "yyyy-MM-dd HH:mm"
    /// yyyy-MM-dd HH:mm:ss
    case dateCompleteSeconds = "yyyy-MM-dd HH:mm:ss"
    
    /// dd-MM-yyyy HH:mm
    case dateCompleteReverse = "dd-MM-yyyy HH:mm"
    /// dd-MM-yy HH:mm
    case dateCompleteReverseShortYear = "dd-MM-yy HH:mm"
    /// EEEE, dd-MM-yyyy
    case dateReverseDay = "EEEE, dd-MM-yyyy"
    /// EEEE, dd-MM-yyyy HH:mm
    case dateCompleteReverseDay = "EEEE, dd-MM-yyyy HH:mm"
    /// dd-MM-yyyy HH:mm:ss
    case dateCompleteSecondsReverse = "dd-MM-yyyy HH:mm:ss"
    /// dd-MM-yy HH:mm:ss
    case dateCompleteSecondsReverseShortYear = "dd-MM-yy HH:mm:ss"
    /// dd-MM-yyyy
    case dateReverse = "dd-MM-yyyy"
    /// dd-MM-yy
    case dateReverseShortYear = "dd-MM-yy"
    
    /// dd/MM/yyyy HH:mm
    case dateCompleteReverseAgainstBar = "dd/MM/yyyy HH:mm"
    /// dd/MM/yy HH:mm
    case dateCompleteReverseShortYearAgainstBar = "dd/MM/yy HH:mm"
    /// EEEE, dd/MM/yyyy
    case dateReverseDayAgainstBar = "EEEE, dd/MM/yyyy"
    /// EEEE, dd/MM/yyyy HH:mm
    case dateCompleteReverseDayAgainstBar = "EEEE, dd/MM/yyyy HH:mm"
    /// dd/MM/yyyy HH:mm:ss
    case dateCompleteSecondsReverseAgainstBar = "dd/MM/yyyy HH:mm:ss"
    /// dd/MM/yy HH:mm:ss
    case dateCompleteSecondsShortYearReverseAgainstBar = "dd/MM/yy HH:mm:ss"
    /// dd/MM/yyyy
    case dateReverseAgainstBar = "dd/MM/yyyy"
    /// dd/MM/yy
    case dateReverseAgainstBarShortYear = "dd/MM/yy"
    /// MM/yyyy
    case dateMonthYearAgainstBar = "MM/yyyy"
    
    /// yyyy MM
    case yearMonthNumbers = "yyyy MM"
    /// MM yyyy
    case yearMonthNumbersReverse = "MM yyyy"
    /// dd MMM
    case dayMonthName = "dd MMM"
    /// MMM yyyy
    case monthNameYearShort = "MMM yyyy"
    /// MMMM yyyy
    case monthNameYear = "MMMM yyyy"
    
    /// HH:mm:ss
    case hourSeconds = "HH:mm:ss"
    /// HH:mm
    case hour = "HH:mm"
    
    /// dd
    case justDay = "dd"
    /// EEEE
    case justDayWeek = "EEEE"
    /// MM
    case justMonth = "MM"
    /// M
    case justMonthNumber = "M"
    /// MMM
    case justMonthNameShort = "MMM"
    /// MMMM
    case justMonthName = "MMMM"
    /// yyyy
    case justYear = "yyyy"
    /// yy
    case justYearShort = "yy"
    /// HH
    case justHour = "HH"
    /// mm
    case justMinutes = "mm"
    /// ss
    case justSeconds = "ss"
}


public var globalStartDate = Date()
public var globalEndDate = Date()
public var globalIdDate = ""

public class DateTools {
    
    public enum DayShortedString: Int {
        case none = 0
        case one = 1
        case two = 2
        case three = 3
    }
    
    public init() {
        
    }

    public var dateFormatter = DateFormatter()
    
    // MARK: CUSTOM DATE
    public func getStringDateFromDate(date: Date, dateFormatOut: DateFormatType) -> String {
        dateFormatter.dateFormat = dateFormatOut.rawValue
        return dateFormatter.string(from: date)
    }
    
    public func getDateFromString(date: String, dateFormatIn: DateFormatType) -> Date {
        
        dateFormatter.dateFormat = dateFormatIn.rawValue
        
        if dateFormatter.date(from: date) != nil {
            return dateFormatter.date(from: date)!
        } else {
            return Date(timeIntervalSince1970: 0)
        }
    }
    
    public func getStringDateFromString(date: String, dateFormatIn: DateFormatType, dateFormatOut: DateFormatType) -> String {
        
        let value = getDateFromString(date: date, dateFormatIn: dateFormatIn)
        return getStringDateFromDate(date: value, dateFormatOut: dateFormatOut)
    }
    
    // MARK: TODAY DATE
    public func getTodayDate() -> String {
        let todayData = Date()
        dateFormatter.dateFormat = DateFormatType.standard.rawValue
        return dateFormatter.string(from: todayData)
    }
    
    public func getTodayDateFormatted() -> String {
        let todayData = Date()
        dateFormatter.dateFormat = DateFormatType.dateReverse.rawValue
        return dateFormatter.string(from: todayData)
    }
    
    public func getTodayDateFormattedCustom(dateFormatOut: DateFormatType) -> String {
        let todayData = Date()
        dateFormatter.dateFormat = dateFormatOut.rawValue
        return dateFormatter.string(from: todayData)
    }
    
    //Date to milliseconds
    public func currentTimeInMiliseconds() -> Int {
        let currentDate = Date()
        let since1970 = currentDate.timeIntervalSince1970
        return Int(since1970 * 1000)
    }
    
    // MARK: COMPARE
    public func compareTwoDatesString(dateReference: String, dateToCompare: String, dateFormatIn: DateFormatType) -> Int {
        
        let referenceDate = getDateFromString(date: dateReference, dateFormatIn: dateFormatIn)
        let compareDate = getDateFromString(date: dateToCompare, dateFormatIn: dateFormatIn)
        
        return compareTwoDates(dateReference: referenceDate, dateToCompare: compareDate)
    }
    
    public func compareTwoDates(dateReference: Date, dateToCompare: Date) -> Int {
        
        // -1=before, 0=equal, 1=after
        
        var result = 9
        
        if (dateReference == dateToCompare){
            result = 0
        } else if (dateReference > dateToCompare) {
            result = 1
        } else if (dateReference < dateToCompare) {
            result  = -1
        }
        
        return result
    }
    
    // MARK: GET SECONDS
    public func getSecondsToHoursMinutesSeconds (seconds: Int) -> String {
        let (h, m, s) = secondsToHoursMinutesSeconds (seconds: seconds)
        return ("\(String(format: "%02d", h)):\(String(format: "%02d", m)):\(String(format: "%02d", s))")
    }
    
    public func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    public func getSecondsFromHourMinutesSecondsDate(date: String, dateFormat: DateFormatType) -> Int {
        
        var totalSeconds = 0
        
        let hour = DateTools().getStringDateFromString(date: date, dateFormatIn: dateFormat, dateFormatOut: .justHour)
        let minutes = DateTools().getStringDateFromString(date: date, dateFormatIn: dateFormat, dateFormatOut: .justMinutes)
        let seconds = DateTools().getStringDateFromString(date: date, dateFormatIn: dateFormat, dateFormatOut: .justSeconds)
        
        guard hour.isNumeric && minutes.isNumeric && seconds.isNumeric else {
            return totalSeconds
        }
        
        let secondsFromHour = (Int(hour)! * 60) * 60
        let secondsFromMinutes = (Int(hour)! * 60)
        totalSeconds = secondsFromHour + secondsFromMinutes + Int(seconds)!
        
        return totalSeconds
    }
    
    // MARK: GET DIFFERENCES
    public func getDifferenceBetweenDatesInHours(dateStart: Date, dateEnd: Date) -> String {
        
        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: dateStart, to: dateEnd)
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        let seconds = components.second ?? 0
        
        return "\(String(format: "%02d", hours)):\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))"
    }
    
    public func getDifferenceBetweenDatesInHours(dateStart: String, dateEnd: String, dateFormatIn: DateFormatType) -> String {
        
        let startTimeDate = getDateFromString(date: dateStart, dateFormatIn: dateFormatIn)
        let endTimeDate = getDateFromString(date: dateEnd, dateFormatIn: dateFormatIn)
        return getDifferenceBetweenDatesInHours(dateStart: startTimeDate, dateEnd: endTimeDate)
    }
    
    // MARK: LOG DATES
    public func setGlobalStartDate(id: String = "") {
        globalStartDate = Date()
        globalIdDate = id
        print("\n ➡️ - - - - > [\(globalIdDate)] - STARTED AT: \t", globalStartDate)
    }
    
    public func setGlobalEndDate() {
        globalEndDate = Date()
        print(" ⬅️ - - - - > [\(globalIdDate)] - FINISHED AT: \t", globalEndDate)
        print(" 🕑 - - - - > [\(globalIdDate)] - DIFFERENCE: \t", getDifferenceBetweenDatesInHours(dateStart: globalStartDate, dateEnd: globalEndDate), "\n")
        globalIdDate = ""
    }
    
    // MARK: GET DAYS NAME
    public func weekdayNameFrom(weekdayNumber: Int, shortedString: DayShortedString = .none, locale: Locale, capitalize: CapitalizeString) -> String {
        var calendar = Calendar.current
        calendar.locale = locale
        let dayIndex = ((weekdayNumber - 1) + (calendar.firstWeekday - 1)) % 7
        
        var valueReturn = ""
        
        if shortedString == .none {
            valueReturn = calendar.weekdaySymbols[dayIndex]
        } else {
            valueReturn =  String(calendar.weekdaySymbols[dayIndex].prefix(shortedString.rawValue))
        }
        
        switch capitalize {
        case .none:
            return valueReturn
        case .uppercased:
            return valueReturn.uppercased()
        case .lowercased:
            return valueReturn.lowercased()
        case .capitalized:
            return valueReturn.capitalized
        }
    }
  
}

// MARK: VALIDATOR
extension String {
    
    public func isCorrectDateFormat(dateFormat: DateFormatType) -> Bool {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.rawValue
        
        if dateFormatter.date(from: self) != nil {
            return true
        } else {
            return false
        }
    }
    
}
