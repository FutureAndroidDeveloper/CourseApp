//
//  ATYPayForCourseView.swift
//  AppToYou
//
//  Created by Philip Bratov on 08.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYPayForCourseView : UIView {

    let payLabel : UILabel = {
        let label = UILabel()
        label.text = "Оплата за вступление в курс"
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
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

    let oneLabel : UILabel = {
        let label = UILabel()
        label.text = "*1"
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        return label
    }()

    let imageCoinView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.coinImage()
        return imageView
    }()

    let oneWalletLabel : UILabel = {
        let label = UILabel()
        label.text = "= 1 USD"
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        return label
    }()

    var callbackText: ((String) -> ())?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        self.addSubview(sanctionTextField)
        self.addSubview(payLabel)
        self.addSubview(oneLabel)
        self.addSubview(imageCoinView)
        self.addSubview(oneWalletLabel)

        let coinImageView = UIImageView(frame: CGRect(x: 0, y: 4.5, width: 21, height: 21))
        coinImageView.image = R.image.coinImage()

        let coinView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 32))
        coinView.addSubview(coinImageView)

        self.sanctionTextField.rightView = coinView
        self.sanctionTextField.rightViewMode = .always

        payLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
        }

        sanctionTextField.delegate = self
        sanctionTextField.layer.cornerRadius = 22.5
        sanctionTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10.0, 0.0, 0)
        sanctionTextField.snp.makeConstraints { (make) in
            make.top.equalTo(payLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview()
            make.height.equalTo(45)
            make.width.equalToSuperview().multipliedBy(0.58)
        }

        oneLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(sanctionTextField)
            make.top.equalTo(sanctionTextField.snp.bottom).offset(15)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(20)
        }

        imageCoinView.layer.cornerRadius = 4.25
        imageCoinView.snp.makeConstraints { (make) in
            make.leading.equalTo(oneLabel.snp.trailing).offset(3)
            make.width.height.equalTo(8.5)
            make.centerY.equalTo(oneLabel)
        }

        oneWalletLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(imageCoinView.snp.trailing).offset(6)
            make.centerY.equalTo(imageCoinView)
            make.trailing.equalToSuperview().offset(-20)
        }

    }
}

extension ATYPayForCourseView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        callbackText?(textField.text ?? "")
    }
}
