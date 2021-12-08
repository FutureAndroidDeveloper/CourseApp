//
//  Date + ToString.swift
//  AppToYou
//
//  Created by Philip Bratov on 02.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//


import UIKit

public extension Date {

    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateFormatter.timeZone = .autoupdatingCurrent
        return dateFormatter
    }()

    func toString(dateFormat format: ATYDateFormat, locale: String? = nil) -> String {
        if let locale = locale {
            Date.dateFormatter.locale = Locale(identifier: locale)
        }
        Date.dateFormatter.dateFormat = format.rawValue
        return Date.dateFormatter.string(from: self)
    }

    enum ATYDateFormat: String {
        case localDateTime = "yyyy-MM-dd'T'HH:mm:ss"
        case simpleDateFormat = "dd.MM.YY"
        case simpleDateFormatFullYear = "dd.MM.YYYY"
        case simpleTimeFormat = "HH:mm"
        case simpleDateTimeFormat = "dd.MM.yy HH:mm"
        case localeYearDate = "yyyy-MM-dd"
        case localeDayMonthWithoutYear = "dd MMMM"
        case localeDayMonth = "dd MMMM, yyyy"
        case currentMonthName = "LLLL"
        case currentYear = "yyyy"
        case calendarFormat = "EEEE, d MMM yyyy"
    }

    var ignoringTime: Date? {
        let dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: self)
        return Calendar.current.date(from: dateComponents)
    }

    init(millis: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(millis / 1000))
        self.addTimeInterval(TimeInterval(Double(millis % 1000) / 1000 ))
    }

    func getLast6Month() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -6, to: self)
    }

    func getLast3Month() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -3, to: self)
    }

    func getYesterday() -> Date? {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)
    }

    func getLast7Day() -> Date? {
        return Calendar.current.date(byAdding: .day, value: -7, to: self)
    }
    func getLast30Day() -> Date? {
        return Calendar.current.date(byAdding: .day, value: -30, to: self)
    }

    func getPreviousMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -1, to: self)
    }

    // This Month Start
    func getThisMonthStart() -> Date? {
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: components)!
    }

    func getThisMonthEnd() -> Date? {
        let components:NSDateComponents = Calendar.current.dateComponents([.year, .month], from: self) as NSDateComponents
        components.month += 1
        components.day = 1
        components.day -= 1
        return Calendar.current.date(from: components as DateComponents)!
    }

    func orderedSameDateOnDays(firstDate: Date? , secondDate: Date?) -> Bool {
        return Calendar.current.compare( firstDate?.ignoringTime ?? Date(), to: secondDate?.ignoringTime ?? Date(), toGranularity: .day) == .orderedSame
    }
}
