//
//  ATYUpCreateCourseViewModel.swift
//  AppToYou
//
//  Created by Philip Bratov on 22.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

protocol ATYUpCreateCourseViewModelDelegate : class {
    func checkProperty(errorMessage: String?)
    func createCourse(course: ATYCourse)
}

class ATYUpCreateCourseViewModel {

    let interactionMode : InteractionMode
    var course = ATYCourse()
    var avatarPath : String?

    weak var delegate : ATYUpCreateCourseViewModelDelegate?

    enum InteractionMode {
        case create
        case update
    }

    init(interactionMode: InteractionMode) {
        self.interactionMode = interactionMode
    }

    func createCourse() {
        guard !course.courseName.isEmpty else {
            self.delegate?.checkProperty(errorMessage: "Заполните название курса!")
            return
        }

        guard let description = course.courseDescription, !description.isEmpty  else {
            self.delegate?.checkProperty(errorMessage: "Заполните описание курса!")
            return
        }

        guard let _ = course.picPath else {
            self.delegate?.checkProperty(errorMessage: "Выберите обложку курса!")
            return
        }

        guard !course.courseCategory.isEmpty else {
            self.delegate?.checkProperty(errorMessage: "Выберите категорию курса!")
            return
        }

        if course.courseType == .PAID, course.coinPrice == nil {
            self.delegate?.checkProperty(errorMessage: "Выставите оплату за вступление в курс!")
            return
        }

        if course.duration.day == 0, course.duration.year == 0 , course.duration.month == 0 {
            self.delegate?.checkProperty(errorMessage: "Заполните длительность курса!")
            return
        }

        self.delegate?.createCourse(course: self.course)
    }

//    func createCourse(courseName: String,
//                      courseDescription: String?,
//                      categories: [ATYCourseCategory],
//                      typeOfCourse: ATYCourseType,
//                      costCourse: Int?,
//                      durationCourse: ATYDurationCourse,
//                      durationType: ATYDurationType,
//                      chatPath: String?) -> ATYCourse {
//        var coinPrice: Int? = nil
//        var diamondPrice: Int? = nil
//
//        if typeOfCourse == .PAID {
//            coinPrice = costCourse
//            diamondPrice = costCourse
//        }
//        return ATYCourse(coinPrice: coinPrice,
//                         diamondPrice: diamondPrice,
//                         courseCategory: categories,
//                         duration: durationCourse,
//                         limited: durationType,
//                         isInternal: false,
//                         isOpen: false,
//                         courseType: typeOfCourse,
//                         privacyEnabled: false,
//                         publicId: "",
//                         likes: 0,
//                         courseName: courseName,
//                         picPath: avatarPath ?? "",
//                         usersAmount: 1)
//    }
}
