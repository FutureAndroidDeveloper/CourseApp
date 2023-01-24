//
//  ATYDurationCreateCourse.swift
//  AppToYou
//
//  Created by Philip Bratov on 08.06.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class ATYDurationCreateCourse: UITableViewCell {

    var durationCourse = ATYDurationCourse()
    var callbackDuration : ((ATYDurationCourse) -> ())?
    var checkBoxCallback : ((Bool) -> ())?

    let durationLabel : UILabel = {
        let label = UILabel()
        label.text = "Длительность курса"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "Срок, в течение которого пользователь будет выполнить все задачи курса после их добавления (срок, на который рассчитан курс)"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = R.color.textSecondaryColor()
        label.numberOfLines = 0
        return label
    }()

    var yearTextField : UITextField = {
        let textField = UITextField()
        textField.tag = 0
        textField.placeholder = "0 " + "год"
        textField.backgroundColor = R.color.backgroundTextFieldsColor()
        textField.textColor = R.color.titleTextColor()
        textField.keyboardType = .numberPad
        return textField
    }()

    var monthTextField : UITextField = {
        let textField = UITextField()
        textField.tag = 1
        textField.placeholder = "0 " + "мес"
        textField.backgroundColor = R.color.backgroundTextFieldsColor()
        textField.textColor = R.color.titleTextColor()
        textField.keyboardType = .numberPad
        return textField
    }()

    var dayTextField : UITextField = {
        let textField = UITextField()
        textField.tag = 2
        textField.placeholder = "0 " + "день"
        textField.backgroundColor = R.color.backgroundTextFieldsColor()
        textField.textColor = R.color.titleTextColor()
        textField.keyboardType = .numberPad
        return textField
    }()

    let checkBox = ATYCheckBox()

    let checkBoxLabel : UILabel = {
        let label = UILabel()
        label.text = "Бесконечная длительность курса"
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = R.color.backgroundAppColor()
        selectionStyle = .none
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func checkBoxAction() {
        checkBoxCallback?(self.checkBox.isSelected)
    }

    private func configure() {
        contentView.addSubview(durationLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(yearTextField)
        contentView.addSubview(monthTextField)
        contentView.addSubview(dayTextField)
        contentView.addSubview(checkBox)
        contentView.addSubview(checkBoxLabel)

        yearTextField.delegate = self
        monthTextField.delegate = self
        dayTextField.delegate = self

        durationLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(durationLabel.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        yearTextField.layer.cornerRadius = 22.5
        yearTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10.0, 0.0, 0.0)
        yearTextField.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(45)
            make.width.equalTo(85)
        }

        monthTextField.layer.cornerRadius = 22.5
        monthTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10.0, 0.0, 0.0)
        monthTextField.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(15)
            make.leading.equalTo(yearTextField.snp.trailing).offset(12)
            make.height.equalTo(45)
            make.width.equalTo(85)
        }

        dayTextField.layer.cornerRadius = 22.5
        dayTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10.0, 0.0, 0.0)
        dayTextField.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(15)
            make.leading.equalTo(monthTextField.snp.trailing).offset(12)
            make.height.equalTo(45)
            make.width.equalTo(85)
        }

        checkBox.addTarget(self, action: #selector(checkBoxAction), for: .valueChanged)
        checkBox.snp.makeConstraints { (make) in
            make.top.equalTo(yearTextField.snp.bottom).offset(15)
            make.leading.equalTo(yearTextField)
            make.width.height.equalTo(20)
            make.bottom.equalToSuperview().offset(-10)
        }

        checkBoxLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(checkBox.snp.trailing).offset(12)
            make.centerY.equalTo(checkBox)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}

extension ATYDurationCreateCourse: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let number =  Int(textField.text ?? "") ?? 0
        switch textField.tag {
        case 0:
            self.durationCourse.year = number
        case 1:
            self.durationCourse.month = number
        case 2:
            self.durationCourse.day = number
        default:
            break
        }
        callbackDuration?(self.durationCourse)
    }
}
