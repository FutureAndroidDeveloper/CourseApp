//
//  ATYTaskAddedViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 20.07.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class ATYTaskAddedViewController: UIViewController {

    private enum ATYTaskAddedEnum: Int, CaseIterable {
        case text
        case description
    }

    enum ATYChooseTaskEnum {
        case oneTask
        case allTasks
    }

    var type : ATYChooseTaskEnum!

    private let createTaskButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.buttonColor()
        return button
    }()

    let tableView = UITableView()
    let lineView = UIView()
    let selectedView = UIView()

    var pushVcCallback : (() -> Void)?

    init(type: ATYChooseTaskEnum) {
        super.init(nibName: nil , bundle: nil)
        self.type = type
        switch self.type {
        case .oneTask:
            createTaskButton.setTitle("Хорошо!", for: .normal)
        case .allTasks:
            createTaskButton.setTitle("Понятно!", for: .normal)
        default : break
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLineView()
        configureTableView()
        view.backgroundColor = R.color.backgroundTextFieldsColor()
        view.layer.cornerRadius = 24
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    private func configureLineView() {
        view.addSubview(lineView)
        lineView.backgroundColor = R.color.lightGrayColor()
        lineView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.height.equalTo(5)
            make.width.equalTo(40)
        }
    }

    private func configureTableView() {
        view.addSubview(tableView)
        view.addSubview(createTaskButton)

        createTaskButton.addTarget(self, action: #selector(createTaskButtonAction), for: .touchUpInside)
        createTaskButton.layer.cornerRadius = 25
        createTaskButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

        tableView.separatorStyle = .none
        tableView.backgroundColor = R.color.backgroundTextFieldsColor()
        tableView.register(ATYTaskAddedTitleTextCell.self, forCellReuseIdentifier: ATYTaskAddedTitleTextCell.reuseIdentifier)
        tableView.register(ATYTaskAddedDescriptionsCell.self, forCellReuseIdentifier: ATYTaskAddedDescriptionsCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    @objc func createTaskButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
}


extension ATYTaskAddedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ATYTaskAddedEnum.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch ATYTaskAddedEnum.init(rawValue: indexPath.row) {
        case .text:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYTaskAddedTitleTextCell.reuseIdentifier, for: indexPath) as! ATYTaskAddedTitleTextCell
            switch self.type {
            case .oneTask:
                cell.nameTaskLabel.text = "Задача добавлена!"
                cell.textImageView.isHidden = true
            case .allTasks:
                cell.nameTaskLabel.text = "Все задачи добавлены!"
                cell.textImageView.isHidden = false
            default : break
            }
            return cell
        case .description:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYTaskAddedDescriptionsCell.reuseIdentifier, for: indexPath) as! ATYTaskAddedDescriptionsCell
            switch self.type {
            case .oneTask:
                cell.firstLabel.text = "Мы учли ваши корректировки и продублировали задачу в ваших личных задачах с пометкой «курс»."
                cell.secondLabel.text = "Ваш прогресс по задачам курса доступен участникам курса."
            case .allTasks:
                cell.firstLabel.text = "Все задачи будут добавлены с исходными параметрами."
                cell.secondLabel.text = "Вы сможете отредактировать задачи после добавления, если редактирование этой задачи предусмотрено автором курса."
            default : break
            }
            return cell
        default : return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

//        self.dismiss(animated: true) { [weak self] in
//            self?.pushVcCallback?((self?.typeTask[indexPath.row])!)
//        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
