//
//  ATYAddTaskViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 26.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYAddTaskViewController: UIViewController {

    let tableView = UITableView()
    let lineView = UIView()
    let chooseTypeTaskLabel = UILabel()
    let selectedView = UIView()

    let titleStrings = ["Разовое выолнение задачи", "Подсчет повторений", "Таймер", "Текст"]
    let subtitleStrings = ["с помощью чек-бокса один раз отметьте выполнение задачи",
                           "укажите количество выполнений и отметьте выполнение задачи необходимым количеством нажатий",
                           "укажите время, необходимое для выполнения задания, и запустите таймер для его выполнения",
                           "чтобы выполнить задание, напишите текст заданной заранее длины"]

    let imageArray = [R.image.checkBox(), R.image.countTask(), R.image.timerTask(), R.image.textTask()]


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
        chooseTypeTaskLabel.text = "Выберите тип задачи"
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
        tableView.register(ATYTaskTableViewCell.self, forCellReuseIdentifier: ATYTaskTableViewCell.reuseIdentifier)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: ATYTaskTableViewCell.reuseIdentifier, for: indexPath) as! ATYTaskTableViewCell

        cell.setUp(image: self.imageArray[indexPath.row], titleLabel: self.titleStrings[indexPath.row], subtitleLabel: self.subtitleStrings[indexPath.row])
        selectedView.backgroundColor = R.color.textColorSecondary()
        selectedView.layer.cornerRadius = 26
        cell.selectedBackgroundView = selectedView
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
