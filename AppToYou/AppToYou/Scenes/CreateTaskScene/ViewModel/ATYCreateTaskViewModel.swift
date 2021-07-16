//
//  ATYCreateTaskViewModel.swift
//  AppToYou
//
//  Created by Philip Bratov on 01.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import Foundation

class ATYCreateTaskViewModel {

    var userTask = ATYUserTask()

    var hour : String?
    var minute : String?

    var daysCode : String? {
        willSet {
            userTask.daysCode = newValue

            let daysArray = ["пн","вт","ср","чт","пт","сб","вс"]
            var resultDescriptionString = ""
            if let code = newValue {
                for i in 0..<code.count {
                    if Array(code)[i] == "1" {
                        resultDescriptionString.append(contentsOf: " " + daysArray[i] + ",")
                    }
                }
                if resultDescriptionString.isEmpty {
                    return
                }
                print(resultDescriptionString)
                resultDescriptionString.removeLast()
                print(resultDescriptionString)
                userTask.taskDescription = resultDescriptionString
            }
        }
    }

    var frequencyType : ATYFrequencyTypeEnum? {
        willSet {
            userTask.frequencyType = newValue ?? .ONCE

            var description = ""
            switch userTask.frequencyType {
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
            }
            userTask.taskDescription = description
        }
    }
//
//    courseTaskId: Int,
//                        daysCode: String?,
//                        editableCourseTask: Bool,
//                        frequencyType: String?,
//                        minimumCourseTaskSanction: Int,
//                        taskAttribute: String?,
//                        startDate: Date?,
//                        taskCompleteTime: Date?,
//                        taskDescription: String?,
//                        taskName: String?,
//                        taskSanction: Int,
//                        taskType: String?,
//                        courseFk: Int?,
//                        userFk: Int

    func createUserTask() {
        guard let dbService = try? ATYDatabaseService() else {
            return
        }

        if userTask.frequencyType != .CERTAIN_DAYS {
            userTask.daysCode = nil
        }
        

        dbService.createUserTask(courseTaskId: userTask.courseTaskId,
                                 daysCode: userTask.daysCode,
                                 editableCourseTask: userTask.editableCourseTask,
                                 frequencyType: userTask.frequencyType.rawValue,
                                 minimumCourseTaskSanction: userTask.minimumCourseTaskSanction,
                                 taskAttribute: userTask.taskAttribute,
                                 startDate: userTask.startDate.toDate(dateFormat: .simpleDateFormat) ?? Date(),
                                 taskCompleteTime: userTask.taskCompleteTime?.toDate(dateFormat: .simpleDateFormat),
                                 taskDescription: userTask.taskDescription,
                                 taskName: userTask.taskName,
                                 taskSanction: userTask.taskSanction,
                                 taskType: userTask.taskType.rawValue,
                                 courseFk:userTask.courseFk,
                                 userFk: userTask.userFk)
    }
}
