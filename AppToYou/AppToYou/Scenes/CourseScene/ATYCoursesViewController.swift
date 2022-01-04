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

class ATYCoursesViewController : UIViewController, BindableType {
    
    var viewModel: CoursesViewModel!

    enum CreateCellCourses: Int, CaseIterable {
        case courseBar
        case courseTasks
    }

    private var transitionSecond: PanelTransition!
    private var transitionOne: PanelTransition!

    private let store = FileStore()
    
    var courseArray = [CourseCreateRequest]()
    
    var filteredArray = [CourseCreateRequest]()
    
    private let refreshControl = UIRefreshControl()
    
    private var courses = [CourseResponse]()

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
        courseArray = store.getCourses()
        filteredArray = courseArray
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
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }

    private func openCourseVc(isMyCourse: Bool, indexPath: IndexPath) {
        let tmpCourse = ATYCourse.init()
        let vc = ATYAboutCourseViewController(isMyCourse: isMyCourse, course: tmpCourse)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func bindViewModel() {
        viewModel.output.courses.bind { [weak self] courses in
            self?.courses = courses
            self?.refreshControl.endRefreshing()
            self?.tableView.reloadData()
        }
        viewModel.input.refresh()
        
    }
    
    @objc
    private func refresh(_ sender: AnyObject) {
        viewModel.input.refresh()
    }
    
    var isFirstLoading = true
    
}

extension ATYCoursesViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        
        if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex && !isFirstLoading {
            print("this is the last cell")
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
            viewModel.input.loadMore()
            isFirstLoading = true
        } else if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex && isFirstLoading {
            tableView.tableFooterView = nil
            tableView.tableFooterView?.isHidden = true
            isFirstLoading.toggle()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : courses.count
//        return section == 0 ? 1 : filteredArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 && indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateCourseCell.reuseIdentifier, for: indexPath) as! ATYCreateCourseCell
            cell.createCourseCallback = { [weak self] in
                print("Create Tapped")
                self?.viewModel.input.createDidTapped()
//                let vc = ATYCreateCourseViewController(interactionMode: .create)
//                vc.callbackCreateCourse = { [weak self] course in
//                    guard let course = course else { return }
//                    self?.courseArray.append(course)
//                    self?.filteredArray = self?.courseArray ?? []
//                    self?.tableView.reloadData()
//                }
//                self?.navigationController?.setNavigationBarHidden(false, animated: false)
//                vc.hidesBottomBarWhenPushed = true
//                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: ATYCourseTableViewCell.reuseIdentifier, for: indexPath) as! ATYCourseTableViewCell
//        let item = filteredArray[indexPath.row]
        
        let course = courses[indexPath.row]
        let isMyCourse = UserSession.shared.getUser()?.id == course.admin.id
        
        cell.setUp(courseName: course.name,
                   categories: [course.courseCategory1, course.courseCategory2, course.courseCategory3],
                   countOfCoin: course.coinPrice,
                   countOfMembers: course.usersAmount,
                   countOfLikes: course.likes,
                   typeOfCourse: course.courseType,
                   isMyCourse: isMyCourse,
                   avatarPath: course.admin.avatarPath,
                   courseDescription: course.description)
        
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
//            self?.filteredArray = self?.filteredArray.filter({ $0.isMyCourse }) ?? []
//            self?.filteredArray = self?.filteredArray
            self?.flag = false
            self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            self?.tableView.reloadData()
        }

        header.searchTextCallback = { [weak self] text in
//            self?.filteredArray = self?.courseArray.filter { $0.courseName.range(of: text ?? "", options: .caseInsensitive) != nil } ?? []
//            if text == nil || text == "" {
//                self?.filteredArray = self?.courseArray ?? []
//            }
//
//            if self?.filteredArray.isEmpty ?? true {
//                self?.tableView.setNoDataPlaceholder("Курсы не найдены")
//            }
//            else {
//                self?.tableView.removeNoDataPlaceholder()
//            }
//            self?.tableView.reloadData()
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
//                openCourseVc(isMyCourse: courseArray[indexPath.row].isMyCourse, indexPath: indexPath)
//                openCourseVc(isMyCourse: true, indexPath: indexPath)
                let course = courses[indexPath.row]
                viewModel.input.openCourse(course)
                return
                
            case .PRIVATE:
//                if courseArray[indexPath.row].isMyCourse {
//                    openCourseVc(isMyCourse: courseArray[indexPath.row].isMyCourse, indexPath: indexPath)
//                    return
//                }
                child = ATYJoinToCloseCourseViewController()
                child.transitioningDelegate = self.transitionOne
                
            case .PAID:
//                if courseArray[indexPath.row].isMyCourse {
//                    openCourseVc(isMyCourse: courseArray[indexPath.row].isMyCourse, indexPath: indexPath)
//                    return
//                }
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



