//
//  ATYPaidCoursePreviewViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 21.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

@available(*, deprecated, message: "old version")
class ATYPaidCoursePreviewViewController: UIViewController {

//    private enum ATYPaidPreviewEnum: Int, CaseIterable {
//        case header
//        case description
//    }
//
//    var completedTask = [TemporaryData(typeTask: .CHECKBOX,
//                                       courseName: "Электрика",
//                                       hasSanction: true,
//                                       titleLabel: "Test text",
//                                       firstSubtitleLabel: "пт, cуб",
//                                       secondSubtitleLabel: "60 мин",
//                                       state: .didNotStart, date: Date.dateFormatter.date(from: "2021/08/12 22:31")),
//                         TemporaryData(typeTask: .RITUAL,
//                                       courseName: "Машиностроение",
//                                       hasSanction: false,
//                                       titleLabel: "Test text",
//                                       firstSubtitleLabel: "пт, cуб, вскр, ср",
//                                       secondSubtitleLabel: "60 мин",
//                                       state: .didNotStart, date: Date.dateFormatter.date(from: "2021/08/12 22:31")),
//                         TemporaryData(typeTask: .TEXT,
//                                       courseName: "Медитация",
//                                       hasSanction: true,
//                                       titleLabel: "Test text",
//                                       firstSubtitleLabel: "ежедневно",
//                                       secondSubtitleLabel: "60 мин",
//                                       state: .didNotStart, date: Date.dateFormatter.date(from: "2021/08/12 22:31")),
//                         TemporaryData(typeTask: .TIMER,
//                                       courseName: "Английский",
//                                       hasSanction: false,
//                                       titleLabel: "Test text",
//                                       firstSubtitleLabel: "пт, cуб, вскр",
//                                       secondSubtitleLabel: "60 мин",
//                                       state: .didNotStart, date: Date.dateFormatter.date(from: "2021/08/12 22:31"))]
//
//    let courseImageView : UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = R.image.exampleAboutCourse()
//        return imageView
//    }()
//
//    private let createTaskButton : UIButton = {
//        let button = UIButton()
//        button.backgroundColor = R.color.buttonColor()
//        button.setTitle("Купить курс", for: .normal)
//        return button
//    }()
//
//    let tableView = UITableView()
//    let lineView = UIView()
//    let selectedView = UIView()
//    var isReadMore = false
//    var dismissCallback : (() -> Void)?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureViews()
//        configureTableView()
//        view.backgroundColor = R.color.backgroundTextFieldsColor()
//        view.layer.cornerRadius = 24
//        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//    }
//
//    private func configureViews() {
//        view.addSubview(courseImageView)
//        courseImageView.snp.makeConstraints { (make) in
//            make.leading.trailing.top.equalToSuperview()
//            make.height.equalTo(140)
//        }
//        courseImageView.layer.cornerRadius = 24
//        courseImageView.layer.masksToBounds = true
//        courseImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        courseImageView.addSubview(lineView)
//        lineView.backgroundColor = R.color.lightGrayColor()
//        lineView.layer.cornerRadius = 2
//        lineView.snp.makeConstraints { (make) in
//            make.centerX.equalToSuperview()
//            make.top.equalToSuperview().offset(5)
//            make.height.equalTo(5)
//            make.width.equalTo(40)
//        }
//    }
//
//    private func configureTableView() {
//        view.addSubview(tableView)
//        view.addSubview(createTaskButton)
//
//        createTaskButton.addTarget(self, action: #selector(createTaskButtonAction), for: .touchUpInside)
//        createTaskButton.layer.cornerRadius = 25
//        createTaskButton.snp.makeConstraints { (make) in
//            make.bottom.equalToSuperview().offset(-20)
//            make.leading.equalToSuperview().offset(20)
//            make.trailing.equalToSuperview().offset(-20)
//            make.height.equalTo(50)
//        }
//
//        tableView.layer.cornerRadius = 24
//        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        tableView.separatorStyle = .none
//        tableView.showsVerticalScrollIndicator = false
//        tableView.backgroundColor = R.color.backgroundTextFieldsColor()
//        tableView.register(ATYPaidCoursePreviewHeaderCell.self, forCellReuseIdentifier: ATYPaidCoursePreviewHeaderCell.reuseIdentifier)
//        tableView.register(ATYPaidCoursePreviewDescriptionCell.self, forCellReuseIdentifier: ATYPaidCoursePreviewDescriptionCell.reuseIdentifier)
//        tableView.register(ATYTaskTableViewCell.self, forCellReuseIdentifier: ATYTaskTableViewCell.reuseIdentifier)
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.snp.makeConstraints { (make) in
//            make.top.equalTo(courseImageView.snp.bottom)
//            make.trailing.equalToSuperview().offset(-20)
//            make.leading.equalToSuperview().offset(20)
//            make.bottom.equalTo(createTaskButton.snp.top).offset(-5)
//        }
//    }
//
//    @objc func createTaskButtonAction() {
//        self.dismiss(animated: true) { [weak self] in
//            self?.dismissCallback?()
//        }
//    }
//}
//
//extension ATYPaidCoursePreviewViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return completedTask.count + ATYPaidPreviewEnum.allCases.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch ATYPaidPreviewEnum.init(rawValue: indexPath.row) {
//        case .header:
//            let cell = tableView.dequeueReusableCell(withIdentifier: ATYPaidCoursePreviewHeaderCell.reuseIdentifier, for: indexPath) as! ATYPaidCoursePreviewHeaderCell
//            cell.setUp(type: .buying)
//            return cell
//        case .description:
//            let cell = tableView.dequeueReusableCell(withIdentifier: ATYPaidCoursePreviewDescriptionCell.reuseIdentifier, for: indexPath) as! ATYPaidCoursePreviewDescriptionCell
//
//            cell.descriptionTextView.numberOfLines = self.isReadMore ? 0 : 3
//            return cell
//        default :
//            let cell = tableView.dequeueReusableCell(withIdentifier: ATYTaskTableViewCell.reuseIdentifier, for: indexPath) as! ATYTaskTableViewCell
//            cell.contentView.backgroundColor = R.color.backgroundTextFieldsColor()
//            cell.backContentView.backgroundColor = R.color.backgroundAppColor()
//            let item = completedTask[indexPath.row - 2]
//            cell.setUp(typeTask: item.typeTask,
//                       courseName: nil,
//                       hasSanction: item.hasSanction,
//                       titleLabel: item.titleLabel,
//                       firstSubtitleLabel: item.firstSubtitleLabel,
//                       secondSubtitleLabel: item.secondSubtitleLabel,
//                       state: .didNotStart,
//                       userOrCourseTask: .user)
//            return cell
//        }
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let _ = (tableView.cellForRow(at: indexPath) as? ATYPaidCoursePreviewDescriptionCell) {
//            self.isReadMore = !self.isReadMore
//        }
//        self.tableView.reloadData()
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row > 1 {
//            return 90
//        } else {
//            return UITableView.automaticDimension
//        }
//    }
}
