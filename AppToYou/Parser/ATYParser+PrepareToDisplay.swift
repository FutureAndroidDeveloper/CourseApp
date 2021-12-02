//
//  ATYParser+PrepareToDisplay.swift
//  AppToYou
//
//  Created by Philip Bratov on 01.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import Foundation

extension ATYParser {

    func prepareToDisplay(userTasks: [CDUserTask]) -> [ATYUserTask] {
        var result = [ATYUserTask]()
        for userTask in userTasks {
            if let parsedUserTask = prepareToDisplay(userTask: userTask) {
                result.append(parsedUserTask)
            }
        }
        return result
    }

    
    func prepareToDisplay(userTask: CDUserTask) -> ATYUserTask? {

        var creationDate: String? = nil
        var updateDate: String? = nil
        var startDate = ""
        var taskCompletedTask: String? = nil
        var frequencyType : ATYFrequencyTypeEnum?
        var taskType : ATYTaskType?

        if let tsCreated = userTask.tsCreated {
            creationDate = tsCreated.toString(dateFormat: .simpleDateTimeFormat)
        }

        if let tsUpdated = userTask.tsUpdated {
            updateDate = tsUpdated.toString(dateFormat: .simpleDateTimeFormat)
        }

        if let startDateTs = userTask.tsUpdated {
            startDate = startDateTs.toString(dateFormat: .simpleDateTimeFormat)
        }

        if let taskCompletedTaskTs = userTask.tsUpdated {
            taskCompletedTask = taskCompletedTaskTs.toString(dateFormat: .simpleDateTimeFormat)
        }

        frequencyType = ATYFrequencyTypeEnum.allCases.first(where: { $0.title == userTask.frequencyType })

        taskType = ATYTaskType.allCases.first(where: { $0.title == userTask.taskType })

        return ATYUserTask(tsCreated: creationDate,
                           tsUpdated: updateDate,
                           courseTaskId: userTask.courseTaskId == nil ? nil : Int(userTask.courseTaskId!),
                           daysCode: userTask.daysCode,
                           editableCourseTask: userTask.editableCourseTask,
                           frequencyType: frequencyType ?? .ONCE,
                           minimumCourseTaskSanction: Int(userTask.minimumCourseTaskSanction),
                           startDate: startDate,
                           taskAttribute: userTask.taskAttribute,
                           taskCompleteTime: taskCompletedTask,
                           taskDescription: userTask.taskDescription,
                           taskName: userTask.taskName,
                           taskSanction: Int(userTask.taskSanction),
                           taskType: taskType ?? .CHECKBOX,
                           userFk: userTask.userFk == nil ? nil : Int(userTask.userFk!),
                           id: Int(userTask.id),
                           courseFk: userTask.courseFk == nil ? nil : Int(userTask.courseFk!))
    }
}
