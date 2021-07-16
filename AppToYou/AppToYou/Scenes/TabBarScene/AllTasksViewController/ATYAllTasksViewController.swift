//
//  ATYAllTasksViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 25.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import Foundation
import UIKit

final class ATYAllTasksViewController: UIViewController {

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
                                        secondSubtitleLabel: "60 мин",
                                        state: .didNotStart),
                          TemporaryData(typeTask: .CHECKBOX,
                                        courseName: "Кулинария",
                                        hasSanction: true,
                                        titleLabel: "Сходить на площадку",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "60 мин",
                                        state: .didNotStart),
                          TemporaryData(typeTask: .CHECKBOX,
                                        courseName: "Спорт",
                                        hasSanction: true,
                                        titleLabel: "Отжимания",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "60 мин",
                                        state: .didNotStart),
                          TemporaryData(typeTask: .CHECKBOX,
                                        courseName: "Энергетика",
                                        hasSanction: true,
                                        titleLabel: "Прочитать книгу",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "60 мин",
                                        state: .didNotStart),
                          TemporaryData(typeTask: .CHECKBOX,
                                        courseName: "Здоровье",
                                        hasSanction: false,
                                        titleLabel: "Отжимания",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "20 раз",
                                        state: .didNotStart),
                          TemporaryData(typeTask: .CHECKBOX,
                                        courseName: "Шитье",
                                        hasSanction: false,
                                        titleLabel: "Большой текст тест текст на длину длинный текст",
                                        firstSubtitleLabel: "Каждый деньфывфывфывфывфы",
                                        secondSubtitleLabel: "60 минпывафывпвыпваыпфывпфывпыфва",
                                        state: .didNotStart)]

    convenience init(name: String) {
        self.init(title: name)
    }

    convenience init(title: String) {
        self.init(title: title, content: title)
    }

    init(title: String, content: String) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabelAndSwitch()
        configureTableView()
    }

    private func configureLabelAndSwitch() {
        view.addSubview(label)
        view.addSubview(switchButton)

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
}

extension ATYAllTasksViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.temporaryArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ATYTaskTableViewCell.reuseIdentifier, for: indexPath) as! ATYTaskTableViewCell
        let temporary = self.temporaryArray[indexPath.row]
        cell.setUp(typeTask: .CHECKBOX,
                   courseName: "temporary.courseName",
                   hasSanction: temporary.hasSanction,
                   titleLabel: temporary.titleLabel,
                   firstSubtitleLabel: temporary.firstSubtitleLabel,
                   secondSubtitleLabel: temporary.secondSubtitleLabel,
                   state: temporary.state, userOrCourseTask: .user)
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

            self.temporaryArray.remove(at: indexPath.row)

            self.futureTasksTableView.deleteRows(at: [indexPath], with: .fade)
        }

        let edit = UIContextualAction(style: .destructive, title: "") { (action, view, boolValue) in
            boolValue(true)
            self.temporaryArray.remove(at: indexPath.row)
            self.futureTasksTableView.deleteRows(at: [indexPath], with: .fade)
        }


        delete.image = R.image.deleteImage()
        edit.image = R.image.editImage()
        let config = UISwipeActionsConfiguration(actions: [edit, delete])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
}
