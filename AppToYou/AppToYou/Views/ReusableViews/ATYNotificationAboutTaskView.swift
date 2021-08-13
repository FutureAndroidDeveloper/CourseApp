//
//  ATYNotificationAboutTaskView.swift
//  AppToYou
//
//  Created by Philip Bratov on 31.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYNotificationAboutTaskView: UIView {

    var hourTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "0 " + R.string.localizable.hour()
        textField.backgroundColor = R.color.backgroundTextFieldsColor()
        textField.textColor = R.color.titleTextColor()
        return textField
    }()

    var minTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "0 " + R.string.localizable.min()
        textField.backgroundColor = R.color.backgroundTextFieldsColor()
        textField.textColor = R.color.titleTextColor()
        return textField
    }()

    var plusButton : UIButton = {
        let button = UIButton()
        button.setImage(R.image.plusImage(), for: .normal)
        return button
    }()

    var switchButton : UISwitch = {
        let switchButton = UISwitch()
        switchButton.onTintColor = R.color.textColorSecondary()
        return switchButton
    }()

    var callback: (() -> Void)?
    var plusCallback: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = R.color.backgroundAppColor()
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        self.addSubview(hourTextField)
        self.addSubview(minTextField)
        self.addSubview(plusButton)
        self.addSubview(switchButton)

        hourTextField.layer.cornerRadius = 22.5
        hourTextField.delegate = self
        hourTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10.0, 0.0, 0.0)
        hourTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(45)
            make.width.equalTo(85)
            make.bottom.equalToSuperview().offset(-15)
        }

        minTextField.layer.cornerRadius = 22.5
        minTextField.delegate = self
        minTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10.0, 0.0, 0.0)
        minTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(hourTextField.snp.trailing).offset(12)
            make.height.equalTo(45)
            make.width.equalTo(85)
        }

        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        plusButton.snp.makeConstraints { (make) in
            make.leading.equalTo(minTextField.snp.trailing).offset(12)
            make.centerY.equalTo(minTextField)
            make.height.equalTo(14)
            make.width.equalTo(14)
        }

        switchButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        switchButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalTo(plusButton)
        }
    }

    @objc func plusButtonTapped() {
        plusCallback?()
    }
}

extension ATYNotificationAboutTaskView : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        callback?()
    }
}
