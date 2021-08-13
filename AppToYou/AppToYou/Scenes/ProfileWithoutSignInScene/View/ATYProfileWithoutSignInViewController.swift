//
//  ATYProfileWithoutSignInViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 28.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYProfileWithoutSignInViewController: UIViewController {

    private enum ProfileCells: Int , CaseIterable {
        case statistics
        case needHelp
        case aboutApp
    }

    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        view.backgroundColor = R.color.backgroundTextFieldsColor()
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationController?.navigationBar.barTintColor = R.color.backgroundAppColor()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: R.image.settingsColorImage(), style: .plain, target: self, action: #selector(settingsAction))
    }

    @objc func settingsAction() {
        
    }

    private func configureTableView() {
        view.addSubview(tableView)

        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = R.color.backgroundAppColor()
        tableView.register(ATYProfileWithoutSignInStatisticCell.self, forCellReuseIdentifier: ATYProfileWithoutSignInStatisticCell.reuseIdentifier)
        tableView.register(ATYProfileNeedHelpCell.self, forCellReuseIdentifier: ATYProfileNeedHelpCell.reuseIdentifier)
        tableView.register(ATYAboutAppCell.self, forCellReuseIdentifier: ATYAboutAppCell.reuseIdentifier)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension ATYProfileWithoutSignInViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileCells.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch ProfileCells.init(rawValue: indexPath.row) {
        case .statistics:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYProfileWithoutSignInStatisticCell.reuseIdentifier, for: indexPath) as! ATYProfileWithoutSignInStatisticCell
            return cell
        case .needHelp:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYProfileNeedHelpCell.reuseIdentifier, for: indexPath) as! ATYProfileNeedHelpCell
            return cell
        case .aboutApp:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYAboutAppCell.reuseIdentifier, for: indexPath) as! ATYAboutAppCell
            return cell
        default : return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
