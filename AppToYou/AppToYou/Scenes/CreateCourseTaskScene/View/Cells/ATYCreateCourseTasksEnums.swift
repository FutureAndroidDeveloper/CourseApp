//
//  ATYCreateCourseTasksEnum.swift
//  AppToYou
//
//  Created by Philip Bratov on 21.06.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

enum ATYEnumWithReuseIdentifierCourseCellCheckBox : Int, CaseIterable {
    case lockCell
    case createTaskNameCell
    case createTaskCountingCell
    case createTaskPeriodCaledarCell
    case createDurationTaskCell
    case createSanctionTaskCell
    case minSanctionCell
    case saveTaskCell

    var identifier: String {
        switch self {
        case .lockCell:
            return ATYCreateCourseTaskLockCell.reuseIdentifier
        case .createTaskNameCell:
            return ATYCreateTaskNameCell.reuseIdentifier
        case .createTaskCountingCell:
            return ATYCreateTaskCountingCell.reuseIdentifier
        case .createTaskPeriodCaledarCell:
            return ATYOnceSelectDayCell.reuseIdentifier
        case .createDurationTaskCell:
            return ATYDurationCourseTaskCell.reuseIdentifier
        case .createSanctionTaskCell:
            return ATYCreateSanctionTaskCell.reuseIdentifier
        case .minSanctionCell:
            return ATYCreateCourseTaskMinSanctionCell.reuseIdentifier
        case .saveTaskCell:
            return ATYSaveTaskCell.reuseIdentifier
        }
    }
}

enum ATYEnumWithReuseIdentifierCourseCellCountRepeat : Int, CaseIterable {
    case lockCell
    case createTaskNameCell
    case createCountRepeatTaskCell
    case createTaskCountingCell
    case createTaskPeriodCaledarCell
    case createDurationTaskCell
    case createSanctionTaskCell
    case minSanctionCell
    case saveTaskCell

    var identifier: String {
        switch self {
        case .lockCell:
            return ATYCreateCourseTaskLockCell.reuseIdentifier
        case .createTaskNameCell:
            return ATYCreateTaskNameCell.reuseIdentifier
        case .createTaskCountingCell:
            return ATYCreateTaskCountingCell.reuseIdentifier
        case .createTaskPeriodCaledarCell:
            return ATYCreateTaskPeriodCalendarCell.reuseIdentifier
        case .createSanctionTaskCell:
            return ATYCreateSanctionTaskCell.reuseIdentifier
        case .minSanctionCell:
            return ATYCreateCourseTaskMinSanctionCell.reuseIdentifier
        case .saveTaskCell:
            return ATYSaveTaskCell.reuseIdentifier
        case .createCountRepeatTaskCell:
            return ATYCreateCountRepeatTaskCell.reuseIdentifier
        case .createDurationTaskCell:
            return ATYDurationCourseTaskCell.reuseIdentifier
        }
    }
}

enum ATYEnumWithReuseIdentifierCourseCellTimer : Int, CaseIterable {
    case lockCell
    case createTaskNameCell
    case createDurationTaskCell
    case createTaskCountingCell
    case createTaskPeriodCaledarCell
    case createDurationTaskCourseCell
    case createSanctionTaskCell
    case minSanctionCell
    case saveTaskCell

    var identifier: String {
        switch self {
        case .lockCell:
            return ATYCreateCourseTaskLockCell.reuseIdentifier
        case .createTaskNameCell:
            return ATYCreateTaskNameCell.reuseIdentifier
        case .createTaskCountingCell:
            return ATYCreateTaskCountingCell.reuseIdentifier
        case .createTaskPeriodCaledarCell:
            return ATYCreateTaskPeriodCalendarCell.reuseIdentifier
        case .createSanctionTaskCell:
            return ATYCreateSanctionTaskCell.reuseIdentifier
        case .saveTaskCell:
            return ATYSaveTaskCell.reuseIdentifier
        case .createDurationTaskCell:
            return ATYCreateDurationTaskCell.reuseIdentifier
        case .createDurationTaskCourseCell:
            return ATYDurationCourseTaskCell.reuseIdentifier
        case .minSanctionCell:
            return ATYCreateCourseTaskMinSanctionCell.reuseIdentifier
        }
    }
}

enum ATYEnumWithReuseIdentifierCourseCellText : Int, CaseIterable {
    case lockCell
    case createTaskNameCell
    case createDescriptionTaskCell
    case createMaxSymbolsCountCell
    case createTaskCountingCell
    case createTaskPeriodCaledarCell
    case createDurationTaskCell
    case createSanctionTaskCell
    case minSanctionCell
    case saveTaskCell

    var identifier: String {
        switch self {
        case .lockCell:
            return ATYCreateCourseTaskLockCell.reuseIdentifier
        case .createTaskNameCell:
            return ATYCreateTaskNameCell.reuseIdentifier
        case .createTaskCountingCell:
            return ATYCreateTaskCountingCell.reuseIdentifier
        case .createTaskPeriodCaledarCell:
            return ATYCreateTaskPeriodCalendarCell.reuseIdentifier
        case .createSanctionTaskCell:
            return ATYCreateSanctionTaskCell.reuseIdentifier
        case .saveTaskCell:
            return ATYSaveTaskCell.reuseIdentifier
        case .createMaxSymbolsCountCell:
            return ATYCreateMaxCountSymbolsCell.reuseIdentifier
        case .createDescriptionTaskCell:
            return ATYCreateDescriptionTaskCell.reuseIdentifier
        case .minSanctionCell:
            return ATYCreateCourseTaskMinSanctionCell.reuseIdentifier
        case .createDurationTaskCell:
            return ATYCreateDurationTaskCell.reuseIdentifier
        }
    }
}

