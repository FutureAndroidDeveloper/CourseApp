//
//  ATYDurationCourseTaskCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 21.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//
import UIKit

class ATYDurationCourseTaskCell: UITableViewCell {

    let durationLabel : UILabel = {
        let label = UILabel()
        label.text = "Длительность выполнения задачи на курсе"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    var hourTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "0 " + "год"
        textField.backgroundColor = R.color.backgroundTextFieldsColor()
        textField.textColor = R.color.titleTextColor()
        textField.keyboardType = .numberPad
        return textField
    }()

    var minTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "0 " + "мес"
        textField.backgroundColor = R.color.backgroundTextFieldsColor()
        textField.textColor = R.color.titleTextColor()
        textField.keyboardType = .numberPad
        return textField
    }()

    var secTextField : UITextField = {
        let textField = UITextField()
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

    private func configure() {
        contentView.addSubview(durationLabel)
        contentView.addSubview(hourTextField)
        contentView.addSubview(minTextField)
        contentView.addSubview(secTextField)
        contentView.addSubview(checkBox)
        contentView.addSubview(checkBoxLabel)

        durationLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        hourTextField.layer.cornerRadius = 22.5
        hourTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10.0, 0.0, 0.0)
        hourTextField.snp.makeConstraints { (make) in
            make.top.equalTo(durationLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(45)
            make.width.equalTo(85)
        }

        minTextField.layer.cornerRadius = 22.5
        minTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10.0, 0.0, 0.0)
        minTextField.snp.makeConstraints { (make) in
            make.top.equalTo(durationLabel.snp.bottom).offset(15)
            make.leading.equalTo(hourTextField.snp.trailing).offset(12)
            make.height.equalTo(45)
            make.width.equalTo(85)
        }

        secTextField.layer.cornerRadius = 22.5
        secTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10.0, 0.0, 0.0)
        secTextField.snp.makeConstraints { (make) in
            make.top.equalTo(durationLabel.snp.bottom).offset(15)
            make.leading.equalTo(minTextField.snp.trailing).offset(12)
            make.height.equalTo(45)
            make.width.equalTo(85)
        }

        checkBox.snp.makeConstraints { (make) in
            make.top.equalTo(hourTextField.snp.bottom).offset(15)
            make.leading.equalTo(hourTextField)
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

