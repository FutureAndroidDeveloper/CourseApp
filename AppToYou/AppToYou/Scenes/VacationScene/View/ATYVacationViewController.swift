//
//  ATYVacationViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 03.08.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYVacataionViewController : UIViewController {

    var countVacationDays = 0

    let titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = R.color.titleTextColor()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.text = "Вы в отпуск?"
        return label
    }()

    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.textColor = R.color.textSecondaryColor()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.text = "Укажите, сколько дней вы будете отдыхать. Вернуться можно в любой день, кроме первого дня"
        return label
    }()

    var countVacationDaysTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "0"
        textField.textAlignment = .left
        textField.rightViewMode = .always
        textField.backgroundColor = R.color.backgroundAppColor()
        textField.textColor = R.color.titleTextColor()
        return textField
    }()

    private let minusButton : UIButton = {
        let button = UIButton()
        button.setImage(R.image.minusButtonImage(), for: .normal)
        return button
    }()

    private let plusButton : UIButton = {
        let button = UIButton()
        button.setImage(R.image.plusButtonImage(), for: .normal)
        return button
    }()

    private let createTaskButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.buttonColor()
        button.setTitle("Уйти в отпуск", for: .normal)
        return button
    }()

    let lineView = UIView()

    var dismissCallback : (() -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLineView()
        configure()
        view.backgroundColor = R.color.backgroundTextFieldsColor()
        view.layer.cornerRadius = 24
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    private func configure() {
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(countVacationDaysTextField)
        view.addSubview(minusButton)
        view.addSubview(plusButton)
        view.addSubview(titleLabel)
        view.addSubview(createTaskButton)

        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(lineView.snp.bottom).offset(21)
        }

        descriptionLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(14)
            make.trailing.equalToSuperview().offset(-20)
        }

        countVacationDaysTextField.keyboardType = .numberPad
        countVacationDaysTextField.text = String(countVacationDays)
        countVacationDaysTextField.layer.cornerRadius = 22.5
        countVacationDaysTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10.0, 0.0, 0)
        countVacationDaysTextField.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(26)
            make.leading.equalToSuperview().offset(20)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(45)
        }

        minusButton.addTarget(self, action: #selector(minusButtonAction), for: .touchUpInside)
        minusButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(countVacationDaysTextField)
            make.leading.equalTo(countVacationDaysTextField.snp.trailing).offset(12)
            make.height.width.equalTo(20)
        }

        plusButton.addTarget(self, action: #selector(plusButtonAction), for: .touchUpInside)
        plusButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(countVacationDaysTextField)
            make.leading.equalTo(minusButton.snp.trailing).offset(12)
            make.height.width.equalTo(20)
        }

        createTaskButton.addTarget(self, action: #selector(createTaskButtonAction), for: .touchUpInside)
        createTaskButton.layer.cornerRadius = 25
        createTaskButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }

    @objc func minusButtonAction() {
        if countVacationDays != 0 {
            countVacationDays -= 1
            countVacationDaysTextField.text = String(countVacationDays)
        }
    }

    @objc func plusButtonAction() {
        countVacationDays += 1
        countVacationDaysTextField.text = String(countVacationDays)
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

    @objc func createTaskButtonAction() {
        self.dismiss(animated: true) { [weak self] in
            self?.dismissCallback?()
        }
    }
}
