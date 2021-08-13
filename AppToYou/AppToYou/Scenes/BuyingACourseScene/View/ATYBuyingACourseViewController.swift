//
//  ATYBuyingACourseViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 22.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYBuyingACourseViewController: UIViewController {

    private enum ATYBuyingEnum: Int, CaseIterable {
        case header
        case cost
    }

    private let buyButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.buttonColor()
        button.setTitle("Купить", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return button
    }()

    private let goToShopButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.backgroundTextFieldsColor()
        button.setTitleColor(R.color.buttonColor(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.setTitle("В магазин", for: .normal)
        return button
    }()

    let tableView = UITableView()
    let lineView = UIView()
    let selectedView = UIView()
    var dismissCallback : (() -> Void)?
    var dismissCallbackWallet : (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureTableView()
        view.backgroundColor = R.color.backgroundTextFieldsColor()
        view.layer.cornerRadius = 24
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    private func configureViews() {
        view.addSubview(lineView)
        lineView.backgroundColor = R.color.lightGrayColor()
        lineView.layer.cornerRadius = 2
        lineView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.height.equalTo(5)
            make.width.equalTo(40)
        }
    }

    private func configureTableView() {
        view.addSubview(tableView)
        view.addSubview(buyButton)
        view.addSubview(goToShopButton)

        goToShopButton.addTarget(self, action: #selector(goToShopButtonAction), for: .touchUpInside)
        goToShopButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-12)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

        buyButton.addTarget(self, action: #selector(createTaskButtonAction), for: .touchUpInside)
        buyButton.layer.cornerRadius = 25
        buyButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(goToShopButton.snp.top).offset(-4)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

        tableView.layer.cornerRadius = 24
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = R.color.backgroundTextFieldsColor()
        tableView.register(ATYHeaderBuyingACourseCell.self, forCellReuseIdentifier: ATYHeaderBuyingACourseCell.reuseIdentifier)
        tableView.register(ATYTheCostCourseCell.self, forCellReuseIdentifier: ATYTheCostCourseCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalTo(buyButton.snp.top).offset(-5)
        }
    }

    @objc func createTaskButtonAction() {
        self.dismiss(animated: true) { [weak self] in
            self?.dismissCallback?()
        }
    }

    @objc func goToShopButtonAction() {
        self.dismiss(animated: true) { [weak self] in
            self?.dismissCallbackWallet?()
        }
    }
}

extension ATYBuyingACourseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ATYBuyingEnum.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch ATYBuyingEnum.init(rawValue: indexPath.row) {
        case .header:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYHeaderBuyingACourseCell.reuseIdentifier, for: indexPath) as! ATYHeaderBuyingACourseCell
            return cell
        case .cost:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYTheCostCourseCell.reuseIdentifier, for: indexPath) as! ATYTheCostCourseCell
            return cell
        default : return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension

    }
}
