//
//  ATYCreateSanctionTaskCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 31.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYCreateSanctionTaskCell: UITableViewCell {

    var nameLabel : UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.penaltyForNonCompliance()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    var sanctionTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "0"
        textField.textAlignment = .left
        textField.rightViewMode = .always
        textField.backgroundColor = R.color.backgroundTextFieldsColor()
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
        backgroundColor = R.color.backgroundAppColor()
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(sanctionTextField)
        contentView.addSubview(nameLabel)
        contentView.addSubview(switchButton)
        contentView.addSubview(questionButton)

        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
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
            make.bottom.equalToSuperview().offset(-15)
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
    }
}

extension ATYCreateSanctionTaskCell: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        callbackText?(textField.text ?? "")
    }
}
