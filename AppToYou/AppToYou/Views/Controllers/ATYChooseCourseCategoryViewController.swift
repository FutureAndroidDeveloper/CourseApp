//
//  ATYChooseCourseCategoryViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 14.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

struct ATYCourseCategorySelect {
    var title: String
    var isSelected = false
}

class ATYChooseCourseCategoryViewController: UIViewController {

    var callBack : (([String]) -> ())?
    var countSelected = 0
    let acceptButton = UIButton(type: .custom)
    private let tableView = UITableView()
    private var arrayCategory : [ATYCourseCategorySelect] = [ATYCourseCategorySelect(title: "Дети", isSelected: false),
                                                             ATYCourseCategorySelect(title: "Домашние животные", isSelected: false),
                                                             ATYCourseCategorySelect(title: "Еда", isSelected: false),
                                                             ATYCourseCategorySelect(title: "ЗОЖ", isSelected: false),
                                                             ATYCourseCategorySelect(title: "Иностранные языки", isSelected: false),
                                                             ATYCourseCategorySelect(title: "Красота", isSelected: false),
                                                             ATYCourseCategorySelect(title: "Образование", isSelected: false),
                                                             ATYCourseCategorySelect(title: "Развитие личности", isSelected: false),
                                                             ATYCourseCategorySelect(title: "Творчество", isSelected: false),
                                                             ATYCourseCategorySelect(title: "Финансы", isSelected: false),
                                                             ATYCourseCategorySelect(title: "Хобби", isSelected: false),
                                                             ATYCourseCategorySelect(title: "IT", isSelected: false),
                                                             ATYCourseCategorySelect(title: "Отношения", isSelected: false),
                                                             ATYCourseCategorySelect(title: "Другое", isSelected: false)]

    init(categories: [String]?) {
        super.init(nibName: nil, bundle: nil)
        if let categories = categories {
            countSelected = categories.count
            for i in 0..<categories.count {
                for j in 0..<arrayCategory.count {
                    if categories[i] == arrayCategory[j].title {
                        arrayCategory[j].isSelected = true
                    }
                }
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()

        acceptButton.setTitle("Сохранить", for: .normal)
        acceptButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        acceptButton.frame = CGRect(x: 0, y: 0, width: 15, height: 30)
        acceptButton.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        acceptButton.setTitleColor(R.color.iconsTintColor(), for: .normal)
        let acceptBarButton = UIBarButtonItem(customView: acceptButton)

        if arrayCategory.filter({ $0.isSelected }).isEmpty {
            acceptButton.isEnabled = false
            acceptButton.setTitleColor(R.color.iconsTintColor(), for: .normal)
        } else {
            acceptButton.isEnabled = true
            acceptButton.setTitleColor(R.color.buttonColor(), for: .normal)
        }


        navigationItem.rightBarButtonItems = [acceptBarButton]
    }

    @objc func saveButtonAction() {
        let resultArray = arrayCategory.filter({ $0.isSelected }).compactMap { (category) -> String? in
            return category.title
        }
        self.callBack?(resultArray)
        self.navigationController?.popViewController(animated: true)
    }

    //MARK:- UI configurations
    private func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(ATYChooseCourseCategoryCell.self, forCellReuseIdentifier: ATYChooseCourseCategoryCell.reuseIdentifier)

        title = "Категория курса"
        self.tableView.separatorStyle = .singleLine
        self.tableView.tableFooterView = UIView()
        view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.top.equalToSuperview()
        }
    }
}

//MARK:- Table view data source
extension ATYChooseCourseCategoryViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayCategory.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ATYChooseCourseCategoryCell.reuseIdentifier, for: indexPath) as! ATYChooseCourseCategoryCell
        let item = arrayCategory[indexPath.row]
        cell.labelCourseLabel.text = item.title
        if item.isSelected {
            cell.radioImageView.image = R.image.selectedRadioButton()
        } else {
            cell.radioImageView.image = R.image.unselectedRadioButton()
        }
        return cell
    }
}

//MARK:- Table view delegate
extension ATYChooseCourseCategoryViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if !arrayCategory[indexPath.row].isSelected && countSelected == 3 {
            self.showAlertCountSelectedCourseCategory()
            return
        }

        if arrayCategory[indexPath.row].isSelected {
            arrayCategory[indexPath.row].isSelected = false
            countSelected -= 1
        } else {
            arrayCategory[indexPath.row].isSelected = true
            countSelected += 1
        }

        if countSelected == 0 {
            acceptButton.isEnabled = false
            acceptButton.setTitleColor(R.color.iconsTintColor(), for: .normal)
        } else {
            acceptButton.isEnabled = true
            acceptButton.setTitleColor(R.color.buttonColor(), for: .normal)
        }

        self.tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
}
