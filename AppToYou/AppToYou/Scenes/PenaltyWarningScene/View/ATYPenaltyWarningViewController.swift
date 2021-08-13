//
//  ATYPenaltyWarningViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 28.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

import UIKit

class ATYPenaltyWarningViewController: UIViewController {

    private let createTaskButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.buttonColor()
        button.setTitle("Понятно", for: .normal)
        return button
    }()

    private let buyLaterButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.backgroundTextFieldsColor()
        button.setTitleColor(R.color.buttonColor(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.setTitle("Оплачу позже", for: .normal)
        return button
    }()

    let viewS = ATYCardView(frame: .zero)
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
        view.addSubview(viewS)
        view.addSubview(tableView)
        view.addSubview(createTaskButton)
        view.addSubview(buyLaterButton)

        buyLaterButton.addTarget(self, action: #selector(goToShopButtonAction), for: .touchUpInside)
        buyLaterButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-12)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

        createTaskButton.addTarget(self, action: #selector(createTaskButtonAction), for: .touchUpInside)
        createTaskButton.layer.cornerRadius = 25
        createTaskButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(buyLaterButton.snp.top).offset(-4)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

        tableView.alwaysBounceVertical = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = R.color.backgroundTextFieldsColor()
        tableView.register(UINib(nibName: "ATYPenaltyWarningCell", bundle: nil), forCellReuseIdentifier: ATYPenaltyWarningCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        viewS.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalTo(createTaskButton.snp.top).offset(-10)
        }
    }

    @objc func createTaskButtonAction() {
        self.dismiss(animated: true) { [weak self] in
            self?.dismissCallback?()
        }
    }

    @objc func goToShopButtonAction() {
        self.dismiss(animated: true) { [weak self] in
            self?.dismissCallback?()
        }
    }
}

extension ATYPenaltyWarningViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ATYPenaltyWarningCell.reuseIdentifier, for: indexPath) as! ATYPenaltyWarningCell
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
