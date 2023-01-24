//
//  ATYCreateCourseTaskViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 21.06.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class ATYCreateCourseTaskViewController: UIViewController {

    var viewModel: ATYCreateCourseTaskViewModel!

    private var transitionForQuestionButton: PanelTransition!

    var createTaskTableView = UITableView()
    var needShowCalendar = true
    var needShowWeekDays = true
    var countOfNotification = 1

    private var transition: PanelTransition!
    private var datePicker = UIDatePicker()

    var types : ATYTaskType!

    var hour : String?
    var minute : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = R.string.localizable.creatingNewTask()
        view.addSubview(createTaskTableView)
        view.backgroundColor = R.color.backgroundAppColor()
        configureNavBar()
        configureCreateTaskTableView()

        self.transitionForQuestionButton = PanelTransition(y: view.bounds.height * 0.4 , height: view.bounds.height * 0.6)
    }

    //MARK:- Configure UI

    private func configureNavBar() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = R.color.lineViewBackgroundColor()
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.navigationBar.setBackgroundImage(nil, for:.default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = false

        self.viewModel = ATYCreateCourseTaskViewModel()
    }

    private func configureCreateTaskTableView() {
        createTaskTableView.separatorStyle = .none
        createTaskTableView.backgroundColor = R.color.backgroundAppColor()
        createTaskTableView.allowsSelection = false
        createTaskTableView.delegate = self
        createTaskTableView.dataSource = self
        createTaskTableView.register(ATYCreateTaskNameCell.self, forCellReuseIdentifier: ATYCreateTaskNameCell.reuseIdentifier)
        createTaskTableView.register(ATYCreateTaskCountingCell.self, forCellReuseIdentifier: ATYCreateTaskCountingCell.reuseIdentifier)
        createTaskTableView.register(ATYCreateTaskPeriodCalendarCell.self, forCellReuseIdentifier: ATYCreateTaskPeriodCalendarCell.reuseIdentifier)
        createTaskTableView.register(ATYCreateNotificationAboutTaskCell.self, forCellReuseIdentifier: ATYCreateNotificationAboutTaskCell.reuseIdentifier)
        createTaskTableView.register(ATYCreateSanctionTaskCell.self, forCellReuseIdentifier: ATYCreateSanctionTaskCell.reuseIdentifier)
        createTaskTableView.register(ATYSaveTaskCell.self, forCellReuseIdentifier: ATYSaveTaskCell.reuseIdentifier)
        createTaskTableView.register(ATYCreateCountRepeatTaskCell.self, forCellReuseIdentifier: ATYCreateCountRepeatTaskCell.reuseIdentifier)
        createTaskTableView.register(ATYCreateMaxCountSymbolsCell.self, forCellReuseIdentifier: ATYCreateMaxCountSymbolsCell.reuseIdentifier)
        createTaskTableView.register(ATYCreateDurationTaskCell.self, forCellReuseIdentifier: ATYCreateDurationTaskCell.reuseIdentifier)
        createTaskTableView.register(ATYCreateDescriptionTaskCell.self, forCellReuseIdentifier: ATYCreateDescriptionTaskCell.reuseIdentifier)
        createTaskTableView.register(ATYOnceSelectDayCell.self, forCellReuseIdentifier: ATYOnceSelectDayCell.reuseIdentifier)
        createTaskTableView.register(ATYSelectWeekDaysCell.self, forCellReuseIdentifier: ATYSelectWeekDaysCell.reuseIdentifier)
        createTaskTableView.register(ATYCreateCourseTaskLockCell.self, forCellReuseIdentifier: ATYCreateCourseTaskLockCell.reuseIdentifier)
        createTaskTableView.register(ATYDurationCourseTaskCell.self, forCellReuseIdentifier: ATYDurationCourseTaskCell.reuseIdentifier)
        createTaskTableView.register(ATYCreateCourseTaskMinSanctionCell.self, forCellReuseIdentifier: ATYCreateCourseTaskMinSanctionCell.reuseIdentifier)
        createTaskTableView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
        }

        self.transition = PanelTransition(y: view.bounds.height * 0.5 , height: view.bounds.height * 0.5)
    }

    private func openTimerViewController() {
        let child = ATYSelectTimeViewController()
        child.callBackTime = { [weak self] (hour, minute) in
            self?.hour = hour
            self?.minute = minute
            self?.createTaskTableView.reloadData()
        }

        child.transitioningDelegate = transition
        child.modalPresentationStyle = .custom

        present(child, animated: true)
    }

    private func openPenaltyForFailureController() {
        let child = ATYPenaltyForFailureViewController()

        child.transitioningDelegate = transitionForQuestionButton
        child.modalPresentationStyle = .custom

        present(child, animated: true)
    }
}

extension ATYCreateCourseTaskViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch types {
        case .CHECKBOX:
            return needShowCalendar ? ATYEnumWithReuseIdentifierCourseCellCheckBox.allCases.count : ATYEnumWithReuseIdentifierCourseCellCheckBox.allCases.count
        case .RITUAL:
            return needShowCalendar ? ATYEnumWithReuseIdentifierCourseCellCountRepeat.allCases.count : ATYEnumWithReuseIdentifierCourseCellCountRepeat.allCases.count
        case .TIMER:
            return needShowCalendar ? ATYEnumWithReuseIdentifierCourseCellTimer.allCases.count : ATYEnumWithReuseIdentifierCourseCellTimer.allCases.count
        case .TEXT:
            return needShowCalendar ? ATYEnumWithReuseIdentifierCourseCellText.allCases.count : ATYEnumWithReuseIdentifierCourseCellText.allCases.count
        default: return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch types {
        case .CHECKBOX:
            switch ATYEnumWithReuseIdentifierCourseCellCheckBox(rawValue: indexPath.row){
            case .lockCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateCourseTaskLockCell.reuseIdentifier, for: indexPath) as! ATYCreateCourseTaskLockCell
                return cell
            case .createTaskNameCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskNameCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskNameCell
                return cell
            case .createTaskCountingCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskCountingCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskCountingCell
                cell.oneRepeatCallback = { [weak self] frequencyType in
                    self?.viewModel.frequencyType = frequencyType
                    self?.createTaskTableView.reloadData()
                }
                return cell
            case .createTaskPeriodCaledarCell:
                if  self.viewModel.frequencyType == .CERTAIN_DAYS {
                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYSelectWeekDaysCell.reuseIdentifier, for: indexPath) as! ATYSelectWeekDaysCell
//                    cell.callbackResult = { [weak self] resultString in
//                        print(resultString)
//                        // self?.viewModel.daysCode = resultString
//                    }
                    return cell
                } else if  self.viewModel.frequencyType == .ONCE {
                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYOnceSelectDayCell.reuseIdentifier, for: indexPath) as! ATYOnceSelectDayCell
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskPeriodCalendarCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskPeriodCalendarCell
                    cell.startCallback = { [weak self] startDateString in
                        //self?.viewModel.userTask.startDate = startDateString ?? ""
                    }

                    cell.endCallback = { [weak self] endDateString in
                        //self?.viewModel.userTask.taskCompleteTime = endDateString ?? ""
                    }
                    return cell
                }
            case .createDurationTaskCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYDurationCourseTaskCell.reuseIdentifier, for: indexPath) as! ATYDurationCourseTaskCell
                cell.checkBoxLabel.text = "Бесконечное выполнение"
                return cell
            case .createSanctionTaskCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateSanctionTaskCell.reuseIdentifier, for: indexPath) as! ATYCreateSanctionTaskCell

//                cell.questionCallback = { [weak self] in
//                    self?.openPenaltyForFailureController()
//                }
                return cell
            case .minSanctionCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateCourseTaskMinSanctionCell.reuseIdentifier, for: indexPath) as! ATYCreateCourseTaskMinSanctionCell
                return cell
            case .saveTaskCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYSaveTaskCell.reuseIdentifier, for: indexPath) as! ATYSaveTaskCell
                cell.setUp(titleForButton: R.string.localizable.createTask())
//                cell.callback = { [weak self] in
//                    self?.navigationController?.popViewController(animated: true)
//                }
                return cell
            default: break
            }
        case .RITUAL:
            switch ATYEnumWithReuseIdentifierCourseCellCountRepeat(rawValue: indexPath.row){
            case .lockCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateCourseTaskLockCell.reuseIdentifier, for: indexPath) as! ATYCreateCourseTaskLockCell
                return cell
            case .createTaskNameCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskNameCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskNameCell
                return cell
            case .createCountRepeatTaskCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateCountRepeatTaskCell.reuseIdentifier, for: indexPath) as! ATYCreateCountRepeatTaskCell
//                cell.lockButton.isHidden = false
                return cell
            case .createTaskCountingCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskCountingCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskCountingCell
                cell.oneRepeatCallback = { [weak self] frequencyType in
                    self?.viewModel.frequencyType = frequencyType
                    self?.createTaskTableView.reloadData()
                }
                return cell
            case .createTaskPeriodCaledarCell:
                if  self.viewModel.frequencyType == .CERTAIN_DAYS {
                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYSelectWeekDaysCell.reuseIdentifier, for: indexPath) as! ATYSelectWeekDaysCell
//                    cell.callbackResult = { [weak self] resultString in
//                        print(resultString)
//                        // self?.viewModel.daysCode = resultString
//                    }
                    return cell
                } else if  self.viewModel.frequencyType == .ONCE {
                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYOnceSelectDayCell.reuseIdentifier, for: indexPath) as! ATYOnceSelectDayCell
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskPeriodCalendarCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskPeriodCalendarCell
                    cell.startCallback = { [weak self] startDateString in
                        //self?.viewModel.userTask.startDate = startDateString ?? ""
                    }

                    cell.endCallback = { [weak self] endDateString in
                        //self?.viewModel.userTask.taskCompleteTime = endDateString ?? ""
                    }
                    return cell
                }
            case .createDurationTaskCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYDurationCourseTaskCell.reuseIdentifier, for: indexPath) as! ATYDurationCourseTaskCell
                cell.checkBoxLabel.text = "Бесконечное выполнение"
                return cell
            case .createSanctionTaskCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateSanctionTaskCell.reuseIdentifier, for: indexPath) as! ATYCreateSanctionTaskCell

//                cell.questionCallback = { [weak self] in
//                    self?.openPenaltyForFailureController()
//                }
                return cell
            case .minSanctionCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateCourseTaskMinSanctionCell.reuseIdentifier, for: indexPath) as! ATYCreateCourseTaskMinSanctionCell
                return cell
            case .saveTaskCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYSaveTaskCell.reuseIdentifier, for: indexPath) as! ATYSaveTaskCell
                cell.setUp(titleForButton: R.string.localizable.createTask())
//                cell.callback = { [weak self] in
//                    self?.navigationController?.popViewController(animated: true)
//                }
                return cell
            default: break
            }
        case .TIMER:
            switch ATYEnumWithReuseIdentifierCourseCellTimer(rawValue: indexPath.row){
            case .lockCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateCourseTaskLockCell.reuseIdentifier, for: indexPath) as! ATYCreateCourseTaskLockCell
                return cell
            case .createTaskNameCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskNameCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskNameCell
                return cell
            case .createDurationTaskCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateDurationTaskCell.reuseIdentifier, for: indexPath) as! ATYCreateDurationTaskCell
                cell.lockButton.isHidden = false
                return cell
            case .createTaskCountingCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskCountingCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskCountingCell
                cell.oneRepeatCallback = { [weak self] frequencyType in
                    self?.viewModel.frequencyType = frequencyType
                    self?.createTaskTableView.reloadData()
                }
                return cell
            case .createTaskPeriodCaledarCell:
                if  self.viewModel.frequencyType == .CERTAIN_DAYS {
                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYSelectWeekDaysCell.reuseIdentifier, for: indexPath) as! ATYSelectWeekDaysCell
//                    cell.callbackResult = { [weak self] resultString in
//                        print(resultString)
//                        // self?.viewModel.daysCode = resultString
//                    }
                    return cell
                } else if  self.viewModel.frequencyType == .ONCE {
                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYOnceSelectDayCell.reuseIdentifier, for: indexPath) as! ATYOnceSelectDayCell
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskPeriodCalendarCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskPeriodCalendarCell
                    cell.startCallback = { [weak self] startDateString in
                        //self?.viewModel.userTask.startDate = startDateString ?? ""
                    }

                    cell.endCallback = { [weak self] endDateString in
                        //self?.viewModel.userTask.taskCompleteTime = endDateString ?? ""
                    }
                    return cell
                }
            case .createDurationTaskCourseCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYDurationCourseTaskCell.reuseIdentifier, for: indexPath) as! ATYDurationCourseTaskCell
                cell.checkBoxLabel.text = "Бесконечное выполнение"
                return cell
            case .createSanctionTaskCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateSanctionTaskCell.reuseIdentifier, for: indexPath) as! ATYCreateSanctionTaskCell

//                cell.questionCallback = { [weak self] in
//                    self?.openPenaltyForFailureController()
//                }
                return cell
            case .minSanctionCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateCourseTaskMinSanctionCell.reuseIdentifier, for: indexPath) as! ATYCreateCourseTaskMinSanctionCell
                return cell
            case .saveTaskCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYSaveTaskCell.reuseIdentifier, for: indexPath) as! ATYSaveTaskCell
                cell.setUp(titleForButton: R.string.localizable.createTask())
//                cell.callback = { [weak self] in
//                    self?.navigationController?.popViewController(animated: true)
//                }
                return cell
            default: break
            }
        case .TEXT:
            switch ATYEnumWithReuseIdentifierCourseCellText(rawValue: indexPath.row){
            case .lockCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateCourseTaskLockCell.reuseIdentifier, for: indexPath) as! ATYCreateCourseTaskLockCell
                return cell
            case .createTaskNameCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskNameCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskNameCell
                return cell
            case .createDescriptionTaskCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateDescriptionTaskCell.reuseIdentifier, for: indexPath) as! ATYCreateDescriptionTaskCell
                return cell
            case .createMaxSymbolsCountCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateMaxCountSymbolsCell.reuseIdentifier, for: indexPath) as! ATYCreateMaxCountSymbolsCell
                cell.lockButton.isHidden = false
                return cell
            case .createTaskCountingCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskCountingCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskCountingCell
                cell.oneRepeatCallback = { [weak self] frequencyType in
                    self?.viewModel.frequencyType = frequencyType
                    self?.createTaskTableView.reloadData()
                }
                return cell
            case .createTaskPeriodCaledarCell:
                if  self.viewModel.frequencyType == .CERTAIN_DAYS {
                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYSelectWeekDaysCell.reuseIdentifier, for: indexPath) as! ATYSelectWeekDaysCell
//                    cell.callbackResult = { [weak self] resultString in
//                        print(resultString)
//                        // self?.viewModel.daysCode = resultString
//                    }
                    return cell
                } else if  self.viewModel.frequencyType == .ONCE {
                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYOnceSelectDayCell.reuseIdentifier, for: indexPath) as! ATYOnceSelectDayCell
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskPeriodCalendarCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskPeriodCalendarCell
                    cell.startCallback = { [weak self] startDateString in
                        //self?.viewModel.userTask.startDate = startDateString ?? ""
                    }

                    cell.endCallback = { [weak self] endDateString in
                        //self?.viewModel.userTask.taskCompleteTime = endDateString ?? ""
                    }
                    return cell
                }
            case .createDurationTaskCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYDurationCourseTaskCell.reuseIdentifier, for: indexPath) as! ATYDurationCourseTaskCell
                return cell
            case .createSanctionTaskCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateSanctionTaskCell.reuseIdentifier, for: indexPath) as! ATYCreateSanctionTaskCell

//                cell.questionCallback = { [weak self] in
//                    self?.openPenaltyForFailureController()
//                }
                
                return cell
            case .minSanctionCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateCourseTaskMinSanctionCell.reuseIdentifier, for: indexPath) as! ATYCreateCourseTaskMinSanctionCell
                return cell
            case .saveTaskCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYSaveTaskCell.reuseIdentifier, for: indexPath) as! ATYSaveTaskCell
                cell.setUp(titleForButton: R.string.localizable.createTask())
//                cell.callback = { [weak self] in
//                    self?.navigationController?.popViewController(animated: true)
//                }
                return cell
            default: break
            }
        default: break
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
