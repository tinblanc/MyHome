//
//  Date+.swift
//  MyHome
//
//  Created by tran.huu.tan on 7/20/18.
//  Copyright © 2018 Tin Blanc. All rights reserved.
//

import UIKit

extension DateFormatter {
    enum Format: String {
        case iso8601 = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        case date = "dd/MM/yyyy"
        case shortTime = "HH:mm"
        case dateTimeString = "yyyyMMddHHmm"
        case dateWithSlash = "yyyy/MM/dd"
        
        var instance: DateFormatter {
            switch self {
            default:
                return DateFormatter().then {
                    $0.dateFormat = self.rawValue
                    $0.calendar = Calendar(identifier: Calendar.Identifier.gregorian)
                    $0.locale = Locale(identifier: "en_US_POSIX")
                }
            }
        }
    }
}

extension Date {
    func toShortTime() -> String {
        let formatter = DateFormatter.Format.shortTime.instance
        return formatter.string(from: self)
    }
    
    func toDate() -> String {
        let formatter = DateFormatter.Format.date.instance
        return formatter.string(from: self)
    }
    
    var minimumDate: Date {
        var dateComponents = DateComponents()
        dateComponents.year = 1900
        dateComponents.month = 1
        dateComponents.day = 1
        let userCalendar = Calendar.current
        let minDate = userCalendar.date(from: dateComponents)
        return minDate ?? Date()
    }
    
    func toDateWithSlash() -> String {
        let formatter = DateFormatter.Format.dateWithSlash.instance
        return formatter.string(from: self)
    }
}
