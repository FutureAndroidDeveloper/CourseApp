//
//  ATYTodayTasksViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 25.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import Foundation
import UIKit

final class ATYTodayTasksViewController: UIViewController {

    private var transition: PanelTransition!

    var viewModel : ATYTodayTasksViewModel!

    var calendarCollectionView: UICollectionView!
    var tasksTableView = UITableView()
    var calendarCollectionViewController: ATYCalendarCollectionViewController!

    let typeButton = UIButton()
    let tipImageView = UIImageView()
    let progressView = ATYStackProgressView()

    var temporaryArray = [TemporaryData(typeTask: .CHECKBOX,
                                        courseName: "Бокс",
                                        hasSanction: true,
                                        titleLabel: "Медитация",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "60 мин",
                                        state: .didNotStart),
                          TemporaryData(typeTask: .RITUAL,
                                        courseName: "Кулинария",
                                        hasSanction: true,
                                        titleLabel: "Сходить на площадку",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "60 мин",
                                        state: .didNotStart),
                          TemporaryData(typeTask: .TEXT,
                                        courseName: "Спорт",
                                        hasSanction: true,
                                        titleLabel: "Отжимания",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "60 мин",
                                        state: .didNotStart),
                          TemporaryData(typeTask: .CHECKBOX,
                                        courseName: "Энергетика",
                                        hasSanction: true,
                                        titleLabel: "Прочитать книгу",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "60 мин",
                                        state: .didNotStart),
                          TemporaryData(typeTask: .CHECKBOX,
                                        courseName: "Здоровье",
                                        hasSanction: false,
                                        titleLabel: "Отжимания",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "20 раз",
                                        state: .didNotStart),
                          TemporaryData(typeTask: .CHECKBOX,
                                        courseName: "Шитье",
                                        hasSanction: false,
                                        titleLabel: "Большой текст тест текст на длину длинный текст",
                                        firstSubtitleLabel: "Каждый деньфывфывфывфывфы",
                                        secondSubtitleLabel: "60 минпывафывпвыпваыпфывпфывпыфва",
                                        state: .didNotStart),
                          TemporaryData(typeTask: .CHECKBOX,
                                        courseName: "iOS Курс",
                                        hasSanction: true,
                                        titleLabel: "Медитация",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "60 мин",
                                        state: .didNotStart),
                          TemporaryData(typeTask: .CHECKBOX,
                                        courseName: "Здоровье",
                                        hasSanction: false,
                                        titleLabel: "Приседания",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "10 раз",
                                        state: .didNotStart),
                          TemporaryData(typeTask: .CHECKBOX,
                                        courseName: "Android курс",
                                        hasSanction: false,
                                        titleLabel: "Медитация",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "60 мин",
                                        state: .didNotStart)]

    var completedTask = [TemporaryData(typeTask: .CHECKBOX,
                                       courseName: "Электрика",
                                       hasSanction: true,
                                       titleLabel: "Test text",
                                       firstSubtitleLabel: "пт, cуб, вскр",
                                       secondSubtitleLabel: "60 мин",
                                       state: .didNotStart),
                         TemporaryData(typeTask: .CHECKBOX,
                                       courseName: "Машиностроение",
                                       hasSanction: false,
                                       titleLabel: "Test text",
                                       firstSubtitleLabel: "пт, cуб, вскр",
                                       secondSubtitleLabel: "60 мин",
                                       state: .didNotStart),
                         TemporaryData(typeTask: .CHECKBOX,
                                       courseName: "Медитация",
                                       hasSanction: true,
                                       titleLabel: "Test text",
                                       firstSubtitleLabel: "пт, cуб, вскр",
                                       secondSubtitleLabel: "60 мин",
                                       state: .didNotStart),
                         TemporaryData(typeTask: .CHECKBOX,
                                       courseName: "Английский",
                                       hasSanction: false,
                                       titleLabel: "Test text",
                                       firstSubtitleLabel: "пт, cуб, вскр",
                                       secondSubtitleLabel: "60 мин",
                                       state: .didNotStart)]

    convenience init(name: String) {
        self.init(title: name)
    }

    convenience init(title: String) {
        self.init(titles: title)
    }

    init(titles: String) {
        super.init(nibName: nil, bundle: nil)
        self.title = titles
        view.backgroundColor = R.color.backgroundAppColor()
        self.viewModel = ATYTodayTasksViewModel()
        self.viewModel.delegate = self
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.transition = PanelTransition(y: view.bounds.height * 0.4 , height: view.bounds.height * 0.6)
        configureViewControllers()
        addBlurEffect()
        confgigureStackView()
        configureTableView()
        configureAddButtonAndTipImage()

        let states = (self.temporaryArray + self.completedTask)
        let filteredStates = states.compactMap { (temporaryData) -> CurrentStateTask? in
            return temporaryData.state
        }
        progressView.countOfViews = (count: self.temporaryArray.count + self.completedTask.count, typeState: filteredStates)
        progressView.layoutSubviews()
    }

    func addBlurEffect() {
        let bounds = self.navigationController?.navigationBar.bounds
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualEffectView.frame = bounds ?? CGRect.zero
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.navigationController?.navigationBar.addSubview(visualEffectView)

        // Here you can add visual effects to any UIView control.
        // Replace custom view with navigation bar in the above code to add effects to the custom view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.getData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.calendarCollectionViewController.updateData()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.typeButton.layer.cornerRadius = self.typeButton.frame.height/2
        typeButton.layer.masksToBounds = false
        typeButton.layer.shadowColor = UIColor.black.cgColor
        typeButton.layer.shadowPath = UIBezierPath(roundedRect: typeButton.bounds, cornerRadius: typeButton.layer.cornerRadius).cgPath
        typeButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        typeButton.layer.shadowOpacity = 0.5
        typeButton.layer.shadowRadius = 1.0
    }

    private func configureAddButtonAndTipImage() {
        let icon = R.image.vBth_add()?.withRenderingMode(.alwaysTemplate)
        self.typeButton.setImage(icon, for: .normal)
        self.typeButton.tintColor = R.color.backgroundTextFieldsColor()
        self.typeButton.backgroundColor = R.color.buttonColor()
        self.typeButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)

        view.addSubview(self.typeButton)
        self.typeButton.snp.makeConstraints { (make) in
            make.bottom.trailing.equalToSuperview().offset(-25)
            make.height.width.equalTo(50)
        }

        tipImageView.image = R.image.tip()
        tipImageView.isHidden = true
        view.addSubview(tipImageView)

        self.tipImageView.snp.makeConstraints { (make) in
            make.trailing.equalTo(typeButton.snp.leading).offset(-10)
            make.centerY.equalTo(typeButton)
        }
    }

    private func configureViewControllers() {
        self.calendarCollectionViewController = ATYCalendarCollectionViewController()
        self.calendarCollectionView = self.calendarCollectionViewController.collectionView

        view.addSubview(self.calendarCollectionView)
        addChild(self.calendarCollectionViewController)
        self.calendarCollectionViewController.didMove(toParent: self)


        self.calendarCollectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.height.equalTo(100)
        }
    }

    private func confgigureStackView() {
        view.addSubview(progressView)
        progressView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(calendarCollectionView.snp.bottom)
            make.height.equalTo(3)
        }
    }

    private func configureTableView() {
        view.addSubview(tasksTableView)
        tasksTableView.backgroundColor = R.color.backgroundAppColor()
        tasksTableView.showsVerticalScrollIndicator = false
        tasksTableView.separatorStyle = .none
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        tasksTableView.register(ATYTaskTableViewCell.self, forCellReuseIdentifier: ATYTaskTableViewCell.reuseIdentifier)
        tasksTableView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(progressView.snp.bottom).offset(5)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
        }
    }

    //MARK:- Handlers

    @objc func addButtonAction() {
        let child = ATYAddTaskViewController()
        let vc = ATYCreateTaskViewController()
        vc.hidesBottomBarWhenPushed = true

        child.pushVcCallback = { [weak self] type in
            vc.types = type
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        child.transitioningDelegate = transition   // 2
        child.modalPresentationStyle = .custom  // 3

        present(child, animated: true)
    }
}

extension ATYTodayTasksViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? self.viewModel.currentTasksArray.count :  self.viewModel.completedTasksArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ATYTaskTableViewCell.reuseIdentifier, for: indexPath) as! ATYTaskTableViewCell
        let temporary = indexPath.section == 0 ? self.viewModel.currentTasksArray[indexPath.row] :  self.viewModel.completedTasksArray[indexPath.row]
        cell.setUp(typeTask: temporary.taskType,
                   courseName: nil,
                   hasSanction: temporary.taskSanction != 0,
                   titleLabel: temporary.taskName,
                   firstSubtitleLabel: temporary.taskDescription ?? "",
                   secondSubtitleLabel: temporary.taskAttribute,
                   state: .didNotStart, userOrCourseTask: .user)
        cell.callback = {
            print("callback")
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = R.color.backgroundAppColor()
        label.text = "Выполненные задачи"
        label.textColor = R.color.textSecondaryColor()
        label.font = UIFont.systemFont(ofSize: 15)

        let view = UIView()
        view.frame = CGRect(origin: .zero, size: .zero)
        return section == 1 ? label : view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 40 : 0
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let delete = UIContextualAction(style: .destructive, title: "") { (action, view, boolValue) in
            boolValue(true)
            if indexPath.section == 0 {
                self.temporaryArray.remove(at: indexPath.row)
            } else {
                self.completedTask.remove(at: indexPath.row)
            }
            self.tasksTableView.deleteRows(at: [indexPath], with: .fade)
        }

        let edit = UIContextualAction(style: .destructive, title: "") { [weak self] (action, view, boolValue) in
            boolValue(true)
            var typeOfTask = 0

            if indexPath.section == 0 {
//                typeOfTask = self?.temporaryArray[indexPath.row].typeTask ?? 0
            } else {
//                typeOfTask = self?.completedTask[indexPath.row].typeTask ?? 0
            }
            let vc = ATYEditTaskViewController()
            vc.types = TypeOfTask.init(rawValue: typeOfTask)
            self?.navigationController?.pushViewController(vc, animated: true)
        }


        delete.image = R.image.deleteImage()
        edit.image = R.image.editImage()
        let config = UISwipeActionsConfiguration(actions: [edit, delete])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
}

extension ATYTodayTasksViewController : ATYTodayTasksViewModelDelegate {
    func updateData() {
        self.tasksTableView.reloadData()
    }
}


struct TemporaryData {
    let typeTask : ATYTaskTypeEnum
    let courseName : String
    let hasSanction : Bool
    let titleLabel : String
    let firstSubtitleLabel : String
    let secondSubtitleLabel : String
    let state : CurrentStateTask
}

