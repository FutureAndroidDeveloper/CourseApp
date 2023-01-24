//
//  ATYUserTask.swift
//  AppToYou
//
//  Created by Philip Bratov on 01.07.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

struct ATYUserTask {
    var tsCreated: String? = Date().toString(dateFormat: .simpleDateFormat)
    var tsUpdated: String? = Date().toString(dateFormat: .simpleDateFormat)
    var courseTaskId: Int? = 0
    var daysCode: String?
    var editableCourseTask: Bool = false
    var frequencyType: ATYFrequencyTypeEnum = .EVERYDAY
    var minimumCourseTaskSanction: Int = 0
    var startDate: String = Date().toString(dateFormat: .simpleDateFormat)
    
    var endDate: String = Date().toString(dateFormat: .simpleDateFormat)
    
    var taskAttribute: String? = "attribute"
    var taskCompleteTime: String? = nil
    var taskDescription: String? = "description"
    var taskName: String = "Name task"
    var taskSanction: Int = 0
    var taskType: ATYTaskType = .CHECKBOX
    var userFk: Int? = 0
    var id: Int = 0
    var courseFk: Int? = 0
    var reminderList : [String]?
}

enum ATYFrequencyTypeEnum: String, CaseIterable, Codable {
    case ONCE
    case EVERYDAY
    case WEEKDAYS
    case MONTHLY
    case YEARLY
    case CERTAIN_DAYS

    var title: String {
        get { return String(describing: self) }
    }
}

enum ATYTaskType: String, CaseIterable, Codable {
    case CHECKBOX
    case TEXT
    case TIMER
    case RITUAL

    var title: String {
        get {
            return String(describing: self)
        }
    }

    var massive : [UITableViewCell] {
        return [ATYCreateDescriptionTaskCell()]
    }
}
