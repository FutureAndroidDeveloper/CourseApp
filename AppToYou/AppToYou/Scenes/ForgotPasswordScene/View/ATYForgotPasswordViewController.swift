//
//  ATYForgotPasswordViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 24.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYForgotPasswordViewController: UIViewController {

    let enterEmailLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font =  UIFont.Regular(size: 28)
        label.text = R.string.localizable.enterEmail()
        label.textColor = R.color.titleTextColor()
        return label
    }()

    let descriptionEmailLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font =  UIFont.Regular(size: 15)
        label.text = R.string.localizable.weWiilSendYourInstructions()
        label.textColor = R.color.textSecondaryColor()
        return label
    }()

    let emailTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = R.string.localizable.enterEmail()
        textField.backgroundColor = R.color.backgroundTextFieldsColor()
        textField.textColor = R.color.titleTextColor()
        return textField
    }()

    let doneButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.buttonColor()
        button.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
        button.setTitle(R.string.localizable.restorePassword(), for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.backgroundAppColor()
        configureViews()
        configureNavBar()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        emailTextField.layer.cornerRadius = emailTextField.frame.height / 2
        doneButton.layer.cornerRadius = doneButton.frame.height / 2
    }


    //MARK:- Configure views

    private func configureNavBar() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = R.color.lineViewBackgroundColor()
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    private func configureViews() {
        view.addSubview(enterEmailLabel)
        enterEmailLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.6)
        }

        view.addSubview(descriptionEmailLabel)
        descriptionEmailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(enterEmailLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        view.addSubview(emailTextField)
        emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10.0, 0.0, 0.0);
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionEmailLabel.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

        view.addSubview(descriptionEmailLabel)
        descriptionEmailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(enterEmailLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        view.addSubview(doneButton)
        doneButton.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }

    //MARK:- Handlers

    @objc func doneButtonAction() {
        
    }
}
