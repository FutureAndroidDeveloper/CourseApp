//
//  ATYUpCreateCourseViewModel.swift
//  AppToYou
//
//  Created by Philip Bratov on 22.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYUpCreateCourseViewModel {

    let interactionMode : InteractionMode
    var course = ATYCourse()
    var avatarPath : String?

    enum InteractionMode {
        case create
        case update
    }

    init(interactionMode: InteractionMode) {
        self.interactionMode = interactionMode
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
