//
//  ATYAchievementListViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 30.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYAchievementListViewController: UIViewController {

    let achievementArray : [ATYAchievementType] = [.marafonec,
                                                   .manyak,
                                                   .boec,
                                                   .bestFriend,
                                                   .maksimalist,
                                                   .nepobedimiy,
                                                   .psix,
                                                   .novichek,
                                                   .adept,
                                                   .kouch]
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavBar()
        view.backgroundColor = R.color.backgroundTextFieldsColor()
    }

    @objc func settingsAction() {

    }

    private func configureTableView() {
        view.addSubview(tableView)

        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = R.color.backgroundAppColor()
        tableView.register(UINib(nibName: "ATYAchievementListCell", bundle: nil), forCellReuseIdentifier: ATYAchievementListCell.reuseIdentifier)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    private func configureNavBar() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = R.color.lineViewBackgroundColor()
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.navigationBar.setBackgroundImage(nil, for:.default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = false
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationController?.navigationBar.barTintColor = R.color.backgroundAppColor()
        self.navigationItem.title = "Достижения"
    }
}

extension ATYAchievementListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return achievementArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ATYAchievementListCell.reuseIdentifier, for: indexPath) as! ATYAchievementListCell
        let item = achievementArray[indexPath.row]
        cell.setUp(image: item.achievementImage,
                   achievementName: item.achievementName,
                   descriptionAchievement: item.achievementDescription,
                   moneyForAchievement: item.moneyForAchievement,
                   progress: item.progressAchievement)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
