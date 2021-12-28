//
//  ATYTasksForAboutCourseCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 18.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYTasksForAboutCourseCell : UITableViewCell {

    var topConstraintTableView = NSLayoutConstraint()

    let tasksCourseLabel : UILabel = {
        let label = UILabel()
        label.text = "Задания курса"
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    let addTasksLabel : UILabel = {
        let label = UILabel()
        label.text = "Добавить все задачи"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    let addTaskButton : UIButton = {
        let button = UIButton()
        button.setImage(R.image.plusButtonImage(), for: .normal)
        return button
    }()

    let chooseTasksLabel : UILabel = {
        let label = UILabel()
        label.text = "выбрано 0 / 0"
        label.textAlignment = .right
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = R.color.textSecondaryColor()
        return label
    }()

    private let createTaskButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.buttonColor()
        button.setTitle("Создать задачу курса", for: .normal)
        return button
    }()

    var tasksTableView = UITableView()

    var applianceTableViewHeightConstraint: NSLayoutConstraint!

    var createTaskCallback : (() -> (Void))?
    var selectSwitchButtonCallback : ((ATYTaskType?) -> ())?
    var addAllTasksCallback: (() -> ())?

    var completedTask = [TemporaryData(typeTask: .CHECKBOX,
                                       courseName: "Электрика",
                                       hasSanction: true,
                                       titleLabel: "Test text",
                                       firstSubtitleLabel: "пт, cуб",
                                       secondSubtitleLabel: "60 мин",
                                       state: .didNotStart, date: Date.dateFormatter.date(from: "2021/08/12 22:31")),
                         TemporaryData(typeTask: .RITUAL,
                                       courseName: "Машиностроение",
                                       hasSanction: false,
                                       titleLabel: "Test text",
                                       firstSubtitleLabel: "пт, cуб, вскр, ср",
                                       secondSubtitleLabel: "60 мин",
                                       state: .didNotStart, date: Date.dateFormatter.date(from: "2021/08/12 22:31")),
                         TemporaryData(typeTask: .TEXT,
                                       courseName: "Медитация",
                                       hasSanction: true,
                                       titleLabel: "Test text",
                                       firstSubtitleLabel: "ежедневно",
                                       secondSubtitleLabel: "60 мин",
                                       state: .didNotStart, date: Date.dateFormatter.date(from: "2021/08/12 22:31")),
                         TemporaryData(typeTask: .TIMER,
                                       courseName: "Английский",
                                       hasSanction: false,
                                       titleLabel: "Test text",
                                       firstSubtitleLabel: "пт, cуб, вскр",
                                       secondSubtitleLabel: "60 мин",
                                       state: .didNotStart, date: Date.dateFormatter.date(from: "2021/08/12 22:31")),
                         TemporaryData(typeTask: .TIMER,
                                       courseName: "Английский",
                                       hasSanction: false,
                                       titleLabel: "Test text",
                                       firstSubtitleLabel: "пт, cуб, вскр",
                                       secondSubtitleLabel: "60 мин",
                                       state: .didNotStart, date: Date.dateFormatter.date(from: "2021/08/12 22:31")),
                         TemporaryData(typeTask: .TIMER,
                                       courseName: "Английский",
                                       hasSanction: false,
                                       titleLabel: "Test text",
                                       firstSubtitleLabel: "пт, cуб, вскр",
                                       secondSubtitleLabel: "60 мин",
                                       state: .didNotStart, date: Date.dateFormatter.date(from: "2021/08/12 22:31")),
                         TemporaryData(typeTask: .TIMER,
                                       courseName: "Английский",
                                       hasSanction: false,
                                       titleLabel: "Test text",
                                       firstSubtitleLabel: "пт, cуб, вскр",
                                       secondSubtitleLabel: "60 мин",
                                       state: .didNotStart, date: Date.dateFormatter.date(from: "2021/08/12 22:31"))]

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = R.color.backgroundAppColor()
        selectionStyle = .none
        configure()
        tasksTableView.delegate = self
        tasksTableView.isScrollEnabled = false
        tasksTableView.dataSource = self
        tasksTableView.separatorStyle = .none
        tasksTableView.register(ATYTaskTableViewCell.self, forCellReuseIdentifier: ATYTaskTableViewCell.reuseIdentifier)
        tasksTableView.estimatedRowHeight = 90
        addObserver()
    }

    func setUp(isMyCourse: Bool) {
        if !isMyCourse {
            self.createTaskButton.isHidden = true
            self.topConstraintTableView.isActive = false
            self.topConstraintTableView = tasksTableView.topAnchor.constraint(equalTo: chooseTasksLabel.bottomAnchor, constant: 26)
            self.topConstraintTableView.isActive = true
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func createTaskButtonAction() {
        createTaskCallback?()
    }

    var tableViewObserver: NSKeyValueObservation?

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
    }

    func addObserver() {
        tableViewObserver = tasksTableView.observe(\.contentSize, changeHandler: { [weak self] (tableView, change) in
            self?.tasksTableView.invalidateIntrinsicContentSize()
            self?.applianceTableViewHeightConstraint.isActive = false
            self?.applianceTableViewHeightConstraint.constant = self?.tasksTableView.contentSize.height ?? 0
            self?.applianceTableViewHeightConstraint.isActive = true
        })
    }

    deinit {
        tableViewObserver = nil
    }

    @objc func addTaskButtonAction() {
        addAllTasksCallback?()
    }

    private func configure() {
        contentView.addSubview(tasksCourseLabel)
        contentView.addSubview(addTasksLabel)
        contentView.addSubview(addTaskButton)
        contentView.addSubview(chooseTasksLabel)
        contentView.addSubview(createTaskButton)
        contentView.addSubview(tasksTableView)

        tasksCourseLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(20)
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview()
        }

        addTasksLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(tasksCourseLabel)
            make.height.equalTo(20)
            make.top.equalTo(tasksCourseLabel.snp.bottom).offset(8)
            make.width.equalTo(addTasksLabel.intrinsicContentSize.width)
        }

        addTaskButton.addTarget(self, action: #selector(addTaskButtonAction), for: .touchUpInside)
        addTaskButton.snp.makeConstraints { (make) in
            make.leading.equalTo(addTasksLabel.snp.trailing).offset(6)
            make.width.height.equalTo(15)
            make.centerY.equalTo(addTasksLabel)
        }

        chooseTasksLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalTo(addTaskButton)
            make.height.equalTo(20)
            make.width.equalTo(chooseTasksLabel.intrinsicContentSize.width)
        }

        createTaskButton.addTarget(self, action: #selector(createTaskButtonAction), for: .touchUpInside)
        createTaskButton.layer.cornerRadius = 25
        createTaskButton.snp.makeConstraints { (make) in
            make.top.equalTo(addTasksLabel.snp.bottom).offset(26)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

        self.topConstraintTableView = tasksTableView.topAnchor.constraint(equalTo: createTaskButton.bottomAnchor, constant: 20)
        self.topConstraintTableView.isActive = true

        self.applianceTableViewHeightConstraint = self.tasksTableView.heightAnchor.constraint(equalToConstant: 90)
        self.applianceTableViewHeightConstraint.isActive = true

        tasksTableView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
//            make.height.equalTo(300)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}

extension ATYTasksForAboutCourseCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completedTask.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ATYTaskTableViewCell.reuseIdentifier, for: indexPath) as! ATYTaskTableViewCell
        cell.callBackSwitch = { [weak self] typeTask in
            self?.selectSwitchButtonCallback?(typeTask)
        }
        let item = completedTask[indexPath.row]
        cell.setUp(typeTask: item.typeTask,
                   courseName: nil,
                   hasSanction: item.hasSanction,
                   titleLabel: item.titleLabel,
                   firstSubtitleLabel: item.firstSubtitleLabel,
                   secondSubtitleLabel: item.secondSubtitleLabel,
                   state: .didNotStart,
                   userOrCourseTask: .course)
        cell.callback = {
            print("callback")
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("!@#")
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
