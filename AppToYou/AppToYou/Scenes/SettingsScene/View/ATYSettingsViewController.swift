//
//  ATYSettingsViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 05.08.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYSettingsViewController : UIViewController {

    enum ATYSettingsEnum : Int, CaseIterable {
        case name
        case language
        case notificationApp
        case notificationChats
        case reminderTasks
        case widget
    }

    let settingsArray : [(String,String?)] = [("Имя","Павел Юзер"),
                                              ("Язык","Русский"),
                                              ("Уведомления приложения", nil),
                                              ("Уведомления чатов", nil),
                                              ("Напоминания заданий", nil),
                                              ("Виджет управления заданиями", nil)]

    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureNavBar()
    }

    //MARK:- Configure UI

    private func configureNavBar() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = R.color.lineViewBackgroundColor()
        view.backgroundColor = R.color.backgroundAppColor()
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.navigationBar.setBackgroundImage(nil, for:.default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = false
        self.navigationController?.navigationBar.setValue(false, forKey: "hidesShadow")
        navigationController?.navigationBar.barTintColor = R.color.backgroundTextFieldsColor()
        self.navigationItem.title = "Настройки"
    }

    private func configure() {
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.layer.cornerRadius = 25
        tableView.backgroundColor = R.color.backgroundAppColor()
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ATYSettingsCell", bundle: nil), forCellReuseIdentifier: ATYSettingsCell.reuseIdentifier)
        tableView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
            make.height.equalTo(275)
        }
    }
}

extension ATYSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ATYSettingsEnum.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ATYSettingsCell.reuseIdentifier, for: indexPath) as! ATYSettingsCell
        let item = settingsArray[indexPath.row]
        cell.setUp(name: item.0, rightLabelText: item.1)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}
