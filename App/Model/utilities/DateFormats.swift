//
//  DateFormats.swift
//  iOS
//
//  Created by Javed Multani on 23/05/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import Foundation

public let GLOBAL_DATE_FORMAT: String = "yyyy-MM-dd HH:mm:ss"
public let ONLY_DATE_FORMAT: String = "yyyy-MM-dd"
public let ONLY_TIME_FORMAT: String = "HH:mm:00"
public let ONLY_DATE_TIME_FORMAT: String = "yyyy-MM-dd HH:mm:00"
public let BIRTH_DATE_FORMAT: String = "yyyy-MM-dd"
public let ONLY_DATE_MONTH_FORMAT: String = "dd/MM"
public let FULL_DATE_FORMAT: String = "dd MMM yyyy hh:mm a"
public let FB_BIRTH_DATE_FORMAT: String = "MM/dd/yyyy"
public let DIFF_DATE_FORMAT: String = "EEE d MMM yyyy"
public let DIFF_DATE_FORMAT2: String = "dd MMM yyyy"
public let ONLY_TIME_FORMAT_12HRS: String = "hh:mm a"
public let COMMON_FORMAT:String = "dd/MM/yyyy"

public let DATE_FOR_CHAT: String = "MMM dd, yyyy"

class DateFormater {
    
   // private static let sharedInstance = DateFormater()
    private var gameScore: Int = 0
    
    var sharedDateFormat : DateFormatter? = nil

    static let sharedInstance:DateFormater = {
        let instance = DateFormater ()
        return instance
    } ()
    
    // MARK: Init
    private init() {
        self.sharedDateFormat = DateFormatter()
        self.sharedDateFormat!.timeZone = NSTimeZone.system
        let enUSPOSIXLocale: NSLocale = NSLocale(localeIdentifier: "en_US_POSIX")
        self.sharedDateFormat!.locale = enUSPOSIXLocale as Locale?
    }

//    static var onceToken: dispatch_once_t = 0
//
//    // METHODS
//    private init() {
//        dispatch_once(&once.onceToken) {
//            self.sharedDateFormat = NSDateFormatter()
//            self.sharedDateFormat!.timeZone = NSTimeZone.system
//            let enUSPOSIXLocale: NSLocale = NSLocale(localeIdentifier: "en_US_POSIX")
//            self.sharedDateFormat!.locale = enUSPOSIXLocale
//        }
//    }
    
    //MARK: - Convert To Local TimeZone
    class func convertDateToLocalTimeZone(givenDate: String) -> String {
        var final_date: String
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        //SET TIME ZONE FORMAT OF SERVER HERE
        let ts_utc: Date = self.sharedInstance.sharedDateFormat!.date(from: givenDate)!
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        final_date = self.sharedInstance.sharedDateFormat!.string(from: ts_utc)
        return final_date
    }
    
    class func convertDateToLocalTimeZoneForDate(givenDate: Date) -> Date {
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        //SET TIME ZONE FORMAT OF SERVER HERE
        let strDate: String = self.sharedInstance.sharedDateFormat!.string(from: givenDate)
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.date(from: strDate)!
    }
    
    class func convertDateToLocalTimeZoneForDateFromString(givenDate: String) -> Date {
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        //SET TIME ZONE FORMAT OF SERVER HERE
        return self.sharedInstance.sharedDateFormat!.date(from: givenDate)!
    }
    
    class func convertLocalDateTimeToServerTimeZone(givenDate: String) -> String {
        let final_date: String
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        let ts_utc: Date = self.sharedInstance.sharedDateFormat!.date(from: givenDate)!
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        final_date = self.sharedInstance.sharedDateFormat!.string(from: ts_utc)
        return final_date
    }
    
    class func generateDateForGivenDateToServerTimeZone(givenDate: Date) -> String {
        self.sharedInstance.sharedDateFormat!.dateFormat = ONLY_DATE_TIME_FORMAT
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        //SET TIME ZONE FORMAT OF SERVER HERE
        return self.sharedInstance.sharedDateFormat!.string(from: givenDate)
    }
    
    class func getUTCDateFromUTCString(givenDate: String) -> Date {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.date(from: givenDate)!
    }
    
    //MARK: Common Formats
    class func getStringFromDateString(givenDate: String) -> String {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        let date: Date = self.sharedInstance.sharedDateFormat!.date(from: givenDate)!
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.string(from: date)
    }
    
    class func getStringFromDate(givenDate: Date) -> String {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = COMMON_FORMAT
        return self.sharedInstance.sharedDateFormat!.string(from: givenDate)
    }
    
    class func getFullDateStringFromDate(givenDate: Date) -> String {
        self.sharedInstance.sharedDateFormat!.timeZone = TimeZone(abbreviation: "GMT")!
        self.sharedInstance.sharedDateFormat!.dateFormat = FULL_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.string(from: givenDate)
    }
    
    class func getFullDateStringFromString(givenDate: String) -> String {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        let date: Date = self.sharedInstance.sharedDateFormat!.date(from: givenDate)!
        self.sharedInstance.sharedDateFormat!.dateFormat = FULL_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.string(from: date)
    }
    
    class func getDateFromString(givenDate: String) -> Date {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.date(from: givenDate)!
    }
    
    class func getDateFromJustDateString(givenDate: String) -> Date {
        
        self.sharedInstance.sharedDateFormat!.dateFormat = ONLY_DATE_FORMAT
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        
        let newDate:NSDate =  self.sharedInstance.sharedDateFormat!.date(from: givenDate)! as NSDate
        
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        
        let newDateString:String = self.getStringFromDate(givenDate: newDate as Date)
        
        return self.sharedInstance.sharedDateFormat!.date(from: newDateString)!
    }
    
    class func getDateFromDate(givenDate: Date) -> Date {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        let strDate: String = self.sharedInstance.sharedDateFormat!.string(from: givenDate)
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.date(from: strDate)!
    }
    
    //MARK: - Timestamp to String date
    class func getDateFromTimeStamp(timeStamp : Int) -> Date? {
        let date = NSDate(timeIntervalSince1970: TimeInterval(timeStamp/1000))
        return getDateFromDate(givenDate: date as Date)
    }
    
    class func getDateStringFromTimeStamp(timeStamp : Int , _ dateFormat : String = DIFF_DATE_FORMAT) -> String? {
        let date = NSDate(timeIntervalSince1970: TimeInterval(timeStamp))
        
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = dateFormat
        let dateString = self.sharedInstance.sharedDateFormat?.string(from: date as Date)
        return dateString
    }

    //MARK: - Timestamp Formats
    class func getTimestampUTC() -> String {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone(name:"UTC")! as TimeZone
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.string(from: NSDate() as Date)
    }
    
    class func getTimestampFromGivenDate(givenDate: String) -> Date {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone(name:"UTC")! as TimeZone
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.date(from: givenDate)!
    }
    
    
    //MARK: - Generate Date
    class func generateDateForGivenDate(strDate: Date, andTime strTime: Date) -> String {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = ONLY_DATE_FORMAT
        let dt: String = self.sharedInstance.sharedDateFormat!.string(from: strDate)
        self.sharedInstance.sharedDateFormat!.dateFormat = ONLY_TIME_FORMAT
        let tm: String = self.sharedInstance.sharedDateFormat!.string(from: strTime)
        return "\(dt) \(tm)"
    }
    
    class func generateTimeForGivenDate(strDate: Date) -> String {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = ONLY_TIME_FORMAT_12HRS
        let tm: String = self.sharedInstance.sharedDateFormat!.string(from: strDate)
        return "\(tm)"
    }
    
    
    
    class func generateDateForGivenDate(strDate: Date) -> String {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = ONLY_DATE_TIME_FORMAT
        return self.sharedInstance.sharedDateFormat!.string(from: strDate)
    }
    
    class func generateOnlyDateForGivenDate(strDate: Date) -> String {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = ONLY_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.string(from: strDate)
    }
    
    //MARK: - Birth Date
    class func getBirthDateFromString(givenDate: String) -> Date {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = ONLY_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.date(from: givenDate)!
    }
    
    class func getBirthDateStringFromDateString(givenDate: String) -> String {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = ONLY_DATE_FORMAT
        let date: Date = self.sharedInstance.sharedDateFormat!.date(from: givenDate)!
        self.sharedInstance.sharedDateFormat!.dateFormat = DIFF_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.string(from: date)
    }

    
    class func birthdayConstraintForUser(givenDate: Date) -> Date {
        var dateComponents: DateComponents = DateComponents()
        dateComponents.year = -13
        let expirationDate = Calendar.current.date(byAdding: dateComponents, to: givenDate, wrappingComponents: false)
        
        return expirationDate!
    }
    
    class func minBirthdayConstraintForUser(givenDate: Date) -> Date {
        var dateComponents: DateComponents = DateComponents()
        dateComponents.year = -113
        let expirationDate = Calendar.current.date(byAdding: dateComponents, to: givenDate, wrappingComponents: false)
        return expirationDate!
    }

    class func generateBirthDateForGivenDate(strDate: Date) -> String {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = BIRTH_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.string(from: strDate)
    }
    
    class func generateBirthDateForGivenFacebookDate(strDate: String) -> Date {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = FB_BIRTH_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.date(from: strDate)!
    }
    
    class func calculateAgeForDOB(DOB: String) -> Int {
        self.sharedInstance.sharedDateFormat!.dateFormat = ONLY_DATE_FORMAT
        let birthday: Date = self.sharedInstance.sharedDateFormat!.date(from: DOB)!
        let now: Date = Date()
        let ageComponents: DateComponents = Calendar.current.dateComponents([.year], from: birthday, to: now)
        let age: Int = ageComponents.year!
        return age
    }
    
    class func getStringDateWithSuffix(givenDate: String) -> String {
        //Convert EEE dd MMM yyyy formate
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        let date: Date = self.sharedInstance.sharedDateFormat!.date(from: givenDate)!
        self.sharedInstance.sharedDateFormat!.dateFormat = DIFF_DATE_FORMAT
        var strDate: String = self.sharedInstance.sharedDateFormat!.string(from: date)
        //To get only date from string
        let monthDayFormatter: DateFormatter = DateFormatter()
        monthDayFormatter.formatterBehavior = .behavior10_4
        
        monthDayFormatter.dateFormat = "d"
        let date_day: Int = Int(monthDayFormatter.string(from: date as Date))!
        monthDayFormatter.dateFormat = "yyyy"
        let date_year: Int = Int(monthDayFormatter.string(from: date as Date))!
        strDate = strDate.replacingOccurrences(of: "\(date_year)", with: "")
        //Add suffix
        var suffix: NSString?
        let ones: Int = date_day % 10
        let tens: Int = (date_day / 10) % 10
        if tens == 1 {
            suffix = "th"
        }
        else if ones == 1 {
            suffix = "st"
        }
        else if ones == 2 {
            suffix = "nd"
        }
        else if ones == 3 {
            suffix = "rd"
        }
        else {
            suffix = "th"
        }
        
        strDate = strDate.replacingOccurrences(of: "\(date_day)", with: "\(date_day)\(String(describing: suffix))")
        strDate = "\(strDate)\(date_year)"
        return strDate
        
    }
    
    
    class func convertFaceBookDateIntoString(givenDate: String) -> String {
        
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = FB_BIRTH_DATE_FORMAT
        let date: Date = self.sharedInstance.sharedDateFormat!.date(from: givenDate)!
        self.sharedInstance.sharedDateFormat!.dateFormat = ONLY_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.string(from: date)
    }
    
    
    // TODO: Create function for Upcoming Date

    /* class func isMatchUpcomingDate(givenDate: String) -> Bool {
     self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
     self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
     var date: Date = self.sharedInstance.sharedDateFormat!.date(from: givenDate)!
     var currentDate: Date = NSDate()
     var calendar: NSCalendar = NSCalendar.current
     
     let flags: NSCalendarUnit = .CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay
     
     var comps: Int = (.Year, .Month, .Day)
     var date1Components: DateComponents = calendar.components(comps, fromDate: date)
     var date2Components: DateComponents = calendar.components(comps, fromDate: currentDate)
     date = calendar.dateFromComponents(date1Components)
     currentDate = calendar.dateFromComponents(date2Components)
     var result: NSComparisonResult = date.compare(currentDate)
     if result == NSOrderedAscending {
     return false
     else  if result == NSOrderedDescending {
     return true
     }
     else {
     return true
     }
     }*/
    
}
