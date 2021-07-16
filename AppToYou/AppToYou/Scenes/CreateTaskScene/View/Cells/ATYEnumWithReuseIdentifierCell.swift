//
//  ATYEnumWithReuseIdentifierCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 31.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

enum ATYEnumWithReuseIdentifierCellCheckBox : Int, CaseIterable {
    case createTaskNameCell
    case createTaskCountingCell
    case createTaskPeriodCaledarCell
    case createNotificationAboutTaskCell
    case createSanctionTaskCell
    case saveTaskCell

    var identifier: String {
        switch self {
        case .createTaskNameCell:
            return ATYCreateTaskNameCell.reuseIdentifier
        case .createTaskCountingCell:
            return ATYCreateTaskCountingCell.reuseIdentifier
        case .createTaskPeriodCaledarCell:
            return ATYCreateTaskPeriodCalendarCell.reuseIdentifier
        case .createNotificationAboutTaskCell:
            return ATYCreateNotificationAboutTaskCell.reuseIdentifier
        case .createSanctionTaskCell:
            return ATYCreateSanctionTaskCell.reuseIdentifier
        case .saveTaskCell:
            return ATYSaveTaskCell.reuseIdentifier
        }
    }
}

enum ATYEnumWithReuseIdentifierCellCountRepeat : Int, CaseIterable {
    case createTaskNameCell
    case createCountRepeatTaskCell
    case createTaskCountingCell
    case createTaskPeriodCaledarCell
    case createNotificationAboutTaskCell
    case createSanctionTaskCell

    case saveTaskCell

    var identifier: String {
        switch self {
        case .createTaskNameCell:
            return ATYCreateTaskNameCell.reuseIdentifier
        case .createTaskCountingCell:
            return ATYCreateTaskCountingCell.reuseIdentifier
        case .createTaskPeriodCaledarCell:
            return ATYCreateTaskPeriodCalendarCell.reuseIdentifier
        case .createNotificationAboutTaskCell:
            return ATYCreateNotificationAboutTaskCell.reuseIdentifier
        case .createSanctionTaskCell:
            return ATYCreateSanctionTaskCell.reuseIdentifier
        case .saveTaskCell:
            return ATYSaveTaskCell.reuseIdentifier
        case .createCountRepeatTaskCell:
            return ATYCreateCountRepeatTaskCell.reuseIdentifier
        }
    }
}

enum ATYEnumWithReuseIdentifierCellTimer : Int, CaseIterable {
    case createTaskNameCell
    case createDurationTaskCell
    case createTaskCountingCell
    case createTaskPeriodCaledarCell
    case createNotificationAboutTaskCell
    case createSanctionTaskCell
    case saveTaskCell

    var identifier: String {
        switch self {
        case .createTaskNameCell:
            return ATYCreateTaskNameCell.reuseIdentifier
        case .createTaskCountingCell:
            return ATYCreateTaskCountingCell.reuseIdentifier
        case .createTaskPeriodCaledarCell:
            return ATYCreateTaskPeriodCalendarCell.reuseIdentifier
        case .createNotificationAboutTaskCell:
            return ATYCreateNotificationAboutTaskCell.reuseIdentifier
        case .createSanctionTaskCell:
            return ATYCreateSanctionTaskCell.reuseIdentifier
        case .saveTaskCell:
            return ATYSaveTaskCell.reuseIdentifier
        case .createDurationTaskCell:
            return ATYCreateDurationTaskCell.reuseIdentifier
        }
    }
}

enum ATYEnumWithReuseIdentifierCellText : Int, CaseIterable {

    case createTaskNameCell
    case createDescriptionTaskCell
    case createMaxSymbolsCountCell
    case createTaskCountingCell
    case createTaskPeriodCaledarCell
    case createNotificationAboutTaskCell
    case createSanctionTaskCell
    case saveTaskCell

    var identifier: String {
        switch self {
        case .createTaskNameCell:
            return ATYCreateTaskNameCell.reuseIdentifier
        case .createTaskCountingCell:
            return ATYCreateTaskCountingCell.reuseIdentifier
        case .createTaskPeriodCaledarCell:
            return ATYCreateTaskPeriodCalendarCell.reuseIdentifier
        case .createNotificationAboutTaskCell:
            return ATYCreateNotificationAboutTaskCell.reuseIdentifier
        case .createSanctionTaskCell:
            return ATYCreateSanctionTaskCell.reuseIdentifier
        case .saveTaskCell:
            return ATYSaveTaskCell.reuseIdentifier
        case .createMaxSymbolsCountCell:
            return ATYCreateMaxCountSymbolsCell.reuseIdentifier
        case .createDescriptionTaskCell:
            return ATYCreateDescriptionTaskCell.reuseIdentifier
        }
    }
}

enum TypeOfTask : Int {
    case checkBox
    case countRepeat
    case timerTask
    case textTask

    var massive : [UITableViewCell] {
        return [ATYCreateDescriptionTaskCell()]
    }
}