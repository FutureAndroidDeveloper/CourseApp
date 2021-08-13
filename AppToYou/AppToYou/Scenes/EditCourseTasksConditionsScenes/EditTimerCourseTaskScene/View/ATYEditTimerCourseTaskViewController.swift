//
//  ATYEditTimerCourseTaskViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 16.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYEditTimerCourseTaskViewController: UIViewController {

    private enum ATYTimerEnum: Int, CaseIterable {
        case time
        case durationAndSanction
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

    var dismissCallback : (() -> Void)?

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

        tableView.isScrollEnabled = false
        tableView.alwaysBounceVertical = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = R.color.backgroundTextFieldsColor()
        tableView.register(ATYEditTimerCourseTaskTimeCell.self, forCellReuseIdentifier: ATYEditTimerCourseTaskTimeCell.reuseIdentifier)
        tableView.register(ATYEditTimerCourseTaskDurationCell.self, forCellReuseIdentifier: ATYEditTimerCourseTaskDurationCell.reuseIdentifier)
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
        self.dismiss(animated: true) { [weak self] in
            self?.dismissCallback?()
        }
    }
}


extension ATYEditTimerCourseTaskViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ATYTimerEnum.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch ATYTimerEnum.init(rawValue: indexPath.row) {
        case .time:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYEditTimerCourseTaskTimeCell.reuseIdentifier, for: indexPath) as! ATYEditTimerCourseTaskTimeCell
            return cell
        case .durationAndSanction:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYEditTimerCourseTaskDurationCell.reuseIdentifier, for: indexPath) as! ATYEditTimerCourseTaskDurationCell
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

