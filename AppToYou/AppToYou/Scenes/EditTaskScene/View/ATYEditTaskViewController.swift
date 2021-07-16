//
//  ATYEditTaskViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 02.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYEditTaskViewController: UIViewController {

    var createTaskTableView = UITableView()
    var needShowCalendar = true
    var needShowWeekDays = false
    var countOfNotification = 1

    private var transition: PanelTransition!
    private var datePicker = UIDatePicker()

    var types : TypeOfTask!

    var hour : String?
    var minute : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = R.string.localizable.editingTask()
        view.addSubview(createTaskTableView)
        view.backgroundColor = R.color.backgroundAppColor()
        configureNavBar()
        configureCreateTaskTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    //MARK:- Configure UI

    private func configureNavBar() {
        let backButton = UIBarButtonItem.init(image: R.image.backButton(), style: .plain, target: self, action: #selector(tappedBackButton))
        backButton.title = ""
        backButton.tintColor = R.color.lineViewBackgroundColor()
        self.navigationItem.setLeftBarButton(backButton, animated: true)
    }

    @objc func tappedBackButton() {
        showAlert()
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

        child.transitioningDelegate = transition   // 2
        child.modalPresentationStyle = .custom  // 3

        present(child, animated: true)
    }
}

extension ATYEditTaskViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch types {
        case .checkBox:
            return needShowCalendar ? ATYEnumWithReuseIdentifierCellCheckBox.allCases.count : ATYEnumWithReuseIdentifierCellCheckBox.allCases.count
        case .countRepeat:
            return needShowCalendar ? ATYEnumWithReuseIdentifierCellCountRepeat.allCases.count : ATYEnumWithReuseIdentifierCellCountRepeat.allCases.count
        case .timerTask:
            return needShowCalendar ? ATYEnumWithReuseIdentifierCellTimer.allCases.count : ATYEnumWithReuseIdentifierCellTimer.allCases.count
        case .textTask:
            return needShowCalendar ? ATYEnumWithReuseIdentifierCellText.allCases.count : ATYEnumWithReuseIdentifierCellText.allCases.count
        default: return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch types {
//        case .checkBox:
//            switch ATYEnumWithReuseIdentifierCellCheckBox(rawValue: indexPath.row){
//            case .createTaskNameCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskNameCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskNameCell
//                return cell
//            case .createTaskCountingCell:
//            let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskCountingCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskCountingCell
//                cell.oneRepeatCallback = { [weak self] isNeedOneDay, isNeedWeekDays in
//                    self?.needShowCalendar = isNeedOneDay
//                    self?.needShowWeekDays = isNeedWeekDays
//                    self?.createTaskTableView.reloadData()
//                }
//                return cell
//            case .createTaskPeriodCaledarCell:
//                if needShowCalendar {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskPeriodCalendarCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskPeriodCalendarCell
//                    return cell
//                } else if !needShowWeekDays {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYOnceSelectDayCell.reuseIdentifier, for: indexPath) as! ATYOnceSelectDayCell
//                    return cell
//                } else {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYSelectWeekDaysCell.reuseIdentifier, for: indexPath) as! ATYSelectWeekDaysCell
//                        return cell
//                }
//
//            case .createNotificationAboutTaskCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateNotificationAboutTaskCell.reuseIdentifier, for: indexPath) as! ATYCreateNotificationAboutTaskCell
//                cell.setUp(notificationCount: countOfNotification)
//                cell.notificationsViews.first?.hourTextField.text = self.hour == nil ? "" : self.hour! + " " + R.string.localizable.hour()
//                cell.notificationsViews.first?.minTextField.text =  self.minute == nil ? "" : self.minute! + " " + R.string.localizable.min()
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
//                    return cell
//            case .saveTaskCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYSaveTaskCell.reuseIdentifier, for: indexPath) as! ATYSaveTaskCell
//                cell.setUp(titleForButton: R.string.localizable.save())
//                cell.callback = { [weak self] in
//                    self?.navigationController?.popViewController(animated: true)
//                }
//                    return cell
//            default: break
//            }
//        case .countRepeat:
//            switch ATYEnumWithReuseIdentifierCellCountRepeat(rawValue: indexPath.row){
//            case .createTaskNameCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskNameCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskNameCell
//                return cell
//            case .createTaskCountingCell:
//            let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskCountingCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskCountingCell
//                cell.oneRepeatCallback = { [weak self] isNeedOneDay, isNeedWeekDays in
//                    self?.needShowCalendar = isNeedOneDay
//                    self?.needShowWeekDays = isNeedWeekDays
//                    self?.createTaskTableView.reloadData()
//                }
//                return cell
//            case .createTaskPeriodCaledarCell:
//                if needShowCalendar {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskPeriodCalendarCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskPeriodCalendarCell
//                        return cell
//                } else if !needShowWeekDays {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYOnceSelectDayCell.reuseIdentifier, for: indexPath) as! ATYOnceSelectDayCell
//                        return cell
//                } else {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYSelectWeekDaysCell.reuseIdentifier, for: indexPath) as! ATYSelectWeekDaysCell
//                        return cell
//                }
//            case .createNotificationAboutTaskCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateNotificationAboutTaskCell.reuseIdentifier, for: indexPath) as! ATYCreateNotificationAboutTaskCell
//                cell.setUp(notificationCount: countOfNotification)
//                cell.notificationsViews.first?.hourTextField.text = self.hour == nil ? "" : self.hour! + " " + R.string.localizable.hour()
//                cell.notificationsViews.first?.minTextField.text =  self.minute == nil ? "" : self.minute! + " " + R.string.localizable.min()
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
//                    return cell
//            case .saveTaskCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYSaveTaskCell.reuseIdentifier, for: indexPath) as! ATYSaveTaskCell
//                cell.setUp(titleForButton: R.string.localizable.save())
//                cell.callback = { [weak self] in
//                    self?.navigationController?.popViewController(animated: true)
//                }
//                    return cell
//            case .createCountRepeatTaskCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateCountRepeatTaskCell.reuseIdentifier, for: indexPath) as! ATYCreateCountRepeatTaskCell
//                    return cell
//            default: break
//            }
//        case .timerTask:
//            switch ATYEnumWithReuseIdentifierCellTimer(rawValue: indexPath.row){
//            case .createTaskNameCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskNameCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskNameCell
//                return cell
//            case .createTaskCountingCell:
//            let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskCountingCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskCountingCell
//                cell.oneRepeatCallback = { [weak self] isNeedOneDay, isNeedWeekDays in
//                    self?.needShowCalendar = isNeedOneDay
//                    self?.needShowWeekDays = isNeedWeekDays
//                    self?.createTaskTableView.reloadData()
//                }
//                return cell
//            case .createTaskPeriodCaledarCell:
//                if needShowCalendar {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskPeriodCalendarCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskPeriodCalendarCell
//                        return cell
//                } else if !needShowWeekDays {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYOnceSelectDayCell.reuseIdentifier, for: indexPath) as! ATYOnceSelectDayCell
//                        return cell
//                } else {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYSelectWeekDaysCell.reuseIdentifier, for: indexPath) as! ATYSelectWeekDaysCell
//                        return cell
//                }
//            case .createNotificationAboutTaskCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateNotificationAboutTaskCell.reuseIdentifier, for: indexPath) as! ATYCreateNotificationAboutTaskCell
//                cell.setUp(notificationCount: countOfNotification)
//                cell.notificationsViews.first?.hourTextField.text = self.hour == nil ? "" : self.hour! + " " + R.string.localizable.hour()
//                cell.notificationsViews.first?.minTextField.text =  self.minute == nil ? "" : self.minute! + " " + R.string.localizable.min()
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
//                    return cell
//            case .saveTaskCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYSaveTaskCell.reuseIdentifier, for: indexPath) as! ATYSaveTaskCell
//                cell.setUp(titleForButton: R.string.localizable.save())
//                cell.callback = { [weak self] in
//                    self?.navigationController?.popViewController(animated: true)
//                }
//                    return cell
//            case .createDurationTaskCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateDurationTaskCell.reuseIdentifier, for: indexPath) as! ATYCreateDurationTaskCell
//                    return cell
//            default: break
//            }
//        case .textTask:
//            switch ATYEnumWithReuseIdentifierCellText(rawValue: indexPath.row){
//            case .createTaskNameCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskNameCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskNameCell
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
//                cell.notificationsViews.first?.hourTextField.text = self.hour == nil ? "" : self.hour! + " " + R.string.localizable.hour()
//                cell.notificationsViews.first?.minTextField.text =  self.minute == nil ? "" : self.minute! + " " + R.string.localizable.min()
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
//                    return cell
//            case .saveTaskCell:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ATYSaveTaskCell.reuseIdentifier, for: indexPath) as! ATYSaveTaskCell
//                cell.setUp(titleForButton: R.string.localizable.save())
//                cell.callback = { [weak self] in
//                    self?.navigationController?.popViewController(animated: true)
//                }
//                    return cell
//            case .createTaskPeriodCaledarCell:
//                if needShowCalendar {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskPeriodCalendarCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskPeriodCalendarCell
//                        return cell
//                } else if !needShowWeekDays {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYOnceSelectDayCell.reuseIdentifier, for: indexPath) as! ATYOnceSelectDayCell
//                        return cell
//                } else {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: ATYSelectWeekDaysCell.reuseIdentifier, for: indexPath) as! ATYSelectWeekDaysCell
//                        return cell
//                }
//            case .createTaskCountingCell:
//            let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskCountingCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskCountingCell
//                cell.oneRepeatCallback = { [weak self] isNeedOneDay, isNeedWeekDays in
//                    self?.needShowCalendar = isNeedOneDay
//                    self?.needShowWeekDays = isNeedWeekDays
//                    self?.createTaskTableView.reloadData()
//                }
//                return cell
//            default: break
//            }
//        default: break
//        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

