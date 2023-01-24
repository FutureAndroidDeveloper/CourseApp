//
//  ATYCourseParticipantsViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 22.07.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class ATYCourseParticipantsViewController : UIViewController {

    let tableView = UITableView()
    var sectionData = [["Отправьте ссылку другу, и он сразу попадет по ней на ваш курс"],
                       ["Ирина Юзер", "Валера Пура", "Филипп Братов", "Петр Юзер", "Илья Марков", "Леша Баклажан", "Андрей Красноухий", "Артем Рак", "Егор Драгель", "Антон Великоборец"],
                       ["Ирина Круг", "Владимирский Цетрал", "Ветер Северный", "Пол Уокер", "Петр Ян", "Максим Горелов", "Андрей Фомин", "Саша Власов"]]

    let sectionsName = ["Заявки на добавление", "Все участники курса"]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavBar()
        view.backgroundColor = R.color.backgroundAppColor()
    }

    private func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.bottom.equalToSuperview()
        }
        tableView.separatorStyle = .none
        tableView.backgroundColor = R.color.backgroundAppColor()
        tableView.register(ATYShareCourseLinkCell.self, forCellReuseIdentifier: ATYShareCourseLinkCell.reuseIdentifier)
        tableView.register(ATYCourseParticipantCell.self, forCellReuseIdentifier: ATYCourseParticipantCell.reuseIdentifier)
    }

    //MARK:- Configure UI

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
        self.navigationItem.title = "Участники курса \"Ментальное здоровье\""
    }
}

extension ATYCourseParticipantsViewController : UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionData.count
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionData[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYShareCourseLinkCell.reuseIdentifier, for: indexPath) as! ATYShareCourseLinkCell
            return cell
        default:
            let item = sectionData[indexPath.section][indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYCourseParticipantCell.reuseIdentifier, for: indexPath) as! ATYCourseParticipantCell
            cell.doneCallback = { [weak self] in
                self?.sectionData[indexPath.section + 1].append(self?.sectionData[indexPath.section][indexPath.row] ?? "")
                self?.sectionData[indexPath.section].remove(at: indexPath.row)
                self?.tableView.reloadData()
            }

            cell.deslineCallback = { [weak self] in
                self?.sectionData[indexPath.section].remove(at: indexPath.row)
                self?.tableView.reloadData()
            }
            cell.setUp(participantUserName: item, type: indexPath.section)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section != 0 ? 40 : 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = UIView()
            view.frame = CGRect(origin: .zero, size: .zero)
            return view
        }
        if sectionData[section].isEmpty {
            return UIView()
        }
        let label = UILabel()
        label.backgroundColor = R.color.backgroundAppColor()
        label.text = sectionsName[section - 1]
        label.textColor = R.color.titleTextColor()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)

        return label
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = ATYProgressParticipantViewController()
//        vc.name = sectionData[indexPath.section][indexPath.row]
//        navigationController?.pushViewController(vc, animated: true)
    }
}
