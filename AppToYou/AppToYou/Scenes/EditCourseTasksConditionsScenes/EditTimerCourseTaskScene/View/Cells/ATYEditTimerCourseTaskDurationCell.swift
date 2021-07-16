//
//  ATYEditTimerCourseTaskDurationCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 16.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYEditTimerCourseTaskDurationCell: UITableViewCell {

    let durationLabel : UILabel = {
        let label = UILabel()
        label.text = "Длительность выполнения задачи на курсе"
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        return label
    }()

    let minSanctionLabel : UILabel = {
        let label = UILabel()
        label.text = "*минимум 1"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = R.color.textSecondaryColor()
        return label
    }()

    let sanctionImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.coinImage()
        return imageView
    }()

    var hourTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "0 " + "год"
        textField.backgroundColor = R.color.backgroundAppColor()
        textField.textColor = R.color.titleTextColor()
        textField.keyboardType = .numberPad
        return textField
    }()

    var minTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "0 " + "мес"
        textField.backgroundColor = R.color.backgroundAppColor()
        textField.textColor = R.color.titleTextColor()
        textField.keyboardType = .numberPad
        return textField
    }()

    var secTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "0 " + "день"
        textField.backgroundColor = R.color.backgroundAppColor()
        textField.textColor = R.color.titleTextColor()
        textField.keyboardType = .numberPad
        return textField
    }()

    var nameLabel : UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.penaltyForNonCompliance()
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    var sanctionTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "0"
        textField.textAlignment = .left
        textField.rightViewMode = .always
        textField.backgroundColor = R.color.backgroundAppColor()
        textField.textColor = R.color.titleTextColor()
        return textField
    }()

    var questionButton : UIButton = {
        let button = UIButton()
        button.setImage(R.image.questionButton(), for: .normal)
        return button
    }()

    var switchButton : UISwitch = {
        let switchButton = UISwitch()
        switchButton.onTintColor = R.color.textColorSecondary()
        return switchButton
    }()

    var callbackText: ((String) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configure()
        configureSanction()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(durationLabel)
        contentView.addSubview(hourTextField)
        contentView.addSubview(minTextField)
        contentView.addSubview(secTextField)

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
    }

    private func configureSanction() {
        contentView.addSubview(sanctionTextField)
        contentView.addSubview(nameLabel)
        contentView.addSubview(switchButton)
        contentView.addSubview(questionButton)
        contentView.addSubview(minSanctionLabel)
        contentView.addSubview(sanctionImageView)

        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(hourTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        let coinImageView = UIImageView(frame: CGRect(x: 0, y: 4.5, width: 21, height: 21))
        coinImageView.image = R.image.coinImage()

        let coinView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 32))
        coinView.addSubview(coinImageView)

        sanctionTextField.rightView = coinView
        sanctionTextField.rightViewMode = .always
        sanctionTextField.delegate = self
        sanctionTextField.keyboardType = .numberPad

        sanctionTextField.layer.cornerRadius = 22.5
        sanctionTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10.0, 0.0, 0)
        sanctionTextField.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(45)
            make.width.equalToSuperview().multipliedBy(0.5)
        }

        questionButton.snp.makeConstraints { (make) in
            make.leading.equalTo(sanctionTextField.snp.trailing).offset(9)
            make.height.width.equalTo(30)
            make.centerY.equalTo(sanctionTextField)
        }

        switchButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalTo(questionButton)
        }

        minSanctionLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(sanctionTextField.snp.bottom).offset(6)
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(minSanctionLabel.intrinsicContentSize.width)
        }

        sanctionImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(minSanctionLabel.snp.trailing).offset(6)
            make.width.height.equalTo(11)
            make.centerY.equalTo(minSanctionLabel)
        }
    }
}

extension ATYEditTimerCourseTaskDurationCell: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        callbackText?(textField.text ?? "")
    }
}
