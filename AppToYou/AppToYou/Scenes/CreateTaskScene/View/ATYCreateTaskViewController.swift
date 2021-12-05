//
//  ATYCreateTaskViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 28.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYCreateTaskViewController: UIViewController, BindableType {
    var viewModel : CreateTaskViewModel!
    
    func bindViewModel() {
        viewModel.output.data.bind(self.update(_:))
        viewModel.output.updatedState.bind { [weak self] _ in
            self?.createTaskTableView.beginUpdates()
            self?.createTaskTableView.endUpdates()
        }
    }

    var createTaskTableView = UITableView()
    var countOfNotification = 1
    
    private var inflater: UITableViewIflater!

    private var transition: PanelTransition!
    private var transitionForQuestionButton: PanelTransition!
    private var datePicker = UIDatePicker()

    var types : ATYTaskType!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = R.string.localizable.creatingNewTask()
        view.addSubview(createTaskTableView)
        view.backgroundColor = R.color.backgroundAppColor()
        configureNavBar()
//        configureCreateTaskTableView()
        configureInflater()
//        viewModel = ATYCreateTaskViewModel()
        
//        viewModel = SimpleCreateTaskViewModel(delegate: self, taskType: .CHECKBOX)
//        update()
    }
    
    private func configureInflater() {
        createTaskTableView.separatorStyle = .none
        createTaskTableView.backgroundColor = R.color.backgroundAppColor()
        createTaskTableView.allowsSelection = false
        
        inflater = UITableViewIflater(createTaskTableView)
        
        inflater.registerRow(model: CreateTaskNameCellModel.self, cell: ATYCreateTaskNameCell.self)
        inflater.registerRow(model: CreateTaskCountingCellModel.self, cell: ATYCreateTaskCountingCell.self)
        inflater.registerRow(model: CreateTaskPeriodCalendarCellModel.self, cell: ATYCreateTaskPeriodCalendarCell.self)
        
        inflater.registerRow(model: NotificationAboutTaskModel.self, cell: NotificationAboutTaskCell.self)
        
        inflater.registerRow(model: CreateSanctionTaskCellModel.self, cell: ATYCreateSanctionTaskCell.self)
        inflater.registerRow(model: SaveTaskCellModel.self, cell: ATYSaveTaskCell.self)
        inflater.registerRow(model: CreateCountRepeatTaskCellModel.self, cell: ATYCreateCountRepeatTaskCell.self)
        inflater.registerRow(model: CreateMaxCountSymbolsCellModel.self, cell: ATYCreateMaxCountSymbolsCell.self)
        inflater.registerRow(model: CreateDurationTaskCellModel.self, cell: ATYCreateDurationTaskCell.self)
        inflater.registerRow(model: CreateDescriptionTaskCellModel.self, cell: ATYCreateDescriptionTaskCell.self)
        inflater.registerRow(model: OnceSelectDayCellModel.self, cell: ATYOnceSelectDayCell.self)
        inflater.registerRow(model: SelectWeekDaysCellModel.self, cell: ATYSelectWeekDaysCell.self)
        
        createTaskTableView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
        }

        self.transition = PanelTransition(y: view.bounds.height * 0.5 , height: view.bounds.height * 0.5)
        self.transitionForQuestionButton = PanelTransition(y: view.bounds.height * 0.4 , height: view.bounds.height * 0.6)
    }
    
    //MARK:- Configure UI

    private func configureNavBar() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = R.color.lineViewBackgroundColor()
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
//    func update() {
////        let section = TableViewSection(models: viewModel.getModel())
////        inflater.inflate(sections: [section])
//    }
    
    func update(_ data: [AnyObject]) {
        let section = TableViewSection(models: data)
        inflater.inflate(sections: [section])
    }

    private func openTimerViewController() {
        let child = ATYSelectTimeViewController()
        child.callBackTime = { [weak self] (hour, minute) in
//            self?.viewModel.hour = hour
//            self?.viewModel.minute = minute
//            if let hour = self?.viewModel.hour, let minute = self?.viewModel.minute {
//                self?.viewModel.userTask.reminderList?.append(hour + ":" + minute)
//            }
            self?.createTaskTableView.reloadData()
        }

        child.transitioningDelegate = transition   // 2
        child.modalPresentationStyle = .custom  // 3

        present(child, animated: true)
    }

    private func openPenaltyForFailureController() {
        let child = ATYPenaltyForFailureViewController()

        child.transitioningDelegate = transitionForQuestionButton
        child.modalPresentationStyle = .custom

        present(child, animated: true)
    }
}

//extension ATYCreateTaskViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch types {
//        case .CHECKBOX:
//            return ATYEnumWithReuseIdentifierCellCheckBox.allCases.count
//        case .RITUAL:
//            return ATYEnumWithReuseIdentifierCellCountRepeat.allCases.count
//        case .TIMER:
//            return ATYEnumWithReuseIdentifierCellTimer.allCases.count
//        case .TEXT:
//            return ATYEnumWithReuseIdentifierCellText.allCases.count
//        default: return 0
//        }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch types {
//        case .CHECKBOX:
//            self.viewModel.userTask.taskType = .CHECKBOX
//            self.viewModel.userTask.taskAttribute = nil
//            switch ATYEnumWithReuseIdentifierCellCheckBox(rawValue: indexPath.row){
//            case .createTaskNameCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskNameCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskNameCell
//                cell.callbackText = { [weak self] text in
//                    self?.viewModel.userTask.taskName = text
//                }
//                return cell
//            case .createTaskCountingCell:
//            let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskCountingCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskCountingCell
//                cell.oneRepeatCallback = { [weak self] frequencyType in
//                    self?.viewModel.frequencyType = frequencyType
//                    self?.createTaskTableView.reloadData()
//                }
//                return cell
//            case .createTaskPeriodCaledarCell:
//                if  self.viewModel.frequencyType == .CERTAIN_DAYS {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYSelectWeekDaysCell.reuseIdentifier, for: indexPath) as! ATYSelectWeekDaysCell
////                    cell.callbackResult = { [weak self] resultString in
////                        print(resultString)
////                        self?.viewModel.daysCode = resultString
////                    }
//                    return cell
//                } else if  self.viewModel.frequencyType == .ONCE {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYOnceSelectDayCell.reuseIdentifier, for: indexPath) as! ATYOnceSelectDayCell
//                    return cell
//                } else {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskPeriodCalendarCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskPeriodCalendarCell
//                    cell.startCallback = { [weak self] startDateString in
//                        self?.viewModel.userTask.startDate = startDateString ?? ""
//                    }
//
//                    cell.endCallback = { [weak self] endDateString in
//                        self?.viewModel.userTask.taskCompleteTime = endDateString ?? ""
//                    }
//                        return cell
//                }
//            case .createNotificationAboutTaskCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateNotificationAboutTaskCell.reuseIdentifier, for: indexPath) as! ATYCreateNotificationAboutTaskCell
//                cell.setUp(notificationCount: countOfNotification)
//                cell.notificationsViews.first?.hourTextField.text = self.viewModel.hour == nil ? "" : self.viewModel.hour! + " " + R.string.localizable.hour()
//                cell.notificationsViews.first?.minTextField.text =  self.viewModel.minute == nil ? "" : self.viewModel.minute! + " " + R.string.localizable.min()
//
//                cell.callBack = { [weak self] in
//                    self?.openTimerViewController()
//                }
//
//                cell.plusCallBack = { [weak self] in
//                    self?.countOfNotification += 1
//                    self?.createTaskTableView.reloadData()
//                }
//                    return cell
//            case .createSanctionTaskCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateSanctionTaskCell.reuseIdentifier, for: indexPath) as! ATYCreateSanctionTaskCell
////                cell.callbackText = { [weak self] text in
////                    self?.viewModel.userTask.taskSanction = Int(text) ?? 0
////                }
//
////                cell.questionCallback = { [weak self] in
////                    self?.openPenaltyForFailureController()
////                }
//                    return cell
//            case .saveTaskCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYSaveTaskCell.reuseIdentifier, for: indexPath) as! ATYSaveTaskCell
//                cell.setUp(titleForButton: R.string.localizable.createTask())
////                cell.callback = { [weak self] in
//////                    self?.viewModel.createUserTask()
////                    self?.navigationController?.popViewController(animated: true)
////                }
//                    return cell
//            default: break
//            }
//
//        case .RITUAL:
//            self.viewModel.userTask.taskType = .RITUAL
//            switch ATYEnumWithReuseIdentifierCellCountRepeat(rawValue: indexPath.row){
//            case .createTaskNameCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskNameCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskNameCell
//                cell.callbackText = { [weak self] text in
//                    self?.viewModel.userTask.taskName = text
//                }
//                return cell
//            case .createTaskCountingCell:
//            let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskCountingCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskCountingCell
//                cell.oneRepeatCallback = { [weak self] frequencyType in
//                    self?.viewModel.frequencyType = frequencyType
//                    self?.createTaskTableView.reloadData()
//                }
//                return cell
//            case .createTaskPeriodCaledarCell:
//                if self.viewModel.frequencyType == .CERTAIN_DAYS {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYSelectWeekDaysCell.reuseIdentifier, for: indexPath) as! ATYSelectWeekDaysCell
////                    cell.callbackResult = { [weak self] resultString in
////                        self?.viewModel.userTask.daysCode = resultString
////                    }
//                        return cell
//                } else if  self.viewModel.frequencyType == .ONCE {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYOnceSelectDayCell.reuseIdentifier, for: indexPath) as! ATYOnceSelectDayCell
//                        return cell
//                } else {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskPeriodCalendarCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskPeriodCalendarCell
//                        return cell
//                }
//            case .createNotificationAboutTaskCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateNotificationAboutTaskCell.reuseIdentifier, for: indexPath) as! ATYCreateNotificationAboutTaskCell
//                cell.setUp(notificationCount: countOfNotification)
//                cell.notificationsViews.first?.hourTextField.text = self.viewModel.hour == nil ? "" : self.viewModel.hour! + " " + R.string.localizable.hour()
//                cell.notificationsViews.first?.minTextField.text =  self.viewModel.minute == nil ? "" : self.viewModel.minute! + " " + R.string.localizable.min()
//
//                cell.callBack = { [weak self] in
//                    self?.openTimerViewController()
//                }
//
//                cell.plusCallBack = { [weak self] in
//                    self?.countOfNotification += 1
//                    self?.createTaskTableView.reloadData()
//                }
//                    return cell
//            case .createSanctionTaskCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateSanctionTaskCell.reuseIdentifier, for: indexPath) as! ATYCreateSanctionTaskCell
////                cell.questionCallback = { [weak self] in
////                    self?.openPenaltyForFailureController()
////                }
//                    return cell
//            case .saveTaskCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYSaveTaskCell.reuseIdentifier, for: indexPath) as! ATYSaveTaskCell
//                cell.setUp(titleForButton: R.string.localizable.createTask())
////                cell.callback = { [weak self] in
//////                    self?.viewModel.createUserTask()
////                    self?.navigationController?.popViewController(animated: true)
////                }
//                    return cell
//            case .createCountRepeatTaskCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateCountRepeatTaskCell.reuseIdentifier, for: indexPath) as! ATYCreateCountRepeatTaskCell
//                    return cell
//            default: break
//            }
//
//        case .TIMER:
//            self.viewModel.userTask.taskType = .TIMER
//            switch ATYEnumWithReuseIdentifierCellTimer(rawValue: indexPath.row){
//            case .createTaskNameCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskNameCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskNameCell
//                cell.callbackText = { [weak self] text in
//                    self?.viewModel.userTask.taskName = text
//                }
//                return cell
//            case .createTaskCountingCell:
//            let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskCountingCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskCountingCell
//                cell.oneRepeatCallback = { [weak self] frequencyType in
//                    self?.viewModel.frequencyType = frequencyType
//                    self?.createTaskTableView.reloadData()
//                }
//                return cell
//            case .createTaskPeriodCaledarCell:
//                if self.viewModel.frequencyType == .CERTAIN_DAYS {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYSelectWeekDaysCell.reuseIdentifier, for: indexPath) as! ATYSelectWeekDaysCell
//                        return cell
//                } else if self.viewModel.frequencyType == .ONCE {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYOnceSelectDayCell.reuseIdentifier, for: indexPath) as! ATYOnceSelectDayCell
//                        return cell
//                } else {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskPeriodCalendarCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskPeriodCalendarCell
//                        return cell
//                }
//            case .createNotificationAboutTaskCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateNotificationAboutTaskCell.reuseIdentifier, for: indexPath) as! ATYCreateNotificationAboutTaskCell
//                cell.setUp(notificationCount: countOfNotification)
//                cell.notificationsViews.first?.hourTextField.text = self.viewModel.hour == nil ? "" : self.viewModel.hour! + " " + R.string.localizable.hour()
//                cell.notificationsViews.first?.minTextField.text =  self.viewModel.minute == nil ? "" : self.viewModel.minute! + " " + R.string.localizable.min()
//
//                cell.callBack = { [weak self] in
//                    self?.openTimerViewController()
//                }
//
//                cell.plusCallBack = { [weak self] in
//                    self?.countOfNotification += 1
//                    self?.createTaskTableView.reloadData()
//                }
//                    return cell
//            case .createSanctionTaskCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateSanctionTaskCell.reuseIdentifier, for: indexPath) as! ATYCreateSanctionTaskCell
////                cell.questionCallback = { [weak self] in
////                    self?.openPenaltyForFailureController()
////                }
//                    return cell
//            case .saveTaskCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYSaveTaskCell.reuseIdentifier, for: indexPath) as! ATYSaveTaskCell
//                cell.setUp(titleForButton: R.string.localizable.createTask())
////                cell.callback = { [weak self] in
//////                    self?.viewModel.createUserTask()
////                    self?.navigationController?.popViewController(animated: true)
////                }
//                    return cell
//            case .createDurationTaskCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateDurationTaskCell.reuseIdentifier, for: indexPath) as! ATYCreateDurationTaskCell
//                    return cell
//            default: break
//            }
//
//        case .TEXT:
//            self.viewModel.userTask.taskType = .TEXT
//            switch ATYEnumWithReuseIdentifierCellText(rawValue: indexPath.row){
//            case .createTaskNameCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskNameCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskNameCell
//                cell.callbackText = { [weak self] text in
//                    self?.viewModel.userTask.taskName = text
//                }
//                return cell
//            case .createDescriptionTaskCell:
//            let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateDescriptionTaskCell.reuseIdentifier, for: indexPath) as! ATYCreateDescriptionTaskCell
//                return cell
//            case .createMaxSymbolsCountCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateMaxCountSymbolsCell.reuseIdentifier, for: indexPath) as! ATYCreateMaxCountSymbolsCell
//                    return cell
//            case .createNotificationAboutTaskCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateNotificationAboutTaskCell.reuseIdentifier, for: indexPath) as! ATYCreateNotificationAboutTaskCell
//                cell.setUp(notificationCount: countOfNotification)
//                cell.notificationsViews.first?.hourTextField.text = self.viewModel.hour == nil ? "" : self.viewModel.hour! + " " + R.string.localizable.hour()
//                cell.notificationsViews.first?.minTextField.text =  self.viewModel.minute == nil ? "" : self.viewModel.minute! + " " + R.string.localizable.min()
//
//                cell.callBack = { [weak self] in
//                    self?.openTimerViewController()
//                }
//
//                cell.plusCallBack = { [weak self] in
//                    self?.countOfNotification += 1
//                    self?.createTaskTableView.reloadData()
//                }
//                    return cell
//            case .createSanctionTaskCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateSanctionTaskCell.reuseIdentifier, for: indexPath) as! ATYCreateSanctionTaskCell
////                cell.questionCallback = { [weak self] in
////                    self?.openPenaltyForFailureController()
////                }
//                    return cell
//            case .saveTaskCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYSaveTaskCell.reuseIdentifier, for: indexPath) as! ATYSaveTaskCell
//                cell.setUp(titleForButton: R.string.localizable.createTask())
////                cell.callback = { [weak self] in
//////                    self?.viewModel.createUserTask()
////                    self?.navigationController?.popViewController(animated: true)
////                }
//                    return cell
//            case .createTaskPeriodCaledarCell:
//                if  self.viewModel.frequencyType == .CERTAIN_DAYS {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYSelectWeekDaysCell.reuseIdentifier, for: indexPath) as! ATYSelectWeekDaysCell
//                        return cell
//                } else if self.viewModel.frequencyType == .ONCE {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYOnceSelectDayCell.reuseIdentifier, for: indexPath) as! ATYOnceSelectDayCell
//                        return cell
//                } else {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskPeriodCalendarCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskPeriodCalendarCell
//                        return cell
//                }
//            case .createTaskCountingCell:
//            let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskCountingCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskCountingCell
//                cell.oneRepeatCallback = { [weak self] frequencyType in
//                    self?.viewModel.frequencyType = frequencyType
//                    self?.createTaskTableView.reloadData()
//                }
//                return cell
//            default: break
//            }
//
//        default: break
//        }
//
//        return UITableViewCell()
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//}
