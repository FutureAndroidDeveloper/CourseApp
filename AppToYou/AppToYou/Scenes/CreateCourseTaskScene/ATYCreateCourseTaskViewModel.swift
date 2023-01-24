//
//  ATYCreateCourseTaskViewModel.swift
//  AppToYou
//
//  Created by Philip Bratov on 15.07.2021.
//  Copyright © 2021 .... All rights reserved.
//

import Foundation

class ATYCreateCourseTaskViewModel {
    var frequencyType : ATYFrequencyTypeEnum? {
        willSet {
//            userTask.frequencyType = newValue ?? .ONCE

            var description = ""
            switch newValue {
            case .ONCE:
                description = "один раз"
            case .EVERYDAY:
                description = "каждый день"
            case .WEEKDAYS:
                description = "по будням"
            case .MONTHLY:
                description = "каждый месяц"
            case .YEARLY:
                description = "ежегодно"
            case .CERTAIN_DAYS:
               break
            default:
                break
            }
//            userTask.taskDescription = description
        }
    }
}
