//
//  String+ToDateTime.swift
//  AppToYou
//
//  Created by Philip Bratov on 01.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import Foundation

public extension String {

    var localDateTime: Date? {
        get {
            self.toDate(dateFormat: .localDateTime)
        }
    }
    
    var localeYearDate: Date? {
        get {
            self.toDate(dateFormat: .localeYearDate)
        }
    }

    var simpleDateTimeFormat: Date? {
        get {
            self.toDate(dateFormat: .simpleDateTimeFormat)
        }
    }

    func toDate(dateFormat format: Date.ATYDateFormat) -> Date? {
        Date.dateFormatter.dateFormat = format.rawValue
        return Date.dateFormatter.date(from: self)
    }

}
