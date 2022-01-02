//
//  ATYAllTasksViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 25.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import Foundation
import UIKit
import XCoordinator


final class ATYAllTasksViewController: UIViewController, BindableType {
    
    func bindViewModel() {
        viewModel.output.tasks.bind { [weak self] tasks in
            self?.tasks = tasks
            self?.futureTasksTableView.reloadData()
        }
        
        viewModel.input.refresh()
    }
    
    var viewModel: AllTasksViewModel!

    var futureTasksTableView = UITableView()

    var label : UILabel = {
        let label = UILabel()
        label.text = "Отображать только мои задачи"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    var switchButton : UISwitch = {
        let switchButton = UISwitch()
        switchButton.onTintColor = R.color.textColorSecondary()
        return switchButton
    }()

    var temporaryArray = [TemporaryData(typeTask: .CHECKBOX,
                                        courseName: "Бокс",
                                        hasSanction: true,
                                        titleLabel: "Медитация",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "40 мин",
                                        state: .didNotStart, date: Date.dateFormatter.date(from: "2021/08/12 22:31")),
                          TemporaryData(typeTask: .RITUAL,
                                        courseName: nil,
                                        hasSanction: true,
                                        titleLabel: "Сходить на площадку",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "20 мин",
                                        state: .didNotStart, date: Date.dateFormatter.date(from: "2021/08/12 22:31")),
                          TemporaryData(typeTask: .TEXT,
                                        courseName: "Спорт",
                                        hasSanction: true,
                                        titleLabel: "Отжимания",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "10 мин",
                                        state: .didNotStart, date: Date.dateFormatter.date(from: "2021/08/12 22:31")),
                          TemporaryData(typeTask: .TIMER,
                                        courseName: "Энергетика",
                                        hasSanction: true,
                                        titleLabel: "Прочитать книгу",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "30 мин",
                                        state: .didNotStart, date: Date.dateFormatter.date(from: "2021/08/12 22:31")),
                          TemporaryData(typeTask: .CHECKBOX,
                                        courseName: nil,
                                        hasSanction: false,
                                        titleLabel: "Отжимания",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "20 раз",
                                        state: .didNotStart, date: Date.dateFormatter.date(from: "2021/08/12 22:31")),
                          TemporaryData(typeTask: .CHECKBOX,
                                        courseName: nil,
                                        hasSanction: true,
                                        titleLabel: "Большой текст тест текст на длину длинный текст",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "60 мин",
                                        state: .didNotStart, date: Date.dateFormatter.date(from: "2021/08/12 22:31")),
                          TemporaryData(typeTask: .RITUAL,
                                        courseName: nil,
                                        hasSanction: false,
                                        titleLabel: "Прыжки",
                                        firstSubtitleLabel: "Каждый месяц",
                                        secondSubtitleLabel: "60 мин",
                                        state: .didNotStart, date: Date.dateFormatter.date(from: "2021/08/12 22:31")),
                          TemporaryData(typeTask: .TIMER,
                                        courseName: "Автоспорт",
                                        hasSanction: true,
                                        titleLabel: "Дрифт",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "40 мин",
                                        state: .didNotStart, date: Date.dateFormatter.date(from: "2021/08/12 22:31")),
                          TemporaryData(typeTask: .RITUAL,
                                        courseName: nil,
                                        hasSanction: false,
                                        titleLabel: "Отжимания и длиный текст для проверки состояния названия",
                                        firstSubtitleLabel: "пн, вт, ср, чт, пт, cб,  вс",
                                        secondSubtitleLabel: "2022 раз",
                                        state: .didNotStart, date: Date.dateFormatter.date(from: "2021/08/12 22:31"))]

    var resultArray = [TemporaryData]()

    private var tasks = [UserTaskResponse]()
    
    init(title: String) {
//        inflater = UITableViewIflater(tasksTableView)
        
        super.init(nibName: nil, bundle: nil)
        self.title = title
        view.backgroundColor = R.color.backgroundAppColor()
        
//        self.viewModel = AllTasksViewModelImpl(taskRouter: taskRouter)
//        self.viewModel.delegate = self
        
//        switchButtonAction()
    }
    

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        resultArray = temporaryArray
        configureLabelAndSwitch()
        configureTableView()
    }

    private func configureLabelAndSwitch() {
        view.addSubview(label)
        view.addSubview(switchButton)

        switchButton.addTarget(self, action: #selector(switchButtonAction), for: .valueChanged)
        switchButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        switchButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(20)
        }

        label.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(switchButton.snp.leading).offset(-10)
            make.centerY.equalTo(switchButton)
        }

    }

    private func configureTableView() {
        view.addSubview(futureTasksTableView)
        futureTasksTableView.backgroundColor = R.color.backgroundAppColor()
        futureTasksTableView.showsVerticalScrollIndicator = false
        futureTasksTableView.separatorStyle = .none
        futureTasksTableView.delegate = self
        futureTasksTableView.dataSource = self
        futureTasksTableView.register(ATYTaskTableViewCell.self, forCellReuseIdentifier: ATYTaskTableViewCell.reuseIdentifier)
        futureTasksTableView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(label.snp.bottom).offset(25)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
        }
    }
    
    @objc
    private func switchButtonAction() {
        viewModel.input.showMyTasks(switchButton.isOn)
    }
}

extension ATYAllTasksViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        self.resultArray.count
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ATYTaskTableViewCell.reuseIdentifier, for: indexPath) as! ATYTaskTableViewCell
//        let temporary = self.resultArray[indexPath.row]
        let task = self.tasks[indexPath.row]
        
//        task.taskSanction
        
        cell.setUp(
            typeTask: task.taskType, courseName: task.courseName, hasSanction: task.taskSanction > .zero,
            titleLabel: task.taskName, firstSubtitleLabel: "Subtitle", secondSubtitleLabel: "Duration",
            state: .didNotStart, userOrCourseTask: .user)
        
//        cell.setUp(typeTask: temporary.typeTask,
//                   courseName: temporary.courseName,
//                   hasSanction: temporary.hasSanction,
//                   titleLabel: temporary.titleLabel,
//                   firstSubtitleLabel: temporary.firstSubtitleLabel,
//                   secondSubtitleLabel: temporary.secondSubtitleLabel,
//                   state: temporary.state, userOrCourseTask: .user)
        cell.callback = {
            print("callback")
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = R.color.backgroundAppColor()
        label.text = "Выполненные задачи"
        label.textColor = R.color.textSecondaryColor()
        label.font = UIFont.systemFont(ofSize: 15)

        let view = UIView()
        view.frame = CGRect(origin: .zero, size: .zero)
        return section == 1 ? label : view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 40 : 0
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let delete = UIContextualAction(style: .destructive, title: "") { (action, view, boolValue) in
            boolValue(true)

            self.resultArray.remove(at: indexPath.row)

            self.futureTasksTableView.deleteRows(at: [indexPath], with: .fade)
        }

        let edit = UIContextualAction(style: .destructive, title: "") { (action, view, boolValue) in
            boolValue(true)
            self.resultArray.remove(at: indexPath.row)
            self.futureTasksTableView.deleteRows(at: [indexPath], with: .fade)
        }


        delete.image = R.image.deleteImage()
        edit.image = R.image.editImage()
        let config = UISwipeActionsConfiguration(actions: [edit, delete])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
}
