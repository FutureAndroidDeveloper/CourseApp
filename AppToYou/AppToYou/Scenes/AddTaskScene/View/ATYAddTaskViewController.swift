//
//  ATYAddTaskViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 26.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYAddTaskViewController: UIViewController, BindableType {
    
    var viewModel: AddTaskViewModel!
    
    func bindViewModel() {
        //
    }

    let tableView = UITableView()
    let lineView = UIView()
    let chooseTypeTaskLabel = UILabel()
    let selectedView = UIView()
    
//    var pushVcCallback : ((ATYTaskType) -> Void)?

    let titleStrings = [R.string.localizable.oneTimeTaskExecution(),
                        R.string.localizable.countingReps(),
                        R.string.localizable.timer(),
                        R.string.localizable.text()]

    let subtitleStrings = [R.string.localizable.useTheCheckbox(),
                           R.string.localizable.specifyTheNumber(),
                           R.string.localizable.specifyTheTime(),
                           R.string.localizable.toCompleteTask()]

    let imageArray = [R.image.checkBox(), R.image.countTask(), R.image.timerTask(), R.image.textTask()]
    let typeTask = [ATYTaskType.CHECKBOX, ATYTaskType.RITUAL, ATYTaskType.TIMER, ATYTaskType.TEXT]


    override func viewDidLoad() {
        super.viewDidLoad()
        configureLineView()

        configureChooseTaskLabel()
        configureTableView()
        view.backgroundColor = R.color.backgroundTextFieldsColor()
        view.layer.cornerRadius = 24
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    private func configureLineView() {
        view.addSubview(lineView)
        lineView.backgroundColor = R.color.lightGrayColor()
        lineView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.height.equalTo(5)
            make.width.equalTo(40)
        }
    }

    private func configureChooseTaskLabel() {
        view.addSubview(chooseTypeTaskLabel)
        chooseTypeTaskLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        chooseTypeTaskLabel.text = R.string.localizable.selectTheTypeOfTask()
        chooseTypeTaskLabel.tintColor = R.color.titleTextColor()
        chooseTypeTaskLabel.snp.makeConstraints { (make) in
            make.top.equalTo(lineView.snp.bottom).offset(23)
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
        }
    }

    private func configureTableView() {
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.backgroundColor = R.color.backgroundTextFieldsColor()
        tableView.register(ATYCreateTaskTableViewCell.self, forCellReuseIdentifier: ATYCreateTaskTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(chooseTypeTaskLabel.snp.bottom).offset(16)
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview()
        }
    }
}


extension ATYAddTaskViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.imageArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskTableViewCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskTableViewCell

        cell.setUp(image: self.imageArray[indexPath.row], titleLabel: self.titleStrings[indexPath.row], subtitleLabel: self.subtitleStrings[indexPath.row])
        selectedView.backgroundColor = R.color.textColorSecondary()
        selectedView.layer.cornerRadius = 26
        cell.selectedBackgroundView = selectedView
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = self.typeTask[indexPath.row]
        viewModel.input.typePicked(type)

//        self.dismiss(animated: true) { [weak self] in
//            self?.pushVcCallback?((self?.typeTask[indexPath.row])!)
//        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
