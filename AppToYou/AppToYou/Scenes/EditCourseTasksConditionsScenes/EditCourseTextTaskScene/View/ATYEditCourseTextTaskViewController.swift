//
//  ATYEditCourseTextTaskViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 20.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYEditCourseTextTaskViewController: UIViewController {

    private enum ATYTextEnum: Int, CaseIterable {
        case text
        case symbolsCount
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
        tableView.register(ATYEditTextCourseTaskCell.self, forCellReuseIdentifier: ATYEditTextCourseTaskCell.reuseIdentifier)
        tableView.register(ATYEditTextSymbolsCountTaskCell.self, forCellReuseIdentifier: ATYEditTextSymbolsCountTaskCell.reuseIdentifier)
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


extension ATYEditCourseTextTaskViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ATYTextEnum.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch ATYTextEnum.init(rawValue: indexPath.row) {
        case .text:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYEditTextCourseTaskCell.reuseIdentifier, for: indexPath) as! ATYEditTextCourseTaskCell
            return cell
        case .symbolsCount:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYEditTextSymbolsCountTaskCell.reuseIdentifier, for: indexPath) as! ATYEditTextSymbolsCountTaskCell
            return cell
        default : return UITableViewCell()
        }
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
