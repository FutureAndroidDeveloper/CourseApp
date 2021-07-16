//
//  ATYEnumsCreateCourseCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 09.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

enum TypeCell: Int {
    case open
    case close
    case payment
}

enum EnumCreateCourseCell: Int, CaseIterable {
    case nameCourse
    case descriptionCourse
    case photoCourse
    case courseCategory
    case radioOpen
    case radioClose
    case radioNeedPay
    case durationCourse
    case chatCourse
    case deleteCourse
    case saveCourse
}
