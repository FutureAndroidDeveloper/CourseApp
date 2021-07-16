//
//  ATYEditCourseCountRepeatTaskViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 16.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYEditCourseCountRepeatTaskViewController: UIViewController {

    private enum ATYCountRepeatEnum: Int, CaseIterable {
        case exercise
        case countRepeat
    }

    private let createTaskButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.buttonColor()
        button.setTitle("Добавить задачу", for: .normal)
        return button
    }()

    let tableView = UITableView()
    let lineView = UIView()
    let selectedView = UIView()

    var pushVcCallback : (() -> Void)?

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
        tableView.register(ATYEditCountCourseTaskTimeCell.self, forCellReuseIdentifier: ATYEditCountCourseTaskTimeCell.reuseIdentifier)
        tableView.register(ATYEditCourseCountTaskCell.self, forCellReuseIdentifier: ATYEditCourseCountTaskCell.reuseIdentifier)
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

    }
}


extension ATYEditCourseCountRepeatTaskViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ATYCountRepeatEnum.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch ATYCountRepeatEnum.init(rawValue: indexPath.row) {
        case .exercise:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYEditCountCourseTaskTimeCell.reuseIdentifier, for: indexPath) as! ATYEditCountCourseTaskTimeCell
            return cell
        case .countRepeat:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYEditCourseCountTaskCell.reuseIdentifier, for: indexPath) as! ATYEditCourseCountTaskCell
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
