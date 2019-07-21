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
    case standard = "yyyy-MM-dd HH:mm:ss Z" /// yyyy-MM-dd HH:mm:ss Z
    
    case date = "yyyy-MM-dd"
    case dateCompleteDay = "EEEE, yyyy-MM-dd HH:mm"
    case dateComplete = "yyyy-MM-dd HH:mm"
    case dateCompleteSeconds = "yyyy-MM-dd HH:mm:ss"
    
    case dateCompleteReverse = "dd-MM-yyyy HH:mm"
    case dateCompleteReverseDay = "EEEE, dd-MM-yyyy HH:mm"
    case dateCompleteSecondsReverse = "dd-MM-yyyy HH:mm:ss"
    case dateReverse = "dd-MM-yyyy"
    
    case dateCompleteReverseAgainstBar = "dd/MM/yyyy HH:mm"
    case dateCompleteReverseDayAgainstBar = "EEEE, dd/MM/yyyy HH:mm"
    case dateCompleteSecondsReverseAgainstBar = "dd/MM/yyyy HH:mm:ss"
    case dateReverseAgainstBar = "dd/MM/yyyy"
    case dateMonthYearAgainstBar = "MM/yyyy"
    
    case hourSeconds = "HH:mm:ss"
    case hour = "HH:mm"
    
    case justDay = "dd"
    case justDayWeek = "EEEE"
    case justMonth = "MM"
    case justYear = "yyyy"
    case justHour = "HH"
    case justMinutes = "mm"
}


public var globalStartDate = Date()
public var globalEndDate = Date()
public var globalIdDate = ""

public class DateTools {
    
    public init() {
        
    }

    var dateFormatter = DateFormatter()
    
    // MARK: CUSTOM DATE
    public func getStringDateFromDate(date: Date, dateFormatOut: DateFormatType) -> String {
        dateFormatter.dateFormat = dateFormatOut.rawValue
        return dateFormatter.string(from: date)
    }
    
    public func getDateFromString(date: String, dateFormatOut: DateFormatType) -> Date {
        
        dateFormatter.dateFormat = dateFormatOut.rawValue
        
        if dateFormatter.date(from: date) != nil {
            return dateFormatter.date(from: date)!
        } else {
            return Date()
        }
        
    }
    
    public func getStringDateFromString(date: String, dateFormatIn: DateFormatType, dateFormatOut: DateFormatType) -> String {
        
        let value = getDateFromString(date: date, dateFormatOut: dateFormatIn)
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
    public func compareTwoDatesString(dateReference: String, dateToCompare: String, dateFormatOut: DateFormatType) -> Int {
        
        let referenceDate = getDateFromString(date: dateReference, dateFormatOut: dateFormatOut)
        let compareDate = getDateFromString(date: dateToCompare, dateFormatOut: dateFormatOut)
        
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
    
    // MARK: GET DIFFERENCES
    public func getDifferenceBetweenDatesInHours(dateStart: Date, dateEnd: Date) -> String {
        
        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: dateStart, to: dateEnd)
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        let seconds = components.second ?? 0
        
        return "\(String(format: "%02d", hours)):\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))"
    }
    
    public func getDifferenceBetweenDatesInHours(dateStart: String, dateEnd: String, dateFormatIn: DateFormatType) -> String {
        
        let startTimeDate = getDateFromString(date: dateStart, dateFormatOut: dateFormatIn)
        let endTimeDate = getDateFromString(date: dateEnd, dateFormatOut: dateFormatIn)
        return getDifferenceBetweenDatesInHours(dateStart: startTimeDate, dateEnd: endTimeDate)
    }
    
    // MARK: LOG DATES
    public func setGlobalStartDate(id: String = "") {
        globalStartDate = Date()
        globalIdDate = id
        print("\n - - - - > [\(globalIdDate)] - STARTED AT: \t", globalStartDate)
    }
    
    public func setGlobalEndDate() {
        globalEndDate = Date()
        print(" - - - - > [\(globalIdDate)] - FINISHED AT: \t", globalEndDate)
        print(" - - - - > [\(globalIdDate)] - DIFFERENCE: \t", getDifferenceBetweenDatesInHours(dateStart: globalStartDate, dateEnd: globalEndDate), "\n")
        globalIdDate = ""
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
