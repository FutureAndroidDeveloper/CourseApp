//
//  ATYAboutCourseScene.swift
//  AppToYou
//
//  Created by Philip Bratov on 09.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYAboutCourseViewController: UIViewController {

    enum AboutCourseTypeCell : Int, CaseIterable{
        case header
        case description
        case tasksCourse
        case members
        case shareCourse
        case reportCourse
    }

    var viewModel: ATYAboutCourseViewModel!

    var isMyCourse : Bool!

    private var transition: PanelTransition!
    private var transitionSecond: PanelTransition!
    private var transitionThird: PanelTransition!

    init(isMyCourse: Bool, course: ATYCourse) {
        super.init(nibName: nil, bundle: nil)
        self.isMyCourse = isMyCourse
        self.viewModel = ATYAboutCourseViewModel(course: course)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        self.tableView.contentInsetAdjustmentBehavior = .never
        self.transition = PanelTransition(y: view.bounds.height * 0.4 , height: view.bounds.height * 0.6)
        self.transitionSecond = PanelTransition(y: view.bounds.height * 0.3 , height: view.bounds.height * 0.7)
        self.transitionThird = PanelTransition(y: view.bounds.height * 0.5 , height: view.bounds.height * 0.5)
    }

    private func configureNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
        navigationController?.navigationBar.isHidden = true
        navigationItem.hidesBackButton = true
        navigationItem.backBarButtonItem = nil
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        configureNavBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.reloadData()
    }

    private func configureTableView() {
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        view.backgroundColor = R.color.backgroundAppColor()
        tableView.backgroundColor = R.color.backgroundAppColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ATYHeaderAboutCourseCell.self, forCellReuseIdentifier: ATYHeaderAboutCourseCell.reuseIdentifier)
        tableView.register(ATYDescriptionAboutCourse.self, forCellReuseIdentifier: ATYDescriptionAboutCourse.reuseIdentifier)
        tableView.register(ATYTasksForAboutCourseCell.self, forCellReuseIdentifier: ATYTasksForAboutCourseCell.reuseIdentifier)
        tableView.register(ATYMembersAboutCourseCell.self, forCellReuseIdentifier: ATYMembersAboutCourseCell.reuseIdentifier)
        tableView.register(ATYShareCourseCell.self, forCellReuseIdentifier: ATYShareCourseCell.reuseIdentifier)
        tableView.register(ATYReportCourseCell.self, forCellReuseIdentifier: ATYReportCourseCell.reuseIdentifier)


        tableView.register(UINib(nibName: "ATYAchievementListCell", bundle: nil), forCellReuseIdentifier: ATYAchievementListCell.reuseIdentifier)
        tableView.register(ATYProfileSignInCollectionAchievementCell.self, forCellReuseIdentifier: ATYProfileSignInCollectionAchievementCell.reuseIdentifier)

        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    private func showTaskAddedPopup() {
        let child = ATYTaskAddedViewController(type: .oneTask)
        child.transitioningDelegate = self.transitionThird
        child.modalPresentationStyle = .custom
        self.present(child, animated: true)
    }

    @objc func tappedBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ATYAboutCourseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AboutCourseTypeCell.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch AboutCourseTypeCell.init(rawValue: indexPath.row) {
        case .header:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYHeaderAboutCourseCell.reuseIdentifier, for: indexPath) as! ATYHeaderAboutCourseCell
            let course = self.viewModel.course
            cell.setUp(isMyCourse: self.isMyCourse,
                       countOfPeople: course.usersAmount ?? 0,
                       duration: course.duration,
                       price: course.coinPrice,
                       typeOfCourse: course.courseType,
                       imagePath: course.picPath)
            cell.callbackBackButton = { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            cell.editButtonCallback = { [weak self] in
                let vc = ATYCreateCourseViewController(interactionMode: .update)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        case .description:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYDescriptionAboutCourse.reuseIdentifier, for: indexPath) as! ATYDescriptionAboutCourse
            cell.setUp(isMyCourse: self.isMyCourse)
            cell.callbackMembers = { [weak self] in
                let vc = ATYCourseParticipantsViewController()
                self?.navigationController?.pushViewController(vc, animated:  true)
            }
            return cell
        case .tasksCourse:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYTasksForAboutCourseCell.reuseIdentifier, for: indexPath) as! ATYTasksForAboutCourseCell
            cell.setUp(isMyCourse: self.isMyCourse)
            cell.createTaskCallback = { [weak self] in
                let child = ATYAddTaskViewController()
                let vc = ATYCreateCourseTaskViewController()
                vc.hidesBottomBarWhenPushed = true

                child.pushVcCallback = { [weak self] type in
                    vc.types = type
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                child.transitioningDelegate = self?.transition
                child.modalPresentationStyle = .custom

                self?.present(child, animated: true)
            }

            cell.selectSwitchButtonCallback = { [weak self] typeTask in
                var child = UIViewController()
                switch typeTask {
                case .CHECKBOX:
//                    child = ATYJoinToCloseCourseViewController()
//                    child.transitioningDelegate = self?.transitionSecond

//                    child = ATYPenaltyWarningViewController()
//                    child.transitioningDelegate = self?.transitionThird
//                      child = ATYVacataionViewController()
//                      child.transitioningDelegate = self?.transitionThird

//                    self?.showViewBlur()
                break
                case .RITUAL:
                    child = ATYEditCourseCountRepeatTaskViewController()
                    (child as! ATYEditCourseCountRepeatTaskViewController).dismissCallback = { [weak self ] in
                        self?.showTaskAddedPopup()
                    }
                    child.transitioningDelegate = self?.transitionThird
                case .TEXT:
                    child = ATYEditCourseTextTaskViewController()
                    (child as! ATYEditCourseTextTaskViewController).dismissCallback = { [weak self ] in
                        self?.showTaskAddedPopup()
                    }
                    child.transitioningDelegate = self?.transitionSecond
                case .TIMER:
                    child = ATYEditTimerCourseTaskViewController()
                    (child as! ATYEditTimerCourseTaskViewController).dismissCallback = { [weak self ] in
                        self?.showTaskAddedPopup()
                    }
                    child.transitioningDelegate = self?.transitionSecond
                default: break
                }

                child.modalPresentationStyle = .custom
                self?.present(child, animated: true)
            }

            cell.addAllTasksCallback = { [weak self] in
                let child = ATYTaskAddedViewController(type: .allTasks)
                child.transitioningDelegate = self?.transitionThird
                child.modalPresentationStyle = .custom
                self?.present(child, animated: true)
            }
            return cell
        case .members:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYMembersAboutCourseCell.reuseIdentifier, for: indexPath) as! ATYMembersAboutCourseCell
            return cell
        case .shareCourse:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYShareCourseCell.reuseIdentifier, for: indexPath) as! ATYShareCourseCell
            return cell
        case .reportCourse:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYReportCourseCell.reuseIdentifier, for: indexPath) as! ATYReportCourseCell
            return cell
        default: break
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let _ = (tableView.cellForRow(at: indexPath) as? ATYMembersAboutCourseCell) {
            navigationController?.pushViewController(ATYCourseRatingViewController(), animated: true)
//            navigationController?.pushViewController(ATYCourseParticipantsViewController(), animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
