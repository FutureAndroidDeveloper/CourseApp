//
//  ATYCoursesViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 25.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

struct ATYTemporaryCourseData {
    var courseName : String
    var countOfCoin : Int?
    var countOfMembers: Int
    var countOfLikes : Int
    var typeOfCourse : ATYCourseType
    var isMyCourse : Bool
    var categories : [String]
}

class ATYCoursesViewController : UIViewController {

    enum CreateCellCourses: Int, CaseIterable {
        case courseBar
        case courseTasks
    }

    private var transitionSecond: PanelTransition!
    private var transitionOne: PanelTransition!

    var courseArray = [ATYCourse]()
    
    var filteredArray = [ATYCourse]()

    var flag = true

    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.backgroundAppColor()
        filteredArray = courseArray
        configureTableView()
        self.tableView.contentInsetAdjustmentBehavior = .never
        self.transitionSecond = PanelTransition(y: view.bounds.height * 0.3 , height: view.bounds.height * 0.7)
        self.transitionOne = PanelTransition(y: view.bounds.height * 0.45 , height: view.bounds.height * 0.55)
    }

    private func configureNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    private func configureTableView() {
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        view.backgroundColor = R.color.backgroundAppColor()
        tableView.backgroundColor = R.color.backgroundAppColor()
        tableView.delegate = self
        tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        tableView.register(ATYCreateCourseCell.self, forCellReuseIdentifier: ATYCreateCourseCell.reuseIdentifier)
        tableView.register(ATYCollectionViewTypeCourseTableCell.self, forCellReuseIdentifier: ATYCollectionViewTypeCourseTableCell.reuseIdentifier)
        tableView.register(ATYCourseTableViewCell.self, forCellReuseIdentifier: ATYCourseTableViewCell.reuseIdentifier)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
        }
    }

    private func openCourseVc() {
        let vc = ATYAboutCourseViewController()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ATYCoursesViewController : UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : filteredArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 && indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateCourseCell.reuseIdentifier, for: indexPath) as! ATYCreateCourseCell
            cell.createCourseCallback = { [weak self] in
                let vc = ATYCreateCourseViewController(interactionMode: .create)
                vc.callbackCreateCourse = { [weak self] course in
                    guard let course = course else { return }
                    self?.courseArray.append(course)
                    self?.filteredArray = self?.courseArray ?? []
                    self?.tableView.reloadData()
                }
                self?.navigationController?.setNavigationBarHidden(false, animated: false)
                vc.hidesBottomBarWhenPushed = true
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: ATYCourseTableViewCell.reuseIdentifier, for: indexPath) as! ATYCourseTableViewCell
        let item = filteredArray[indexPath.row]
        cell.setUp(courseName: item.courseName,
                   categories: item.courseCategory,
                   countOfCoin: item.coinPrice,
                   countOfMembers: item.usersAmount ?? 0,
                   countOfLikes: item.likes ?? 0,
                   typeOfCourse: item.courseType,
                   isMyCourse: item.isMyCourse,
                   avatarPath: item.picPath,
                   courseDescription: item.courseDescription)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ATYSearchBarCollectionView(flag: self.flag, frame: .zero)
        header.callbackErrorThree = { [weak self] in
            self?.showAlertCountSelectedCourseCategory(text: "Для выбора доступно максимум 3 категории!")
        }
        header.firstCallback = { [weak self] in
            self?.filteredArray = self?.courseArray ?? []
            self?.flag = true
            self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            self?.tableView.reloadData()
        }

        header.secondCallback = { [weak self] in
            self?.filteredArray = self?.filteredArray.filter({ $0.isMyCourse }) ?? []
            self?.flag = false
            self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            self?.tableView.reloadData()
        }

        header.searchTextCallback = { [weak self] text in
            self?.filteredArray = self?.courseArray.filter { $0.courseName.range(of: text ?? "", options: .caseInsensitive) != nil } ?? []
            if text == nil || text == "" {
                self?.filteredArray = self?.courseArray ?? []
            }

            if self?.filteredArray.isEmpty ?? true {
                self?.tableView.setNoDataPlaceholder("Курсы не найдены")
            }
            else {
                self?.tableView.removeNoDataPlaceholder()
            }
            self?.tableView.reloadData()
        }
        return section == 1 ? header : nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 350
        }
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? ATYCourseTableViewCell {
            var child = UIViewController()
            switch cell.typeOfCourse {
            case .PUBLIC:
                openCourseVc()
                return
            case .PRIVATE:
                if courseArray[indexPath.row].isMyCourse {
                    openCourseVc()
                    return
                }
                child = ATYJoinToCloseCourseViewController()
                child.transitioningDelegate = self.transitionOne
            case .PAID:
                if courseArray[indexPath.row].isMyCourse {
                    openCourseVc()
                    return
                }
                child = ATYPaidCoursePreviewViewController()
                child.transitioningDelegate = self.transitionSecond
                (child as? ATYPaidCoursePreviewViewController)?.dismissCallback = { [weak self] in
                    let child = ATYBuyingACourseViewController()
                    child.dismissCallbackWallet = { [weak self] in
                        let vc = ATYNavigationBarWalletViewController()
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                    child.transitioningDelegate = self?.transitionOne
                    child.modalPresentationStyle = .custom
                    self?.present(child, animated: true)
                    return
                }

            default: break
            }
            child.modalPresentationStyle = .custom
            self.present(child, animated: true)
        }
    }
}



