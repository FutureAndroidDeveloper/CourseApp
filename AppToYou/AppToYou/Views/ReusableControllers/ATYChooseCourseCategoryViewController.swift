//
//  ATYChooseCourseCategoryViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 14.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

struct ATYCourseCategorySelect {
    var courseCategory: ATYCourseCategory
    var isSelected = false
}

class ATYChooseCourseCategoryViewController: UIViewController {

    var callBack : (([ATYCourseCategory]) -> ())?
    var countSelected = 0
    let acceptButton = UIButton(type: .custom)
    private let tableView = UITableView()
    private var arrayCategory : [ATYCourseCategorySelect] = [ATYCourseCategorySelect(courseCategory: .CHILDREN, isSelected: false),
                                                             ATYCourseCategorySelect(courseCategory: .PETS, isSelected: false),
                                                             ATYCourseCategorySelect(courseCategory: .FOOD, isSelected: false),
                                                             ATYCourseCategorySelect(courseCategory: .HEALTHY_LIFESTYLE, isSelected: false),
                                                             ATYCourseCategorySelect(courseCategory: .FOREIGN_LANGUAGES, isSelected: false),
                                                             ATYCourseCategorySelect(courseCategory: .BEAUTY, isSelected: false),
                                                             ATYCourseCategorySelect(courseCategory: .EDUCATION, isSelected: false),
                                                             ATYCourseCategorySelect(courseCategory: .PERSONAL_DEVELOPMENT, isSelected: false),
                                                             ATYCourseCategorySelect(courseCategory: .CREATION, isSelected: false),
                                                             ATYCourseCategorySelect(courseCategory: .FINANCE, isSelected: false),
                                                             ATYCourseCategorySelect(courseCategory: .HOBBY, isSelected: false),
                                                             ATYCourseCategorySelect(courseCategory: .IT, isSelected: false),
                                                             ATYCourseCategorySelect(courseCategory: .RELATIONSHIPS, isSelected: false),
                                                             ATYCourseCategorySelect(courseCategory: .OTHER, isSelected: false)]

    init(categories: [ATYCourseCategory]?) {
        super.init(nibName: nil, bundle: nil)
        if let categories = categories {
            countSelected = categories.count
            for i in 0..<categories.count {
                for j in 0..<arrayCategory.count {
                    if categories[i].title == arrayCategory[j].courseCategory.title {
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
        configureTableViewNavBar()

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
        let resultArray = arrayCategory.filter({ $0.isSelected }).compactMap { (category) -> ATYCourseCategory? in
            return category.courseCategory
        }
        self.callBack?(resultArray)
        self.navigationController?.popViewController(animated: true)
    }

    //MARK:- UI configurations
    private func configureTableViewNavBar() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = R.color.lineViewBackgroundColor()
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        view.backgroundColor = R.color.backgroundAppColor()

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
        cell.labelCourseLabel.text = item.courseCategory.title
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
            self.showAlertCountSelectedCourseCategory(text: "Курс может иметь не более трех категорий!")
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
